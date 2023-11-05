#!/bin/bash
i=0
while :
do
	d=`date +%Y-%M-%d\ %H:%M:%S`
	echo "$d loop: $i"
#
# command
#	./consumer_event_s3.py -v

	i=$((i+1))
	sleep 60
done
