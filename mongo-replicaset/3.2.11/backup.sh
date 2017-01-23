#!/bin/bash
set -e

if [ "${BACKUP_LOCATION}" == "" ]; then
  echo "Variable BACKUP_LOCATION not provided: skipping backup"
  exit 0
fi
if [ "${BACKUP_BASENAME}" == "" ]; then
  echo "Variable BACKUP_BASENAME not provided: skipping backup"
  exit 0
fi
MASTER=`mongo --quiet --eval "d=db.isMaster(); print( d['ismaster'] );"`
if [ "${MASTER}" != "true" ]; then
  echo "Current instance is not master: skipping backup"
  exit 0
fi

DIR="/tmp/backup"
FILE="/tmp/backup.tar.gz"
MILLIS_FILE="/tmp/last_time_millis"
DATE=`date +%Y%m%d%H%M%S`
MILLIS=`date +%s%N | cut -b1-13`
rm -rf $DIR
mkdir -p $DIR
mongodump --out=$DIR
rm -f $FILE
tar cvzf $FILE -C $DIR .
rm -f $MILLIS
echo -n $MILLIS > /tmp/last_time_millis
/aws/env/bin/aws s3 cp $FILE s3://${BACKUP_LOCATION}/mongo/${BACKUP_BASENAME}.$DATE.tar.gz
/aws/env/bin/aws s3 cp $MILLIS_FILE s3://${BACKUP_LOCATION}/mongo/last_time_millis --acl public-read