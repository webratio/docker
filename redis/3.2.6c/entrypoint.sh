#!/bin/sh

echo "Start redis monitor master. Waiting network is up ..."
sleep 10

IP_RESOLV=$(drill $SLAVE_ANNOUNCE_HOST | grep $SLAVE_ANNOUNCE_HOST | tail -n +2 | awk '{print $5}')

echo "Slave ip $IP_RESOLV - hostname $SLAVE_ANNOUNCE_HOST" 

SLAVE_ANNOUNCE_IP=$IP_RESOLV

echo "Starting redis-server: Slave Announce Ip = $SLAVE_ANNOUNCE_IP"

sed -i "s|@MIN_SLAVES_TO_WRITE@|$MIN_SLAVES_TO_WRITE|g" /redis/redis.conf
sed -i "s|@MIN_SLAVES_MAX_LAG@|$MIN_SLAVES_MAX_LAG|g" /redis/redis.conf
sed -i "s|@SLAVE_ANNOUNCE_IP@|$SLAVE_ANNOUNCE_IP|g" /redis/redis.conf

if [ ! -z "$SLAVE_OF" ]; then 
       sed -i "s|@SLAVE_OF@|$SLAVE_OF|g" /redis/redis.conf
else
       sed -i "s|slaveof @SLAVE_OF@|# slaveof @SLAVE_OF@|g" /redis/redis.conf
fi

echo "Restarting automatically is delayed to 35 sec in order to avoid issue Safety of replication when master has persistence turned off"
sleep 35

redis-server /redis/redis.conf
