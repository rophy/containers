#!/bin/sh

set -e
set -u

tmp_dir="$(mktemp -d)"
trap 'rm -rf -- "$tmp_dir"' EXIT

if [[ $# -eq 0 ]] ; then
  2>&1 echo 'missing argument path_to_main.tf'
  exit 1
fi

config_file=$1

cd "${tmp_dir}"
cp "${config_file}" ./main.tf

TF_LOG=debug terraform init

mkdir -p /usr/share/terraform/plugins
cp -R ./.terraform/providers/registry.terraform.io /usr/share/terraform/plugins/
