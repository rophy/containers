import sql from "k6/x/sql";
import driver from "k6/x/sql/driver/oracle";

const db = sql.open(driver, "oracle://system:testpass@oracle:1521/XEPDB1");

export default function () {
  const results = db.query("SELECT 1 AS val FROM dual");
  for (const row of results) {
    console.log(`result: ${JSON.stringify(row)}`);
  }
}

export function teardown() {
  db.close();
}
