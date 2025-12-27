#!/bin/bash
set -e

# Find HammerDB installation directory
HAMMERDB_DIR=$(find /home -maxdepth 1 -type d -name "HammerDB-*" | head -1)
if [ -z "$HAMMERDB_DIR" ]; then
  echo "ERROR: HammerDB directory not found"
  exit 1
fi
cd "$HAMMERDB_DIR"

echo "HammerDB Performance Test Client"
echo "================================="
echo ""
echo "Available commands:"
echo "  build    - Build TPROC-C schema"
echo "  run      - Run TPROC-C workload"
echo "  delete   - Delete TPROC-C schema"
echo "  shell    - Interactive hammerdbcli shell"
echo "  cmd      - Run one-shot TCL command"
echo "  web      - Start web service (port 8080)"
echo ""

TIMESTAMP=$(date -u +%Y%m%d_%H%M%S)
OUTPUT_DIR="/tmp"

case "${1:-shell}" in
  build)
    echo "Building TPROC-C schema..."
    stdbuf -oL ./hammerdbcli auto /scripts/buildschema.tcl 2>&1 | tee "${OUTPUT_DIR}/build_${TIMESTAMP}.log"
    ;;
  run)
    echo "Running TPROC-C workload..."
    stdbuf -oL ./hammerdbcli auto /scripts/runworkload.tcl 2>&1 | tee "${OUTPUT_DIR}/run_${TIMESTAMP}.log"
    ;;
  delete)
    echo "Deleting TPROC-C schema..."
    stdbuf -oL ./hammerdbcli auto /scripts/deleteschema.tcl 2>&1 | tee "${OUTPUT_DIR}/delete_${TIMESTAMP}.log"
    ;;
  shell)
    echo "Starting interactive shell..."
    exec ./hammerdbcli
    ;;
  cmd)
    shift
    echo "$@" > /tmp/cmd.tcl
    ./hammerdbcli auto /tmp/cmd.tcl
    ;;
  web)
    echo "Initializing jobs database..."
    echo "jobs" > /tmp/init.tcl
    ./hammerdbcli auto /tmp/init.tcl
    exec ./hammerdbws wait
    ;;
  sleep)
    echo "Sleeping forever..."
    exec bash -c "sleep infinity"
    ;;
  *)
    echo "Unknown command: $1"
    echo "Usage: $0 {build|run|delete|shell|cmd|web}"
    exit 1
    ;;
esac
