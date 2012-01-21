
if [ "$1" == "help" ]
then
	echo "Usage: cat *.rocs | $0" 
	exit
fi

if [ "$1" == "header" ]
then
	echo "mean	sd"
	exit
fi


R --vanilla --slave -f /vw/bin/median.r
