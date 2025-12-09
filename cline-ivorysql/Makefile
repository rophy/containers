FOLDER := $(notdir $(CURDIR))
VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/$(FOLDER):$(VERSION) .

up:
	echo "HOST_UID=`id -u`" > .env
	echo "HOST_GID=`id -g`" >> .env
	docker compose up -d
