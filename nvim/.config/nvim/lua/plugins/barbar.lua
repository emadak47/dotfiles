return {
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',  -- for file icons
		},
		event = "VeryLazy",
		init = function() vim.g.barbar_auto_setup = false end,

		opts = {
			icons = {
				button = false, -- don't dispaly no bottons pls
				filetype = {
					custom_colors = false,
					enabled = true 
				}
			}
		},
	}
}
