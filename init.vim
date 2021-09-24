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
Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'machakann/vim-sandwich'
" Plug 'vim-python/python-syntax'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'
Plug 'neovim/nvim-lspconfig'
Plug 'ray-x/lsp_signature.nvim'
Plug 'nvim-lua/completion-nvim'
Plug 'google/vim-maktaba'
Plug 'google/vim-glaive'
"Plug 'HallerPatrick/py_lsp.nvim'
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
call glaive#Install()

xnoremap <leader>c :w !clip.exe<cr><cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Completion
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/usr/bin/zsh
lua <<EOF
-- require'py_lsp'.setup {}
vim.lsp.set_log_level("debug")

local custom_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  require'completion'.on_attach(client)

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require'lspconfig'.pyright.setup{
	on_attach=custom_attach,
	settings = {
		  python = {
			analysis = {
			  typeCheckingMode = "off",
			  autoSearchPaths = true,
			  reportOptionalMemberAccess = false,
			  extraPaths = {"/mnt/c/projects/ais_tools"}
			  -- executionEnvironments = {{ root = "availability_predictor", extraPaths = {"/mnt/c/projects/ais_tools" }}}
			  }
		}
	}
}
require'lspconfig'.dockerls.setup{}
require"lsp_signature".setup{}
EOF
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:virtualenv_directory = '~/.cache/pypoetry/virtualenvs'
"let g:poetv_auto_activate = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting/Fixing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Testing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>ct :CoverageToggle<CR>



function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
nnoremap <leader>fx :PrettyXML<CR>
