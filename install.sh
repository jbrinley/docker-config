#!/bin/bash

# install docker
brew install docker

# install docker compose
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# install boot2docker vm
brew install boot2docker

# initialize boot2docker vm
boot2docker init

# start boot2docker vm
boot2docker up

# setup mysql data volume
docker create -v /var/lib/mysql --name mysqldata busybox /bin/true

# setup elasticsearch data volume
docker create -v /usr/share/elasticsearch/data --name elasticsearchdata busybox /bin/true
