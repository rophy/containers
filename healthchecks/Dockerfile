FROM healthchecks/healthchecks:v3.5.2

USER root

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

COPY patches patches

RUN patches/apply.sh

USER hc
