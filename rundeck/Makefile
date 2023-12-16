RAND_HASH := $(shell tr -dc A-Za-z0-9 </dev/urandom | head -c 8; echo)

build:
	docker build -t rundeck .

load:
	docker tag rundeck rundeck:$(RAND_HASH)
	kind load docker-image rundeck:$(RAND_HASH)
