local mock = require("luassert.mock")
local module = require("remember_me.module")

describe("save module should", function()
  local a_path = "tests/fixtures/"
  local a_project_name = "something"
  local a_suffix = ".sess.nvim"

  describe("save a session", function()
    it("when the dir exists", function()
      local api = mock(vim.api, false)
      module.save(a_project_name, a_path, a_suffix)

      local session_to_load = a_path .. a_project_name .. a_suffix
      assert.stub(api.nvim_command).was.called_with("mksession! " .. session_to_load)
      mock.revert(api)
    end)

    it("when the dir does NOT exists", function()
      local new_path = a_path .. "new_path/"
      local api = mock(vim.api, false)
      module.save(a_project_name, new_path, a_suffix)

      local session_to_load = new_path .. a_project_name .. a_suffix
      assert.stub(api.nvim_command).was.called_with("mksession! " .. session_to_load)
      -- cleanup
      os.execute("rm -rf " .. new_path)
      mock.revert(api)
    end)
  end)
end)
