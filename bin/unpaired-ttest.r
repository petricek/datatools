
d <- read.table("/dev/stdin") 
t.test(d[,1],d[,2],paired=F)
q(runLast=FALSE)
