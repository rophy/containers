#!/bin/bash

set -e
set -u

tmpdir="$(mktemp -d)"
trap 'rm -rf -- "$tmpdir"' EXIT

git init
git config user.name temp
git config user.email temp@temp.com
git add .
git commit -m 'base commit'

find patches -type f -name '*.patch' > $tmpdir/patches.txt
while read p; do
  git apply $p
  git add .
  git commit -m "apply patch $p"
done <$tmpdir/patches.txt

rm -rf ./.git

