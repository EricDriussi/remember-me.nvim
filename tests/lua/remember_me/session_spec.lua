local mock = require("luassert.mock")
require("remember_me.session")
local h = require("tests.helper")

describe("session should", function()
  local session = Session.new("a_name", "a_path")
  session.store = "tests/fixtures/false_path"

  after_each(function()
    h.clear_sessions()
  end)
  before_each(function()
    h.clear_sessions()
  end)

  it("save even if store dir does NOT exist", function()
    local api = mock(vim.api, false)

    session:save()

    local full_session_path = session.store .. session.name .. session.ext
    assert.stub(api.nvim_command).was.called_with("mksession! " .. full_session_path)
    mock.revert(api)
    os.execute("rm -rf " .. session.store)
  end)

  it("load if available", function()
    local api = mock(vim.api, false)
    local existing_session = session.store .. session.name .. session.ext
    os.execute("touch " .. existing_session)

    session:load()

    assert.stub(api.nvim_command).was.called_with("source " .. existing_session)
    mock.revert(api)
  end)

end)
