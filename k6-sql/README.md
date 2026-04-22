# k6-sql

k6 image with [xk6-sql](https://github.com/grafana/xk6-sql) for SQL database load testing.

## Included Drivers

| Driver | Import Path | database/sql Name | Use Case |
|--------|-------------|-------------------|----------|
| [lib/pq](https://github.com/lib/pq) | `k6/x/sql/driver/postgres` | `postgres` | Standard PostgreSQL |
| [yugabyte/pgx](https://github.com/yugabyte/pgx) | `k6/x/sql/driver/pgx` | `pgx` | YugabyteDB YSQL (cluster-aware, topology load balancing) |
| [go-ora](https://github.com/sijms/go-ora) | `k6/x/sql/driver/oracle` | `oracle` | Oracle Database (pure Go, no Instant Client needed) |

## Usage

### Standard PostgreSQL

```js
import sql from "k6/x/sql";
import driver from "k6/x/sql/driver/postgres";

const db = sql.open(driver, "postgres://user:pass@host:5432/dbname?sslmode=disable");

export default function () {
  const results = db.query("SELECT id, name FROM users LIMIT 10");
  for (const row of results) {
    console.log(`id: ${row.id}, name: ${row.name}`);
  }
}

export function teardown() {
  db.close();
}
```

### YugabyteDB YSQL

```js
import sql from "k6/x/sql";
import driver from "k6/x/sql/driver/pgx";

const db = sql.open(driver, "postgres://yugabyte:yugabyte@yb-tserver:5433/yugabyte?sslmode=disable&load_balance=true");

export default function () {
  const results = db.query("SELECT id, name FROM users LIMIT 10");
  for (const row of results) {
    console.log(`id: ${row.id}, name: ${row.name}`);
  }
}

export function teardown() {
  db.close();
}
```

The `load_balance=true` parameter enables YugabyteDB's cluster-aware topology load balancing.

### Oracle

```js
import sql from "k6/x/sql";
import driver from "k6/x/sql/driver/oracle";

const db = sql.open(driver, "oracle://user:pass@host:1521/service_name");

export default function () {
  const results = db.query("SELECT id, name FROM users WHERE ROWNUM <= 10");
  for (const row of results) {
    console.log(`id: ${row.ID}, name: ${row.NAME}`);
  }
}

export function teardown() {
  db.close();
}
```

### Running

```bash
# Run a script
docker run --rm -v ./scripts:/scripts rophy/k6-sql:latest k6 run /scripts/test.js

# Run as a sidecar (sleep forever)
docker run -d -v ./scripts:/scripts rophy/k6-sql:latest
```

## Testing with Docker Compose

A `docker-compose.yaml` is included with all three databases and a k6 service for local testing.

```bash
# Start all services (Oracle, PostgreSQL, YugabyteDB, k6)
docker compose up -d

# Run test scripts
docker compose exec k6 k6 run /scripts/test-postgres.js
docker compose exec k6 k6 run /scripts/test-yugabytedb.js
docker compose exec k6 k6 run /scripts/test-oracle.js

# Tear down
docker compose down
```
