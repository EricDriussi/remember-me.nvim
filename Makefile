.DEFAULT_GOAL := help

MAKE_PARAMS := $(filter-out $@,$(MAKECMDGOALS))
FILE_PATH := $(word 2,$(MAKE_PARAMS))

.PHONY: help
help: ## This help menu
	@grep -E '^\S+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'

.PHONY: lint
lint:   ## Linting & formatting
	stylua .

TEST_INIT := tests/minimal_init.lua
ALL_TESTS := nvim --headless --noplugin -u $(TEST_INIT) -c "PlenaryBustedDirectory tests/ {minimal_init='$(TEST_INIT)'; timeout=500}"
ONE_TEST := nvim --headless --noplugin -u $(TEST_INIT) -c "PlenaryBustedFile $(FILE_PATH)"

.PHONY: test
test: ## Run test given test or all tests
ifdef FILE_PATH
	@$(ONE_TEST)
else
	@$(ALL_TESTS)
endif

.PHONY: test-watch
test-watch: ## Run given test or all tests in watch mode
ifdef FILE_PATH
	- @$(ONE_TEST)
	@while true; do \
		inotifywait -qq -e create,modify,move,delete ./; \
		printf "\n[ . . . Re-running tests . . . ]\n"; \
		$(ONE_TEST); \
	done
else
	- @$(ALL_TESTS)
	@while true; do \
		inotifywait -qq -r -e create,modify,move,delete ./; \
		printf "\n[ . . . Re-running tests . . . ]\n"; \
		$(ALL_TESTS); \
	done
endif
