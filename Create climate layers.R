library(raster)
library(rworldmap)

climate <- getData('worldclim', var='bio', res=2.5)
#?getData
climate <- climate[[c(1:19)]]
names(climate) <- c("Annual Mean Temperature", "Mean Diurnal Range", "Isothermality", "Temperature Seasonality","Max Temperature of Warmest Month","Min Temperature of Coldest Month",
                    "Temperature Annual Range", "Mean Temperature of Wettest Quarter","Mean Temperature of Driest Quarter", "Mean Temperature of Warmest Quarter", "Mean Temperature of Coldest Quarter",
                    "Annual Precipitation","Precipitation of Wettest Month","Precipitation of Driest Month","Precipitation Seasonality (Coefficient of Variation)","Precipitation of Wettest Quarter",
                    "Precipitation of Driest Quarter","Precipitation of Warmest Quarter","Precipitation of Coldest Quarter")
#coordinates(climate)
points<-SpatialPoints(coordinates(climate))

#extract all data from worldclim
values <- extract(climate, points)
allclimateworld<- cbind.data.frame(coordinates(points),values)
allclimateworld <- na.omit(allclimateworld)


coords2continent = function(points)
{  
  countriesSP <- getMap(resolution='low')
  #countriesSP <- getMap(resolution='high') #you could use high res map from rworldxtra if you were concerned about detail
  
  # converting points to a SpatialPoints object
  # setting CRS directly to that from rworldmap
  pointsSP = SpatialPoints(allclimateworld, proj4string=CRS(proj4string(countriesSP)))  
  
  
  # use 'over' to get indices of the Polygons object containing each point 
  indices = over(pointsSP, countriesSP)
  
  #indices$continent   # returns the continent (6 continent model)
  indices$REGION   # returns the continent (7 continent model)
  #indices$ADMIN  #returns country name
  #indices$ISO3 # returns the ISO3 code 
}

#assign continents
allclimateworld$continent<-coords2continent(allclimateworld)


#select continents
clim1.1<-subset(allclimateworld, allclimateworld$continent=="Europe")
#clim1.2<-subset(allclimateworld , allclimateworld$continent == "Asia")
#clim1<-rbind(clim1.1,clim1.2)
#clim1<-subset(climateclean, climateclean$continent=="Asia")
# load climate variables for all sites of the invaded area 1
#clim2.1<-subset(allclimateworld, allclimateworld$continent=="North America")
#clim2.2<-subset(allclimateworld, allclimateworld$continent == "South America")
#clim2<-rbind(clim2.1,clim2.2)

#clim12<-rbind(clim1,clim2)

#remove variables not in use
#clim12 <- na.omit(clim12[,c(1:21)])
#clim1 <- na.omit(clim1[,c(1:21)])
#clim2 <- na.omit(clim2[,c(1:21)])
clim1.1 <- na.omit(clim1.1[,c(1:21)])

#names(clim12)

#Convert dataframe to rasterstack
#Here clim12 would be your data for just Europe
#coordinates(clim12) <- ~ x + y
coordinates(clim1.1) <- ~ x + y

# coerce to SpatialPixelsDataFrame
#gridded(clim12)<- T
gridded(clim1.1)<- T
# coerce to raster
#s <- stack(clim12)
s <- stack(clim1.1)

#Crop raster
e <- extent(-12, 50, 34, 75)
r <- crop(s, e)

#Write raster
unstack(s)
bio01asc <- writeRaster(r[[1]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio01.asc", package="raster")
bio01 <- writeRaster(r[[1]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio01.grd", package="raster")
bio02 <- writeRaster(r[[2]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio02.grd", package="raster")
bio03 <- writeRaster(r[[3]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio03.grd", package="raster")
bio04 <- writeRaster(r[[4]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio04.grd", package="raster")
bio05 <- writeRaster(r[[5]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio05.grd", package="raster")
bio06 <- writeRaster(r[[6]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio06.grd", package="raster")
bio07 <- writeRaster(r[[7]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio07.grd", package="raster")
bio08 <- writeRaster(r[[8]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio08.grd", package="raster")
bio09 <- writeRaster(r[[9]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio09.grd", package="raster")
bio10 <- writeRaster(r[[10]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio10.grd", package="raster")
bio11 <- writeRaster(r[[11]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio11.grd", package="raster")
bio12 <- writeRaster(r[[12]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio12.grd", package="raster")
bio13 <- writeRaster(r[[13]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio13.grd", package="raster")
bio14 <- writeRaster(r[[14]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio14.grd", package="raster")
bio15 <- writeRaster(r[[15]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio15.grd", package="raster")
bio16 <- writeRaster(r[[16]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio16.grd", package="raster")
bio17 <- writeRaster(r[[17]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio17.grd", package="raster")
bio18 <- writeRaster(r[[18]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio18.grd", package="raster")
bio19 <- writeRaster(r[[19]], "//a00143.science.domain/lfj315/Documents/Projects/T immigrans/ArcGIS/bio19.grd", package="raster")
