#!/bin/sh

# exit if a command fails
set -eo pipefail

apk update

# install pg_dump
apk add postgresql-client

# install xz compression
apk add xz

# install s3 tools
apk add aws-cli

# install curl
apk add curl

# cleanup
rm -rf /var/cache/apk/*
