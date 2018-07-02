#!/bin/bash
set -e

echo "Waiting 20 seconds for Docker swarm network name..."
sleep 20
/entrypoint.sh "$@"