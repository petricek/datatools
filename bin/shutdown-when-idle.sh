#!/bin/sh

JID=$1

if [ "$JID" == "" ]
then
	JID=`cat /vw/cluster.id`
fi

echo $JID

while true
do
	if elastic-mapreduce -j $JID --list | grep WAITING
	then
		elastic-mapreduce -j $JID --terminate
		echo  " TERMINATED "
		elastic-mapreduce -j $JID --list
		exit
	else
		echo SLEEPING
		sleep 300
	fi
done

