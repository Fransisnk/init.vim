set nocompatible               " be improved, required
filetype off                   " required
set relativenumber

let mapleader = " "
set ts=4 sw=4 " tab to 4 spaces
map <F12> :tabedit $MYVIMRC<CR>
imap <F12> <C-c>:tabedit $MYVIMRC<CR>
set updatetime=300
set autoread 
set inccommand=nosplit " Live substitution highlight
set mouse=a
set shell=/bin/zsh

call plug#begin(stdpath('data') . '/plugged')            " required
Plug 'VundleVim/Vundle.vim'  " required

" Theme
Plug 'arcticicestudio/nord-vim'
Plug 'whatyouhide/vim-gotham'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'

" Git tols
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" () '' tools
Plug 'kylechui/nvim-surround'

" smooth scrolling
Plug 'psliwka/vim-smoothie'

" f F preview
Plug 'unblevable/quick-scope'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
"
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
" Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

" File finder
Plug 'nvim-lua/plenary.nvim' " Used by telescope
Plug 'nvim-telescope/telescope.nvim'

Plug 'norcalli/nvim-terminal.lua'
Plug 'camgraff/telescope-tmux.nvim'

" Terminal
Plug 'voldikss/vim-floaterm'

" file icons
Plug 'kyazdani42/nvim-web-devicons'

" tresitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Hover
Plug 'lewis6991/hover.nvim'

call plug#end()               " required
filetype plugin indent on       " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors/Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set cursorline
let g:nord_cursor_line_number_background = 1
let g:nord_uniform_diff_background = 1
let g:python_highlight_all = 1
" colorscheme nord
colorscheme gotham

lua require('lualine').setup()
lua require("nvim-surround").setup()
lua require("noice").setup()
lua require("lsp_lines").setup()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filesystem
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
nnoremap <leader>fg <cmd>Telescope git_branches<cr>
nnoremap <leader>fs <cmd>Telescope tmux sessions<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movements
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows/Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set splitright
set splitbelow

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
" vnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.range_code_action()<CR>
" autocmd BufEnter * lua require'completion'.on_attach()

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lsp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:coq_settings = { 'auto_start': v:true }
lua require('custom_lsp_config')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hover
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('custom_hover_config')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:tnoremap <Esc> <C-\><C-n> " Remap Esc from terminal
nnoremap <CR> :noh<CR><CR>  " Disable highlight after search
augroup TerminalStuff
	" au! " Clear old autocommands
	autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

lua require('custom_treesitter_config')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua require('custom_terminal_config')
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F10>'

nnoremap <leader>tp :FloatermNew --width=0.5 --wintype=normal --position=right ipython<cr>

nnoremap <leader>tt <cmd>lua make_ipynb()<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" yank to end
nnoremap Y y$

" Centered movement
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Chunkwise undo
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
" 
" Text moving
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc>:m .+1<CR>==:star<CR>
inoremap <C-k> <esc>:m .-2<CR>==:star<CR>
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==


nnoremap <leader>cj <cmd>cn<cr> " Next quick fix error
nnoremap <leader>ck <cmd>cp<cr>
nnoremap <leader>cn <cmd>cnf<cr> " First error next file
nnoremap <leader>co <cmd>copen<cr> " Open quickfix
nnoremap <leader>cc <cmd>ccl<cr> " Open quickfix


let g:python3_host_prog = '/usr/bin/python3'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Biscuit Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ac <cmd>vsplit  ~/.config/nvim/lua/biscuit_acronyms.lua<cr>
