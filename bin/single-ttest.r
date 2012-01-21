
d <- read.table("/dev/stdin") 
t=t.test(d[,1],alternative="two.sided")
cat(t$p.value, t$estimate, t$conf.int, '\n', sep = '\t')
q(runLast=FALSE)
