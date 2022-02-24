#!/bin/sh
. /_lib.shlib

set -eo pipefail
set -o pipefail

grab_opts "$@"

if [ "${SAVE_LOCATION}" = "s3" ]; then
  aws_init
  aws s3 ls --recursive "s3://${S3_BUCKET}${S3_PREFIX}" | sort
else
  local_init
  ls /backup
fi
