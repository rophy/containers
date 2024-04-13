FROM alpine:3.19.1

RUN apk add --no-cache curl && \
	mkdir -p /tmp/logcli && \
	cd /tmp/logcli && \
	curl -fsSL -o logcli-linux-amd64.zip https://github.com/grafana/loki/releases/download/v2.9.7/logcli-linux-amd64.zip && \
	unzip logcli-linux-amd64.zip && \
	mv ./logcli-linux-amd64 /usr/local/bin/logcli && \
	chmod +x /usr/local/bin/logcli && \
	logcli --version && \
	rm -rf /tmp/logcli

ENTRYPOINT ["/usr/local/bin/logcli"]
