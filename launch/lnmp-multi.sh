#!/bin/bash

cd ~/system/launch/base
docker-compose --project-name=web up -d --no-recreate

cd ~/system/launch/lnmp-multi
docker-compose --project-name=lnmp_multi up

