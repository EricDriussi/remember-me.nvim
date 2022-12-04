if vim.g.loaded_aucmd_toggle == 1 then
  return
end
vim.g.loaded_aucmd_toggle = 1

-- Offer the user a command
vim.api.nvim_create_user_command("AucmdForPluginUser", function(input)
  require("plugin_name").do_the_thing(2, input.args)
end, {
  desc = "A brief description",
  nargs = 1,
})
