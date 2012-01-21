
df <- read.table("/dev/stdin") 
d=as.numeric(df[,1])
cat(mean(d), ' +-', sd(d), '\n', sep='')
q(runLast=FALSE)
