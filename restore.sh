#!/bin/sh
. /_lib.shlib

echo "Restoring ${LATEST_BACKUP}"
./extract.sh "$@"
postgres_init
psql -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -f dump-tmp.sql
echo "Restore complete"
