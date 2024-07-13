VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/patroni-citus-k8s:$(VERSION) .
