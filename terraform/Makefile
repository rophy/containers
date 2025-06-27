VERSION := $(shell cat version.txt)

build:	
	docker build -t rophy/terraform:$(VERSION) .

shell:
	docker run --rm -it --network=none --entrypoint=sh rophy/terraform:$(VERSION) 
	# docker run --rm -it --entrypoint=sh rophy/terraform:$(VERSION) 