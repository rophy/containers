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
    # build fio from source to avoid CVE-2023-49569 in ceph libs
    && dnf install -y --setopt=install_weak_deps=False gcc make libaio-devel \
    && curl -fsSL https://github.com/axboe/fio/archive/refs/tags/fio-3.39.tar.gz \
       | tar xz -C /tmp \
    && cd /tmp/fio-fio-3.39 \
    && ./configure --disable-rados \
    && make -j"$(nproc)" \
    && make install \
    && cd / && rm -rf /tmp/fio-fio-3.39 \
    && dnf remove -y gcc make libaio-devel \
    && dnf install -y --setopt=install_weak_deps=False libaio \
    && dnf clean all \
    && rm -rf /var/cache/dnf
