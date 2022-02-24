Postgres backup and restore
=================================

## Environment

See Dockerfile for environment vars and defaults.

## Local directory

Logs and local backups are saves in the /backup directory in the container. Mount this directory to make these files available on the host.

## backup.sh

Backup the database and save logs. These options are available:

- l: Save location. s3 or local
- d: The subfolder to use inside /backup when using the local save location or inside $BUCKET/$S3_PREFIX when using s3
- s: This is a scheduled backup (organises into daily/weekly/monthly sub-folders)

The filename is generated using the current timestamp. If you need to specify a filename, use _backup.sh instead.

Using either s3 or local for the backup save location, logs are saved locally in the /backup directory.

If the `WEBHOOK` environment variable is set, logs are sent to that URL.

If the `-s` flag is set, backups will be saved under sub-directories:

- daily/ — every backup, unless it occurs on a Monday, or first day of the month
- weekly/ - if the backup occurs on a Monday
- monthly/ - if the backup occurs on the first of the month

## restore.sh

Restore the local database from a backup file.

- f: Filename of the backup file to restore from, excluding the extension (.sql.xz).

## extract.sh

Extract a backup file into it’s uncompressed version.

- e: Extract the file to this location on the local filesystem (within the container, so you’ll need to use a mounted directory to have access via the host).

## _backup.sh

Lower level version of `backup.sh` — allows you to specify a filename, and doesn’t save or post any logs. Only really for use with our `bin/pg` scripts like `pull` and `push`.
