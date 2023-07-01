FROM alpine/curl:8.1.2

RUN curl -fL https://app.getambassador.io/download/tel2oss/releases/download/v2.14.0/telepresence-linux-amd64 -o /usr/local/bin/telepresence

RUN chmod a+x /usr/local/bin/telepresence

CMD ["/usr/local/bin/telepresence"]