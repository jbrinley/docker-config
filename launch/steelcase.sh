#!/bin/bash

cd ~/system/launch/core
docker-compose --project-name=core up -d --no-recreate

cd ~/system/launch/steelcase
docker-compose --project-name=steelcase up

