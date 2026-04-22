# k6 with xk6-sql and PostgreSQL driver for YugabyteDB YSQL load testing

FROM golang:1.25-bookworm AS builder

RUN go install go.k6.io/xk6/cmd/xk6@latest

RUN xk6 build \
    --with github.com/grafana/xk6-sql@latest \
    --with github.com/grafana/xk6-sql-driver-postgres@latest \
    --output /k6

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /k6 /usr/local/bin/k6

RUN k6 version

WORKDIR /scripts

CMD ["sleep", "infinity"]
