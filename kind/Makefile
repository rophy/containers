VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/kind:$(VERSION) .

test:
	docker run --rm rophy/kind:$(VERSION) --version
