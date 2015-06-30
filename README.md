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

* You'll need to clone this repository (or symlink it) to a path in your home directory (e.g., `~/system/`).
* Your projects (WordPress sites, projects, etc) will need to be in `~/projects/`. Note: You can change this default by declaring `$DOCKER_PROJECT_DIR` in your `.bashrc`/`.zshrc`

#### brew

The installation script included in this repo assumes that you have brew installed. If you do not,
you can get it [here](http://brew.sh/).

### Run the install script

Run it like so (assuming this file is in the directory `~/system`):

```
cd ~/system
./install.sh
```

The install script does the following:

1. Installs Docker
1. Installs boot2docker
1. Installs Docker Compose
1. Initializes and starts up `boot2docker`
1. Sets up a MySQL data volume (`mysqldata`)
1. Sets up an Elasticsearch data volume (`elasticsearchdata`)

If you _don't_ want to use the install script and instead want to install all of the pieces
yourself, check the INSTALL.md file.

## boot2docker VM info

`boot2docker` is a lightweight Linux distribution made specifically to
run Docker containers.  It runs completely from RAM, weights ~27MB and
boots in ~5s.

### Starting VM

While the install script _does_ start `boot2docker`, if you restart your
machine, you'll need to start it up again.

```
boot2docker up
```

### Use NFS Mounts

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

## Running

### Setup `/etc/hosts`

Before you get rolling, you'll want your `boot2docker` IP address in `/etc/hosts` along with the domains you'll be hosting from there.  You can get your `boot2docker` IP via:

```
boot2docker ip
```

#### Hostnames

The hostnames that are used in this repo can be found in the apache and
nginx config directories:

* nginx: `shared-config/nginx/conf.d/`
* apache: `shared-config/apache/sites-enabled/`

### Starting your container

Via command line, navigate to this repo's directory. You'll see a `start.sh` file.
Run that to spin up an Nginx/PHP 5.5 environment:

```
cd ~/system/
./start.sh
```

This will spin up the relevant containers (mysql, mysqldata, memcached, elasticsearch,
elasticsearchdata, nginx, and php) in an interactive terminal where log information is sent to
STDOUT.

To spin up different configurations, you can specify those as a
parameter to `start.sh`.  Example:

```
./start.sh lamp53
```

Parameters you can pass:
* `lnmp55`: Nginx + PHP 5.5
* `lnmp54`: Nginx + PHP 5.4
* `lnmp53`: Nginx + PHP 5.3
* `lnmp52`: Nginx + PHP 5.2
* `lamp55`: Apache + PHP 5.5
* `lamp54`: Apache + PHP 5.4
* `lamp53`: Apache + PHP 5.3
* `lamp52`: Apache + PHP 5.2

Config files for those environments can be found in `launch/`.

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
