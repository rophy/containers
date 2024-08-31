VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/skaffold-cli:$(VERSION) .

test:
	docker run --rm rophy/skaffold-cli:$(VERSION) skaffold version
