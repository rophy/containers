VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/kubecolor:$(VERSION) .

test:
	docker run --rm rophy/kubecolor:$(VERSION) version --client=true
