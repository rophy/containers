# https://github.com/patroni/patroni/blob/master/kubernetes/Dockerfile.citus

FROM postgres:16.3-bookworm
LABEL maintainer="Alexander Kukushkin <akukushkin@microsoft.com>"

RUN export DEBIAN_FRONTEND=noninteractive \
    && echo 'APT::Install-Recommends "0";\nAPT::Install-Suggests "0";' > /etc/apt/apt.conf.d/01norecommend \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-cache depends patroni | sed -n -e 's/.* Depends: \(python3-.\+\)$/\1/p' \
            | grep -Ev '^python3-(sphinx|etcd|consul|kazoo|kubernetes)' \
            | xargs apt-get install -y busybox vim-tiny curl jq less locales git python3-pip python3-wheel lsb-release \
    ## Make sure we have a en_US.UTF-8 locale available
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && if [ $(dpkg --print-architecture) = 'arm64' ]; then \
        apt-get install -y postgresql-server-dev-16 \
                           gcc make autoconf \
                           libc6-dev flex libcurl4-gnutls-dev \
                           libicu-dev libkrb5-dev liblz4-dev \
                           libpam0g-dev libreadline-dev libselinux1-dev\
                           libssl-dev libxslt1-dev libzstd-dev uuid-dev \
        && git clone -b "main" https://github.com/citusdata/citus.git \
        && MAKEFLAGS="-j $(grep -c ^processor /proc/cpuinfo)" \
        && cd citus && ./configure && make install && cd ../ && rm -rf /citus; \
    else \
        echo "deb [signed-by=/etc/apt/trusted.gpg.d/citusdata_community.gpg] https://packagecloud.io/citusdata/community/debian/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/citusdata_community.list \
        && curl -sL https://packagecloud.io/citusdata/community/gpgkey | gpg --dearmor > /etc/apt/trusted.gpg.d/citusdata_community.gpg \
        && apt-get update -y \
        && apt-get -y install postgresql-16-citus-12.1; \
    fi \
    && pip3 install --break-system-packages setuptools \
    && pip3 install --break-system-packages 'git+https://github.com/patroni/patroni.git#egg=patroni[kubernetes]' \
    && PGHOME=/home/postgres \
    && mkdir -p $PGHOME \
    && chown postgres $PGHOME \
    && sed -i "s|/var/lib/postgresql.*|$PGHOME:/bin/bash|" /etc/passwd \
    && /bin/busybox --install -s \
    # Set permissions for OpenShift
    && chmod 775 $PGHOME \
    && chmod 664 /etc/passwd \
    # Clean up
    && apt-get remove -y git python3-pip python3-wheel \
               postgresql-server-dev-16 gcc make autoconf \
               libc6-dev flex libicu-dev libkrb5-dev liblz4-dev \
               libpam0g-dev libreadline-dev libselinux1-dev libssl-dev libxslt1-dev libzstd-dev uuid-dev \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* /root/.cache

ADD entrypoint.sh /
ENV PGSSLMODE=verify-ca PGSSLKEY=/etc/ssl/private/ssl-cert-snakeoil.key PGSSLCERT=/etc/ssl/certs/ssl-cert-snakeoil.pem PGSSLROOTCERT=/etc/ssl/certs/ssl-cert-snakeoil.pem

RUN sed -i 's/^postgresql:/&\n  basebackup:\n    checkpoint: fast/' /entrypoint.sh \
    && sed -i "s|^    postgresql:|&\n      parameters:\n        max_connections: 100\n        shared_buffers: 16MB\n        ssl: 'on'\n        ssl_ca_file: $PGSSLROOTCERT\n        ssl_cert_file: $PGSSLCERT\n        ssl_key_file: $PGSSLKEY\n        citus.node_conninfo: 'sslrootcert=$PGSSLROOTCERT sslkey=$PGSSLKEY sslcert=$PGSSLCERT sslmode=$PGSSLMODE'|"  /entrypoint.sh \
    && sed -i 's/^      pg_hba:/&\n      - local all all trust/' /entrypoint.sh \
    && sed -i "s/^\(.*\) \(.*\) \(.*\) \(.*\) \(.*\) md5.*$/\1 hostssl \3 \4 all md5 clientcert=$PGSSLMODE/" /entrypoint.sh \
    && sed -i "s#^    \(superuser\|replication\):#&\n      sslmode: $PGSSLMODE\n      sslkey: $PGSSLKEY\n      sslcert: $PGSSLCERT\n      sslrootcert: $PGSSLROOTCERT#" /entrypoint.sh

EXPOSE 5432 8008
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 EDITOR=/usr/bin/editor
USER postgres
WORKDIR /home/postgres
CMD ["/bin/bash", "/entrypoint.sh"]
