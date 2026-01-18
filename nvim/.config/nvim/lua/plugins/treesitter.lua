return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"rust",
				"lua",
				"python",
				"bash",
				"markdown",
				"json",
				"yaml",
				"toml",
				"vim",
				"vimdoc",
				"html",
				"css",
				"javascript",
				"typescript",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			folds = {
				enable = true,
			},
		},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
		end,
	},
}

