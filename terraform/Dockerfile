FROM hashicorp/terraform:1.12

COPY scripts /scripts

RUN /scripts/download-plugins.sh /scripts/main.tf && \
    addgroup -g 1000 tf && \
    adduser -u 1000 -G tf -h /home/tf -D tf && \
    ln -s /bin/terraform /bin/tf

ENV CHECKPOINT_DISABLE=true
USER tf
WORKDIR /home/tf
