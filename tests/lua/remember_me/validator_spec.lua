local validate = require("remember_me.validator")
local h = require("tests.helper")

describe("validator should,", function()
  local ignored_filetypes = { "man", "gitignore", "gitcommit" }
  local project_root = { ".git", ".svn" }
  describe("for project_root,", function()
    it("return project root when vcs is present", function()
      local vcs_fixture = "tests/fixtures/another_path/with/vcs/fixture"
      vim.cmd(":e " .. vcs_fixture)
      local root_path = validate.project_root(project_root)
      assert.equals("another_path", root_path)
    end)

    it("return nil when vcs is absent", function()
      local no_vcs_fixture = "tests/fixtures/a_path/with_no/vcs/fixture"
      vim.cmd(":e " .. no_vcs_fixture)
      local root_path = validate.project_root(project_root)
      -- simulate behavior since it will always default to this repo's root
      assert.equals(false, h.is_dir_in_path(no_vcs_fixture, root_path))
    end)
  end)

  describe("for filetype,", function()
    it("return true when ft is not to be ingored", function()
      local valid_file = "tests/fixtures/valid_ftp.md"
      vim.cmd(":e " .. valid_file)
      assert.equals(true, validate.filetype(ignored_filetypes))
    end)

    it("return false when ft is to be ignored", function()
      local file_to_ignore = "tests/fixtures/.gitignore"
      vim.cmd(":e " .. file_to_ignore)
      assert.equals(false, validate.filetype(ignored_filetypes))
    end)
  end)
end)
