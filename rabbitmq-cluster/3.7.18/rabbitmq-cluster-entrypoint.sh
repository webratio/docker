#!/bin/bash
set -x


wait_network() {

    echo "Start rabbit node. Waiting network is up ..."
    sleep 5
    
    
    RABBIT_HOST=`echo $RABBITMQ_NODENAME | cut -d'@' -f 2`
    
    if [ -z "$RABBIT_HOST" ]; then
        echo "Wrong $RABBITMQ_NODENAME"
        exit 1
    fi
    
    n=1
    while [[ $(drill $RABBIT_HOST | grep $RABBIT_HOST | tail -n +2 | awk '{print $5}' | grep '^10.0' | wc -c) -eq 0 ]] && [[ $n -le 10 ]]
    do
         n=$(( n+1 ))
         sleep 5
    done
    
    
    if [ $n -gt 10 ]; then
        echo "Problem to resolv IP for $RABBITMQ_NODENAME"
        exit 1
    fi
    
    IP_RESOLV=$(drill $RABBIT_HOST | grep $RABBIT_HOST | tail -n +2 | awk '{print $5}')
    
    
    echo "Rabbit IP $IP_RESOLV for Rabbit nodename $RABBITMQ_NODENAME" 

}

setup_cluster() {

    if [ -z "$CLUSTER_WITH" ]; then
    echo "Setup single node ${RABBITMQ_NODENAME} in High Availability at the first starting"
        # Check when pid of rabbitmq-server is created; first node only sets HA policy
        rabbitmqctl wait /var/lib/rabbitmq/mnesia/$RABBITMQ_NODENAME.pid && sleep 20 && \
        rabbitmqctl set_policy ha-all '^(?!amq\.|springCloudBus\.).*' '{"ha-mode": "all", "ha-sync-mode": "automatic"}' &
    else
        echo "Setup Cluster with $CLUSTER_WITH for node ${RABBITMQ_NODENAME}"
        # Check when pid of rabbitmq-server is created; this node must to cluster with others node; if this node ($RABBITMQ_NODENAME) is alone, stop app, joins in the cluster with ($CLUSTER_WITH) and start app.
        rabbitmqctl wait /var/lib/rabbitmq/mnesia/$RABBITMQ_NODENAME.pid && sleep 20 && \
        [ $(rabbitmqctl cluster_status |  grep -oE '\{disc,\[(.*)\]' | grep $RABBITMQ_NODENAME |cut -d"[" -f2 | cut -d"]" -f1 | cut -d"," -f1- --output-delimiter=' ' | wc -w) -eq 1 ] && \
        rabbitmqctl stop_app && \
        rabbitmqctl join_cluster ${CLUSTER_WITH} && \
        rabbitmqctl start_app &
    fi

}


wait_network

setup_cluster

# run rabbitmq-server
/usr/local/bin/docker-entrypoint.sh rabbitmq-server



