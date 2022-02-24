#!/bin/sh

if [ -z "${SCHEDULE}" ]; then
  echo "$SCHEDULE in not defined. This is not a problem if you don’t want to schedule database backups."
  exit 0
else 
  echo "$SCHEDULE /backup.sh -l $BACKUP_TO -s" >> /etc/crontabs/root
  crontab -l
  crond -f -l 8
fi
