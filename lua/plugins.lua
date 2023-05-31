local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
print(lazypath)
--{ 'nvim-lualine/lualine.nvim', dependencies= { 'kyazdani42/nvim-web-devicons', opt = true }require('lualine').setup() },

require("lazy").setup({
	'neovim/nvim-lspconfig', --require("custom_lsp_config"), },
	{ 'EdenEast/nightfox.nvim' },
	{ 'kyazdani42/nvim-web-devicons' },
	--{ 'lewis6991/gitsigns.nvim'function() require('custom_git_config') end }
	{ 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },
	'psliwka/vim-smoothie',
	--'unblevable/quick-scope',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-vsnip',
	'hrsh7th/vim-vsnip',
	{ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' },
	'ray-x/lsp_signature.nvim',
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.0',
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' }, },
	'norcalli/nvim-terminal.lua',
	{ 'voldikss/vim-floaterm' },
	{ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
	{ 'lewis6991/hover.nvim' },
})

require("custom_lsp_config")
require("custom_telescope_config")
require("custom_terminal_config")
require("custom_hover_config")
require('custom_treesitter_config')
require('custom_nightfox_config')
require("lsp_lines").setup()
