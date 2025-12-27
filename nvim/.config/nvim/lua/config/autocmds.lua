-- Groups prevent duplicate listeners
local function augroup(name)
	return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank({ timeout = 100 }) -- fade after 0.1s
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Create an autocmd to highlight todo keywords
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("todo_highlight"),
	callback = function()
		vim.fn.matchadd("Todo", [[\c\(TODO\|NOTE\|FIXME\|REFACTOR\|HARDCODE\|HACK\)]])
	end,
})

-- strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("strip_whitespace"),
	pattern = { "*.clj", "*.py", "*.rs", "*.txt", "*.md", "*.env", "*.toml" },
	callback = function(event)
		local lines = vim.api.nvim_buf_get_lines(event.buf, 0, -1, false)
		local cleaned = {}
		for _, line in ipairs(lines) do
			local cleaned_line = line:gsub("%s+$", "")
			table.insert(cleaned, cleaned_line)
		end
		vim.api.nvim_buf_set_lines(event.buf, 0, -1, false, cleaned)
	end,
})