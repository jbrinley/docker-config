#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/bin/bash "$LAUNCHDIR/core.sh"

cd "$LAUNCHDIR/lamp-5.5"
echo "Starting project: lamp55"
docker-compose --project-name=lamp55 up