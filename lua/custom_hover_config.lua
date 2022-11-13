
require("hover").setup {
	init = function()
		require("hover.providers.lsp")
		require("acronym_map")
		-- require('hover.providers.dictionary')
	end,
	preview_opts = {
		border = nil
	},
	-- Whether the contents of a currently open hover window should be moved
	-- to a :h preview-window when pressing the hover keymap.
	preview_window = false,
	title = true
}

vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})

