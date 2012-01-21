
if [ "$1" == "" ]
then
	echo "Usage: $0 probs [label]"
	exit
fi

probs=$1
label=$2

echo "
sink('/dev/null') 

suppressMessages(library(lattice, verbose=F))
suppressMessages(library(binom, verbose=F))
suppressMessages(library(Hmisc, verbose=F))
suppressMessages(library(stats, verbose=F))

probs=read.delim(file='$probs',sep='\t',header=F)
dims=dim(probs)
ncols=dims[2]

#fit=read.delim(file='$probs.fitd1',sep='\t',header=F)
#a=fit[1,1]
#b=fit[1,3]
#c=fit[1,5]
#d=fit[1,7]
x=probs[,1]
#y1= a * (0.5 + 0.5 * tanh (b * (x - c))) + d * x
#
#fit=read.delim(file='$probs.fitd0',sep='\t',header=F)
#a=fit[1,1]
#b=fit[1,3]
#c=fit[1,5]
#d=fit[1,7]
#y0= a * (0.5 + 0.5 * tanh (b * (x - c))) + d * x
#
#fit=read.delim(file='$probs.expd0',sep='\t',header=F)
#a=fit[1,1]
#b=fit[1,3]
#c=fit[1,5]
#y2= a * exp( (-b) * x) + c

if(ncols == 5) ci=binom.confint(probs[,5],probs[,4],methods='exact') else ci=binom.confint(probs[,3],probs[,2],methods='exact')

redspline=smooth.spline(probs[,1],ci[,'mean'],probs[,4])

png('$probs.png',width = 800, height = 600)
errbar(probs[,1],ci[,'mean'],ci[,'lower'],ci[,'upper'],xlab=\"predicted probability\",ylab=\"empirical probability\")
title(\"$label\")
lines(redspline, col='red')
#lines(smooth.spline(probs[,1],ci[,'mean'],probs[,4]), col='red')
#lines(smooth.spline(probs[,1],ci[,'mean'],probs[,4], spar=0.2), col='green', lwd=2)
#lines(x,y1,col='red')
lines(x,x,col='green')
#lines(x,y2,col='magenta')
legend(\"topleft\", c(\"spline\", \"y=x\"),  title=\"lines\", lty=c(1,1), col=c('red','green'))
dev.off()


ci=ci[ci[,'mean']>0,]
probs=probs[probs[,2]>0,]

png('$probs.logy.png',width = 800, height = 600)
errbar(probs[,1],ci[,'mean'],ci[,'lower'],ci[,'upper'],log='y',,xlab=\"predicted probability\",ylab=\"empirical probability\")
title(\"$label\")
lines(redspline, col='red')
#lines(smooth.spline(probs[,1],ci[,'mean'],probs[,4]), col='red')
#lines(smooth.spline(probs[,1],ci[,'mean'],probs[,4], spar=0.2), col='green', lwd=2)
#lines(x,y1,col='red')
lines(x,x,col='green')
#lines(x,y2,col='magenta')
legend(\"topleft\", c(\"spline\", \"y=x\"),  title=\"lines\", lty=c(1,1), col=c('red','green'))
dev.off()

sink()
" | R --slave --no-save --no-restore

