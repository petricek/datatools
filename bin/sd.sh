
if [ "$1" == "" ]
then
	echo "Usage: $0 out"
	exit
fi

out=$1
cut -c8-|R CMD BATCH --vanilla --slave /vw/bin/sd.r $out
