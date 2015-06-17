#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/bin/bash "$LAUNCHDIR/core.sh"

cd "$LAUNCHDIR/lnmp-5.3"
echo "Starting project: lnmp53"
docker-compose --project-name=lnmp53 up

