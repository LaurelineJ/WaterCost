
library(ggplot2)
library(PBSmapping)
#library(rmngb)
EPAshape <- importShapefile('data/plants characteristics/Environmental_Protection_Agency_EPA_Facility_Registry_Service_FRS_Wastewater_Treatment_Plants')

## fips of the facility location?
EPAshape$FID
EPAshape$CWP_ZIP
EPAshape$FAC_FIPS_C

## what's the treatment type/technology?
names(EPAshape)
# ?
