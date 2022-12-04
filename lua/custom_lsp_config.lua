local coq = require "coq"
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}
local util = require 'lspconfig/util'

require('lspconfig')['pyright'].setup {
	coq.lsp_ensure_capabilities {
		on_attach = on_attach,
		flags = lsp_flags,
		settings = {
			python = {
				pythonPath = '/usr/bin/Python3'
			}
		},
		root_dir = function(fname)
			local root_files = {
				'pyproject.toml',
				'setup.py',
				'setup.cfg',
				'requirements.txt',
				'Pipfile',
				'pyrightconfig.json',
			}
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
		end,
	}
}
require('lspconfig')['tsserver'].setup {
	-- cmd = { "typescript-language-server" },
	on_attach = on_attach,
	flags = lsp_flags,
}
-- local black = require "efm/black"
require "lspconfig".efm.setup {
	on_attach = on_attach,
	flags = lsp_flags,
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			python = {
				{ formatCommand = "black --line-length 120 --quiet -", formatStdin = true }
			}
		}
	}
}

require 'lspconfig'.sumneko_lua.setup {
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
}


vim.diagnostic.config({
	virtual_text = false,
})
vim.keymap.set(
	"",
	"<Leader>l",
	require("lsp_lines").toggle,
	{ desc = "Toggle lsp_lines" }
)
