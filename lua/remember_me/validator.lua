local M = {}

M.current_ft_against = function(ignored_ft)
  for _, ign_ftp in pairs(ignored_ft) do
    if vim.bo.filetype == ign_ftp then
      return false
    end
  end
  return true
end

local function get_parent_path(current)
  return vim.fn.fnamemodify(current, ":h")
end

local function get_dir(path)
  return string.match(path, ".*/(.*)$")
end

M.if_in_project = function(valid_roots)
  local current = vim.fn.getcwd()
  local parent_path = current

  while true do
    for _, root in ipairs(valid_roots) do
      if vim.fn.globpath(parent_path, root) ~= "" then
        return true, get_dir(parent_path)
      end
    end

    current, parent_path = parent_path, get_parent_path(parent_path)
    if parent_path == current then
      break
    end
  end

  return false, nil
end

return M
