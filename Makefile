NVIM ?= nvim

.PHONY: deps health lock check help

help:
	@printf 'Usage: make <target>\n\n'
	@printf 'Targets:\n'
	@printf '  deps   Sync pinned Lazy plugins headlessly\n'
	@printf '  health Run :checkhealth to verify the environment\n'
	@printf '  lock   Refresh lazy-lock.json with current plugin revisions\n'
	@printf '  check  Run deps and health sequentially\n'

deps:
	@echo '==> Syncing Lazy plugins'
	@$(NVIM) --headless "+Lazy! sync" +qa

health:
	@echo '==> Running :checkhealth'
	@$(NVIM) --headless "+checkhealth" +qa

lock:
	@echo '==> Updating lazy-lock.json'
	@$(NVIM) --headless "+Lazy! lock" +qa

check:
	@$(MAKE) deps
	@$(MAKE) health
