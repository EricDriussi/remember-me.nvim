local M = {}

M.current_ft_against = function(ignored_ft)
  for _, ign_ftp in pairs(ignored_ft) do
    if vim.bo.filetype == ign_ftp then
      return false
    end
  end
  return true
end

M.if_in_project = function(valid_roots)
  local current = vim.fn.getcwd()
  local parent_path = current

  while true do
    for _, root in ipairs(valid_roots) do
      local parent_is_root = vim.fn.globpath(parent_path, root) ~= ""
      if parent_is_root then
        return true, parent_path
      end
    end

    current, parent_path = parent_path, vim.fn.fnamemodify(parent_path, ":h")
    if parent_path == current then
      break
    end
  end

  return false, ""
end

local function _fnv1a(s)
  local bit = require("bit")
  local prime = 1099511628211
  local hash = 14695981039346656037
  for i = 1, #s do
    hash = bit.bxor(hash, s:byte(i))
    hash = hash * prime
  end
  return hash
end

M.hashed_session_name = function(path)
  local dir_name = string.match(path, ".*/(.*)$")
  local hash = _fnv1a(path)
  return string.format("%s__%u", dir_name, hash)
end

return M
