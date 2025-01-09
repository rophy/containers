FROM getsentry/sentry-cli:2.36.2 AS sentry-cli
FROM alpine:3.20.5

COPY ./docker-entrypoint.sh /
COPY --from=sentry-cli /bin/sentry-cli /bin/sentry-cli
ENTRYPOINT ["/docker-entrypoint.sh"]

