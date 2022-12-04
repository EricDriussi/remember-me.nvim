local M = {}

M.save = function(root_dir, sess_dir, sess_suff)
  os.execute("mkdir -p " .. sess_dir)
  local path = sess_dir .. root_dir .. sess_suff
  vim.api.nvim_command("mksession! " .. path)
end

M.load = function(root_dir, sess_dir, sess_suff)
  local sessionName = sess_dir .. root_dir .. sess_suff
  -- TODO. breaks if project is moved. sed the sess file?
  local sessionExists = vim.fn.filereadable(vim.fn.expand(sessionName)) == 1
  if sessionExists then
    vim.api.nvim_command("source " .. sessionName)
  end
end

return M
