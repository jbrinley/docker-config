#!/bin/bash

cd ~/system/launch/base
docker-compose --project-name=web up -d --no-recreate

cd ~/system/launch/lnmp-5.3
docker-compose --project-name=lnmp53 up

