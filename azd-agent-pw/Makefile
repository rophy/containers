VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/azd-agent-pw:$(VERSION) .

test:
	docker run --rm --entrypoint=bash -v `pwd`/tests:/azp/tests rophy/azd-agent-pw:$(VERSION) -c "npx playwright test"

