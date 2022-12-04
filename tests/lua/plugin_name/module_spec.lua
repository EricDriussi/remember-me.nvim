local plugin = require("plugin_name.module")

describe("module should", function()
  it("add", function()
    assert(5, plugin.add(2, 3))
  end)

  it("multiply", function()
    assert(6, plugin.multiply(2, 3))
  end)
end)
