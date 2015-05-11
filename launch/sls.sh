#!/bin/bash

cd ~/system/launch/base
docker-compose --project-name=web up -d --no-recreate

cd ~/system/launch/sls
docker-compose --project-name=sls up

