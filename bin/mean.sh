#!/usr/bin/env bash

cd $(dirname "$0" )

usage="Usage: cat *.rocs | $0" 

function rcode()
{
cat << __EOF__
mystdin <- file("stdin")
d <- read.table(mystdin)
m=as.numeric(mean(d[,1]))
s=sapply(d,sd)
cat(m, s, '\n', sep = '\t')
q(runLast=FALSE)
__EOF__
}

if [ "$1" == "help" ]
then
	echo $usage
	exit
fi

if [ "$1" == "header" ]
then
	echo "mean	sd"
	exit
fi


R --vanilla --slave -f <( rcode )

cd - > /dev/null
