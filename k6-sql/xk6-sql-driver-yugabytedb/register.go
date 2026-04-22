package yugabytedb

import (
	"github.com/grafana/xk6-sql/sql"
	_ "github.com/yugabyte/pgx/v5/stdlib"
)

func init() {
	sql.RegisterModule("pgx")
}
