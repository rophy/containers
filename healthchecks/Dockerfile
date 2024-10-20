FROM healthchecks/healthchecks:v3.5.2

USER root

COPY patches patches

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/* && \
    patches/apply.sh

USER hc
