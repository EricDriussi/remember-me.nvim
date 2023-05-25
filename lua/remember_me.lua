local aucmds = require("remember_me.aucmds")
local config = require("remember_me.config")
local Project = require("remember_me.project")
local Session = require("remember_me.session")

local M = {}

local function merge_user_config(conf)
	setmetatable(config, { __index = vim.tbl_extend("force", config.defaults, conf) })
	if string.sub(config.session_store, -1) ~= "/" then
		config.session_store = config.session_store .. "/"
	end
end

M.setup = function(args)
	if args ~= nil and type(args) ~= "table" then
		error("Setup func only accepts table as arg")
		return
	end
	merge_user_config(args)
    if config.autosave then
        aucmds.create(M.memorize, M.recall)
    end
end

M.autosave = function(auto)
    if auto == true or (auto == nil and config.autosave) then
        aucmds.create(M.memorize, M.recall)
    else
        aucmds.clear()
    end
end


M.memorize = function(auto)
    local project = Project.new()

    if project:is_valid() then
        local session = Session.new(project.name, project.path)
        session:save()

        M.autosave(auto)
    end
end

M.recall = function(even_if_args)
    local should_load = (even_if_args == true) or (vim.fn.argc() == 0)
    if not should_load then
        return
    end

    local project = Project.new()
	if project:is_valid() then
		local session = Session.new(project.name, project.path)
		session:load()
	end
end

M.forget = function(auto)
    local project = Project.new()

    if project:is_valid() then
        local session = Session.new(project.name, project.path)
        session:delete()

        M.autosave(auto)
    end
end

return M
