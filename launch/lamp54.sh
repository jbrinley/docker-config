#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/bin/bash "$LAUNCHDIR/core.sh"

cd "$LAUNCHDIR/lamp-5.4"
echo "Starting project: lamp54"
docker-compose --project-name=lamp54 up