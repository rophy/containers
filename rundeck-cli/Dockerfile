FROM bitnami/java:11.0.24-9-debian-12-r6

RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/rundeck/rundeck-cli/releases/download/v2.0.8/rd-2.0.8.zip && \
    unzip rd-2.0.8.zip && \
    rm rd-2.0.8.zip && \
    mv rd-2.0.8 /usr/local/rundeck-cli && \
    ln -s /usr/local/rundeck-cli/bin/rd /usr/local/bin/rd

ENV DISABLE_WELCOME_MESSAGE=true

CMD ["/bin/bash"]
