#!/bin/sh
set -eu

umask "${UMASK:-0022}"
/usr/local/tomcat/bin/set_timezone.sh
/usr/local/tomcat/bin/import_self_signed_certs.sh
exec "$@"
