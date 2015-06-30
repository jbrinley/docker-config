#!/bin/bash

REPODIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ $1 ]]
then
	/bin/bash "$REPODIR/compiled/launch/$1.sh"
else
	/bin/bash "$REPODIR/compiled/launch/lnmp.sh"
fi
