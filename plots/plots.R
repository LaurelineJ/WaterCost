
library(ggplot2)
library(PBSmapping)
#library(rmngb)
shapes <- importShapefile('plots/shape_file/US_county_2000-simple')
polydata <- attributes(shapes)$PolyData
polydata$STATE <- as.numeric(levels(polydata$STATE))[polydata$STATE]
polydata$COUNTY <- as.numeric(levels(polydata$COUNTY))[polydata$COUNTY]
shapes$id <- polydata$STATE[shapes$PID] * 100 + polydata$COUNTY[shapes$PID] / 10
names(shapes) <- tolower(names(shapes))
load("data/geography/referencefips.Rdata")

mapdata <- function(vartoplot,varname, transtype='identity'){
  dfp = data.frame(v_FIPS,vartoplot)
  names(dfp) = c("FIPS","vartoplot")

print(ggplot(dfp, aes(fill=vartoplot)) + 
        geom_map(aes(map_id=FIPS), map=shapes) + 
        expand_limits(x=c(-2500000, 2500000), y=c(-1.4e6, 1.6e6)) +
        scale_fill_gradient(name=varname, trans=transtype, low='purple', high='orange') +
        theme_bw() + theme(legend.justification=c(0,0), legend.position=c(0,0)) + xlab('') + ylab(''))
}

