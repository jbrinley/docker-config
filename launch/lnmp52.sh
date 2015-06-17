#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/bin/bash "$LAUNCHDIR/core.sh"

cd "$LAUNCHDIR/lnmp-5.2"
echo "Starting project: lnmp52"
docker-compose --project-name=lnmp52 up

