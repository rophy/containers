import sql from "k6/x/sql";
import driver from "k6/x/sql/driver/postgres";

const db = sql.open(driver, "postgres://testuser:testpass@postgres:5432/testdb?sslmode=disable");

export default function () {
  const results = db.query("SELECT 1 AS val");
  for (const row of results) {
    console.log(`result: ${JSON.stringify(row)}`);
  }
}

export function teardown() {
  db.close();
}
