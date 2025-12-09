FOLDER := $(notdir $(CURDIR))
VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/$(FOLDER):$(VERSION) .

