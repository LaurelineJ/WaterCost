## script to load USGS data
withdrawals <- array(0, dim = c(5,5,ncounty))#,dimnames = as.list(c("watertype","use","county")))

usgsdata <- read.csv("data/demand/simulation2010demanddata.csv")
# URBAN USE
withdrawals[1,1,] <- usgsdata$PS_WGWTo # gw fresh
withdrawals[2,1,] <- 0 # gw brackish
withdrawals[3,1,] <- usgsdata$PS_WSWTo # sw fresh
withdrawals[4,1,] <- 0 # sw brackish
withdrawals[5,1,] <- 0 # sea water

# AG USE
withdrawals[1,2,] <- usgsdata$IR_WGWFr # gw fresh
withdrawals[2,2,] <- 0 # gw brackish
withdrawals[3,2,] <- usgsdata$IR_WSWFr # sw fresh
withdrawals[4,2,] <- 0 # sw brackish
withdrawals[5,2,] <- 0 # sea water

# ENERGY USE
withdrawals[1,3,] <- usgsdata$PT_WGWTo # gw fresh
withdrawals[2,3,] <- 0 # gw brackish
withdrawals[3,3,] <- usgsdata$PT_WSWTo # sw fresh
withdrawals[4,3,] <- 0 # sw brackish
withdrawals[5,3,] <- 0 # sea water

# INDUSTRIAL USE
withdrawals[1,4,] <- usgsdata$IN_WGWTo # gw fresh
withdrawals[2,4,] <- 0 # gw brackish
withdrawals[3,4,] <- usgsdata$IN_WSWTo # sw fresh
withdrawals[4,4,] <- 0 # sw brackish
withdrawals[5,4,] <- 0 # sea water

# MINING USE
withdrawals[1,5,] <- usgsdata$MI_WGWTo # gw fresh
withdrawals[2,5,] <- 0 # sw brackish
withdrawals[3,5,] <- usgsdata$MI_WSWTo # sw fresh
withdrawals[4,5,] <- 0 # sw brackish
withdrawals[5,5,] <- 0 # sea water
