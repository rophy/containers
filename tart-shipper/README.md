# tart-shipper

Bundles Tart (macOS VM manager) and its dependencies for air-gapped installation.

## Contents

  /shipper/
  ├── tap/                  Homebrew tap (openai/homebrew-tools, git repo)
  │   └── Formula/
  │       ├── tart.rb       Tart v2.36.0
  │       └── softnet.rb    Softnet v0.23.0 (tart dependency)
  ├── binaries/
  │   ├── tart.tar.gz       ~22MB
  │   └── softnet.tar.gz    ~5MB
  ├── rewrite-urls.sh       Rewrites formula URLs
  └── README.md             This file

## Admin Setup

1. Extract contents:

     docker create --name tart-shipper <this-image>
     docker cp tart-shipper:/shipper ./tart-shipper
     docker rm tart-shipper

2. Upload binaries to a corporate HTTP server (Nexus, Artifactory, etc.)

3. Rewrite formula URLs:

     ./tart-shipper/rewrite-urls.sh https://corp-nexus.example.com/tart

4. Push tap to corporate Git:

     cd tart-shipper/tap
     git add -A && git commit -m 'rewrite URLs for air-gapped install'
     git remote set-url origin https://corp-git.example.com/openai/homebrew-tools.git
     git push

## User Install

     brew tap openai/tools https://corp-git.example.com/openai/homebrew-tools.git
     brew trust openai/tools
     brew install openai/tools/tart
