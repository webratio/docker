#!/bin/bash
set -e

mongo --eval 'rs.status()'