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

lua require('plugins')
lua vim.notify = require("notify")

filetype plugin indent on       " required
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors/Themes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
set cursorline
let g:python_highlight_all = 1
" colorscheme nord
colorscheme gotham


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

" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
" set shortmess+=c
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
nnoremap <leader>cc <cmd>ccl<cr> " Close quickfix
nnoremap <leader>cd <cmd>call setqflist([], 'f')<cr> " Close quickfix


let g:python3_host_prog = '/usr/bin/python3'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Biscuit Remaps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ac <cmd>vsplit  ~/.config/nvim/lua/biscuit_acronyms.lua<cr>
