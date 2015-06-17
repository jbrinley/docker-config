#!/bin/bash

# Add an additional local IP address to the host machine's loopback
# adapter, so that it can be reached at a consistent address
# from inside containers.
#
# This allows containers to point to a dnsmasq server running
# on the host machine. E.g. docker-compose.yml:
#
#  dns:
#    - 10.254.254.254
#    - 8.8.8.8

sudo ifconfig lo0 alias 10.254.254.254
