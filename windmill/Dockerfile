ARG BASE_IMAGE=ghcr.io/windmill-labs/windmill:1.654.0

FROM php:8.3.33-cli-bookworm AS php

FROM ${BASE_IMAGE}

# CVE-2024-11236, CVE-2025-1861, CVE-2025-14179, CVE-2026-6722, CVE-2026-7261: upgrade PHP to 8.3.33
COPY --from=php /usr/local/bin/php /usr/bin/php

# CVE-2026-33845, CVE-2026-42010: upgrade libgnutls30
# CVE-2026-31789: upgrade openssl/libssl3
# CVE-2026-23112, CVE-2026-43011, CVE-2026-43037, CVE-2026-53215: upgrade linux-libc-dev
RUN apt-get update && \
    apt-get install -y --only-upgrade \
      libgnutls30 \
      openssl libssl3 \
      linux-libc-dev && \
    rm -rf /var/lib/apt/lists/*

# CVE-2025-62718, CVE-2026-42043, CVE-2026-42044, CVE-2026-42264: upgrade axios from 1.7.7 to 1.15.2
RUN BUN_CACHE=/tmp/windmill/cache_nomount/bun && \
    npm pack axios@1.15.2 --pack-destination /tmp && \
    rm -rf $BUN_CACHE/axios@1.7.7@@@1 $BUN_CACHE/axios && \
    mkdir -p $BUN_CACHE/axios@1.15.2@@@1 && \
    tar -xzf /tmp/axios-1.15.2.tgz -C $BUN_CACHE/axios@1.15.2@@@1 --strip-components=1 && \
    cp -r $BUN_CACHE/axios@1.15.2@@@1 $BUN_CACHE/axios && \
    rm -f /tmp/axios-1.15.2.tgz

# CVE-2026-27699: upgrade basic-ftp from 5.0.5 to 5.2.0
# CVE-2025-7783: upgrade form-data from 4.0.0 to 4.0.4
# CVE-2026-59873: upgrade tar from 6.2.1 to 7.5.19 (npm internal dependency)
RUN npm pack tar@7.5.19 --pack-destination /tmp && \
    rm -rf /usr/lib/node_modules/npm/node_modules/tar && \
    mkdir /usr/lib/node_modules/npm/node_modules/tar && \
    tar -xzf /tmp/tar-7.5.19.tgz -C /usr/lib/node_modules/npm/node_modules/tar --strip-components=1 && \
    rm -f /tmp/tar-7.5.19.tgz

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
