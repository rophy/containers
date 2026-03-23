# claude

A dev container for AI-assisted development, bundling Claude Code and related tools with a full DevOps toolchain.

## Included Tools

### AI Coding Assistants

| Tool | Version |
|------|---------|
| claude-code | latest |
| cline | 2.8.1 |

### DevOps Toolchain

| Tool | Version |
|------|---------|
| Docker CLI (+ buildx, compose) | latest (Debian bookworm) |
| kubectl | 1.35.0 |
| Helm | 4.0.4 |
| AWS CLI | latest |
| Terraform | 1.14.3 |
| kind | latest |
| minikube | latest |
| GitHub CLI | 2.86.0 |

## Prebuilt Image

Prebuilt images are available at:

```
ghcr.io/rophy/containers/claude
```

Tags follow the format `YYYYMMDD-<commit-sha>`. Pull the latest with:

```sh
docker pull ghcr.io/rophy/containers/claude:<tag>
```

## Quick Start

### Build

```sh
make build
```

### Run

```sh
# Install the launcher script
make install

# Launch the container in the current directory
claude.sh
```

### Run directly with Docker

```sh
docker run --rm -it \
  -e HOST_UID=$(id -u) \
  -e HOST_GID=$(id -g) \
  -e DOCKER_GID=$(getent group docker | cut -d: -f3) \
  -v /var/run/docker.sock:/var/run/docker.sock:ro \
  -v "${HOME}/.devcontainer:/home/claude" \
  -v "$(pwd):$(pwd)" \
  --workdir="$(pwd)" \
  claude:latest
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `HOST_UID` | 1000 | UID to run as (mapped from host) |
| `HOST_GID` | 1000 | GID to run as (mapped from host) |
| `DOCKER_GID` | 999 | GID of the docker group on the host |
| `GOSU_USER` | claude | Username to run as |
| `WELCOME_MSG` | "Run 'claude' to start Claude Code." | Message shown at container start |

## Shell Aliases

The following aliases are configured in interactive login shells:

- `claude` → `claude --dangerously-skip-permissions`
- `docker-compose` is symlinked to `docker compose`
