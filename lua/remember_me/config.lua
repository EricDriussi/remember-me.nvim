local config = {}
config.defaults = {
  ignore_ft = { "man", "gitignore", "gitcommit" },
  session_store = "~/.cache/remember-me/",
  ext = ".r.vim",
  project_roots = { ".git", ".svn" }
}
setmetatable(config, { __index = config.defaults })
return config

