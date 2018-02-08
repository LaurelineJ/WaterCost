################################################
##### WATER COST MODEL
################################################
ncounty <- 3109

## READ THE WATER USE INFO
source("scriptreadwithdrawalsusgs.R")

## DEFINE THE COST MATRIX
cost <- array(NA, dim = c(5,5,3,4))#, dimnames = c("watertype","use","costtype","cost"))

# EXTRACTION COST
# unit extraction cost: in $/m3/m of lift
unit_ext_cost <- 0.02
load("data/aquifer/headinit1.Rdata")
cost[1:2,,,1] <- unit_ext_cost # for GW, same cost for all use, regardless of the quality, prop to the depth to the water table (ask mean values to Tristan)
cost[3:4,,,1] <- 0*unit_ext_cost # for SW, same cost for all use, regardless of the quality, assumption: water is never pumped up (not true) (get min value elevation per county?)
cost[5,,,] <- 10*unit_ext_cost

# TREATMENT COST
# urban treatment cost
cost[1,1,,2] <- 1 # gw fresh
cost[2,1,,2] <- 7 # gw brackish
cost[3,1,,2] <- 3 # sw fresh
cost[4,1,,2] <- 7 # sw brackish
cost[5,1,,2] <- 10 # sea water

# ag treatment cost
cost[1,2,,2] <- 0 # gw fresh
cost[2,2,,2] <- 5 # gw brackish
cost[3,2,,2] <- 0 # sw fresh
cost[4,2,,2] <- 5 # sw brackish
cost[5,2,,2] <- 10 # sea water

# energy treatment cost: same as ag
cost[,3,,2] <- cost[,2,,2]

# industrial treatment cost: same as ag as we do not have more information
cost[,4,,2] <- cost[,2,,2]

# mining treatment cost
cost[c(1,3),5,,2] <- 0 # gw and sw fresh
cost[c(2,4),5,,2] <- 0.1 # gw and sw brackish
cost[5,5,,2] <- 0.1 # sea water

# DISTRIBUTION COST
# assuming for a few meters of lift in function of use ... 
cost[,1,,3] <- 20*unit_ext_cost # for urban
cost[,2,,3] <- 3*unit_ext_cost # for ag
cost[,3,,3] <- 3*unit_ext_cost # for energy
cost[,4,,3] <- 3*unit_ext_cost # for industry
cost[,5,,3] <- 3*unit_ext_cost # for mining

# WASTE TREATMENT
cost[,,,4] <- 0 # no information so far

## COMPUTE THE COST
tot_cost <- array(NA, dim = c(5,5,3,4,ncounty))#, dimnames = c("watertype","use","costtype","cost","county"))
for(nn in 1:ncounty){
  for(tt in 1:3){
    for(cc in 1:4){
      tot_cost[,,tt,cc,nn] <- cost[,,tt,cc]*withdrawals[,,nn]
    }
    tot_cost[1:2,,tt,1,nn] <-  cost[1:2,,tt,cc]*withdrawals[1:2,,nn]*h01[nn] # ext multiply by depth for gw
  }
}

## PRODUCE THE PLOTS
source("plots/plots.R")
source("sumupcost.R")

mapdata(totw,"total withdrawals","log")
mapdata(totsw,"total sw withdrawals","log")
mapdata(totgw,"total gw withdrawals","log")
mapdata(totsw/totw*100,"% sw")
mapdata(totur,"total urban withdrawals","log")
mapdata(totag,"total ag withdrawals","log")
mapdata(toten,"total energy withdrawals","log")
mapdata(totmi,"total mining withdrawals","log")
mapdata(totin,"total ind withdrawals","log")
mapdata(totur/totw*100,"% urban withdrawals")
mapdata(totag/totw*100,"% ag withdrawals")
mapdata(toten/totw*100,"% energy withdrawals")
mapdata(totmi/totw*100,"% mining withdrawals")
mapdata(totin/totw*100,"% ind withdrawals")


mapdata(costw,"cost withdrawals","log")
mapdata(costw/totw,"cost withdrawals","log")
mapdata(costsw,"cost sw withdrawals","log")
mapdata(costgw,"cost gw withdrawals","log")
mapdata(costsw/costw*100,"% sw")
mapdata(costur,"cost urban withdrawals","log")
mapdata(costag,"cost ag withdrawals","log")
mapdata(costen,"cost energy withdrawals","log")
mapdata(costmi,"cost mining withdrawals","log")
mapdata(costin,"cost ind withdrawals","log")
mapdata(costur/costw*100,"% urban withdrawals")
mapdata(costag/costw*100,"% ag withdrawals")
mapdata(costen/costw*100,"% energy withdrawals")
mapdata(costmi/costw*100,"% mining withdrawals")
mapdata(costin/costw*100,"% ind withdrawals")

mapdata(costur/costw*100-totur/totw*100,"% urban withdrawals")
