local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()


--[[
vim.g.coq_settings = {
	auto_start = true,
	['display.pum.y_max_len'] = 3,
	['display.pum.y_ratio'] = .1,
	["keymap.pre_select"] = true,
	clients = {
		lsp = {
			enabled = true,
			weight_adjust = 1.1
		},
		tree_sitter = {
			enabled = true,
			weight_adjust = 1.0
		},
		tabnine = {
			enabled = false,
		},
	},
}
--]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'whatyouhide/vim-gotham'

	-- Statusline
	use {
		'nvim-lualine/lualine.nvim',
		config = require("lualine").setup(),
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- nicer command line and messages
	use {
		'folke/noice.nvim',
		config = function()
			require("noice").setup()
		end,
		requires = {
			'MunifTanjim/nui.nvim',
			'rcarriga/nvim-notify',
		}
	}

	-- Git tols
	-- use 'tpope/vim-fugitive'
	-- use 'airblade/vim-gitgutter'
	use {
		'lewis6991/gitsigns.nvim',
		config = require('custom_git_config')
	}

	-- () '' tools
	use { 'kylechui/nvim-surround',
		config = function()
			require("nvim-surround").setup()
		end,
	}

	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

	-- smooth scrolling
	use 'psliwka/vim-smoothie'

	-- f F preview
	use 'unblevable/quick-scope'

	-- lsp
	use {
		'neovim/nvim-lspconfig',
		config = require("custom_lsp_config"),
	}

	use 'ray-x/lsp_signature.nvim'
	--
	use { 'ms-jpq/coq_nvim',
		branch = 'coq',
		config = require('coq'),
	}
	-- 9000+ Snippets
	-- use 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

	use {
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require("lsp_lines").setup()
		end,
	}

	-- File finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { { 'nvim-lua/plenary.nvim' } },
	}
	-- use 'camgraff/telescope-tmux.nvim'
	-- use "nvim-telescope/telescope-file-browser.nvim"

	use 'norcalli/nvim-terminal.lua'


	-- Terminal
	use {
		'voldikss/vim-floaterm',
		config = require("custom_terminal_config")
	}

	-- tresitter
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- Hover
	use { 'lewis6991/hover.nvim',
		config = require("custom_hover_config")
	}

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)
