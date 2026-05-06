#!/bin/bash

pid=$(jcmd | grep apache | awk '{print $1}')
if [ -z "$1" ]; then
	foldername="shared/javadump/javadump_$(date +%Y%m%d%H%M%S)"
else
	foldername="$1"
fi
if [ -z "$2" ]; then
	type="all"
else
	type="$2"
fi
mkdir -p $foldername

count=5
sleep_time=5

if test "$type" = "all"; then

	echo "[*] Retrieving Tomcat logs..."
	tomcat="$(find / -type d -name tomcat)/logs"
	tar -czf $foldername/tomcat_logs.tar.gz "$tomcat"

	echo "[*] Retrieving application logs..."
	for d in $(find / -type d -name WEB-INF); do
		file="$(echo ${d%/*} | grep -oG /[^/]*$ | cut -c 2-).tar.gz"
		tar -czvf "$foldername/$file" "$d/log"
	done

fi

echo "[*] Dumping threads..."
for i in $(seq $count); do
	echo "Dumping threads $i of $count times..."
	jcmd $pid Thread.print >$foldername/threads_$i.txt
	sleep $sleep_time
done

echo "[*] Dumping JVM info"
echo "----VM.info-----" >$foldername/info.txt
jcmd $pid VM.info >>$foldername/info.txt
echo "---- VM.flags-----" >>$foldername/info.txt
jcmd $pid VM.flags >>$foldername/info.txt
echo "----VM.command_line-----" >>$foldername/info.txt
jcmd $pid VM.command_line >>$foldername/info.txt
echo "----VM.system_properties-----" >>$foldername/info.txt
jcmd $pid VM.system_properties >>$foldername/info.txt

jcmd $pid VM.classloader_stats >$foldername/classloader_stats.txt

echo "----info retrieved from jcmd-----" >>$foldername/metaspace.txt
jcmd $pid VM.metaspace >>$foldername/metaspace.txt
echo "----info retrieved from jstat-----" >>$foldername/metaspace.txt
min_space=$(jstat -gcmetacapacity $pid | awk '{print($1)}')
max_space=$(jstat -gcmetacapacity $pid | awk '{print($2)}')
cur_space=$(jstat -gcmetacapacity $pid | awk '{print($3)}')
usage=$(jstat -gcold $pid | awk '{print($3)}')
usage_perc=$(jstat -gcutil $pid | awk '{print($5)}')

echo "Max space: $min_space" >>$foldername/metaspace.txt
echo "Min space: $max_space" >>$foldername/metaspace.txt
echo "Current space: $cur_space" >>$foldername/metaspace.txt
echo "Used space: $usage" >>$foldername/metaspace.txt
echo "Percentage used: $usage_perc" >>$foldername/metaspace.txt

echo "[*] Dumping memory (may take a while)"
jmap -dump:live,format=b,file=$foldername/dump.hprof $pid

echo "[*] Generating archive and cleanup"
tar -czf $foldername.tar.gz $foldername
rm -rf $foldername
echo "[+] Done!"
echo "[+] archive is at $foldername.tar.gz"