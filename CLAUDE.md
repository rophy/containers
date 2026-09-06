# Claude Code Guidelines

## Project Overview

See `README.md` for repo structure, local build instructions, and CI/CD pipeline details (registry, tagging, PR rules).

## Git Policies

- Prefix commit messages with: feat, fix, test, chore, docs, refactor
- Keep commit messages short and precise
- Do not include "Co-Authored-By" or any mention of Claude in commits

## GitHub Actions

- When creating or updating workflows, check the latest version of each action before using it (e.g. `gh api repos/<owner>/<action>/releases/latest --jq '.tag_name'`)
- Do not hardcode old versions from memory — always verify
