return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },

		opts = {
			winopts = {
				height = 0.7,
				width = 0.7,
				row = 0.5,
				col = 0.5,
				preview = {
					scrollchars = { "┃", "" },
				},
			},
			fzf_opts = {
				["--no-scrollbar"] = true,
			},
			previewers = {
				builtin = {
					extensions = {
						["png"] = { "ueberzug" },
						["jpg"] = { "ueberzug" },
						["jpeg"] = { "ueberzug" },
						["gif"] = { "ueberzug" },
					},
				},
			},
			files = {
				-- Use ripgrep for file finding (fd is faster but rg respects .gitignore better)
				cmd = "rg --files --hidden --follow --glob '!.git'",
				git_icons = true,
				file_icons = true,
				color_icons = true,
			},
			live_grep = {
				-- Use ripgrep with smart case
				cmd = "rg",
				rg_opts = "--column --line-number --no-heading --color=always --smart-case",
				rg_glob = "!.git",
				previewer = "builtin",
				file_icons = true,
				color_icons = true,
			},
			buffers = {
				file_icons = false,
				git_icons = true,
			},
		},
	},
}
