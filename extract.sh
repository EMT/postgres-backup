#!/bin/sh
. /_lib.shlib

set -eo pipefail
set -o pipefail

grab_opts "$@"

if [ "${SAVE_LOCATION}" = "s3" ]; then
  aws_init
  echo "Extracting dump from S3 ${FULL_PATH}"
  aws s3 cp "s3://${FULL_PATH}" dump-tmp.sql.xz || exit 2
  xz -d dump-tmp.sql.xz

  if [ ! -z "$EXTRACT_TO" ]; then
    mv dump-tmp.sql $EXTRACT_TO || exit 2
  fi
  
  echo "SQL backup extracted successfully"
else
  local_init
  echo "Extracting dump from ${FULL_PATH}"
  cp -f ${FULL_PATH} || exit 2
  xz -d dump-tmp.sql.xz

  if [ ! -z "$EXTRACT_TO" ]; then
    mv dump-tmp.sql $EXTRACT_TO || exit 2
  fi

  echo "SQL backup extracted successfully"
fi
