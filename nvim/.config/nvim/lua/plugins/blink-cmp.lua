return {
	{
		"Saghen/blink.cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		version = "1.*",
		opts = {
			keymap = { preset = "enter" },

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					auto_show = true,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
			},

			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },

			-- signature help
			signature = { enabled = true },

			cmdline = {
				enabled = true,
				keymap = {
					preset = "cmdline",
				},
				completion = {
					menu = {
						auto_show = function(ctx)
							return vim.fn.getcmdtype() == ":"
						end,
					},
				},
			},
		},

		config = function(_, opts)
			require("blink.cmp").setup(opts)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "blink-cmp-documentation",
				callback = function()
					local opts_doc = { buffer = 0, noremap = true, silent = true }
					-- Scroll down
					vim.keymap.set("n", "<C-f>", "<C-f>", opts_doc)
					vim.keymap.set("i", "<C-f>", "<C-f>", opts_doc)
					-- Scroll up
					vim.keymap.set("n", "<C-b>", "<C-b>", opts_doc)
					vim.keymap.set("i", "<C-b>", "<C-b>", opts_doc)
					-- Half page down
					vim.keymap.set("n", "<C-d>", "<C-d>", opts_doc)
					vim.keymap.set("i", "<C-d>", "<C-d>", opts_doc)
					-- Half page up
					vim.keymap.set("n", "<C-u>", "<C-u>", opts_doc)
					vim.keymap.set("i", "<C-u>", "<C-u>", opts_doc)
				end,
			})
		end,
	},
}

