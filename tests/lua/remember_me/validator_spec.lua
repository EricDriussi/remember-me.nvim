local validate = require("remember_me.validator")
local h = require("tests.helper")

describe("validator should,", function()
  local ignored_ft = { "man", "gitignore", "gitcommit" }
  local project_root = { ".git", ".svn" }

  describe("for project_root,", function()
    it("return root when in a project", function()
      local vcs_fixture = "tests/fixtures/another_path/with/vcs/fixture"
      vim.cmd(":e " .. vcs_fixture)
      local _, root = validate.current_file_in_project(project_root)
      assert.equals("another_path", root)
    end)

    it("return true when in a project", function()
      local vcs_fixture = "tests/fixtures/another_path/with/vcs/fixture"
      vim.cmd(":e " .. vcs_fixture)
      local is_project, _ = validate.current_file_in_project(project_root)
      assert.equals(true, is_project)
    end)

    it("return nil when vcs is absent", function()
      local no_vcs_fixture = "tests/fixtures/a_path/with_no/vcs/fixture"
      vim.cmd(":e " .. no_vcs_fixture)
      local _, root = validate.current_file_in_project(project_root)
      -- simulate behavior since it will always default to this repo's root
      assert.equals(false, h.is_dir_in_path(no_vcs_fixture, root))
    end)
  end)

  describe("for filetype,", function()
    it("return true when ft is not to be ingored", function()
      local valid_file = "tests/fixtures/valid_ftp.md"
      vim.cmd(":e " .. valid_file)
      assert.equals(true, validate.current_ft_against(ignored_ft))
    end)

    it("return false when ft is to be ignored", function()
      local file_to_ignore = "tests/fixtures/.gitignore"
      vim.cmd(":e " .. file_to_ignore)
      assert.equals(false, validate.current_ft_against(ignored_ft))
    end)
  end)
end)
