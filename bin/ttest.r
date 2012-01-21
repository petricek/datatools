d <- read.table("/dev/stdin")
t=t.test(d[,1],d[,2],paired=__PAIRED__,alternative="__ALTERNATIVE__")
cat(t$p.value, t$estimate, t$conf.int, '\n', sep = '\t')
q(runLast=FALSE)

