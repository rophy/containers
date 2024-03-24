VERSION := $(shell cat version.txt)
RAND_HASH := $(shell tr -dc A-Za-z0-9 </dev/urandom | head -c 8; echo)

build:
	docker build -t rophy/rundeck:$(VERSION) .

load:
	docker tag rophy/rundeck:$(VERSION) rophy/rundeck:$(RAND_HASH)
	kind load docker-image rophy/rundeck:$(RAND_HASH)
