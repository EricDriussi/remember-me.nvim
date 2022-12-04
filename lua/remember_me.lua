local module = require("remember_me.module")
local validate = require("remember_me.validator")

local M = {}

local config = {
  ignored_filetypes = { "man", "gitignore", "gitcommit" },
  session_dir = "~/.cache/nvim_sessions/",
  session_suffix = ".sess.nvim",
  valid_roots = { ".git", ".svn" },
  -- TODO. also use full path as sess name
  use_full_path = false
}

M.setup = function(args)
  if type(args) ~= "table" then
    error("Setup func only accepts table as arg")
  else
    config = vim.tbl_deep_extend("force", config, args or {})
    -- TODO. create aucmds
  end
end

local function should_save(root_path)
  return validate.filetype(config.ignored_filetypes) and root_path ~= nil
end

M.save = function()
  local root_path = validate.project_root(config.valid_roots)
  if should_save(root_path) then
    module.save(root_path, config.session_dir, config.session_suffix)
  end
end

local function should_load(root_path)
  return validate.filetype(config.ignored_filetypes) and root_path ~= nil and vim.fn.argc() == 0
end

M.load = function()
  local root_path = validate.project_root(config.valid_roots)
  if should_load(root_path) then
    module.load(root_path, config.session_dir, config.session_suffix)
  end
end

return M
