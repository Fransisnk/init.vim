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

call plug#begin(stdpath('data') . '/plugged')            " required
Plug 'VundleVim/Vundle.vim'  " required

" Theme
Plug 'arcticicestudio/nord-vim'
Plug 'whatyouhide/vim-gotham'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

" Git tolls
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" () '' tools
Plug 'machakann/vim-sandwich'

" smooth scrolling
Plug 'psliwka/vim-smoothie'

" f F preview
Plug 'unblevable/quick-scope'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
" Plug 'nvim-lua/completion-nvim'

" File finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'norcalli/nvim-terminal.lua'
Plug 'camgraff/telescope-tmux.nvim'

" Terminal
Plug 'voldikss/vim-floaterm'

" file icons
Plug 'kyazdani42/nvim-web-devicons'

" tresitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

 " completion
" Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'RishabhRD/popfix'
Plug 'RishabhRD/nvim-lsputils'

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
lua require('custom_completion_config')
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
vnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.range_code_action()<CR>
" autocmd BufEnter * lua require'completion'.on_attach()

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lsp
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua require('custom_lsp_config')
lua vim.lsp.set_log_level('WARN')
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
"call glaive#Install()

xnoremap <leader>c :w !clip.exe<cr><cr>

lua require('custom_treesitter_config')
set shell=/usr/bin/zsh

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="google"

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

let g:python3_host_prog = '/usr/bin/python3'
