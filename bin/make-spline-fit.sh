
if [ "$1" == "" ]
then
	echo "Usage: $0 probs [min max]"
	exit
fi

probs=$1
min=$2
max=$3

if [ `wc -l $probs -l | cut -f1 -d' '` -le 4 ]
then
	cat $probs | cut -f1-2
	exit
fi

if [ "$max" == "" ]
then
	max=1
fi
if [ "$min" == "" ]
then
	min=0
fi

echo "
suppressMessages(library(lattice, verbose=F))
suppressMessages(library(binom, verbose=F))
#suppressMessages(library(Hmisc, verbose=F))
suppressMessages(library(stats, verbose=F))

probs=read.delim(file='$probs',sep='\t',header=F)
probs=probs[probs[,4]> 10,]
dims=dim(probs)
ncols=dims[2]

if(ncols == 5) ci=binom.confint(probs[,5],probs[,4],methods='exact') else ci=binom.confint(probs[,3],probs[,2],methods='exact')
spl=smooth.spline(probs[,1],ci[,'mean'],probs[,4])
p=predict(spl, seq($min,$max,0.05))
cat(sprintf(\"%.2f\t%.6f\",p\$x,p\$y),sep='\n')
" | R --slave --no-save --no-restore --quiet

