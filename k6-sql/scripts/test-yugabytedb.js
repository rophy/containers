import sql from "k6/x/sql";
import driver from "k6/x/sql/driver/pgx";

const db = sql.open(driver, "postgres://yugabyte:yugabyte@yugabytedb:5433/yugabyte?sslmode=disable&load_balance=true");

export default function () {
  const results = db.query("SELECT 1 AS val");
  for (const row of results) {
    console.log(`result: ${JSON.stringify(row)}`);
  }
}

export function teardown() {
  db.close();
}
