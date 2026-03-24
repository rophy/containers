FROM yugabytedb/yugabyte:2025.2.0.1-b1

RUN dnf install -y epel-release \
    && dnf install -y --setopt=install_weak_deps=False \
      # terminal & editors
      tmux \
      vim \
      less \
      # performance & benchmarking
      sysstat \
      iotop \
      perf \
      strace \
      ltrace \
      # network tools
      iproute \
      iputils \
      net-tools \
      nmap-ncat \
      tcpdump \
      bind-utils \
      # process & system
      procps-ng \
      psmisc \
      lsof \
      htop \
      # misc utilities
      jq \
      wget \
      curl \
      tar \
      gzip \
      unzip \
    && dnf clean all \
    && rm -rf /var/cache/dnf
