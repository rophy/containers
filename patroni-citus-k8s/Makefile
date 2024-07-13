VERSION := $(shell cat version.txt)

build:
	docker build -t patroni-citus-k8s .

tag: build
	docker tag patroni-citus-k8s rophy/patroni-citus-k8s:$(VERSION)
