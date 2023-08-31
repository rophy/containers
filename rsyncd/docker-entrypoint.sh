#!/bin/sh
set -e

if [ -z "$RSYNCD_PASSWORD" ]; then
    echo 'WARNING: env var $RSYNCD_PASSWORD not defined, using container default, which is INSECURE!'
else
    echo "rsyncd:$RSYNCD_PASSWORD" > /home/rsyncd/rsyncd.secrets
fi

exec "$@"
