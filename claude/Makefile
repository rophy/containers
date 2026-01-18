.PHONY: help build install

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

build: ## Build docker image tagged claude:latest
	docker build -t claude:latest .

install: ## Install claude.sh to /usr/local/bin/
	sudo install -m 755 claude.sh /usr/local/bin/claude.sh
