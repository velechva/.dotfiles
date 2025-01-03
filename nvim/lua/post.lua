local theme = require('last-color').recall() or 'default'
vim.cmd.colorscheme(theme)

local function file_exists(path)
  local f = io.open(path, "r")

  if f ~= nil then
    f:close()
    return true
  end

  return false
end

local function read_file(path)
  local f = assert(io.open(path, "r"))
  local content = f:read("*a")

  f:close()

  -- Trim trailing whitespace/newlines
  content = content:gsub("%s+$", "")

  return content
end


local home = os.getenv("HOME")
local path = home .. "/.nvimbg"

if file_exists(path) then
  local theme = read_file(path)

  vim.o.background = theme
  print("Background set to " .. theme)
end
