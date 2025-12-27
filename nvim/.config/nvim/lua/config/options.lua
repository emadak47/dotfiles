-- set Leader first
vim.g.mapleader = " "

-- search
vim.opt.ignorecase	= true				-- case-insensitive search
vim.opt.hlsearch	= true				-- highlight search
vim.opt.incsearch	= true				-- incremental search
vim.opt.smartcase	= true				-- override ignorecase option if searching for capital letters
vim.opt.gdefault	= true				-- :%s/<X>/<Y>/g
vim.opt.history		= 10000

-- wildmenu
vim.opt.wildmenu    = true				-- auto-complete menu after TAB
vim.opt.wildmode    = 'list:longest'	-- auto-complete to longest common match
vim.opt.wildignore  = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor'

-- completion
vim.opt.completeopt = "menuone,noselect,noinsert"
vim.opt.cmdheight   = 2					-- height of cmdline at the bottom
vim.opt.updatetime  = 300				-- you will have bad experience for diagnostic messages when it's default 4000

-- wide tabs
vim.opt.shiftwidth  = 4					-- width for auto indents
vim.opt.softtabstop = 4					-- see multiple spaces as tabstops
vim.opt.tabstop		= 4					-- number of columns occupied by a tab
vim.opt.expandtab   = false				-- don't convert tabs to whitespace

-- editor
vim.opt.autoindent  = true
vim.opt.timeoutlen  = 300				-- http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
vim.opt.encoding	= "utf-8"
vim.opt.scrolloff	= 8					-- min. number of lines to keep above and below cursor
vim.opt.hidden      = true
vim.opt.grepformat	= "%f:%l:%c:%m"
vim.opt.grepprg		= "rg --vimgrep"

-- files
vim.opt.autoread	 = true
vim.opt.fileencoding = "utf8"
vim.opt.fileformat   = "unix"

-- nvim -d
vim.opt.diffopt:append('iwhite')		
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')

-- misc
vim.opt.termguicolors  = true
vim.opt.number		   = true
vim.opt.relativenumber = true
vim.opt.signcolumn     = 'yes'
vim.opt.foldmethod	   = 'manual'		-- manual folding by default
vim.opt.wrap		   = false
vim.opt.showmatch	   = true			-- highlight matching brackets
vim.opt.ttyfast		   = true
vim.opt.mouse		   = 'a'
vim.opt.showcmd		   = false
vim.opt.clipboard	   = 'unnamedplus'	-- always use system clipboard
vim.opt.splitright     = true
vim.opt.splitbelow     = true
vim.opt.undofile	   = true			-- unlimited 'u' -> ~/.local/state/nvim/undo/
vim.opt.vb			   = false
vim.opt.listchars	   = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'	-- hidden characters