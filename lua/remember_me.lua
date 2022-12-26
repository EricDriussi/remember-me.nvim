local module = require("remember_me.module")
local aucmds = require("remember_me.aucmds")
local validate = require("remember_me.validator")

local M = {}

local config = {
  ignore_ft = { "man", "gitignore", "gitcommit" },
  session_store = "~/.cache/remember-me",
  ext = ".r.vim",
  project_roots = { ".git", ".svn" }
}

M.setup = function(args)
  if args ~= nil and type(args) ~= "table" then
    error("Setup func only accepts table as arg")
    return
  end
  config = vim.tbl_deep_extend("force", config, args or {})
  if string.sub(config.session_store, -1) ~= "/" then
    config.session_store = config.session_store .. "/"
  end
  aucmds.create_save(M.save)
  aucmds.create_load(M.load)
end

M.save = function()
  local is_project, root_path = validate.if_in_project(config.project_roots)
  local ft_is_valid = validate.current_ft_against(config.ignore_ft)

  if is_project and ft_is_valid then
    local hashed_name = validate.hashed_session_name(root_path)
    module.save(config.session_store, hashed_name, config.ext)
  end
end

M.load = function()
  local is_project, root_path = validate.if_in_project(config.project_roots)
  local ft_is_valid = validate.current_ft_against(config.ignore_ft)
  local no_args = vim.fn.argc() == 0

  if is_project and ft_is_valid and no_args then
    local hashed_name = validate.hashed_session_name(root_path)
    module.load(config.session_store, hashed_name, config.ext)
  end
end

return M
