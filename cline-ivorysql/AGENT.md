# Cline Agent Guide: IvorySQL & Oracle Testing Environment

You are running inside an **air-gapped Docker container** with NO internet access. This guide contains everything you need to work with the databases in this environment.

## Environment Overview

```
┌─────────────────────────────────────────────────────────────┐
│  docker-compose network (internal only, no internet)        │
│                                                             │
│  ┌─────────┐     ┌─────────────┐     ┌─────────────┐       │
│  │  cline  │────▶│  ivorysql   │     │   oracle    │       │
│  │  (you)  │────▶│             │     │             │       │
│  └─────────┘     └─────────────┘     └─────────────┘       │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

| Container | Purpose | Port | Client |
|-----------|---------|------|--------|
| `cline` | Your environment | - | (you are here) |
| `ivorysql` | IvorySQL database | 5432 (PG mode), 1521 (Oracle mode) | `psql` |
| `oracle` | Oracle 23ai Free | 1521 | `sqlplus` |

## What is IvorySQL?

**IvorySQL** is a PostgreSQL-based database with Oracle compatibility features:

- Based on **PostgreSQL 18beta1** (IvorySQL 5beta1)
- Supports Oracle-compatible SQL syntax
- **PL/iSQL** = IvorySQL's implementation of Oracle's PL/SQL
- Supports Oracle packages (`CREATE PACKAGE`), procedures, functions
- Two connection modes:
  - **Port 5432**: Standard PostgreSQL behavior
  - **Port 1521**: Oracle compatibility mode (use this for PL/iSQL)

---

## IvorySQL Connection

### Credentials

| Parameter | Value |
|-----------|-------|
| Host | `ivorysql` |
| Port | `1521` (Oracle mode) or `5432` (PG mode) |
| User | `ivorysql` |
| Password | `ivorypwd` |
| Database | `ivorysql` |

### Connection Commands

```bash
# Set password to avoid prompts (REQUIRED)
export PGPASSWORD=ivorypwd

# Connect in Oracle compatibility mode (USE THIS FOR PL/iSQL)
psql -h ivorysql -U ivorysql -d ivorysql -p 1521

# Connect in PostgreSQL mode
psql -h ivorysql -U ivorysql -d ivorysql -p 5432
```

### Running SQL

```bash
# Single command
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -c "SELECT 1;"

# From a file
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -f /path/to/file.sql

# Multi-line with heredoc
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 << 'EOF'
SELECT version();
SELECT current_date;
EOF
```

### Creating Extensions

```bash
# dblink is required for PRAGMA AUTONOMOUS_TRANSACTION
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -c "CREATE EXTENSION IF NOT EXISTS dblink;"
```

---

## Oracle Connection

### Credentials

| Parameter | Value |
|-----------|-------|
| Host | `oracle` |
| Port | `1521` |
| Service | `FREEPDB1` (pluggable database) |
| User | `system` |
| Password | `orapwd` |

### Connection Commands

```bash
# Connect to Oracle
sqlplus system/orapwd@oracle:1521/FREEPDB1

# Silent mode (for scripts)
sqlplus -s system/orapwd@oracle:1521/FREEPDB1
```

### Running SQL

```bash
# Single command
echo 'SELECT sysdate FROM dual;' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1

# Multi-line with heredoc (RECOMMENDED)
cat << 'EOF' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1
SET SERVEROUTPUT ON SIZE 1000000
SELECT sysdate FROM dual;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello from Oracle');
END;
/
EXIT;
EOF
```

### Creating a Test User (Optional)

If you need a non-system user for testing:

```bash
cat << 'EOF' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1
-- Create test user
CREATE USER testuser IDENTIFIED BY testpwd
  DEFAULT TABLESPACE USERS
  QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE TO testuser;
GRANT EXECUTE ON DBMS_OUTPUT TO testuser;
EXIT;
EOF

# Then connect as:
sqlplus testuser/testpwd@oracle:1521/FREEPDB1
```

---

## PL/iSQL and PL/SQL Packages

### Package Structure

PL/SQL packages have two parts:
1. **Package Specification** (`.pks`) - declares public interface
2. **Package Body** (`.pkb`) - implements the procedures/functions

### IvorySQL Example

```bash
# 1. Create package spec
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 << 'EOF'
CREATE OR REPLACE PACKAGE test_pkg IS
  PROCEDURE hello(name VARCHAR2);
  FUNCTION add_numbers(a NUMBER, b NUMBER) RETURN NUMBER;
END;
/
EOF

