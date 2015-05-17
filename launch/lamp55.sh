#!/bin/bash

cd ~/system/launch/core
docker-compose --project-name=core up -d --no-recreate

cd ~/system/launch/lamp-5.5
docker-compose --project-name=lamp55 up