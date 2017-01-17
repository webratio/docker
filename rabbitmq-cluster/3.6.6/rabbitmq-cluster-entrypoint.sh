#!/bin/bash

if [ -z "$CLUSTER_WITH" ]; then
    sleep 15 && rabbitmqctl set_policy ha-all '^(?!amq\.).*' '{"ha-mode": "all", "ha-sync-mode": "automatic"}' &
else
    sleep 15 && rabbitmqctl stop_app && rabbitmqctl reset && rabbitmqctl join_cluster ${CLUSTER_WITH} && rabbitmqctl start_app &
fi
/docker-entrypoint.sh rabbitmq-server