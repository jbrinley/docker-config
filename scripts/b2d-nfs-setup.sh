#!/bin/bash
 
############################################################################
# On OX X host you need to add a line (and file) /etc/exports:
# /Users -mapall=[youruser]:[yourgroup] [boot2dockerip]
# See: https://quip.com/EDYLAAfuup5M (no login needed)
# See also: https://github.com/boot2docker/boot2docker/issues/587#issuecomment-66935011 
# See also: http://support.apple.com/en-us/HT202243
# See also: https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man5/exports.5.html
#############################################################################
 
sudo umount /Users
sudo /usr/local/etc/init.d/nfs-client start
sudo mount 192.168.59.3:/Users /Users -o rw,async,noatime,rsize=32768,wsize=32768,proto=tcp
