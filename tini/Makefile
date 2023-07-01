VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/tini:$(VERSION) .

test:
	docker run --rm rophy/tini:$(VERSION) telepresence version
