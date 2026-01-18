return {
	--main color scheme
	--{
	--	"wincent/base16-nvim",
	--	lazy = false, -- load at start
	--	priority = 1000, -- load first
	--	config = function()
	--		vim.cmd([[colorscheme gruvbox-dark-hard]])
	--		vim.o.background = "dark"
	--		--vim.cmd([[hi Normal ctermbg=NONE]])
	--		-- Apply highlights after colorscheme is loaded
	--		require("config.highlights").setup()
	--	end,
	--},

	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			require("everforest").setup({
				background = "hard",
				transparent_background_level = 2,
				italics = false,
				disable_italic_comments = false,
				sign_column_background = "grey",
				ui_contrast = "high",
				dim_inactive_windows = false,
				diagnostic_text_highlight = false,
				diagnostic_virtual_text = "coloured",
				show_eob = true,
				float_style = "bright",
			})

			vim.cmd([[colorscheme everforest]])
			require("config.highlights").setup()
		end,
	},
}
