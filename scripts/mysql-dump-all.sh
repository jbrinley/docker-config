#!/bin/bash

USER="root"
PASSWORD="password"
HOST="docker"
OUTPUTDIR="/Users/jbrinley/system/backups/mysql"

mkdir -p $OUTPUTDIR
#rm "$OUTPUTDIR/*gz" > /dev/null 2>&1

databases=`mysql -u $USER -p$PASSWORD -h $HOST -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

for db in $databases; do
    if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != _* ]] ; then
        echo "Dumping database: $db"
        mysqldump -u $USER -p$PASSWORD -h $HOST --databases $db | gzip -c > $OUTPUTDIR/$db.`date +%Y%m%d`.sql.gz
    fi
done