local config = require("remember_me.config")
Session = {}
Session.__index = Session

local function _FNV_hash(s)
  local prime = 1099511628211
  local hash = 14695981039346656037
  for i = 1, #s do
    hash = require("bit").bxor(hash, s:byte(i))
    hash = hash * prime
  end
  return hash
end

function Session.new(project_name, project_path)
  local ses = setmetatable({}, Session)
  ses.name = string.format("%s__%u", project_name, _FNV_hash(project_path))
  ses.ext = config.ext
  ses.store = config.session_store
  return ses
end

function Session:save()
  os.execute("mkdir -p " .. self.store)
  local session = self.store .. self.name .. self.ext
  vim.api.nvim_command("mksession! " .. session)
end

function Session:load()
  local session = self.store .. self.name .. self.ext
  local session_exists = vim.fn.filereadable(vim.fn.expand(session)) == 1
  if session_exists then
    vim.api.nvim_command("source " .. session)
  end
end

return Session
