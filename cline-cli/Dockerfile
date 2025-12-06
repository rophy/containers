FROM node:22-alpine

RUN apk add --update tini && npm install -g cline

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["cline"]
