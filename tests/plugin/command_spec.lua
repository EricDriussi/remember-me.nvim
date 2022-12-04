require("plugin.plugin_name")

describe("plugin should", function()
  it("create AucmdForPluginUser user command", function()
    assert.has_no.errors(function()
      vim.cmd("AucmdForPluginUser 3")
    end)
  end)
end)
