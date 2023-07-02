require('telescope').setup{
  defaults = {
    layout_config = {
      horizontal = { width = 0.9 }
    },
  },
}
require("telescope").load_extension "file_browser"
require("telescope").load_extension "wikilinky"


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fs', builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<leader>fg', builtin.grep_string, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})


vim.keymap.set("n", "<leader>fb", ":Telescope file_browser", { noremap = true })
-- git
vim.keymap.set('n', '<leader>fgc', builtin.git_commits, {})
vim.keymap.set('n', '<leader>fgb', builtin.git_branches, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

