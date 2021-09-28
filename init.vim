set nocompatible               " be improved, required
filetype off                   " required
set relativenumber

let mapleader = ","
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

" Statusline
Plug 'vim-airline/vim-airline'

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
Plug 'nvim-lua/completion-nvim'
 "Plug 'google/vim-maktaba'
"Plug 'google/vim-glaive'

" File finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" file icons
Plug 'kyazdani42/nvim-web-devicons'

" tresitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
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
:colorscheme nord

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filesystem
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fb <cmd>Telescope file_browser<cr>
nnoremap <leader>fl <cmd>Telescope live_grep<cr>
nnoremap <leader>fc <cmd>Telescope git_commits<cr>
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

map <F10> :split term://bash<CR>i
noremap <silent> <C-h> :vertical resize +3<CR>
noremap <silent> <C-l> :vertical resize -3<CR>
noremap <silent> <C-j> :resize +3<CR>
noremap <silent> <C-k> :resize -3<CR>
:nnoremap <A-s-h> :topleft vsplit 
:nnoremap <A-s-j> :botright split 
:nnoremap <A-s-k> :topleft split 
:nnoremap <A-s-l> :botright vsplit 

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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/usr/bin/zsh
lua require('custom_lsp_config')
let g:completion_trigger_keyword_length = 2 
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
set completeopt=menu,menuone,noselect

" 
" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_enable_snippet = 'UltiSnips'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="google"

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99
