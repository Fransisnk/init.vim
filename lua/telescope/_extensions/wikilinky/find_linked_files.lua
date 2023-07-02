local conf = require('telescope.config').values
local entry_display = require('telescope.pickers.entry_display')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')
local wikilinky = require('wikilinky') -- replace with the actual require path of your plugin


local function pick_linked_files(opts)
	opts = opts or {}

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 30 },
			{ remaining = true },
		},
	})

	local function make_display(entry)
		return displayer {
			entry.filename,
			entry.text,
		}
	end

	pickers.new(opts, {
		prompt_title = 'Linked files',
		finder = finders.new_table({
			results = wikilinky.get_files_linking_to(vim.fn.expand('%:p')),
			entry_maker = function(entry)
				local previewer = previewers.new_buffer_previewer({
					define_preview = function(self, entry, status)
						-- Provide a function that could read the file and highlight the matching line
						local line_number = utils.index_of(entry.text, '[[' .. vim.fn.expand('%:t:r') .. ']]')
						if line_number then
							self.state.bufnr = vim.fn.bufnr()
							pcall(vim.api.nvim_buf_set_lines, self.state.bufnr, 0, -1, false,
								vim.fn.readfile(entry.filename))
							pcall(vim.api.nvim_buf_add_highlight, self.state.bufnr, self.state.hl_id,
								"TelescopePreviewMatch", line_number - 1, 0, -1)
						end
					end,
				})

				return {
					value = entry,
					ordinal = entry,
					display = make_display,
					filename = entry,
					text = vim.fn.join(vim.fn.readfile(entry), '\n'), -- You might want to cache this to optimize the performance
					previewer = previewer,
				}
			end,
		}),
		sorter = conf.file_sorter(opts),
		previewer = conf.grep_previewer(opts),
	}):find()
end

return {
	pick_linked_files = pick_linked_files,
}
