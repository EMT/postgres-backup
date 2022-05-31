#!/bin/sh
. /_lib.shlib

grab_opts "$@"

FILENAME=all_$(date +"%Y-%m-%dT%H:%M:%SZ")
LOG_FILE=$FILENAME.log

if [ $IS_SCHEDULED = 1 ]; then
  SCHEDULE_FOLDER="daily"
  DOW=$(date +%u)
  DOM=$(date +%d)

  if [ $DOW = 1 ]; then
    SCHEDULE_FOLDER="weekly"
  fi

  if [ "$DOM" = '01' ]; then
    SCHEDULE_FOLDER="monthly"
  fi

  echo "Scheduled backup: $SCHEDULE_FOLDER"
  echo "Backing up database using filename: $FILENAME"
  /_backup.sh "$@" -f $FILENAME -d $SCHEDULE_FOLDER > /backup/$LOG_FILE 2>&1
else
  echo "Backing up database using filename: $FILENAME"
  /_backup.sh "$@" -f $FILENAME > /backup/$LOG_FILE 2>&1
fi



# log the last 3 lines of the log file
tail -n 3 /backup/$LOG_FILE

# Send log file report if the $WEBHOOK var is set
if [ -z "${WEBHOOK}" ]; then
  exit 0
else 
  curl --data-binary "@/backup/$LOG_FILE" $WEBHOOK
fi