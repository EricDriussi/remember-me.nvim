local new_au_cmd = vim.api.nvim_create_autocmd
local remember_me_group = vim.api.nvim_create_augroup("RememberMe", {})

local M = {}

M.create_save = function(save)
  new_au_cmd("VimLeavePre", {
    desc = "Memorize Project",
    group = remember_me_group,
    callback = save,
  })
end

M.create_load = function(load)
  new_au_cmd("VimEnter", {
    desc = "Remember Project",
    group = remember_me_group,
    callback = load,
    nested = true
  })
end

return M
