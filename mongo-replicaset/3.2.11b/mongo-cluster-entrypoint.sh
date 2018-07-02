#!/bin/bash
set -x
echo "1: $1"
echo "2: $2"
echo "3: $3"
echo "all: $@"

echo "Sleeping 20 seconds..."
sleep 20
echo "Sleep done"
/entrypoint.sh "$@"