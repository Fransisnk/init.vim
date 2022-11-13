
local async = require('hover.async')
local acronyms = require('biscuit_acronyms')

local function enabled()
  return true
end


local execute = async.void(function(done)
  local word = vim.fn.expand('<cWORD>')
  
  local delim = {',', '%s', '.', '-', '_'}
  local p = "[a-zA-Z0-9]+"
  local lines = {
	'***'..word..'***',
	'',
  }
  local found = false
  for w in string.gmatch(word, p) do
	  local match = acronyms[string.upper(w)]
	  if match then
	    found = true

		lines[#lines+1] = '**'..w..'**'
		for _, m in pairs(match) do
			lines[#lines+1] = '*'..string.gsub(m, ': ', '*: ', 1)
			lines[#lines+1] = ''
		end
		lines[#lines+1] = "---"
	  end
  end

  if not found then
    done()
	return
  end

  done{lines=lines, filetype="markdown"}
end)

require('hover').register {
  name = 'acronym_map',
  priority = 1001,
  enabled = enabled,
  execute = execute,
}

