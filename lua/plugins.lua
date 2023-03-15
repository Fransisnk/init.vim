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

vim.g.coq_settings = {
	['display.pum.y_max_len'] = 6,
	['display.pum.y_ratio'] = .2,
	['display.pum.fast_close'] = false,
	["keymap.pre_select"] = true,
	-- ['keymap.jump_to_mark'] = '<leader>n',
	['weights.recency'] = 1.2,
	['completion.skip_after'] = { "{", "}", "[", "]", '(', ')', ','},
	auto_start = 'shut-up',
	clients = {
		lsp = {
			enabled = true,
			weight_adjust = 1.1
		},
		tmux = {
			enabled = false,
			weight_adjust = 1.0
		},
		tree_sitter = {
			enabled = false,
			weight_adjust = 1.0
		},
		tabnine = {
			enabled = false,
		},
	},
}

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- use { '/Users/fransismnk/Projects/foundry-tools', requires = 'nvim-lua/plenary.nvim' }
	--use { 'whatyouhide/vim-gotham', run = vim.cmd [[ colorscheme gotham ]] }
	-- use { 'EdenEast/nightfox.nvim', config = require('custom_nightfox_config')}
	use { 'EdenEast/nightfox.nvim', config = require('custom_nightfox_config')}
	use { 'kyazdani42/nvim-web-devicons' }

	-- Statusline
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = require('lualine').setup()
	}

	-- nicer command line and messages
	--[[
	use({
  "folke/noice.nvim",
  config = function()
    require("noice").setup({
        -- add any options here
    })
  end,
  requires = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
})
	--]]

	-- Git tols
	-- use 'tpope/vim-fugitive'
	-- use 'airblade/vim-gitgutter'
	use {
		'lewis6991/gitsigns.nvim',
		config = function() require('custom_git_config') end
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


	use { 'ms-jpq/coq_nvim',
		branch = 'coq',
		--run = ':COQdeps',
	}
	--[[
	-- 9000+ Snippets
	-- use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

	use {
		'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
		config = function()
			require("lsp_lines").setup()
		end,
	}
	use 'ray-x/lsp_signature.nvim'
	--]]
	use {
		'neovim/nvim-lspconfig',
		config = require("custom_lsp_config"),
	}

	-- File finder
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		config = require("custom_telescope_config"),
		requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-file-browser.nvim' },
	}
	-- use 'camgraff/telescope-tmux.nvim'

	use 'norcalli/nvim-terminal.lua'


	-- Terminal
	use {
		'voldikss/vim-floaterm',
		config = require("custom_terminal_config")
	}

	-- tresitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = require('custom_treesitter_config')
	}

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
