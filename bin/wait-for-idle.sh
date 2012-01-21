#!/bin/sh

JID=$1
if [ "$JID" == "" ]
then
	JID=`cat /vw/cluster.id`
fi

while true
do
	if elastic-mapreduce -j $JID --list | grep WAITING
	then
		exit 0
	else
		echo "Cluster is working ... sleeping."
		sleep 100
	fi
done

