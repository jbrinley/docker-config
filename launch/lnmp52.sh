#!/bin/bash

cd ~/system/launch/core
docker-compose --project-name=core up -d --no-recreate

cd ~/system/launch/lnmp-5.2
docker-compose --project-name=lnmp52 up

