" ===========================================================================
" # General
" ===========================================================================
set nocompatible    " Disable compatibility with vi which can cause unexpected issues

" Filtype
filetype off 		" Disable type file detection
filetype plugin on 	" Enable plugins and load plugin for the detected file type
filetype indent on 	" Load an indent file for the detected file type.

" ===========================================================================
" # Plugin
" ===========================================================================
call plug#begin("~/.config/nvim/autoload")

" GUI
Plug 'itchyny/lightline.vim'            " Lightline (status bar)
Plug 'andymass/vim-matchup'             " Highlight and navigate sets of matching text
Plug 'lewis6991/gitsigns.nvim'          " Git status in tabs bar
Plug 'romgrk/barbar.nvim'

" Theme
" Plug 'ellisonleao/gruvbox.nvim'

" Fuzzy finder
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Vim Iced (Clojure Repl)
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'liquidz/vim-iced', { 'for': 'clojure' }

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Semantic language support
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'kylechui/nvim-surround'
Plug 'hrsh7th/vim-vsnip'

" cmd
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp' 
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'

" Stylistic
Plug 'zirrostig/vim-schlepp'

" Rust
Plug 'rust-lang/rust.vim'

call plug#end()

" ===========================================================================
" # Customisation options
" ===========================================================================

" Search
set ignorecase		" Case insensitive search
set hlsearch		" Highlights searchs
set incsearch		" Incremental Search
set smartcase		" Override thew ignorecase option if searching for capital letters
set gdefault		" Search and replace
set history=10000	" Save history up to 10000

" Wildmenu
set helpheight=30
set wildmenu                " Enable auto completion meun after passing TAB
set wildmode=list:longest   " Make wildmenu behave like similar to Base completion
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor " File extensions to ignore when editing in vim

" Completion
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect
set cmdheight=2		" Better display for messages
set updatetime=300	" You will have bad experience for diagnostic messages when it's default 4000.

" Wide tabs
set shiftwidth=4	" width for auto indents
set softtabstop=4 	" see multiple spaces as tabstops
set tabstop=4		" number of columns occupied by a tab
set expandtab		" don't convert tabs to whitespace

" Editor
set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=7
set noshowmode
set hidden

" Color scheme
set termguicolors   " required for all themes
set background=dark " set the background tone
colorscheme onedark

" Files
set autoread
set noswapfile
set nowritebackup
set fileencoding=utf8
set fileformat=unix

" Pane Split
set splitright
set splitbelow

" Misc
syntax on                 " Turn synatx highlighting on
set number                " Add numbers to each line on the left-hand side
set relativenumber        " Line number one is the cursor line
set showmatch             " Highlight matching bracket
set ttyfast               " Speed up scrolling
set foldmethod=indent     " Enable indent folding by default
set showcmd               " Show partial command in status line
set mouse=a               " Enable mouse usage (all modes) in terminals
set clipboard=unnamedplus " Use system clipborad
set signcolumn=yes

" ===========================================================================
" # Mappings
" ===========================================================================
let mapleader = "\<Space>"

" Yank from cursor to end of line
nnoremap Y y$
" ; as :
nnoremap ; :

" Quick save
nmap <leader>w :w<cr>
" Quick save and quit
nmap <leader>q :wq<cr>

" Split window
nmap <silent> <leader>- :sp<cr>
nmap <silent> <leader><bar> :vsp<cr>

" Navigate the split view
nnoremap <silent> <leader>j <c-w>j
nnoremap <silent> <leader>k <c-w>k
nnoremap <silent> <leader>h <c-w>h
nnoremap <silent> <leader>l <c-w>l

" Resize split windows
noremap <silent> <leader><Up> <c-w>+
noremap <silent> <leader><Down> <c-w>-
noremap <silent> <leader><Left> <c-w>>
noremap <silent> <leader><Right> <c-w><
noremap <silent> <leader>= <c-w>=

" Center the cursor vertically when moving to the next word during a search
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Toggle between buffers
nnoremap <silent> <leader><leader> <c-^>

" Show stats
nnoremap <leader>z g<c-g>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Unhighlight search results
vnoremap <leader>g :nohlsearch<cr>
nnoremap <leader>g :nohlsearch<cr>

