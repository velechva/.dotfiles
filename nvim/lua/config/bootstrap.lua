local function cmd_is_installed(cmd)
  local handle = io.popen(string.format('command -v %s', cmd))
  local result = handle:read("*a")
  handle:close()
  return result ~= ''
end

local function install_cmd(cmd, installer)
  print(string.format('Installing %s...', cmd))
  local handle = io.popen('%s %s', installer, cmd)
  local result = handle:read("*a")
  handle:close()
  print(result)
end

local function ensure_installed(cmd, installer)
    if not cmd_is_installed(cmd) then
        install_cmd(cmd, installer)
end

ensure_installed('rust-analyzer', 'cargo install')
ensure_installed('pyright', 'pip install')

