local plugin = require("remember_me")
local mock = require("luassert.mock")
local h = require("tests.helper")

describe("default setup includes", function()
  it("save and load aucmds", function()
    local aucmds = mock(require("remember_me.aucmds"), false)

    plugin.setup({ session_store = vim.fn.getcwd() })

    assert.stub(aucmds.create_save).was.called()
    assert.stub(aucmds.create_load).was.called()

    mock.revert(aucmds)
    h.clear_sessions()
  end)
end)
