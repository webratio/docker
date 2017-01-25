#!/bin/sh

echo "docker_node{id=\"$DOCKER_NODE_ID\",hostname=\"$DOCKER_NODE_HOSTNAME\"} 1" > /etc/node-exporter/host_hostname.prom

set -- $NODE_EXPORTER_BIN "$@"

exec "$@"