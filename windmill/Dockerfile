ARG BASE_IMAGE=ghcr.io/windmill-labs/windmill:1.654.0

FROM php:8.3.21-cli AS php

FROM ${BASE_IMAGE}

# CVE-2024-11236, CVE-2025-1861: upgrade PHP from 8.3.7 to 8.3.21
COPY --from=php /usr/local/bin/php /usr/bin/php

# CVE-2026-27699: upgrade basic-ftp from 5.0.5 to 5.2.0
# CVE-2025-7783: upgrade form-data from 4.0.0 to 4.0.4
RUN BUN_CACHE=/tmp/windmill/cache_nomount/bun && \
    npm pack basic-ftp@5.2.0 --pack-destination /tmp && \
    rm -rf $BUN_CACHE/basic-ftp@5.0.5@@@1 $BUN_CACHE/basic-ftp && \
    mkdir -p $BUN_CACHE/basic-ftp@5.2.0@@@1 && \
    tar -xzf /tmp/basic-ftp-5.2.0.tgz -C $BUN_CACHE/basic-ftp@5.2.0@@@1 --strip-components=1 && \
    cp -r $BUN_CACHE/basic-ftp@5.2.0@@@1 $BUN_CACHE/basic-ftp && \
    npm pack form-data@4.0.4 --pack-destination /tmp && \
    rm -rf $BUN_CACHE/form-data@4.0.0@@@1 $BUN_CACHE/form-data && \
    mkdir -p $BUN_CACHE/form-data@4.0.4@@@1 && \
    tar -xzf /tmp/form-data-4.0.4.tgz -C $BUN_CACHE/form-data@4.0.4@@@1 --strip-components=1 && \
    cp -r $BUN_CACHE/form-data@4.0.4@@@1 $BUN_CACHE/form-data && \
    rm -f /tmp/basic-ftp-5.2.0.tgz /tmp/form-data-4.0.4.tgz