# 2. Create package body
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 << 'EOF'
CREATE OR REPLACE PACKAGE BODY test_pkg IS
  PROCEDURE hello(name VARCHAR2) IS
  BEGIN
    RAISE NOTICE 'Hello, %', name;
  END;

  FUNCTION add_numbers(a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN a + b;
  END;
END;
/
EOF

# 3. Call the package
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -c "CALL test_pkg.hello('World');"
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -c "SELECT test_pkg.add_numbers(2, 3);"
```

### Oracle Example

```bash
# 1. Create package spec
cat << 'EOF' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1
CREATE OR REPLACE PACKAGE test_pkg IS
  PROCEDURE hello(name VARCHAR2);
  FUNCTION add_numbers(a NUMBER, b NUMBER) RETURN NUMBER;
END;
/
show errors
EOF

# 2. Create package body
cat << 'EOF' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1
CREATE OR REPLACE PACKAGE BODY test_pkg IS
  PROCEDURE hello(name VARCHAR2) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, ' || name);
  END;

  FUNCTION add_numbers(a NUMBER, b NUMBER) RETURN NUMBER IS
  BEGIN
    RETURN a + b;
  END;
END;
/
show errors
EOF

# 3. Call the package
cat << 'EOF' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1
SET SERVEROUTPUT ON SIZE 1000000
BEGIN
  test_pkg.hello('World');
END;
/
SELECT test_pkg.add_numbers(2, 3) FROM dual;
EOF
```

---

## Syntax Differences: IvorySQL vs Oracle

| Feature | IvorySQL | Oracle |
|---------|----------|--------|
| Console output | `RAISE NOTICE 'msg'` or `DBMS_OUTPUT` | `DBMS_OUTPUT.PUT_LINE` |
| Cursor record | `c RECORD;` declaration required | Implicit (no declaration needed) |
| Enable output | Automatic | `SET SERVEROUTPUT ON SIZE 1000000` |
| Schema creation | `CREATE SCHEMA IF NOT EXISTS name;` | `CREATE USER name IDENTIFIED BY pass;` |
| Drop table | `DROP TABLE IF EXISTS name;` | `DROP TABLE name;` (errors if not exists) |
| Exit script | Not needed | `EXIT;` required in heredoc |
| Statement terminator | `/` after PL block | `/` after PL block |
| Named parameters | `proc(param => value)` | Same |

### Converting Oracle Code to IvorySQL

```sql
-- Oracle (cursor record is implicit):
FOR c IN (SELECT * FROM mytable) LOOP
  process(c.column_name);
END LOOP;

-- IvorySQL (explicit RECORD declaration required):
DECLARE
  c RECORD;
BEGIN
  FOR c IN (SELECT * FROM mytable) LOOP
    process(c.column_name);
  END LOOP;
END;
```

---

## Known Limitations

### IvorySQL: Autonomous Transaction

IvorySQL implements `PRAGMA AUTONOMOUS_TRANSACTION` using dblink (separate DB connection). Limitations:

1. **Package variables not accessible** - autonomous TX runs in separate session
2. **Private procedures not callable** - only PUBLIC procedures work
3. **DO blocks not supported** - must be in named procedure/function

**Workaround**: Make procedures called from autonomous transactions PUBLIC.

### Oracle: DBMS_OUTPUT

Always enable before running PL/SQL that uses DBMS_OUTPUT:

```sql
SET SERVEROUTPUT ON SIZE 1000000
```

---

## Debugging

### IvorySQL

```bash
# Check for compilation errors
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -c "\d+ test_pkg"

# Enable verbose messages
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -c "SET client_min_messages = 'DEBUG';"
```

### Oracle

```sql
-- After CREATE PACKAGE or CREATE PACKAGE BODY
show errors

-- Query errors directly
SELECT line, position, text FROM user_errors WHERE name = 'TEST_PKG' ORDER BY sequence;
```

---

## Quick Reference

### IvorySQL (Oracle mode)

```bash
# One-liner
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -c "SQL HERE"

# Multi-line
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 << 'EOF'
SQL HERE
EOF

# From file
PGPASSWORD=ivorypwd psql -h ivorysql -U ivorysql -d ivorysql -p 1521 -f file.sql
```

### Oracle

```bash
# One-liner
echo 'SQL HERE' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1

# Multi-line
cat << 'EOF' | sqlplus -s system/orapwd@oracle:1521/FREEPDB1
SET SERVEROUTPUT ON
SQL HERE
EXIT;
EOF

# From file
sqlplus -s system/orapwd@oracle:1521/FREEPDB1 @file.sql
```

---

## Testing Workflow

When testing Oracle-to-IvorySQL compatibility:

1. **Write and test in Oracle first** - Oracle is the reference implementation
2. **Adapt for IvorySQL** - Apply necessary syntax transformations (cursor RECORD, etc.)
3. **Compare results** - Output should match between both databases

When testing IvorySQL-to-Oracle migration:

1. **Identify IvorySQL-specific syntax** - PostgreSQL extensions, `IF EXISTS`, etc.
2. **Convert to Oracle syntax** - Use Oracle equivalents
3. **Test in Oracle** - Verify identical behavior

---

## Important Reminders

- **NO INTERNET ACCESS** - You cannot fetch external resources or documentation
- **Use hostnames, not localhost** - Containers communicate via `ivorysql` and `oracle` hostnames
- **Always set PGPASSWORD** - IvorySQL requires authentication
- **Use port 1521 for PL/iSQL** - Oracle compatibility mode
- **Use EXIT; in Oracle heredocs** - Otherwise sqlplus hangs
- **Use SET SERVEROUTPUT ON in Oracle** - Required to see DBMS_OUTPUT
