#!/bin/bash
set -e

# Only try to write if the file is writable
if [ -w /etc/timezone ]; then
    echo "${TZ}" > /etc/timezone
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
else
    echo "ERROR: /etc/timezone is not writable. Cannot set timezone." >&2
    exit 1  # fail loudly
fi