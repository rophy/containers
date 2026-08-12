ARG BASE_IMAGE=ghcr.io/windmill-labs/windmill:1.786.0

FROM php:8.3.33-cli-bookworm AS php

FROM ${BASE_IMAGE}

# CVE-2025-14179, CVE-2026-6722, CVE-2026-7261, CVE-2026-17543: upgrade PHP to 8.3.33
COPY --from=php /usr/local/bin/php /usr/bin/php

# CVE-2026-54058: upgrade Pillow from 11.1.0 to 12.3.0
RUN dpkg --purge --force-depends python3-pil && \
    python3 -c "\
import urllib.request, zipfile, os; \
url='https://files.pythonhosted.org/packages/f7/62/de5bdd77d935331f4f802edc11e4d82950f642caad6cb2f949837b8560e2/pillow-12.3.0-cp313-cp313-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl'; \
urllib.request.urlretrieve(url, '/tmp/pillow.whl'); \
zipfile.ZipFile('/tmp/pillow.whl').extractall('/usr/lib/python3/dist-packages'); \
os.remove('/tmp/pillow.whl')"

# CVE-2026-59873: upgrade tar from 6.2.1 to 7.5.19 (npm internal dependency)
RUN npm pack tar@7.5.19 --pack-destination /tmp && \
    rm -rf /usr/lib/node_modules/npm/node_modules/tar && \
    mkdir /usr/lib/node_modules/npm/node_modules/tar && \
    tar -xzf /tmp/tar-7.5.19.tgz -C /usr/lib/node_modules/npm/node_modules/tar --strip-components=1 && \
    rm -f /tmp/tar-7.5.19.tgz
