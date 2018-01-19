#!/bin/sh

echo "Start redis sentinel monitor master. Waiting network is up ..."

sleep 10

IP_RESOLV=$(drill $SENTINEL_HOST | grep $SENTINEL_HOST | tail -n +2 | awk '{print $5}')

echo "Sentinel ip $IP_RESOLV - hostname $SENTINEL_HOST" 

SENTINEL_IP=$IP_RESOLV

sed -i "s|@PORT@|$PORT|g" /etc/redis/sentinel.conf
sed -i "s|@MASTER_NAME@|$MASTER_NAME|g" /etc/redis/sentinel.conf
sed -i "s|@MASTER_IP@|$MASTER_IP|g" /etc/redis/sentinel.conf
sed -i "s|@SENTINEL_IP@|$SENTINEL_IP|g" /etc/redis/sentinel.conf
sed -i "s|@MASTER_PORT@|$MASTER_PORT|g" /etc/redis/sentinel.conf
sed -i "s|@QUORUM@|$QUORUM|g" /etc/redis/sentinel.conf
sed -i "s|@DOWN_AFTER@|$DOWN_AFTER|g" /etc/redis/sentinel.conf
sed -i "s|@FAILOVER_TIMEOUT@|$FAILOVER_TIMEOUT|g" /etc/redis/sentinel.conf
sed -i "s|@PARALLEL_SYNCS@|$PARALLEL_SYNCS|g" /etc/redis/sentinel.conf
chown redis:redis /etc/redis/sentinel.conf
docker-entrypoint.sh redis-server /etc/redis/sentinel.conf --sentinel

