#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/bin/bash "$LAUNCHDIR/core.sh"

cd "$LAUNCHDIR/lnmp-5.5"
echo "Starting project: lnmp55"
docker-compose --project-name=lnmp55 up

