local module = require("remember_me.module")
local validate = require("remember_me.validator")

local M = {}

local config = {
  ignore_ft = { "man", "gitignore", "gitcommit" },
  session_store = "~/.cache/nvim_sessions/",
  extension = ".sess.nvim",
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

local function should_save(root)
  return validate.filetype(config.ignore_ft) and root ~= nil
end

M.save = function()
  local root = validate.project_root(config.project_roots)
  if should_save(root) then
    module.save(config.session_store, root, config.extension)
  end
end

local function should_load(root)
  return validate.filetype(config.ignore_ft) and root ~= nil and vim.fn.argc() == 0
end

M.load = function()
  local root = validate.project_root(config.project_roots)
  if should_load(root) then
    module.load(config.session_store, root, config.extension)
  end
end

return M
