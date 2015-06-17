#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

/bin/bash "$LAUNCHDIR/core.sh"

cd "$LAUNCHDIR/lnmp-multi"
echo "Starting project: lnmp_multi"
docker-compose --project-name=lnmp_multi up

