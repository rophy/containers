FROM jupyter/base-notebook:ubuntu-20.04
# Built from... https://hub.docker.com/r/jupyter/base-notebook/
#               https://github.com/jupyter/docker-stacks/blob/HEAD/base-notebook/Dockerfile
# Built from... Ubuntu 20.04

# VULN_SCAN_TIME=2021-08-24_00:59:21

# The jupyter/docker-stacks images contains jupyterhub and jupyterlab already.

# Example install of git and nbgitpuller.
# NOTE: git is already available in the jupyter/minimal-notebook image.
USER root
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        dnsutils \
        git \
        iputils-ping \
        curl \
        fzf \
        fzy \
        tmux \
        tree \
        htop \
        iftop \
        tig \
        silversearcher-ag \
        unzip \
    && rm -rf /var/lib/apt/lists/*

# nats
RUN curl -sLo nats.zip https://github.com/nats-io/natscli/releases/download/v0.0.34/nats-0.0.34-linux-amd64.zip \
    && unzip nats.zip \
    && mv nats-0.0.34-linux-amd64/nats /usr/local/bin \
    && rm -rf nats-0.0.34-linux-amd64 nats.zip

# jq
RUN curl -sLo ./jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
    && chmod +x ./jq \
    && mv ./jq /usr/local/bin

# yq
RUN curl -sLo ./yq.tar.gz https://github.com/mikefarah/yq/releases/download/v4.27.2/yq_linux_amd64.tar.gz \
    && tar -zxf yq.tar.gz ./yq_linux_amd64 \
    && mv yq_linux_amd64 /usr/local/bin/yq \
    && rm -f yq.tar.gz

# kubectl
RUN curl -sLO https://dl.k8s.io/release/v1.24.0/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/

# helm
RUN curl -sLo ./helm.tar.gz https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz \
    && tar -zxvf helm.tar.gz linux-amd64/helm \
    --strip-components 1 && mv ./helm /usr/local/bin/ \
    && rm ./helm.tar.gz

#k9s
RUN curl -sS https://webinstall.dev/k9s | bash
# RUN source ~/.config/envman/PATH.env

# vault
RUN curl -sLo vault.zip https://releases.hashicorp.com/vault/1.7.10/vault_1.7.10_linux_amd64.zip \
    && unzip vault.zip \
    && mv ./vault /usr/local/bin/ \
    && rm vault.zip

USER $NB_USER

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --no-cache-dir \
    -r /tmp/requirements.txt

# Support overriding a package or two through passed docker --build-args.
# ARG PIP_OVERRIDES="jupyterhub==1.3.0"
ARG PIP_OVERRIDES=
RUN if [[ -n "$PIP_OVERRIDES" ]]; then \
        pip install --no-cache-dir $PIP_OVERRIDES; \
    fi

RUN jupyter serverextension enable --py nbgitpuller --sys-prefix

# Uncomment the line below to make nbgitpuller default to start up in JupyterLab
#ENV NBGITPULLER_APP=lab

# conda/pip/apt install additional packages here, if desired.