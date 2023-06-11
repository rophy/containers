VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/azdevops-agent:$(VERSION) .

test:
	docker run --rm -e AZP_URL=https://dev.azure.com -e AZP_TOKEN=abcdefghijk -e PROXY_URL=http://217.23.6.40:1080 rophy/azdevops-agent:$(VERSION)