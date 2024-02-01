#!/bin/bash

which go || NO_GO=1

if [[ "$NO_GO" -eq "1" ]]; then
    echo "Installing go..."
	curl -sLo go1.21.6.linux-amd64.tar.gz https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
    rm go1.21.6.linux-amd64.tar.gz
fi

rm -rf ./cluster-capacity
git clone -b v0.29.0 --depth 1  https://github.com/kubernetes-sigs/cluster-capacity
cd cluster-capacity
make build
make image
docker tag cluster-capacity:latest rophy/cluster-capacity:0.29.0-20240201-r1
