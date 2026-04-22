package oracle

import (
	"github.com/grafana/xk6-sql/sql"
	_ "github.com/sijms/go-ora/v2"
)

func init() {
	sql.RegisterModule("oracle")
}
