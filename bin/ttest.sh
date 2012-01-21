
if [ "$1" == "help" ]
then
	echo "Usage: paste baseline.aucs model.aucs | $0" 
	exit
fi

if [ "$1" == "header" ]
then
	echo "p.value	estimate	conf.int"
	exit
fi


if [ "$1" == "paired" ]
then
	R --vanilla --slave -f /vw/bin/paired-ttest.r
else if [ "$1" == "unpaired" ]
     then
	  R --vanilla --slave -f /vw/bin/unpaired-ttest.r
     else if [ "$1" == "single" ]
		then
		  R --vanilla --slave -f /vw/bin/single-ttest.r
		else
		  R --vanilla --slave -f /vw/bin/paired-ttest.r
	  fi
     fi
fi

