local plugin = require("remember_me")
local mock = require("luassert.mock")
local h = require("tests.helper")

describe("remember_me should,", function()
  local vcs_path = "tests/fixtures/another_path/with/vcs/"
  local no_vcs_path = "tests/fixtures/a_path/with_no/vcs/"
  local test_dir = vim.fn.getcwd()
  plugin.setup({ session_store = test_dir })

  after_each(function()
    vim.api.nvim_set_current_dir(test_dir)
  end)
  before_each(function()
    vim.api.nvim_set_current_dir(test_dir)
  end)

  describe("for a valid project,", function()
    after_each(function()
      vim.cmd(":q")
    end)

    it("save and load given a valid ft", function()
      vim.api.nvim_set_current_dir(vcs_path)
      vim.cmd(":vs " .. vcs_path .. "fixture")
      local module = mock(require("remember_me.module"), false)

      plugin.save()
      plugin.load()

      assert.stub(module.save).was.called()
      assert.stub(module.load).was.called()
      mock.revert(module)
    end)

    it("NOT save or load given an invalid ft", function()
      vim.api.nvim_set_current_dir(vcs_path)
      vim.cmd(":vs " .. vcs_path .. ".gitignore")
      local module = mock(require("remember_me.module"), false)

      plugin.save()
      plugin.load()

      assert.stub(module.save).was_not.called()
      assert.stub(module.load).was_not.called()
      mock.revert(module)
    end)
  end)

  describe("for an ivalid project,", function()
    it("NOT save or load", function()
      vim.api.nvim_set_current_dir(no_vcs_path)
      local module = mock(require("remember_me.module"), false)

      plugin.save()
      plugin.load()

      -- Expect save not to be called.
      -- Simulates behavior since it would always
      -- default to the root of this project
      for str in h.split_path(no_vcs_path) do
        assert.stub(module.save).was_not.called_with(test_dir, str, ".r.vim")
        assert.stub(module.load).was_not.called_with(test_dir, str, ".r.vim")
      end
      mock.revert(module)
    end)
  end)

end)
