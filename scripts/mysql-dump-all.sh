#!/bin/bash

# Back up all databases to ../backups/mysql/yyyy-mm-dd
# Assumes that mysql is running and accessible

USER="root"
PASSWORD="password"
HOST="docker"

DATE=`date +%Y-%m-%d`
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
REPODIR=$( dirname "$SCRIPTDIR" )
OUTPUTDIR="$REPODIR/backups/mysql/$DATE"

echo "Saving backups to $OUTPUTDIR"

mkdir -p $OUTPUTDIR

databases=`mysql -u $USER -p$PASSWORD -h $HOST -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump -u $USER -p$PASSWORD -h $HOST --databases $db | gzip -c > $OUTPUTDIR/$db.sql.gz
    fi
done