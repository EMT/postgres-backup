#!/bin/sh
. /_lib.shlib

set -eo pipefail
set -o pipefail

grab_opts "$@"
postgres_init
echo "Creating dump of all databases from ${POSTGRES_HOST}..."
pg_dumpall -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER --clean | xz -6 > dump-tmp.sql.xz

if [ "${SAVE_LOCATION}" = "s3" ]; then
  aws_init
  echo "Uploading dump to ${FULL_PATH}"
  cat dump-tmp.sql.xz | aws $AWS_ARGS s3 cp - "s3://${FULL_PATH}" || exit 2
  echo "SQL backup uploaded successfully"
else
  local_init
  echo "Copying dump to ${FULL_PATH}"
  cp dump-tmp.sql.xz ${FULL_PATH} || exit 2
  echo "SQL backup copied successfully"
fi

rm -rf dump.sql.xz
