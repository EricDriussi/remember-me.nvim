local new_au_cmd = vim.api.nvim_create_autocmd
local augroup_name = "RememberMe"
local remember_me_group = vim.api.nvim_create_augroup(augroup_name, {})

local M = {}

local function on_open(save)
	new_au_cmd("VimLeavePre", {
		desc = "Memorize Project",
		group = remember_me_group,
		callback = save,
	})
end

local function on_close(load)
	new_au_cmd("VimEnter", {
		desc = "Remember Project",
		group = remember_me_group,
		callback = load,
		nested = true,
	})
end

M.create = function(save_func, load_func)
	on_open(save_func)
	on_close(load_func)
end

M.clear = function()
    vim.api.nvim_create_augroup(augroup_name, {})
end

return M
