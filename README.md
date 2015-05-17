# Flexible Nginx & Apache Docker Config

This is a basic framework for building a flexible local WordPress development environment using docker.

An environment includes:

PHP (versions 5.2-5.5 available)
Nginx or Apache
MySQL
Memcached
Elasticsearch

## Installation

### Assumptions

This Docker config setup makes some assumptions about your local environment.

* You'll need to clone this repository (or symlink it) to `~/system/`.
* Your projects (WordPress sites, projects, etc) will need to be in `~/projects/`

### Install Docker

You'll need docker (of course). Instructions on installation can be
found on the [docker docs site](https://docs.docker.com). Here's the [OS X install docs](https://docs.docker.com/installation/mac/).

### Install `docker-compose`

`docker-compose` allows for easy multi-container applications to be defined within a
`docker-compose.yml` file, allowing you to spin up an application with a single command.  This
repo relies on `docker-compose`, so you'll want that installed.

Here are some [installation instructions](https://docs.docker.com/compose/install/).

### Install boot2docker VM

`boot2docker` is a lightweight Linux distribution made specifically to
run Docker containers.  It runs completely from RAM, weights ~27MB and
boots in ~5s.

You can get it at [boot2docker.io](http://boot2docker.io/).

#### Initialize the VM

Once you've installed `boot2docker`, you'll need to initialize the VM
(you'll only have to do this once):

```
boot2docker init
```

#### Start VM

```
boot2docker up
```

#### Use NFS Mounts

boots2docker automatically mounts your `/Users/` directory using vboxsf.
To switch to the more performance nfs:
 
Edit `/etc/exports`, adding:

```
/Users -mapall=[youruser]:[yourgroup] [boot2dockerip]
```

Example:

```
"/Users" -mapall=501:20 192.168.59.103
```

Then ssh into boot2docker and re-mount the directory:

```
boot2docker ssh
```

```
sudo umount /Users
sudo /usr/local/etc/init.d/nfs-client start
sudo mount 192.168.59.3:/Users /Users -o rw,async,noatime,rsize=32768,wsize=32768,proto=tcp
```

You will need to re-run this every time you restart the virtual machine (but not when restarting containers).

#### More info

You can get more info about `boot2docker` at its [GitHub repo](https://github.com/boot2docker/boot2docker).

### Create data volume containers

Sometimes you want containers that contain persistent data. Luckily, you can create a container
whose sole purpose is to store data for other containers. Running this config requires that you have
a data volume container for MySQL (named `mysqldata`) and one for Elasticsearch (named `elasticsearchdata`).

#### MySQL

```
docker create -v /var/lib/mysql --name mysqldata busybox /bin/true
```

#### Elasticsearch

```
docker create -v /usr/share/elasticsearch/data --name elasticsearchdata busybox /bin/true
```

## Running

### Setup `/etc/hosts`

Before you get rolling, you'll want your `boot2docker` IP address in `/etc/hosts` along with the domains you'll be hosting from there.  You can get your `boot2docker` IP via:

```
boot2docker ip
```

#### Hostnames

The hostnames that are used in this repo can be found in the apache and
nginx config directories:

* nginx: `~/system/shared-config/nginx/conf.d/`
* apache: `~/system/shared-config/apache/sites-enabled/`

### Starting your container

Via command line, navigate to `~/system/launch/`. You'll see a pile of `*.sh` files. Those are used
to run your containers. The `lnmp*.sh` files use nginx and the `lamp*.sh` files run apache. Simply
execute the version of your choice:

```
./lnmp54.sh
```

This will spin up the relevant containers (mysql, mysqldata, memcached, elasticsearch,
elasticsearchdata, nginx, and php) in an interactive terminal where log information is sent to
STDOUT.

### Viewing running containers

In another terminal window, you can view the containers that are
running via:

```
docker ps
```

## Stopping

If you have your STDOUT log stream terminal open, you should be able to `CTRL+C` to kill your
application. You can _also_ stop docker containers via the `docker stop` command.

```
docker stop [container name]
```
