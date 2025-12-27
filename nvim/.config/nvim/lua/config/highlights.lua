-- Define all highlight groups in one place
local M = {}

function M.setup()
	-- Window separator
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = 1250067 })
	
	-- Make it clearly visible which argument we're at.
	local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
	vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter', { 
		fg = marked.fg,
		bg = marked.bg,
		ctermfg = marked.ctermfg,
		ctermbg = marked.ctermbg,
		bold = true 
	})

	-- Comments highlight group
	vim.api.nvim_set_hl(0, 'Comment', { fg = "#d4a574", ctermfg = 180, italic = true})
	
	-- Todo highlight group
	vim.api.nvim_set_hl(0, "Todo", { fg = "#ff9e64", bold = true })
end

return M