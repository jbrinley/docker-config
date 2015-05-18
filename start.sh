#!/bin/bash

if [[ $1 ]]
then
	~/system/launch/$1.sh
else
	~/system/launch/lnmp55.sh
fi
