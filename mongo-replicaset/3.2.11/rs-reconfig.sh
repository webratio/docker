#!/bin/bash
set -e

usage(){
  echo "Usage: /rs-reconfig.sh <MAX_INDEX>"
  exit 1
}
setVariable(){
  if [ -z "$2" ]
    then
      echo "Error: <$1> not provided"
      usage
  fi
  eval "$1=$2"
}

setVariable 'MAX_INDEX' $1
MEMBERS="{\"_id\":1,\"host\":\"mongo1\",\"priority\":1}"
for ((i = 2; i <= $(($MAX_INDEX)); i++)); do
    MEMBERS="$MEMBERS,{\"_id\":$i,\"host\":\"mongo$i\",\"priority\":1}"
done
EVAL_ARG="rs.reconfig({\"_id\":\"semioty\",\"members\":[$MEMBERS]})"
mongo --host mongo1 --eval "$EVAL_ARG"
