local aucmds = require("remember_me.aucmds")
local config = require("remember_me.config")
require("remember_me.project")
require("remember_me.session")

local M = {}

M.setup = function(args)
  if args ~= nil and type(args) ~= "table" then
    error("Setup func only accepts table as arg")
    return
  end
  setmetatable(config, { __index = vim.tbl_extend("force", config.defaults, args) })
  if string.sub(config.session_store, -1) ~= "/" then
    config.session_store = config.session_store .. "/"
  end
  aucmds.create_save(M.save)
  aucmds.create_load(M.load)
end

M.save = function()
  local project = Project.new()

  if project:is_valid() then
    local session = Session.new(project.name, project.path)
    session:save()
  end
end

M.load = function()
  local project = Project.new()
  local no_args = vim.fn.argc() == 0

  if project:is_valid() and no_args then
    local session = Session.new(project.name, project.path)
    session:load()
  end
end

return M
