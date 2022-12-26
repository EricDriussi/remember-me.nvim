local config = require("remember_me.config")
Project = {}
Project.__index = Project

local function _has_valid_ftp()
  for _, ign_ftp in pairs(config.ignore_ft) do
    if vim.bo.filetype == ign_ftp then
      return false
    end
  end
  return true
end

local function root_path()
  local current = vim.fn.getcwd()
  local parent_path = current

  while true do
    for _, root in ipairs(config.project_roots) do
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

function Project.new()
  local pro = setmetatable({}, Project)
  pro.has_root, pro.path = root_path()
  pro.name = string.match(pro.path, ".*/(.*)$")
  return pro
end

function Project:is_valid()
  return _has_valid_ftp() and self.has_root
end

return Project
