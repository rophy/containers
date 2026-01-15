# containers

Monorepo for Docker container images.

## Structure

Each container has its own folder with a `Dockerfile` and optional `version.txt`.

## Local Build

```bash
# Build a specific container
make build <folder-name>

# Example
make build aws-cli
```

## CI/CD Pipeline

GitHub Actions automatically builds and pushes images on changes to `main`.

- **Registry**: `ghcr.io/<owner>/containers/<folder-name>`
- **Tags**: `YYYYMMDD-<sha>` on main, `pr-<number>` on PRs
- **PR builds**: Validated but not pushed

### Rules

- Each commit/PR must modify only **one** container folder
- Changes to multiple containers in a single PR will fail the build
