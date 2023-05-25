local config = {}
config.defaults = {
	ignore_ft = { "man", "gitignore", "gitcommit" },
	-- TODO. option to store in current project
	-- vim.fn.getcwd() ?
	session_store = "~/.cache/remember-me/",
	ext = ".r.vim",
	project_roots = { ".git", ".svn" },
    autosave = true,
}
setmetatable(config, { __index = config.defaults })
return config
