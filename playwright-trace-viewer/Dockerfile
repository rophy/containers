FROM node:18.16.0-alpine3.17 AS builder

RUN apk add --no-cache curl

WORKDIR /tmp/playwright

ENV PLAYWRIGHT_VERSION=1.34.3
RUN curl -sL "https://github.com/microsoft/playwright/archive/v${PLAYWRIGHT_VERSION}.tar.gz" | tar zxf - --strip-components 1 \
    && npm i \
    && npm run build

FROM nginx:1.25.0-alpine3.17-slim
COPY --from=builder /tmp/playwright/packages/playwright-core/lib/webpack/traceViewer /usr/share/nginx/html
