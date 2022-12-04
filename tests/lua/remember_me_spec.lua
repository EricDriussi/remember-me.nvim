local plugin = require("remember_me")
local mock = require("luassert.mock")
local h = require("tests.helper")

describe("remember_me should", function()
  local vcs_path = "tests/fixtures/another_path/with/vcs/"
  local vcs_fixture = vcs_path .. "fixture"
  local no_vcs_path = "tests/fixtures/a_path/with_no/vcs/"
  local no_vcs_fixture = no_vcs_path .. "fixture"

  after_each(function()
    h.clear_sessions()
  end)
  before_each(function()
    h.clear_sessions()
  end)

  describe("call", function()
    it("the save module when inside a project and for valid ft", function()
      vim.cmd(":e " .. vcs_fixture)
      local module = mock(require("remember_me.module"), false)
      plugin.save()

      assert.stub(module.save).was.called()
      mock.revert(module)
    end)

    it("the load module when inside a project and for valid ft", function()
      vim.cmd(":e " .. vcs_fixture)
      local module = mock(require("remember_me.module"), false)
      plugin.load()

      assert.stub(module.load).was.called()
      mock.revert(module)
    end)
  end)

  describe("NOT call", function()
    describe("the save module when", function()
      it("when inside a project for invalid ft", function()
        plugin.setup({ session_dir = vcs_path })
        vim.cmd(":e " .. vcs_path .. ".gitignore")

        local module = mock(require("remember_me.module"), false)
        plugin.save()

        assert.stub(module.save).was_not.called()
        mock.revert(module)
      end)

      it("when NOT inside a project", function()
        plugin.setup({ session_dir = no_vcs_path })
        vim.cmd(":e " .. no_vcs_fixture)

        local module = mock(require("remember_me.module"), false)
        plugin.save()

        -- Expect save not to be called.
        -- Simulates behavior since it would always
        -- default to the root of this project
        for str in h.split_path(no_vcs_path) do
          assert.stub(module.save).was_not.called_with(str, no_vcs_path, ".sess.nvim")
        end
        mock.revert(module)
      end)
    end)

    describe("the load module when", function()
      it("when inside a project for invalid ft", function()
        plugin.setup({ session_dir = vcs_path })
        vim.cmd(":e " .. vcs_path .. ".gitignore")

        local module = mock(require("remember_me.module"), false)
        plugin.load()

        assert.stub(module.load).was_not.called()
        mock.revert(module)
      end)

      it("when NOT inside a project", function()
        plugin.setup({ session_dir = no_vcs_path })
        vim.cmd(":e " .. no_vcs_fixture)

        local module = mock(require("remember_me.module"), false)
        plugin.load()

        -- Expect load not to be called.
        -- Simulates behavior since it would always
        -- default to the root of this project
        for str in h.split_path(no_vcs_path) do
          assert.stub(module.load).was_not.called_with(str, no_vcs_path, ".sess.nvim")
        end
        mock.revert(module)
      end)
    end)

  end)
end)
