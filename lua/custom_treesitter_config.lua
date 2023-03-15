require 'nvim-treesitter.configs'.setup {
	ensure_installed = { "typescript", "lua", "python", "regex", "bash", "markdown", "markdown_inline" },
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
		  init_selection = "gnn",
		  node_incremental = "grn",
		  scope_incremental = "grc",
		  node_decremental = "grm",
		},
  },
}
