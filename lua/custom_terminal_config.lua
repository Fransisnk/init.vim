
function _G.make_ipynb(...)
	vim.api.nvim_exec('FloatermNew --width=0.5 --wintype=normal --name=ipynbterm --position=right ipython', false)
	vim.api.nvim_exec('FloatermSend --name=ipynbterm \\%load_ext autoreload', false)
	vim.api.nvim_exec('FloatermSend --name=ipynbterm \\%autoreload 2', false)
	vim.api.nvim_exec('FloatermSend --name=ipynbterm \\%autoindent', false)
end
