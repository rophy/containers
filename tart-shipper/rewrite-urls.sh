#!/bin/sh
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <base-url>"
  echo ""
  echo "Rewrites Formula URLs in the tap to point at a corporate HTTP server."
  echo ""
  echo "Example:"
  echo "  $0 https://corp-nexus.example.com/tart"
  echo ""
  echo "This rewrites tart.rb and softnet.rb so brew fetches tarballs from:"
  echo "  <base-url>/tart.tar.gz"
  echo "  <base-url>/softnet.tar.gz"
  exit 1
fi

BASE_URL="${1%/}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TAP_DIR="$SCRIPT_DIR/tap"

if [ ! -d "$TAP_DIR/Formula" ]; then
  echo "Error: $TAP_DIR/Formula not found"
  exit 1
fi

for formula in "$TAP_DIR"/Formula/*.rb; do
  name=$(basename "$formula" .rb)
  sed -i.bak "s|url \"https://github.com/[^\"]*/${name}.tar.gz\"|url \"${BASE_URL}/${name}.tar.gz\"|" "$formula"
  rm -f "${formula}.bak"
  echo "Rewrote $(basename "$formula"): url -> ${BASE_URL}/${name}.tar.gz"
done

echo ""
echo "Done. Commit and push the tap to your corporate Git server:"
echo "  cd $TAP_DIR"
echo "  git add -A && git commit -m 'rewrite URLs for air-gapped install'"
echo "  git remote set-url origin <corp-git-url>"
echo "  git push"
