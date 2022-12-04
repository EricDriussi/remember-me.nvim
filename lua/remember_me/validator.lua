local M = {}

M.filetype = function(ignored_filetypes)
  local ft = vim.bo.filetype
  for _, ift in pairs(ignored_filetypes) do
    if ift == ft then
      return false
    end
  end
  return true
end

-- TODO. wtf is going on here?
local function match(dir, pattern)
  if string.sub(pattern, 1, 1) == "=" then
    return vim.fn.fnamemodify(dir, ":t") == string.sub(pattern, 2, #pattern)
  else
    return vim.fn.globpath(dir, pattern) ~= ""
  end
end

M.project_root = function(valid_roots)
  -- TODO. refactor, possibly two funcs
  local current = vim.api.nvim_buf_get_name(0)
  local parent = vim.fn.fnamemodify(current, ":h") -- direct parent dir
  -- vim.fn.getcwd() seems to get root when in git, else direct parent dir

  while 1 do
    for _, pattern in ipairs(valid_roots) do
      if match(parent, pattern) then
        return string.match(parent, ".*/(.*)$")
      end
    end
    current, parent = parent, vim.fn.fnamemodify(parent, ":h")
    if parent == current then
      break
    end
  end
  return nil
end

return M
