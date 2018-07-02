#!/bin/bash
set -e

mongo --host mongo1 --eval 'rs.initiate({"_id":"semioty","members":[{"_id":1,"host":"mongo1","priority":1}]})'