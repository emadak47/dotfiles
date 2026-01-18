return {
	-- main color scheme
	{
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme gruvbox-dark-hard]])
			vim.o.background = "dark"
			vim.cmd([[hi Normal ctermbg=NONE]])
			-- Apply highlights after colorscheme is loaded
			require("config.highlights").setup()
		end,
	},
}
