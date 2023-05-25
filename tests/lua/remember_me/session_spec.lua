local mock = require("luassert.mock")
local Session = require("remember_me.session")

describe("session should", function()
	local session = Session.new("a_name", "a_path")
	session.store = "tests/fixtures/"

	after_each(function()
		os.execute("rm -rf tests/fixtures")
	end)
	before_each(function()
		os.execute("rm -rf tests/fixtures")
	end)

	it("save even if store dir does NOT exist", function()
		local api = mock(vim.api, false)

		session:save()

		local full_session_path = session.store .. session.name .. session.ext
		assert.stub(api.nvim_parse_cmd).was.called_with("mksession! " .. full_session_path, {})
		assert.stub(api.nvim_cmd).was.called()
		mock.revert(api)
		os.execute("rm -rf " .. session.store)
	end)

	it("load if available", function()
		local api = mock(vim.api, false)
		local existing_session = session.store .. session.name .. session.ext
		os.execute("mkdir " .. session.store)
		os.execute("touch " .. existing_session)

		session:load()

		assert.stub(api.nvim_parse_cmd).was.called_with("source " .. existing_session, {})
		assert.stub(api.nvim_cmd).was.called()
		mock.revert(api)
	end)

    it("delete if exists", function()
        local api = mock(vim.api, false)
        local existing_session = session.store .. session.name .. session.ext
        os.execute("mkdir " .. session.store)
        os.execute("touch " .. existing_session)

        session:forget()

        assert.stub(api.nvim_parse_cmd).was.called_with("!rm " .. existing_session, {})
        assert.stub(api.nvim_cmd).was.called()
        mock.revert(api)
    end)
end)
