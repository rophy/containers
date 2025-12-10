FROM node:22-bookworm-slim

ARG INSTANT_CLIENT_VERSION=23.6.0.24.10
ARG INSTANT_CLIENT_DIR=2360000

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    gosu \
    libaio1 \
    passwd \
    postgresql-client \
    tini \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/oracle && cd /opt/oracle \
    && wget -q https://download.oracle.com/otn_software/linux/instantclient/${INSTANT_CLIENT_DIR}/instantclient-basic-linux.x64-${INSTANT_CLIENT_VERSION}.zip \
    && wget -q https://download.oracle.com/otn_software/linux/instantclient/${INSTANT_CLIENT_DIR}/instantclient-sqlplus-linux.x64-${INSTANT_CLIENT_VERSION}.zip \
    && unzip -oq instantclient-basic-linux.x64-${INSTANT_CLIENT_VERSION}.zip \
    && unzip -oq instantclient-sqlplus-linux.x64-${INSTANT_CLIENT_VERSION}.zip \
    && rm -f *.zip \
    && apt-get purge -y wget unzip && apt-get autoremove -y

ENV ORACLE_HOME=/opt/oracle/instantclient_23_6
ENV LD_LIBRARY_PATH=$ORACLE_HOME
ENV PATH=$PATH:$ORACLE_HOME

RUN npm install -g cline

COPY AGENT.md /AGENT.md
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/entrypoint.sh"]

CMD ["cline"]
