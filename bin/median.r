
d <- read.table("/dev/stdin") 
m=median(d[,1])
s=sd(d)
cat(m, s, '\n', sep = '\t')
q(runLast=FALSE)
