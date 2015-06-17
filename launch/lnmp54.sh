#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/bin/bash "$LAUNCHDIR/core.sh"

cd "$LAUNCHDIR/lnmp-5.4"
echo "Starting project: lnmp54"
docker-compose --project-name=lnmp54 up

