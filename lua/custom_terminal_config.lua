local g = vim.g
function make_ipynb(...)
	vim.api.nvim_exec('FloatermNew --width=0.5 --wintype=normal --name=ipynbterm --position=right ipython', false)
	vim.api.nvim_exec('FloatermSend --name=ipynbterm \\%load_ext autoreload', false)
	vim.api.nvim_exec('FloatermSend --name=ipynbterm \\%autoreload 2', false)
	vim.api.nvim_exec('FloatermSend --name=ipynbterm \\%autoindent', false)
end

g.floaterm_keymap_new    = '<F7>'
g.floaterm_keymap_prev   = '<F8>'
g.floaterm_keymap_next   = '<F9>'
g.floaterm_keymap_toggle = '<F10>'

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>tp', "FloatermNew --width=0.5 --wintype=normal --position=right ipython", opts)
vim.keymap.set('n', '<leader>tt', make_ipynb, opts)
