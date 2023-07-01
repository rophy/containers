VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/telepresence-cli:$(VERSION) .

test:
	docker run --rm rophy/telepresence-cli:$(VERSION) telepresence version
