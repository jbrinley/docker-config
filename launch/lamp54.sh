#!/bin/bash

cd ~/system/launch/base
docker-compose --project-name=web up -d --no-recreate

cd ~/system/launch/lamp-5.4
docker-compose --project-name=lamp54 up