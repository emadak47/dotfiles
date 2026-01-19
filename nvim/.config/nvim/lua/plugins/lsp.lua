return {
	-- Mason: LSP server installer/manager
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	-- Bridge between Mason and lspconfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "mason.nvim" },
		opts = {
			ensure_installed = {
				"rust_analyzer",
				"lua_ls",
				--"pyright",
			},
		},
	},
	-- LSP configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local blink_capabilities = require("blink.cmp").get_lsp_capabilities()

			-- ============================================================================
			-- LSP Server Configurations
			-- ============================================================================

			-- Rust
			vim.lsp.config("rust_analyzer", {
				capabilities = blink_capabilities,
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							targetDir = true,
						},
						checkOnSave = {
							enable = true,
							command = "clippy",
						},
						check = {
							command = "clippy",
						},
						imports = {
							group = {
								enable = false,
							},
						},
						completion = {
							postfix = {
								enable = false,
							},
						},
					},
				},
			})
			vim.lsp.enable("rust_analyzer")

			-- Lua
			vim.lsp.config("lua_ls", {
				capabilities = blink_capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")

			-- Python
			--vim.lsp.config("pyright", {
			--	capabilities = blink_capabilities,
			--})
			--vim.lsp.enable("pyright")

			-- Optional LSP servers (only if executable exists)
			if vim.fn.executable("bash-language-server") == 1 then
				vim.lsp.config("bashls", {
					capabilities = blink_capabilities,
				})
				vim.lsp.enable("bashls")
			end

			if vim.fn.executable("texlab") == 1 then
				vim.lsp.config("texlab", {
					capabilities = blink_capabilities,
				})
				vim.lsp.enable("texlab")
			end

			if vim.fn.executable("ruff") == 1 then
				vim.lsp.config("ruff_lsp", {
					capabilities = blink_capabilities,
				})
				vim.lsp.enable("ruff_lsp")
			end

			-- ============================================================================
			-- Diagnostics Configuration
			-- ============================================================================

			vim.diagnostic.config({
				virtual_text = false,
				virtual_lines = false, -- Off by default
				signs = true, -- Show in signcolumn
				underline = true, -- Underline errors
				update_in_insert = false,
				severity_sort = true,
			})

			-- Toggle inline diagnostics
			local virtual_lines_enabled = false
			local function toggle_virtual_lines()
				virtual_lines_enabled = not virtual_lines_enabled
				vim.diagnostic.config({
					virtual_lines = virtual_lines_enabled and {
						only_current_line = true,
						highlight_whole_line = true,
					} or false,
				})
			end

			-- ============================================================================
			-- Keybindings
			-- ============================================================================

			-- Diagnostic navigation
			vim.keymap.set("n", "<leader>d", toggle_virtual_lines, { desc = "Toggle inline diagnostics" })
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end, { desc = "Previous diagnostic" })
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end, { desc = "Next diagnostic" })
			-- Action
			vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)

			-- ============================================================================
			-- LSP Attach Configuration
			-- ============================================================================

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf, noremap = true, silent = true }
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					-- Navigation (using fzf-lua)
					vim.keymap.set("n", "gD", function()
						require("fzf-lua").lsp_declarations({ jump1 = true, ignore_current_line = true })
					end, opts)
					vim.keymap.set("n", "gd", function()
						require("fzf-lua").lsp_definitions({ jump1 = true, ignore_current_line = true })
					end, opts)
					vim.keymap.set("n", "gr", function()
						require("fzf-lua").lsp_references({ jump1 = true, ignore_current_line = true })
					end, opts)
					vim.keymap.set("n", "gi", function()
						require("fzf-lua").lsp_implementations({ jump1 = true, ignore_current_line = true })
					end, opts)

					-- Client-specific settings
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					end

					-- 					client.server_capabilities.semanticTokensProvider = nil

					-- Format on save
					if client.server_capabilities.documentFormattingProvider then
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
							buffer = event.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = event.buf })
							end,
						})
					end
				end,
			})
		end,
	},
}
