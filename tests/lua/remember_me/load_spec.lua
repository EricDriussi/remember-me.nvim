local mock = require("luassert.mock")
local module = require("remember_me.module")
local h = require("tests.helper")

describe("load module should", function()
  local a_path = "tests/fixtures/"
  local a_project_name = "something"
  local a_suffix = ".sess.nvim"

  after_each(function()
    h.clear_sessions()
  end)
  before_each(function()
    h.clear_sessions()
  end)

  describe("load a session", function()
    it("when a session file exists", function()
      local session_to_load = a_path .. a_project_name .. a_suffix
      os.execute("touch " .. session_to_load)

      local api = mock(vim.api, false)
      module.load(a_project_name, a_path, a_suffix)

      assert.stub(api.nvim_command).was.called_with("source " .. session_to_load)
      mock.revert(api)
    end)
  end)

  describe("NOT load a session", function()
    it("when a session file does NOT exists", function()

      local api = mock(vim.api, false)
      module.load(a_project_name, a_path, a_suffix)

      assert.stub(api.nvim_command).was_not.called()
      mock.revert(api)
    end)
  end)
end)
