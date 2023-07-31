if vim.g.loaded_remember_me == 1 then
	return
end
vim.g.loaded_remember_me = 1

vim.api.nvim_create_user_command("Memorize", function()
	require("remember_me").memorize()
end, {
	desc = "Try to save session for later",
	nargs = 0,
})

vim.api.nvim_create_user_command("Remember", function()
	require("remember_me").recall()
end, {
	desc = "Try to load last session",
})

vim.api.nvim_create_user_command("Forget", function()
    require("remember_me").forget()
end, {
    desc = "Try to delete last session",
})
