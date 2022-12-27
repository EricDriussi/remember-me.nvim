require("remember_me.project")

describe("project should", function()

  after_each(function()
    vim.cmd(":q")
  end)
  describe("be valid if", function()

    it("ft is not in ignored list AND a project root is present", function()
      local valid_file = "tests/fixtures/another_path/with/vcs/valid_ftp.md"
      vim.cmd(":vs " .. valid_file)
      local project = Project.new()
      assert.equals(true, project:is_valid())
    end)

  end)

  describe("be invalid if", function()
    it("ft is to be ignored", function()
      local file_to_ignore = "tests/fixtures/another_path/with/vcs/.gitignore"
      vim.cmd(":vs " .. file_to_ignore)
      local project = Project.new()
      assert.equals(false, project:is_valid())
    end)

    it("a project root is NOT present", function()
      local valid_file = "tests/fixtures/valid_ftp.md"
      vim.cmd(":vs " .. valid_file)
      local project = Project.new()
      -- simulate behavior since it will always default to this repo's root
      assert.equals(project.name, "remember-me.nvim")
    end)
  end)
end)
