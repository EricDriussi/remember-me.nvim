if vim.g.loaded_remember_me == 1 then
	return
end
vim.g.loaded_remember_me = 1

vim.api.nvim_create_user_command("Memorize", function(opts)
    require("remember_me").memorize(not opts.bang)
end, {
    desc = "Try to save session for later",
    nargs = 0,
    bang = true,
})

vim.api.nvim_create_user_command("Remember", function(opts)
    require("remember_me").recall(not opts.bang)
end, {
    desc = "Try to load last session",
    bang = true,
})

vim.api.nvim_create_user_command("Forget", function(opts)
    require("remember_me").forget(not opts.bang)
end, {
    desc = "Try to delete last session",
    bang = true,
})

vim.api.nvim_create_user_command("AutoMemorize", function(opts)
    require("remember_me").autosave(not opts.bang)
end, {
    desc = "Enable/disable Autosaving session",
    bang = true,
})
