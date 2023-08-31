VERSION := $(shell cat version.txt)

build:
	docker build -t rophy/rsyncd:$(VERSION) .

test:
	docker run --name=rsyncd -d -p 8873:873 rophy/rsyncd:$(VERSION)
	sleep 3
	echo changeme > /tmp/password
	chmod 600 /tmp/password
	rsync --port=8873 --password-file=/tmp/password ./Dockerfile rsync://rsyncd@localhost/share/testing && echo success!
	docker stop rsyncd && docker rm rsyncd
