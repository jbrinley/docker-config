#!/bin/bash

cd ~/system/launch/core
docker-compose --project-name=core up -d --no-recreate

cd ~/system/launch/lnmp-5.3
docker-compose --project-name=lnmp53 up

