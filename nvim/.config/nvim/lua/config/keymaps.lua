local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Yank from cursor to end of line
keymap("n", "Y", "y$", opts)

-- ; as :
keymap("n", ";", ":", opts)

-- Quick save
keymap("n", "<leader>w", ":w<cr>", { noremap = true })

-- Quick save and quit
keymap("n", "<leader>q", ":wq<cr>", { noremap = true })

-- Split window
keymap("n", "<leader>-", ":sp<cr>", opts)
keymap("n", "<leader><bar>", ":vsp<cr>", opts)

-- Navigate the split view
keymap("n", "<leader>j", "<c-w>j", opts)
keymap("n", "<leader>k", "<c-w>k", opts)
keymap("n", "<leader>h", "<c-w>h", opts)
keymap("n", "<leader>l", "<c-w>l", opts)

-- Resize split windows
keymap("n", "<leader><Up>", "<c-w>+", opts)
keymap("n", "<leader><Down>", "<c-w>-", opts)
keymap("n", "<leader><Left>", "<c-w>>", opts)
keymap("n", "<leader><Right>", "<c-w><", opts)
keymap("n", "<leader>=", "<c-w>=", opts)

-- Center the cursor vertically when moving to the next word during a search
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)

-- Toggle between buffers
keymap("n", "<leader><leader>", "<c-^>", opts)

-- Show stats
keymap("n", "<leader>z", "g<c-g>", opts)

-- Left and right can switch buffers
keymap("n", "<left>", ":bp<CR>", { noremap = true })
keymap("n", "<right>", ":bn<CR>", { noremap = true })

-- Unhighlight search results
keymap("v", "<leader>g", ":nohlsearch<cr>", { noremap = true })
keymap("n", "<leader>g", ":nohlsearch<cr>", { noremap = true })

-- Move selected text up/down using built-in :m command
keymap("v", "<Up>", ":m '<-2<CR>gv=gv", { noremap = true })
keymap("v", "<Down>", ":m '>+1<CR>gv=gv", { noremap = true })

-- fzf and Rg search
--keymap("n", "<leader>f", ":Files<cr>", { noremap = true })
--keymap("n", "<leader>r", ":Rg<cr>", { noremap = true })
keymap("n", "<leader>f", function()
	require("fzf-lua").files()
end, opts)
keymap("n", "<leader>r", function()
	require("fzf-lua").live_grep()
end, opts)

-- Buffer bar (barbar)
keymap("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
keymap("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)
keymap("n", "<leader>x", "<Cmd>BufferClose<CR>", opts)
keymap("n", "<leader>X", "<Cmd>BufferRestore<CR>", opts)
