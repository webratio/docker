#!/bin/bash
set -e

# Only try to write if the file is writable
if [ -w /etc/timezone ]; then
    echo "${TZ}" > /etc/timezone
    ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime
    dpkg-reconfigure -f noninteractive tzdata
else
    echo "Notice: /etc/timezone is read-only. Relying on TZ environment variable."
fi

# These are usually safe as they write to /var or /usr
locale-gen en_US.UTF-8 || echo "Could not gen locale"
update-locale LANG=en_US.UTF-8 || echo "Could not update locale"