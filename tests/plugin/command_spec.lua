require("plugin.remember_me")

describe("plugin should", function()
  it("create Memorize user command", function()
    assert.has_no.errors(function()
      vim.cmd("Memorize")
    end)
  end)
  it("create Remember user command", function()
    assert.has_no.errors(function()
      vim.cmd("Remember")
    end)
  end)
end)
