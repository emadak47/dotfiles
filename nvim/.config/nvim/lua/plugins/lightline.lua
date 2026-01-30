return {
	{
		"itchyny/lightline.vim",
		lazy = false,
		-- lua module not supported for 'lightline', so using config fn
		config = function()
			-- don't show vim mode in command line
			vim.o.showmode = false
			vim.g.lightline = {
				-- https://github.com/romgrk/barbar.nvim?tab=readme-ov-file#known-issues
				enable = {
					statusline = 1,
					tabline = 0,
				},
				active = {
					left = {
						{ "mode", "paste" },
						{ "readonly", "filename", "modified" },
					},
					right = {
						{ "lineinfo" },
						{ "percent" },
						{ "fileencoding", "filetype" },
					},
				},
				component_function = {
					filename = "LightlineFilename",
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand("%:t") == "" then
					return "[No Name]"
				else
					return vim.fn.expand("%")
				end
			end

			-- https://github.com/itchyny/lightline.vim/issues/657
			vim.api.nvim_exec(
				[[
				function! g:LightlineFilename()
					return v:lua.LightlineFilenameInLua()
				endfunction
				]],
				true
			)
		end,
	},
}
