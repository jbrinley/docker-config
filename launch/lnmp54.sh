#!/bin/bash

cd ~/system/launch/core
docker-compose --project-name=core up -d --no-recreate

cd ~/system/launch/lnmp-5.4
docker-compose --project-name=lnmp54 up

