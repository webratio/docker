#!/bin/sh
set -eu

tomcat_dir=/usr/local/tomcat
timestamp=$(date +%Y%m%d%H%M%S)
foldername=${1:-"/usr/local/tomcat/temp/javadump_$timestamp"}
dump_type=${2:-all}

case "$foldername" in
  ""|/)
    echo "Refusing unsafe dump path: $foldername" >&2
    exit 1
    ;;
esac

pid=$("$JAVA_HOME/bin/jcmd" | awk '/org.apache.catalina.startup.Bootstrap/ { print $1; exit }')
if [ -z "$pid" ]; then
  echo "Tomcat JVM not found" >&2
  exit 1
fi

mkdir -p "$foldername"
if [ "$dump_type" = "all" ]; then
  tar -czf "$foldername/tomcat_logs.tar.gz" -C "$tomcat_dir" logs
fi

i=1
while [ "$i" -le 5 ]; do
  "$JAVA_HOME/bin/jcmd" "$pid" Thread.print >"$foldername/threads_$i.txt"
  i=$((i + 1))
  sleep 5
done

"$JAVA_HOME/bin/jcmd" "$pid" VM.info >"$foldername/vm_info.txt"
"$JAVA_HOME/bin/jcmd" "$pid" VM.flags >"$foldername/vm_flags.txt"
"$JAVA_HOME/bin/jcmd" "$pid" VM.system_properties >"$foldername/vm_system_properties.txt"
"$JAVA_HOME/bin/jmap" -dump:live,format=b,file="$foldername/dump.hprof" "$pid"
tar -czf "$foldername.tar.gz" -C "$(dirname -- "$foldername")" "$(basename -- "$foldername")"
echo "Java dump retained at $foldername and archived at $foldername.tar.gz"
