local validate = require("remember_me.validator")
local h = require("tests.helper")

describe("validator should,", function()
  local project_root = { ".git", ".svn" }

  describe("for project_root,", function()
    it("return correct root when in a project", function()
      local vcs_fixture = "tests/fixtures/another_path/with/vcs/"
      vim.api.nvim_set_current_dir(vcs_fixture)
      local _, root = validate.if_in_project(project_root)
      assert.equals("another_path", root)
    end)

    it("return false when NOT in a project", function()
      local no_vcs_fixture = "tests/fixtures/a_path/with_no/vcs/fixture"
      local _, root = validate.if_in_project(project_root)
      -- simulate behavior since it will always default to this repo's root
      assert.equals(false, h.is_dir_in_path(no_vcs_fixture, root))
    end)
  end)

  describe("for filetype,", function()
    local ignored_ft = { "man", "gitignore", "gitcommit" }

    after_each(function()
      vim.cmd(":q")
    end)

    it("return true when ft is not to be ingored", function()
      local valid_file = "tests/fixtures/valid_ftp.md"
      vim.cmd(":vs " .. valid_file)
      assert.equals(true, validate.current_ft_against(ignored_ft))
    end)

    it("return false when ft is to be ignored", function()
      local file_to_ignore = "tests/fixtures/.gitignore"
      vim.cmd(":vs " .. file_to_ignore)
      assert.equals(false, validate.current_ft_against(ignored_ft))
    end)
  end)
end)
