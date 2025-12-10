FOLDER := $(notdir $(CURDIR))
VERSION := $(shell cat version.txt)

.PHONY: help build up shell

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

build: ## Build the cline Docker image
	docker build -t rophy/$(FOLDER):$(VERSION) .

up: ## Start all containers (creates .env with host UID/GID)
	echo "HOST_UID=`id -u`" > .env
	echo "HOST_GID=`id -g`" >> .env
	docker compose up -d

shell: ## Open a shell in the cline container as node user
	docker compose exec -u node cline bash
