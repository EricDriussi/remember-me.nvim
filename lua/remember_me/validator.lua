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
        local parent_dir = string.match(parent_path, ".*/(.*)$")
        return true, parent_dir
      end
    end

    current, parent_path = parent_path, vim.fn.fnamemodify(parent_path, ":h")
    if parent_path == current then
      break
    end
  end

  return false, nil
end

return M
