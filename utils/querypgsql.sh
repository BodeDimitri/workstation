#!/bin/bash

# Database credentials
HOST=""
PORT=""
USER=""
DBNAME=""
PASSWORD=""

# The SQL query you want to run
QUERY='";'

# Export password so psql can use it
export PGPASSWORD="$PASSWORD"

# Execute the query
psql -h "$HOST" -p "$PORT" -U "$USER" -d "$DBNAME" -c "$QUERY"

unset PGPASSWORD