local module = require("remember_me.module")
local validate = require("remember_me.validator")

local M = {}

local config = {
  ignore_ft = { "man", "gitignore", "gitcommit" },
  session_store = "~/.cache/nvim_sessions/",
  extension = ".r.vim",
  project_roots = { ".git", ".svn" },
  -- TODO. also use full project path as sess name
  path_as_name = false
}

M.setup = function(args)
  if type(args) ~= "table" then
    error("Setup func only accepts table as arg")
  else
    config = vim.tbl_deep_extend("force", config, args or {})
    -- TODO. create aucmds
  end
end

M.save = function()
  local is_project, root = validate.if_in_project(config.project_roots)
  local ft_is_valid = validate.current_ft_against(config.ignore_ft)

  if is_project and ft_is_valid then
    module.save(config.session_store, root, config.extension)
  end
end

M.load = function()
  local is_project, root = validate.if_in_project(config.project_roots)
  local ft_is_valid = validate.current_ft_against(config.ignore_ft)
  local no_args = vim.fn.argc() == 0

  if is_project and ft_is_valid and no_args then
    module.load(config.session_store, root, config.extension)
  end
end

return M
