local M = {}

local scan = require 'plenary.scandir'
local path = require 'plenary.path'
local cmp = require 'cmp'


function M.collect_markdown_files(dir)
	local markdown_files = scan.scan_dir(dir, {
		search_pattern = "%.md$",
		depth = 4,
	})

	local markdown_file_paths = {}
	for _, file in ipairs(markdown_files) do
		local p = path:new(file)
		print(file)
		markdown_file_paths[p:make_relative(vim.fn.getcwd())] = true
	end

	return markdown_file_paths
end

function M.navigate_link()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local before_cursor = string.sub(line, 1, col)

	local start_pos = string.find(before_cursor, '%[%[.*%]%]$')
	if not start_pos then
		return
	end

	local link = string.sub(before_cursor, start_pos, col)
	local file_name = string.match(link, '%[%[(.*)%]%]')
	if not file_name then
		return
	end

	local file_path = string.format('%s.md', file_name)
	if not vim.loop.fs_stat(file_path) then
		-- Create the file if it doesn't exist.
		vim.loop.fs_open(file_path, 'w', 438, vim.schedule_wrap(function(err, fd)
			vim.loop.fs_close(fd)
		end))
	end

	vim.cmd(string.format('edit %s', file_path))
end

vim.api.nvim_set_keymap('n', '<CR>', '<Cmd>lua require"wikilinky".navigate_link()<CR>', { noremap = true })


local Source = {
	config = { root_dir = "/home/fransis/projects/wikilinks" },
	filetypes = { '.md' }
}

Source.new = function()
	local self = setmetatable({}, { __index = Source })
	self.wikitable = M.collect_markdown_files(self.config.root_dir)

	self.get_debug_name = function()
		return 'wiki_links'
	end
	self.get_keyword_pattern = function()
		return '\\[\\[\\a\\+'
	end
	return self
end

Source.complete = function(self, args, callback)
	local items = {}
	for file_path in pairs(self.wikitable) do
		local file_name = string.gsub(file_path, '.md$', '')
		local name_w_brackets = string.format('[[%s]]', file_name)
		table.insert(items,
			{
				word = file_name,
				label = name_w_brackets,
				insertText = name_w_brackets
			}
		)
	end
	self.items = table
	callback(items)
end

cmp.register_source('wiki_links', Source.new())


local function find_links_in_file(filename)
  local links = {}

  -- Read file
  local file = io.open(filename, "r")
  if not file then return links end
  local content = file:read("*all")
  file:close()

  -- Find links
  for link in string.gmatch(content, "%[%[(.-)%]%]") do
    table.insert(links, link)
  end

  return links
end



local file_links = {}

function M.index_links()
	local files = scan.scan_dir(Source.config.root_dir, {
		search_pattern = "%.md$",
		depth = 4,
	})
  file_links = {}

  for _, file in ipairs(files) do
    local links = find_links_in_file(file)
    for _, link in ipairs(links) do
      if not file_links[link] then
        file_links[link] = {}
      end
      table.insert(file_links[link], file)
    end
  end
  -- ... any remaining indexing code ...
end

function M.get_files_linking_to(file)
  return file_links[file] or {}
end


local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')



function M.find_files_linking_to_current_file()
  local current_file = vim.fn.expand('%:p')
  local linking_files = M.get_files_linking_to(current_file)

  pickers.new({}, {
    prompt_title = 'Files linking to current file',
    finder = finders.new_table({
      results = linking_files,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end,
    }),
    sorter = conf.file_sorter({}),
    previewer = previewers.vim_buffer_cat.new({}),
    attach_mappings = function(_, map)
      map('i', '<CR>', actions.select_default)
      map('n', '<CR>', actions.select_default)
      return true
    end,
  }):find()
end


return M
