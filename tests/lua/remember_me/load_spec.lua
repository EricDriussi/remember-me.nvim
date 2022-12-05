local mock = require("luassert.mock")
local module = require("remember_me.module")
local h = require("tests.helper")

describe("load module should", function()
  local a_sess_store = "tests/fixtures/"
  local a_project_name = "something"
  local an_extension = ".r.vim"

  after_each(function()
    h.clear_sessions()
  end)
  before_each(function()
    h.clear_sessions()
  end)

  describe("load a session", function()
    it("when a session file exists", function()
      local existing_session = a_sess_store .. a_project_name .. an_extension
      os.execute("touch " .. existing_session)

      local api = mock(vim.api, false)
      module.load(a_sess_store, a_project_name, an_extension)

      assert.stub(api.nvim_command).was.called_with("source " .. existing_session)
      mock.revert(api)
    end)
  end)

  describe("NOT load a session", function()
    it("when a session file does NOT exists", function()

      local api = mock(vim.api, false)
      module.load(a_sess_store, a_project_name, an_extension)

      assert.stub(api.nvim_command).was_not.called()
      mock.revert(api)
    end)
  end)
end)
