set nocompatible               " be improved, required
filetype off                   " required
set relativenumber
set rtp+=~/.config/nvim/bundle/Vundle.vim

let mapleader = ","
set ts=4 sw=4 " tab to 4 spaces
map <F12> :tabedit $MYVIMRC<CR>
imap <F12> <C-c>:tabedit $MYVIMRC<CR>
set updatetime=300
set autoread 
set inccommand=nosplit " Live substitution highlight
set mouse=a

call vundle#begin()            " required
Plugin 'VundleVim/Vundle.vim'  " required
Plugin 'arcticicestudio/nord-vim'
Plugin 'preservim/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'machakann/vim-sandwich'
Plugin 'jiangmiao/auto-pairs'
Plugin 'petobens/poet-v'
Plugin 'vim-python/python-syntax'
Plugin 'psliwka/vim-smoothie'
Plugin 'dense-analysis/ale'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'unblevable/quick-scope'
Plugin 'neovim/nvim-lspconfig'
Plugin 'nvim-lua/completion-nvim'
call vundle#end()               " required
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
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
map <A-f> :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>fg :GFiles<CR>
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require'nvim_lsp'.pyls_ms.setup{on_attach=require'completion'.on_attach, 
								cmd = { "dotnet", "exec", "/home/fransik/python-language-server/output/bin/Debug/Microsoft.Python.LanguageServer.dll"}
    }
require'nvim_lsp'.dockerls.setup{}
require'nvim_lsp'.yamlls.setup{}
EOF
set completeopt=menuone,noinsert,noselect
let g:completion_enable_snippet = 'UltiSnips'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="google"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:poetv_auto_activate = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting/Fixing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_fixers = {'python': ['black', 'isort', 'autopep8']}

py3 << EOF
import os
import sys
import vim
import jedi
if 'VIRTUAL_ENV' in os.environ:
	base = os.environ['VIRTUAL_ENV']
	site_packages = os.path.join(base, 'lib', 'python%s' %  sys.version[:3], 'site-packages')
	prev_sys_path = list(sys.path)
	import site
	site.addsitedir(site_packages)
	sys.real_prefix = sys.prefix
	sys.prefix = base
	# Move the added items to the front of the path:
	new_sys_path = []
	for item in list(sys.path):
		if item not in prev_sys_path:
			new_sys_path.append(item)
			sys.path.remove(item)
	sys.path[:0] = new_sys_path
EOF
