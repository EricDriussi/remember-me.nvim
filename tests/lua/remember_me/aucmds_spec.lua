local plugin = require("remember_me")
local mock = require("luassert.mock")

describe("default setup includes", function()
	it("save and load aucmds", function()
		local aucmds_mock = mock(require("remember_me.aucmds"), false)
		plugin.setup({ session_store = vim.fn.getcwd() })

		assert.stub(aucmds_mock.create).was.called()

		mock.revert(aucmds_mock)
	end)
end)

describe("autosave can be disabled", function()
    it("with autosave = false", function()
        local aucmds_mock = mock(require("remember_me.aucmds"), false)
        plugin.setup({ session_store = vim.fn.getcwd(), autosave = false })

        assert.stub(aucmds_mock.create).was_not.called()

        mock.revert(aucmds_mock)
    end)
end)
