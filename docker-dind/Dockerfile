FROM docker:29.8.0-dind-alpine3.24

# CVE-2026-60002: OpenSSH use-after-free (< 10.4p1)
# Alpine 3.24 only has 10.3p1; upgrade from edge
RUN apk upgrade --no-cache \
      --repository=https://dl-cdn.alpinelinux.org/alpine/edge/main \
      openssh-client-common openssh-client-default openssh-keygen
