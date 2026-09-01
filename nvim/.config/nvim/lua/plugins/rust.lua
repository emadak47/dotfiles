return {
	{
		"mrcjkb/rustaceanvim",
		version = "^8",
		lazy = false,
		init = function()
			vim.g.rustaceanvim = {
				server = {
					capabilities = require("blink.cmp").get_lsp_capabilities(),
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								targetDir = true,
								allTargets = false,
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
				},
			}
		end,
	},
}
