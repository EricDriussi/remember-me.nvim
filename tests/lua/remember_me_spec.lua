local plugin = require("remember_me")
local mock = require("luassert.mock")

describe("in a valid project, remember_me should", function()
	local vcs_path = "tests/fixtures/another_path/with/vcs/"
	local test_dir = vim.fn.getcwd()
	plugin.setup({ session_store = test_dir })

	after_each(function()
		vim.api.nvim_set_current_dir(test_dir)
		vim.cmd(":q")
	end)

	it("save and load given a valid ft", function()
		vim.api.nvim_set_current_dir(vcs_path)
		vim.cmd(":vs " .. vcs_path .. "fixture")

		local session_mock = mock(require("remember_me.session"), false)
		plugin.memorize()
		plugin.recall()

		assert.stub(session_mock.save).was.called()
		assert.stub(session_mock.load).was.called()
		mock.revert(session_mock.save)
		mock.revert(session_mock.load)
	end)

	it("NOT save or load given an invalid ft", function()
		vim.api.nvim_set_current_dir(vcs_path)
		vim.cmd(":vs " .. vcs_path .. ".gitignore")

		local session_mock = mock(require("remember_me.session"), false)
		plugin.memorize()
		plugin.recall()

		assert.stub(session_mock.save).was_not.called()
		assert.stub(session_mock.load).was_not.called()
		mock.revert(session_mock.save)
		mock.revert(session_mock.load)
	end)
end)
