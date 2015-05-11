#!/bin/bash

cd ~/system/launch/base
docker-compose --project-name=web up -d --no-recreate

cd ~/system/launch/lnmp-5.5
docker-compose --project-name=lnmp55 up

