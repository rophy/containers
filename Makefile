.PHONY: build help

# Capture arguments after the target
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
# Turn them into do-nothing targets
$(eval $(ARGS):;@:)

build: ## Build a container image: make build <folder-name>
	@./scripts/build.sh $(ARGS)

help: ## Show this help message
	@echo "Usage: make <target> [args]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'
