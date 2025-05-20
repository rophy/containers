#!/bin/sh
# source: https://github.com/getsentry/sentry-cli/blob/master/docker-entrypoint.sh

# For compatibility with older entrypoints
if [ "${1}" == "sentry-cli" ]; then
  shift
elif [ "${1}" == "sh" ] || [ "${1}" == "/bin/sh" ]; then
  exec "$@"
fi

exec /bin/sentry-cli "$@"
