M = {}

function M.log_table(tabl)
  print(vim.inspect(tabl))
end

function M.is_dir_in_path(path, dir)
  return string.match(path, dir) ~= nil
end

function M.clear_sessions()
  os.execute("find . -type f -name '*.r.vim' -delete")
end

function M.split_path(path)
  return string.gmatch(path, "([^" .. "/" .. "]+)")
end

return M
