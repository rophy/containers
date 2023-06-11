FROM rophy/azdevops-agent:20230611-r1

# Reference some steps from https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.focal

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=America/Los_Angeles

# === INSTALL Node.js ===

RUN apt-get update && \
    # Install Node 18
    apt-get install -y curl wget gpg && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    # Feature-parity with node.js base images.
    apt-get install -y --no-install-recommends git openssh-client && \
    npm install -g yarn && \
    # clean apt cache
    rm -rf /var/lib/apt/lists/*

# === BAKE BROWSERS INTO IMAGE ===

RUN npm install @playwright/test \
    && npx playwright install --with-deps chromium 

