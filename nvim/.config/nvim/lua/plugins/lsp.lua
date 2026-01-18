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
				"pyright",
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},

		config = function()
			local blink_capabilities = require("blink.cmp").get_lsp_capabilities()

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

			vim.lsp.config("pyright", {
				capabilities = blink_capabilities,
			})
			vim.lsp.enable("pyright")

			-- Bash LSP
			if vim.fn.executable("bash-language-server") == 1 then
				vim.lsp.config("bashls", {
					capabilities = blink_capabilities,
				})
				vim.lsp.enable("bashls")
			end

			-- texlab for LaTeX
			if vim.fn.executable("texlab") == 1 then
				vim.lsp.enable("texlab")
			end

			-- Ruff for Python
			if vim.fn.executable("ruff") == 1 then
				vim.lsp.config("ruff_lsp", {
					capabilities = blink_capabilities,
				})
				vim.lsp.enable("ruff")
			end

			-- Global mappings
			vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
				callback = function(event)
					-- Buffer local mappings
					local opts = { buffer = event.buf, noremap = true, silent = true }

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
					--vim.keymap.set("n", "gt", function()
					--	require("fzf-lua").lsp_typedefs({ jump1 = true, ignore_current_line = true })
					--end, opts)
					vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)

					-- Get the client
					local client = vim.lsp.get_client_by_id(event.data.client_id)

					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
					end

					-- Disable semantic tokens (cleaner, less noise)
					client.server_capabilities.semanticTokensProvider = nil

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
