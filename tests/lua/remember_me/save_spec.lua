local mock = require("luassert.mock")
local module = require("remember_me.module")

describe("save module should", function()
  local a_sess_store = "tests/fixtures/"
  local a_project_name = "something"
  local an_extension = ".sess.nvim"

  describe("save a session", function()
    it("when the session store dir exists", function()
      local api = mock(vim.api, false)
      module.save(a_sess_store, a_project_name, an_extension)

      local session = a_sess_store .. a_project_name .. an_extension
      assert.stub(api.nvim_command).was.called_with("mksession! " .. session)
      mock.revert(api)
    end)

    it("when the session store dir does NOT exists", function()
      local new_path = a_sess_store .. "new_path/"
      local api = mock(vim.api, false)
      module.save(new_path, a_project_name, an_extension)

      local session = new_path .. a_project_name .. an_extension
      assert.stub(api.nvim_command).was.called_with("mksession! " .. session)
      -- cleanup
      os.execute("rm -rf " .. new_path)
      mock.revert(api)
    end)
  end)
end)
