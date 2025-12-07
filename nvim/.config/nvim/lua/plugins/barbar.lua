return {
	{
		'romgrk/barbar.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',  -- for file icons
		},
		event = "VeryLazy",
		init = function() vim.g.barbar_auto_setup = false end,

		keys = {
			{ "<leader>1", "<Cmd>BufferGoto 1<CR>" },
			{ "<leader>2", "<Cmd>BufferGoto 2<CR>" },
			{ "<leader>3", "<Cmd>BufferGoto 3<CR>" },
			{ "<leader>4", "<Cmd>BufferGoto 4<CR>" },
			{ "<leader>5", "<Cmd>BufferGoto 5<CR>" },
			{ "<leader>6", "<Cmd>BufferGoto 6<CR>" },
			{ "<leader>7", "<Cmd>BufferGoto 7<CR>" },
			{ "<leader>8", "<Cmd>BufferGoto 8<CR>" },
			{ "<leader>9", "<Cmd>BufferGoto 9<CR>" },
			{ "<leader>0", "<Cmd>BufferLast<CR>" },
			{ "<leader>x", "<Cmd>BufferClose<CR>" },
			{ "<leader>X", "<Cmd>BufferRestore<CR>" },
		},

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
