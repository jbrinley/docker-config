#!/bin/bash

cd ~/system/launch/core
docker-compose --project-name=core up -d --no-recreate

cd ~/system/launch/lnmp-multi
docker-compose --project-name=lnmp_multi up

