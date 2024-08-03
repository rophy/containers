VERSION := $(shell cat version.txt)

build:
	docker build -t cloud-provider-kind .

tag:
	docker tag cloud-provider-kind rophy/cloud-provider-kind:$(VERSION)

run-host:
	docker run --rm --network host -v /var/run/docker.sock:/var/run/docker.sock cloud-provider-kind

run-kind:
	docker run --rm --network kind -v /var/run/docker.sock:/var/run/docker.sock cloud-provider-kind