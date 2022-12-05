local M = {}

M.save = function(sess_store, project, extension)
  os.execute("mkdir -p " .. sess_store)
  local session = sess_store .. project .. extension
  vim.api.nvim_command("mksession! " .. session)
end

M.load = function(sess_store, project, extension)
  local session = sess_store .. project .. extension
  -- TODO. breaks if project is moved. sed the sess file?
  local session_exists = vim.fn.filereadable(vim.fn.expand(session)) == 1
  if session_exists then
    vim.api.nvim_command("source " .. session)
  end
end

return M
