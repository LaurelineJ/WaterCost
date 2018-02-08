
totw <- apply(withdrawals, MARGIN=c(3), sum)

totsw <- apply(withdrawals[3:4,,], MARGIN=c(3), sum)
totgw <- apply(withdrawals[1:2,,], MARGIN=c(3), sum)

totfr <- apply(withdrawals[c(1,3),,], MARGIN=c(3), sum)
totbk <- apply(withdrawals[c(2,4),,], MARGIN=c(3), sum)

totur <- apply(withdrawals[,1,], MARGIN=c(2), sum)
totag <- apply(withdrawals[,2,], MARGIN=c(2), sum)
toten <- apply(withdrawals[,3,], MARGIN=c(2), sum)
totin <- apply(withdrawals[,4,], MARGIN=c(2), sum)
totmi <- apply(withdrawals[,5,], MARGIN=c(2), sum)

costw <- apply(tot_cost, MARGIN=c(5), sum)

costsw <- apply(tot_cost[3:4,,,,], MARGIN=c(5), sum)
costgw <- apply(tot_cost[1:2,,,,], MARGIN=c(5), sum)

costfr <- apply(tot_cost[c(1,3),,,,], MARGIN=c(5), sum)
costbk <- apply(tot_cost[c(2,4),,,,], MARGIN=c(5), sum)

costur <- apply(tot_cost[,1,,,], MARGIN=c(4), sum)
costag <- apply(tot_cost[,2,,,], MARGIN=c(4), sum)
costen <- apply(tot_cost[,3,,,], MARGIN=c(4), sum)
costin <- apply(tot_cost[,4,,,], MARGIN=c(4), sum)
costmi <- apply(tot_cost[,5,,,], MARGIN=c(4), sum)