FROM rundeck/rundeck:4.17.4

USER root

RUN apt-get update && \
    apt-get install -y python3 python3-pip python-is-python3 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install kubernetes && \
    wget https://dl.k8s.io/release/v1.29.0/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

USER rundeck 
ENV RDECK_BASE=/home/rundeck
RUN wget https://github.com/rophy/rundeck-plugins-kubernetes/releases/download/2.0.14-rophy-20240324/kubernetes-2.0.14-rophy-20240324.zip && \
    mv kubernetes-2.0.14-rophy-20240324.zip ${RDECK_BASE}/libext

RUN wget https://github.com/rundeck-plugins/vault-storage/releases/download/1.3.12/vault-storage-1.3.12.jar && \
    mv vault-storage-1.3.12.jar ${RDECK_BASE}/libext
