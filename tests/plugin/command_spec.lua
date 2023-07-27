require("plugin.remember_me")
local plugin = require("remember_me")

describe("plugin should", function()
	plugin.setup({ session_store = vim.fn.getcwd() })

	it("create Memorize user command", function()
		assert.has_no.errors(function()
			vim.cmd("Memorize")
		end)
	end)

	it("create Remember user command", function()
		assert.has_no.errors(function()
			vim.cmd("Remember")
		end)
	end)

    it("create Forget user command", function()
		assert.has_no.errors(function()
			vim.cmd("Forget")
		end)
    end)
end)
