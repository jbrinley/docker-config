#!/bin/bash

cd ~/system/launch/core
docker-compose --project-name=core up -d --no-recreate

cd ~/system/launch/lnmp-5.5
docker-compose --project-name=lnmp55 up

