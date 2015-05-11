#!/bin/bash

cd ~/system/launch/base
docker-compose --project-name=web up -d --no-recreate

cd ~/system/launch/lnmp-5.4
docker-compose --project-name=lnmp54 up

