#!/bin/bash

source ./setup-dirs.sh

# install docker
echo 'Installing docker via brew'
brew install docker

# install boot2docker vm
echo 'Installing docker via brew'
brew install boot2docker

# install docker compose
echo 'Install docker compose'
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# initialize boot2docker vm
echo 'Initializing boot2docker'
boot2docker init

# start boot2docker vm
echo 'Starting boot2docker'
boot2docker up

# Set up docker environment variables
eval "$(boot2docker shellinit 2> /dev/null)"

# setup mysql data volume
echo 'Setting up the mysqldata data volume';
docker create -v /var/lib/mysql --name mysqldata busybox /bin/true

# setup elasticsearch data volume
echo 'Setting up the elasticsearchdata data volume';
docker create -v /usr/share/elasticsearch/data --name elasticsearchdata busybox /bin/true

echo '--------------------------'
echo 'You will need to add the following vars to your .bashrc/.zshrc:'
boot2docker shellinit
echo '--------------------------'
