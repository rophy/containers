# cloud-iso

Ships cloud ISOs (e.g. Ubuntu cloud images) via container registry for air-gapped environments.

## How it works

The Dockerfile downloads an ISO from a given URL into a `scratch` image.
The resulting image is just the ISO file — no OS, no runtime.

## Usage

### Build via GitHub Actions

Trigger manually from the Actions tab or via CLI:

```bash
gh workflow run cloud-iso.yml \
  -f iso_url=https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img \
  -f image_name=ubuntu \
  -f image_tag=noble-20260401
```

This pushes to: `ghcr.io/<owner>/containers/cloud-iso/ubuntu:noble-20260401`

### Extract the ISO

```bash
# Using crane
crane export ghcr.io/<owner>/containers/cloud-iso/ubuntu:noble-20260401 - | tar -xf - -C /tmp/

# Using docker
docker create --name iso ghcr.io/<owner>/containers/cloud-iso/ubuntu:noble-20260401
docker cp iso:/ /tmp/iso/
docker rm iso
```