" fzf and Rg search
nnoremap <leader>f :Files<cr>
nnoremap <leader>r :Rg<cr>

" Schlepp
vmap <up> <Plug>SchleppUp
vmap <down> <Plug>SchleppDown
vmap <left> <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight

" Buffer bar (barbar)
nnoremap <silent> <leader>1 :BufferGoto 1<cr>
nnoremap <silent> <leader>2 :BufferGoto 2<cr>
nnoremap <silent> <leader>3 :BufferGoto 3<cr>
nnoremap <silent> <leader>4 :BufferGoto 4<cr>
nnoremap <silent> <leader>5 :BufferGoto 5<cr>
nnoremap <silent> <leader>6 :BufferGoto 6<cr>
nnoremap <silent> <leader>7 :BufferGoto 7<cr>
nnoremap <silent> <leader>8 :BufferGoto 8<cr>
nnoremap <silent> <leader>9 :BufferGoto 9<cr>
nnoremap <silent> <leader>0 :BufferLast<cr>
nnoremap <silent> <leader>x :BufferClose<cr>
nnoremap <silent> <leader>X :BufferRestore<cr>

" ===========================================================================
" # Vimscript
" ===========================================================================

" Schlepp {{{
let g:Schlepp#allowSquishingLines = 0
let g:Schlepp#allowSquishingBlock = 0
let g:Schlepp#trimWS = 0
" }}}

" Enable permananet undo
if version >= 703
	set undofile			" Save undos after files closes
	set undodir=~/.vim/undo		" Where to save undo histories
	set undoreload=10000
endif 

" Preview Fzf window at the bottom, occuping 20% of the window height
let g:fzf_layout = { 'down': '~30%' }

" Lightline configuration
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileencoding', 'filetype' ] ],
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Lua Scripts  {{{
lua << EOF

-- Set up cmp
-- https://github.com/hrsh7th/nvim-cmp/
local cmp = require'cmp'
cmp.setup({
	-- REQUIRED - you must specify a snippet engine
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
    mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' },
    }, {
		{ name = 'path' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
		{ name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` "if you enabled `native_menu`, this won't work anymore".
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
    sources = {
		{ name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
		{ name = 'path' }
    }, {
		{ name = 'cmdline' }
    })
})

-- Set up lspconfig
local lspconfig = require('lspconfig')
local function on_attach(client, buffer) 
	-- Get signatures (and _only_ signatures) when in argument lists.
 	-- require "lsp_signature".on_attach({
 	-- 	doc_lines = 0,
 	-- 	handler_opts = {
 	-- 		border = "none"
 	-- 	},
 	-- })
end 

local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.rust_analyzer.setup {
	on_attach=on_attach,
 	settings = {
 		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			}, 
 			cargo = {
 				allFeatures = true,
 			},
 			completion = {
 				postfix = {
 					enable = false,
 				},
 			},
 		},
 	},
 	capabilities = capabilities
}


-- set up vim surround
require'nvim-surround'.setup {} -- defualt configs

-- set up barbar.nvim
require'barbar'.setup {
    icons = {
        filetype = {
            enabled = false,
        },
    },
}


EOF
" }}}

" # Clojure {{{
" Enable vim-iced's default key mapping 
let g:iced_enable_default_key_mappings = v:true

" Formatting code functions with vim-iced's vim-sexp
let g:sexp_mappings = {'sexp_indet': '', 'sexp_indet_top': ''}
" }}}

" # Rust  {{{
let g:rustfmt_autosave = 1		" Auto run :RustFmt on saving buffer
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
" }}}
" ===========================================================================

" ===========================================================================
" # Autocmmands
" ===========================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Follow Rust code style rules
au Filetype rust source ~/.config/nvim/scripts/spacetab.vim
"au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.psql set filetype=sql
autocmd BufRead *.sql set filetype=sql
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.tex set filetype=tex

" Strip trailing spaces on save
autocmd BufWritePre *.clj :%s/\s\+$//e
autocmd BufWritePre *.py

augroup usr
    autocmd!
    autocmd BufRead     *.vim set foldmethod=marker

    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g'\"" |
        \ endif

    autocmd BufNewFile,BufRead  *.sol setf solidity
    autocmd BufWritePost        *.sync.py !jupytext -s %
augroup END
