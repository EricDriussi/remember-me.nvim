local plugin = require("remember_me")
local mock = require("luassert.mock")
local h = require("tests.helper")

describe("remember_me should,", function()
  local repo_dir = vim.fn.getcwd()
  local root_path = "tests/fixtures/another_path"
  vim.api.nvim_set_current_dir(root_path .. "/with/vcs/")

  describe("given a valid env", function()
    it("save and load by path", function()
      local module = mock(require("remember_me.module"), false)

      local full_path = repo_dir .. "/" .. root_path
      local sep = "_-_"
      local ext = ".r.vim"
      plugin.setup({
        session_store = full_path,
        full_name_sep = sep,
        ext = ext,
        full_name = true
      })

      plugin.save()
      plugin.load()

      local name = full_path:gsub("/", sep)
      assert.stub(module.save).was.called_with(full_path, name, ext)
      assert.stub(module.load).was.called_with(full_path, name, ext)

      mock.revert(module)
      h.clear_sessions()
    end)
  end)
end)
