#!/bin/bash

LAUNCHDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd "$LAUNCHDIR/core"
echo "Starting project: core"
docker-compose --project-name=core up -d --no-recreate