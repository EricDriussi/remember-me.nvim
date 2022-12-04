local module = require("plugin_name.module")

local M = {}

-- default config
local config = {
  what_to_do = "add",
}

-- user config
M.setup = function(args)
  if type(args) ~= "table" then
    error("Setup func only accepts table as arg")
  else
    config = vim.tbl_deep_extend("force", config, args or {})
  end
end

-- public facing function
M.do_the_thing = function(a, b)
  if config.what_to_do == "add" then
    return module.add(a, b)
  elseif config.what_to_do == "multiply" then
    return module.multiply(a, b)
  else
    return {}
  end
end

return M
