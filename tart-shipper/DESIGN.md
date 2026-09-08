# tart-shipper Design

## Problem

[Tart](https://github.com/openai/tart) is a macOS VM manager installed via Homebrew (`brew install openai/tools/tart`). In air-gapped corporate environments there is no access to GitHub for the Homebrew tap or release binaries.

## Solution

A Docker image that bundles everything needed to set up Tart in an air-gapped environment:

- The Homebrew tap repository (`openai/homebrew-tools`)
- Release tarballs (`tart.tar.gz`, `softnet.tar.gz`)
- A script to rewrite formula URLs to point at a corporate HTTP server
- Documentation

Docker is used as the transfer vehicle because corporate air-gapped environments typically support pulling images from an approved Docker registry.

## Contents

```
/shipper/
├── tap/                  # Full clone of openai/homebrew-tools
│   └── Formula/
│       ├── tart.rb       # Tart formula (v2.36.0)
│       └── softnet.rb    # Softnet formula (v0.23.0, tart dependency)
├── binaries/
│   ├── tart.tar.gz       # ~22MB, macOS arm64 binary
│   └── softnet.tar.gz    # ~5MB, macOS arm64 binary
├── rewrite-urls.sh       # Rewrites formula URLs to corporate HTTP server
└── README.md             # Usage instructions (shown by ENTRYPOINT)
```

## Workflow

### Admin (one-time setup)

1. **Pull** the shipper image from the internet-connected registry
2. **Transfer** the image to the air-gapped Docker registry (corporate pull pipeline, `docker save`/`load`, etc.)
3. **Extract** contents on an air-gapped machine:
   ```bash
   docker create --name tart-shipper <image>
   docker cp tart-shipper:/shipper ./tart-shipper
   docker rm tart-shipper
   ```
4. **Upload binaries** to a corporate HTTP server (Nexus, Artifactory, etc.):
   ```
   https://corp-nexus.example.com/tart/tart.tar.gz
   https://corp-nexus.example.com/tart/softnet.tar.gz
   ```
5. **Rewrite formula URLs** to point at the corporate server:
   ```bash
   ./tart-shipper/rewrite-urls.sh https://corp-nexus.example.com/tart
   ```
   This updates the `url` fields in the tap's Formula/*.rb files.
6. **Push the tap** to a corporate Git server:
   ```bash
   cd tart-shipper/tap
   git remote set-url origin https://corp-git.example.com/openai/homebrew-tools.git
   git push
   ```

### Users

```bash
brew tap openai/tools https://corp-git.example.com/openai/homebrew-tools.git
brew install openai/tools/tart
```

This installs both tart and its softnet dependency. No internet access required.

## Notes

- **softnet** is a hard dependency in the tart formula. It requires macOS Sequoia or later.
- The Docker image is built as `linux/amd64` for corporate registry compatibility (same rationale as ubuntu-tvm).
- The tap is included as a full Git repo so it can be pushed directly to corporate Git.
- Formula `sha256` checksums are preserved — they match the bundled tarballs, so `brew install` verification works without changes.
