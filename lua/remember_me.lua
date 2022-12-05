local module = require("remember_me.module")
local aucmds = require("remember_me.aucmds")
local validate = require("remember_me.validator")

local M = {}

local config = {
  ignore_ft = { "man", "gitignore", "gitcommit" },
  session_store = "~/.cache/nvim_sessions/",
  ext = ".r.vim",
  project_roots = { ".git", ".svn" },
  create_aucmds = true,
  full_name = false,
  full_name_sep = "_-_"
}

M.setup = function(args)
  if type(args) ~= "table" then
    error("Setup func only accepts table as arg")
  else
    config = vim.tbl_deep_extend("force", config, args or {})
    if config.create_aucmds then
      aucmds.create_save(M.save)
      aucmds.create_load(M.load)
    end
  end
end

M.save = function()
  local is_project, root_path = validate.if_in_project(config.project_roots)
  local ft_is_valid = validate.current_ft_against(config.ignore_ft)

  if is_project and ft_is_valid then
    if config.full_name then
      local full_path = root_path:gsub("/", config.full_name_sep)
      module.save(config.session_store, full_path, config.ext)
    else
      local dir_name = string.match(root_path, ".*/(.*)$")
      module.save(config.session_store, dir_name, config.ext)
    end
  end
end

M.load = function()
  local is_project, root_path = validate.if_in_project(config.project_roots)
  local ft_is_valid = validate.current_ft_against(config.ignore_ft)
  local no_args = vim.fn.argc() == 0

  if is_project and ft_is_valid and no_args then
    if config.full_name then
      local full_path = root_path:gsub("/", config.full_name_sep)
      module.load(config.session_store, full_path, config.ext)
    else
      local dir_name = string.match(root_path, ".*/(.*)$")
      module.load(config.session_store, dir_name, config.ext)
    end
  end
end

return M
