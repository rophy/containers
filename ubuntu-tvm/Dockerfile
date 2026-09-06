FROM busybox
COPY ubuntu-24.04.tvm /vm/ubuntu-24.04.tvm
ENTRYPOINT ["echo", "Ubuntu 24.04 Tart VM image\n\nTo extract:\n  docker create --name tmp <image>\n  docker cp tmp:/vm/ubuntu-24.04.tvm .\n  docker rm tmp\n\nTo import into Tart:\n  tart import ubuntu-24.04.tvm ubuntu"]
