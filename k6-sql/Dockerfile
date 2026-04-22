# k6 with xk6-sql, PostgreSQL, YugabyteDB, and Oracle drivers for SQL load testing

FROM golang:1.25-bookworm AS builder

RUN go install go.k6.io/xk6/cmd/xk6@latest

COPY xk6-sql-driver-yugabytedb /build/xk6-sql-driver-yugabytedb
COPY xk6-sql-driver-oracle /build/xk6-sql-driver-oracle

RUN xk6 build \
    --with github.com/grafana/xk6-sql@latest \
    --with github.com/grafana/xk6-sql-driver-postgres@latest \
    --with github.com/rophy/xk6-sql-driver-yugabytedb=/build/xk6-sql-driver-yugabytedb \
    --with github.com/rophy/xk6-sql-driver-oracle=/build/xk6-sql-driver-oracle \
    --output /k6

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /k6 /usr/local/bin/k6

RUN k6 version

WORKDIR /scripts

CMD ["sleep", "infinity"]
