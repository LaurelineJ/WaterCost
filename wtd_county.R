## wtd_county_v2 is the updated dataset for the water table depth of each US county.  
## I extracted the data from N_America_model_wtd_v2.nc file 
## And converted all the gridded data into county scale. 
## There are 3218 US counties with 15842184 obervations (with no missing values). 
## Some counties use the same name, so we should refer to their state code and county code instead. 
## (The dataset is so big that it may require some time to download it.)
## I also calculated the mean and standard deviation for each county in meansd2.csv. 
## The shapefile I used is from:  https://www.census.gov/geo/maps-data/data/cbf/cbf_counties.html

##read the nc file
library(chron)
library(RColorBrewer)
library(lattice)
library(ncdf)
install.packages("ncdf4")
library(ncdf4)
##open the nc file
ncfile<-nc_open("N_America_model_wtd_v2.nc")

##get the longitude data
lon <- ncvar_get(ncfile,"lon")
nlon <- dim(lon)
head(lon)

##get the longitude data
lat <- ncvar_get(ncfile,"lat")
nlat <- dim(lat)
head(lat)

##get the time data
t <- ncvar_get(ncfile,"time")
t <- dim(t)
t

##get the water table depth data
wtd<-ncvar_get(ncfile,"WTD")

##Replace netCDF fillvalues with R NAs
fillvalue <- ncatt_get(ncfile,"WTD","_FillValue")
fillvalue
wtd[wtd==fillvalue$value] <- NA

##The total number of non-missing grid data
length(na.omit(as.vector(wtd[,1])))

dim(wtd)
v1 <- ncfile$var[[1]]
data1 <- ncvar_get(ncfile, v1 )
ncfile$var[[1]]$varsize
##take a look at the matrix 'wtd'
lonlat <- as.matrix(expand.grid(lon,lat))
dim(lonlat)

m <- 1
wtd_slice <- wtd[,m]
wtd_vec <- as.vector(wtd)
length(wtd_vec)

wtd_df01 <- data.frame(cbind(lonlat,wtd_vec))
summary(wtd_df01)
nona<-na.omit(wtd_df01)
summary(nona)
head(nona,4)
names(nona) <- c("lon","lat","wtd")
head(na.omit(wtd_df01), 10)
write.table(na.omit(wtd_df01),"wtd.file", row.names=FALSE, sep=",")
write.table(nona,"wtd.csv", row.names=FALSE, sep=",")

library(rgeos)
library(sp)
library(rgdal)
##read the shapefile
counties <- readOGR('cb_2016_us_county_500k.shp')
#counties <- readOGR('cb_2016_us_county_500k.shp') for the year 2000
##red the points
nona <-read.csv("wtd.csv")
nona <-as.data.frame(nona)
nona<-nona[,c("lon","lat")]
names(nona)
##convert the data into county scale
coordinates(nona) <- ~ lon + lat
proj4string(nona) <- proj4string(counties)
outcome2<-over(nona,counties)
names(outcome2)
names(nona2)
##add the lat,lon and wtd to the dataset
outcome2$lon<-nona2$lon
outcome2$lat<-nona2$lat
outcome2$wtd<-nona2$wtd

summary(outcome2)
head(outcome2,10)
##omit the na values
outcome3<-na.omit(outcome2)
head(outcome3)
unique(outcome3$COUNTYNS)
typeof(nona)
nona <- as.data.frame(nona)
names(nona)
write.csv(outcome3,"wtd_county_v2.csv")
