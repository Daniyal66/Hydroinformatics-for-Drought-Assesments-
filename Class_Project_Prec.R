#required packages
library(dataRetrieval)
library(timeDate)
library(lubridate)
library(ggplot2)
library(xts)
library(ReadAxfBOM)
library(xlsx)
library(gridExtra)
library(raster)
library(rgdal)
library(sf)
library(maptools)
library(ncdf4)
library(reshape2)
library(dplyr)
library(spi)
library(SPEI)
library(ncdf4)
library(reshape2)
library(dplyr)
# Reading Utah Counties

list.files("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties")
Utah_Counties <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/UtahCounties.shp")
plot(Utah_Counties)
SALTLAKE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/SALTLAKE.shp")
CARBON <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/CARBON.shp")
SEVIER <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/SEVIER.shp")
EMERY <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/EMERY.shp")
WAYNE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/WAYNE.shp")
MORGAN <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/MORGAN.shp")
DAVIS <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/DAVIS.shp")
PIUTE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/PIUTE.shp")
DAGGETT <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/DAGGETT.shp")
DUCHESNE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/DUCHESNE.shp")
UTAH <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/UTAH.shp")
JUAB <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/JUAB.shp")
WASATCH <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/WASATCH.shp")
MILLARD <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/MILLARD.shp")
WASHINGTON <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/WASHINGTON.shp")
GRAND <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/GRAND.shp")
UINTAH <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/UINTAH.shp")
CACHE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/CACHE.shp")
BOX_ELDER <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/BOX_ELDER.shp")
BEAVER <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/BEAVER.shp")
TOOELE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/TOOELE.shp")
SUMMIT <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/SUMMIT.shp")
RICH <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/RICH.shp")
GARFIELD <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/GARFIELD.shp")
SAN_JUAN <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/SAN_JUAN.shp")
WEBER <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/WEBER.shp")
KANE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/KANE.shp")
IRON <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/IRON.shp")
SANPETE <- readOGR("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/UtahCounties/SANPETE.shp")


setwd("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS")

# retrieve a list of nc files in my data folder:

ncflist <- list.files(path = "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS", 
                      pattern = NULL, all.files = FALSE,
                      full.names = FALSE, recursive = FALSE,
                      ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)
#Read Data from NetCDF
# Total Precipitation Rate kg m^-2 s^-1
# Convert into meters by multiplication factors: 2678.4 (31 days month), 2592 (30 days month), 2505.6 (29 days month), 2419.2 (28 days month) 
#2000
P_200001 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200001.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200002 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200002.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2505.6
P_200003 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200003.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200004 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200004.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200005 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200005.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200006 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200006.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200007 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200007.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200008 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200008.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200009 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200009.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200010 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200010.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200011 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200011.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200012 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200012.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2001
P_200101 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200101.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200102 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200102.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_200103 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200103.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200104 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200104.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200105 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200105.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200106 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200106.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200107 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200107.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200108 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200108.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200109 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200109.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200110 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200110.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200111 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200111.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200112 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200112.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2002
P_200201 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200201.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200202 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200202.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_200203 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200203.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200204 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200204.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200205 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200205.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200206 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200206.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200207 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200207.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200208 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200208.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200209 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200209.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200210 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200210.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200211 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200211.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200212 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200212.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2003
P_200301 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200301.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200302 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200302.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_200303 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200303.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200304 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200304.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200305 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200305.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200306 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200306.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200307 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200307.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200308 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200308.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200309 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200309.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200310 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200310.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200311 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200311.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200312 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200312.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2004
P_200401 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200401.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200402 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200402.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2505.6
P_200403 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200403.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200404 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200404.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200405 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200405.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200406 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200406.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200407 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200407.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200408 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200408.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200409 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200409.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200410 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200410.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200411 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200411.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200412 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200412.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2005
P_200501 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200501.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200502 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200502.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_200503 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200503.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200504 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200504.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200505 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200505.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200506 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200506.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200507 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200507.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200508 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200508.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200509 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200509.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200510 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200510.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200511 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200511.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200512 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200512.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2006
P_200601 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200601.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200602 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200602.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_200603 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200603.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200604 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200604.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200605 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200605.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200606 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200606.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200607 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200607.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200608 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200608.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200609 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200609.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200610 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200610.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200611 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200611.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200612 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200612.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4

#2007
P_200701 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200701.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200702 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200702.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_200703 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200703.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200704 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200704.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200705 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200705.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200706 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200706.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200707 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200707.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200708 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200708.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200709 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200709.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200710 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200710.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200711 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200711.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200712 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200712.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2008
P_200801 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200801.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200802 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200802.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2505.6
P_200803 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200803.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200804 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200804.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200805 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200805.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200806 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200806.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200807 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200807.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200808 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200808.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200809 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200809.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200810 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200810.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200811 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200811.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200812 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200812.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4

#2009
P_200901 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200901.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200902 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200902.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_200903 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200903.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200904 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200904.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200905 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200905.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200906 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200906.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200907 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200907.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200908 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200908.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200909 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200909.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200910 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200910.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_200911 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200911.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_200912 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A200912.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4

#2010
P_201001 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201001.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201002 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201002.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_201003 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201003.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201004 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201004.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201005 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201005.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201006 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201006.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201007 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201007.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201008 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201008.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201009 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201009.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201010 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201010.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201011 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201011.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201012 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201012.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2011
P_201101 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201101.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201102 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201102.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_201103 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201103.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201104 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201104.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201105 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201105.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201106 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201106.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201107 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201107.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201108 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201108.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201109 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201109.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201110 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201110.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201111 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201111.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201112 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201112.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4



#2012
P_201201 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201201.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201202 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201202.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2505.6
P_201203 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201203.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201204 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201204.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201205 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201205.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201206 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201206.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201207 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201207.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201208 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201208.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201209 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201209.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201210 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201210.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201211 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201211.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201212 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201212.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2013
P_201301 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201301.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201302 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201302.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_201303 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201303.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201304 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201304.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201305 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201305.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201306 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201306.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201307 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201307.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201308 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201308.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201309 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201309.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201310 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201310.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201311 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201311.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201312 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201312.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4

#2014
P_201401 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201401.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201402 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201402.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_201403 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201403.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201404 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201404.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201405 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201405.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201406 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201406.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201407 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201407.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201408 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201408.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201409 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201409.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201410 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201410.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201411 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201411.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201412 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201412.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2015
P_201501 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201501.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201502 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201502.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_201503 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201503.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201504 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201504.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201505 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201505.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201506 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201506.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201507 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201507.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201508 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201508.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201509 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201509.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201510 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201510.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201511 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201511.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201512 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201512.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2016
P_201601 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201601.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201602 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201602.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2505.6
P_201603 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201603.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201604 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201604.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201605 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201605.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201606 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201606.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201607 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201607.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201608 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201608.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201609 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201609.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201610 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201610.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201611 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201611.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201612 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201612.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4


#2017
P_201701 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201701.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201702 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201702.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_201703 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201703.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201704 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201704.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201705 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201705.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201706 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201706.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201707 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201707.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201708 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201708.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201709 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201709.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201710 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201710.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201711 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201711.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201712 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201712.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4

#2018
P_201801 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201801.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201802 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201802.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2419.2
P_201803 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201803.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201804 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201804.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201805 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201805.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201806 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201806.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592
P_201807 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201807.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201808 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201808.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2678.4
P_201809 <- raster("C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/RPackageSWSIPSI/GLDAS/GLDAS_NOAH025_M.A201809.021.nc4.SUB.nc4", varname = "Rainf_f_tavg", write=FALSE, readunlim=TRUE, verbose=FALSE,auto_GMT=TRUE, suppress_dimvals=FALSE )*2592


# Crop Monthly Precipitation to the Counties

# Box Elder
#2000
BOX_ELDER_P_200001 <- crop(P_200001, BOX_ELDER) 
BOX_ELDER_P_200002 <- crop(P_200002, BOX_ELDER)
BOX_ELDER_P_200003 <- crop(P_200003, BOX_ELDER)
BOX_ELDER_P_200004 <- crop(P_200004, BOX_ELDER)
BOX_ELDER_P_200005 <- crop(P_200005, BOX_ELDER)
BOX_ELDER_P_200006 <- crop(P_200006, BOX_ELDER)  
BOX_ELDER_P_200007 <- crop(P_200007, BOX_ELDER)  
BOX_ELDER_P_200008 <- crop(P_200008, BOX_ELDER)  
BOX_ELDER_P_200009 <- crop(P_200009, BOX_ELDER)  
BOX_ELDER_P_200010 <- crop(P_200010, BOX_ELDER)  
BOX_ELDER_P_200011 <- crop(P_200011, BOX_ELDER)  
BOX_ELDER_P_200012 <- crop(P_200012, BOX_ELDER)  
#2001
BOX_ELDER_P_200101 <- crop(P_200101, BOX_ELDER) 
BOX_ELDER_P_200102 <- crop(P_200102, BOX_ELDER)
BOX_ELDER_P_200103 <- crop(P_200103, BOX_ELDER)
BOX_ELDER_P_200104 <- crop(P_200104, BOX_ELDER)
BOX_ELDER_P_200105 <- crop(P_200105, BOX_ELDER)
BOX_ELDER_P_200106 <- crop(P_200106, BOX_ELDER)  
BOX_ELDER_P_200107 <- crop(P_200107, BOX_ELDER)  
BOX_ELDER_P_200108 <- crop(P_200108, BOX_ELDER)  
BOX_ELDER_P_200109 <- crop(P_200109, BOX_ELDER)  
BOX_ELDER_P_200110 <- crop(P_200110, BOX_ELDER)  
BOX_ELDER_P_200111 <- crop(P_200111, BOX_ELDER)  
BOX_ELDER_P_200112 <- crop(P_200112, BOX_ELDER)  

#2002
BOX_ELDER_P_200201 <- crop(P_200201, BOX_ELDER) 
BOX_ELDER_P_200202 <- crop(P_200202, BOX_ELDER)
BOX_ELDER_P_200203 <- crop(P_200203, BOX_ELDER)
BOX_ELDER_P_200204 <- crop(P_200204, BOX_ELDER)
BOX_ELDER_P_200205 <- crop(P_200205, BOX_ELDER)
BOX_ELDER_P_200206 <- crop(P_200206, BOX_ELDER)  
BOX_ELDER_P_200207 <- crop(P_200207, BOX_ELDER)  
BOX_ELDER_P_200208 <- crop(P_200208, BOX_ELDER)  
BOX_ELDER_P_200209 <- crop(P_200209, BOX_ELDER)  
BOX_ELDER_P_200210 <- crop(P_200210, BOX_ELDER)  
BOX_ELDER_P_200211 <- crop(P_200211, BOX_ELDER)  
BOX_ELDER_P_200212 <- crop(P_200212, BOX_ELDER)  
#2003
BOX_ELDER_P_200301 <- crop(P_200301, BOX_ELDER) 
BOX_ELDER_P_200302 <- crop(P_200302, BOX_ELDER)
BOX_ELDER_P_200303 <- crop(P_200303, BOX_ELDER)
BOX_ELDER_P_200304 <- crop(P_200304, BOX_ELDER)
BOX_ELDER_P_200305 <- crop(P_200305, BOX_ELDER)
BOX_ELDER_P_200306 <- crop(P_200306, BOX_ELDER)  
BOX_ELDER_P_200307 <- crop(P_200307, BOX_ELDER)  
BOX_ELDER_P_200308 <- crop(P_200308, BOX_ELDER)  
BOX_ELDER_P_200309 <- crop(P_200309, BOX_ELDER)  
BOX_ELDER_P_200310 <- crop(P_200310, BOX_ELDER)  
BOX_ELDER_P_200311 <- crop(P_200311, BOX_ELDER)  
BOX_ELDER_P_200312 <- crop(P_200312, BOX_ELDER)  
#2004
BOX_ELDER_P_200401 <- crop(P_200401, BOX_ELDER) 
BOX_ELDER_P_200402 <- crop(P_200402, BOX_ELDER)
BOX_ELDER_P_200403 <- crop(P_200403, BOX_ELDER)
BOX_ELDER_P_200404 <- crop(P_200404, BOX_ELDER)
BOX_ELDER_P_200405 <- crop(P_200405, BOX_ELDER)
BOX_ELDER_P_200406 <- crop(P_200406, BOX_ELDER)  
BOX_ELDER_P_200407 <- crop(P_200407, BOX_ELDER)  
BOX_ELDER_P_200408 <- crop(P_200408, BOX_ELDER)  
BOX_ELDER_P_200409 <- crop(P_200409, BOX_ELDER)  
BOX_ELDER_P_200410 <- crop(P_200410, BOX_ELDER)  
BOX_ELDER_P_200411 <- crop(P_200411, BOX_ELDER)  
BOX_ELDER_P_200412 <- crop(P_200412, BOX_ELDER)  
#2005
BOX_ELDER_P_200501 <- crop(P_200501, BOX_ELDER) 
BOX_ELDER_P_200502 <- crop(P_200502, BOX_ELDER)
BOX_ELDER_P_200503 <- crop(P_200503, BOX_ELDER)
BOX_ELDER_P_200504 <- crop(P_200504, BOX_ELDER)
BOX_ELDER_P_200505 <- crop(P_200505, BOX_ELDER)
BOX_ELDER_P_200506 <- crop(P_200506, BOX_ELDER)  
BOX_ELDER_P_200507 <- crop(P_200507, BOX_ELDER)  
BOX_ELDER_P_200508 <- crop(P_200508, BOX_ELDER)  
BOX_ELDER_P_200509 <- crop(P_200509, BOX_ELDER)  
BOX_ELDER_P_200510 <- crop(P_200510, BOX_ELDER)  
BOX_ELDER_P_200511 <- crop(P_200511, BOX_ELDER)  
BOX_ELDER_P_200512 <- crop(P_200512, BOX_ELDER)  
#2006
BOX_ELDER_P_200601 <- crop(P_200601, BOX_ELDER) 
BOX_ELDER_P_200602 <- crop(P_200602, BOX_ELDER)
BOX_ELDER_P_200603 <- crop(P_200603, BOX_ELDER)
BOX_ELDER_P_200604 <- crop(P_200604, BOX_ELDER)
BOX_ELDER_P_200605 <- crop(P_200605, BOX_ELDER)
BOX_ELDER_P_200606 <- crop(P_200606, BOX_ELDER)  
BOX_ELDER_P_200607 <- crop(P_200607, BOX_ELDER)  
BOX_ELDER_P_200608 <- crop(P_200608, BOX_ELDER)  
BOX_ELDER_P_200609 <- crop(P_200609, BOX_ELDER)  
BOX_ELDER_P_200610 <- crop(P_200610, BOX_ELDER)  
BOX_ELDER_P_200611 <- crop(P_200611, BOX_ELDER)  
BOX_ELDER_P_200612 <- crop(P_200612, BOX_ELDER)  
#2007
BOX_ELDER_P_200701 <- crop(P_200701, BOX_ELDER) 
BOX_ELDER_P_200702 <- crop(P_200702, BOX_ELDER)
BOX_ELDER_P_200703 <- crop(P_200703, BOX_ELDER)
BOX_ELDER_P_200704 <- crop(P_200704, BOX_ELDER)
BOX_ELDER_P_200705 <- crop(P_200705, BOX_ELDER)
BOX_ELDER_P_200706 <- crop(P_200706, BOX_ELDER)  
BOX_ELDER_P_200707 <- crop(P_200707, BOX_ELDER)  
BOX_ELDER_P_200708 <- crop(P_200708, BOX_ELDER)  
BOX_ELDER_P_200709 <- crop(P_200709, BOX_ELDER)  
BOX_ELDER_P_200710 <- crop(P_200710, BOX_ELDER)  
BOX_ELDER_P_200711 <- crop(P_200711, BOX_ELDER)  
BOX_ELDER_P_200712 <- crop(P_200712, BOX_ELDER)  
#2008
BOX_ELDER_P_200801 <- crop(P_200801, BOX_ELDER) 
BOX_ELDER_P_200802 <- crop(P_200802, BOX_ELDER)
BOX_ELDER_P_200803 <- crop(P_200803, BOX_ELDER)
BOX_ELDER_P_200804 <- crop(P_200804, BOX_ELDER)
BOX_ELDER_P_200805 <- crop(P_200805, BOX_ELDER)
BOX_ELDER_P_200806 <- crop(P_200806, BOX_ELDER)  
BOX_ELDER_P_200807 <- crop(P_200807, BOX_ELDER)  
BOX_ELDER_P_200808 <- crop(P_200808, BOX_ELDER)  
BOX_ELDER_P_200809 <- crop(P_200809, BOX_ELDER)  
BOX_ELDER_P_200810 <- crop(P_200810, BOX_ELDER)  
BOX_ELDER_P_200811 <- crop(P_200811, BOX_ELDER)  
BOX_ELDER_P_200812 <- crop(P_200812, BOX_ELDER)  
#2009
BOX_ELDER_P_200901 <- crop(P_200901, BOX_ELDER) 
BOX_ELDER_P_200902 <- crop(P_200902, BOX_ELDER)
BOX_ELDER_P_200903 <- crop(P_200903, BOX_ELDER)
BOX_ELDER_P_200904 <- crop(P_200904, BOX_ELDER)
BOX_ELDER_P_200905 <- crop(P_200905, BOX_ELDER)
BOX_ELDER_P_200906 <- crop(P_200906, BOX_ELDER)  
BOX_ELDER_P_200907 <- crop(P_200907, BOX_ELDER)  
BOX_ELDER_P_200908 <- crop(P_200908, BOX_ELDER)  
BOX_ELDER_P_200909 <- crop(P_200909, BOX_ELDER)  
BOX_ELDER_P_200910 <- crop(P_200910, BOX_ELDER)  
BOX_ELDER_P_200911 <- crop(P_200911, BOX_ELDER)  
BOX_ELDER_P_200912 <- crop(P_200912, BOX_ELDER)  
#2010
BOX_ELDER_P_201001 <- crop(P_201001, BOX_ELDER) 
BOX_ELDER_P_201002 <- crop(P_201002, BOX_ELDER)
BOX_ELDER_P_201003 <- crop(P_201003, BOX_ELDER)
BOX_ELDER_P_201004 <- crop(P_201004, BOX_ELDER)
BOX_ELDER_P_201005 <- crop(P_201005, BOX_ELDER)
BOX_ELDER_P_201006 <- crop(P_201006, BOX_ELDER)  
BOX_ELDER_P_201007 <- crop(P_201007, BOX_ELDER)  
BOX_ELDER_P_201008 <- crop(P_201008, BOX_ELDER)  
BOX_ELDER_P_201009 <- crop(P_201009, BOX_ELDER)  
BOX_ELDER_P_201010 <- crop(P_201010, BOX_ELDER)  
BOX_ELDER_P_201011 <- crop(P_201011, BOX_ELDER)  
BOX_ELDER_P_201012 <- crop(P_201012, BOX_ELDER)  
#2011
BOX_ELDER_P_201101 <- crop(P_201101, BOX_ELDER) 
BOX_ELDER_P_201102 <- crop(P_201102, BOX_ELDER)
BOX_ELDER_P_201103 <- crop(P_201103, BOX_ELDER)
BOX_ELDER_P_201104 <- crop(P_201104, BOX_ELDER)
BOX_ELDER_P_201105 <- crop(P_201105, BOX_ELDER)
BOX_ELDER_P_201106 <- crop(P_201106, BOX_ELDER)  
BOX_ELDER_P_201107 <- crop(P_201107, BOX_ELDER)  
BOX_ELDER_P_201108 <- crop(P_201108, BOX_ELDER)  
BOX_ELDER_P_201109 <- crop(P_201109, BOX_ELDER)  
BOX_ELDER_P_201110 <- crop(P_201110, BOX_ELDER)  
BOX_ELDER_P_201111 <- crop(P_201111, BOX_ELDER)  
BOX_ELDER_P_201112 <- crop(P_201112, BOX_ELDER)  
#2012
BOX_ELDER_P_201201 <- crop(P_201201, BOX_ELDER) 
BOX_ELDER_P_201202 <- crop(P_201202, BOX_ELDER)
BOX_ELDER_P_201203 <- crop(P_201203, BOX_ELDER)
BOX_ELDER_P_201204 <- crop(P_201204, BOX_ELDER)
BOX_ELDER_P_201205 <- crop(P_201205, BOX_ELDER)
BOX_ELDER_P_201206 <- crop(P_201206, BOX_ELDER)  
BOX_ELDER_P_201207 <- crop(P_201207, BOX_ELDER)  
BOX_ELDER_P_201208 <- crop(P_201208, BOX_ELDER)  
BOX_ELDER_P_201209 <- crop(P_201209, BOX_ELDER)  
BOX_ELDER_P_201210 <- crop(P_201210, BOX_ELDER)  
BOX_ELDER_P_201211 <- crop(P_201211, BOX_ELDER)  
BOX_ELDER_P_201212 <- crop(P_201212, BOX_ELDER)  
#2013
BOX_ELDER_P_201301 <- crop(P_201301, BOX_ELDER) 
BOX_ELDER_P_201302 <- crop(P_201302, BOX_ELDER)
BOX_ELDER_P_201303 <- crop(P_201303, BOX_ELDER)
BOX_ELDER_P_201304 <- crop(P_201304, BOX_ELDER)
BOX_ELDER_P_201305 <- crop(P_201305, BOX_ELDER)
BOX_ELDER_P_201306 <- crop(P_201306, BOX_ELDER)  
BOX_ELDER_P_201307 <- crop(P_201307, BOX_ELDER)  
BOX_ELDER_P_201308 <- crop(P_201308, BOX_ELDER)  
BOX_ELDER_P_201309 <- crop(P_201309, BOX_ELDER)  
BOX_ELDER_P_201310 <- crop(P_201310, BOX_ELDER)  
BOX_ELDER_P_201311 <- crop(P_201311, BOX_ELDER)  
BOX_ELDER_P_201312 <- crop(P_201312, BOX_ELDER)  
#2014
BOX_ELDER_P_201401 <- crop(P_201401, BOX_ELDER) 
BOX_ELDER_P_201402 <- crop(P_201402, BOX_ELDER)
BOX_ELDER_P_201403 <- crop(P_201403, BOX_ELDER)
BOX_ELDER_P_201404 <- crop(P_201404, BOX_ELDER)
BOX_ELDER_P_201405 <- crop(P_201405, BOX_ELDER)
BOX_ELDER_P_201406 <- crop(P_201406, BOX_ELDER)  
BOX_ELDER_P_201407 <- crop(P_201407, BOX_ELDER)  
BOX_ELDER_P_201408 <- crop(P_201408, BOX_ELDER)  
BOX_ELDER_P_201409 <- crop(P_201409, BOX_ELDER)  
BOX_ELDER_P_201410 <- crop(P_201410, BOX_ELDER)  
BOX_ELDER_P_201411 <- crop(P_201411, BOX_ELDER)  
BOX_ELDER_P_201412 <- crop(P_201412, BOX_ELDER)  
#2015
BOX_ELDER_P_201501 <- crop(P_201501, BOX_ELDER) 
BOX_ELDER_P_201502 <- crop(P_201502, BOX_ELDER)
BOX_ELDER_P_201503 <- crop(P_201503, BOX_ELDER)
BOX_ELDER_P_201504 <- crop(P_201504, BOX_ELDER)
BOX_ELDER_P_201505 <- crop(P_201505, BOX_ELDER)
BOX_ELDER_P_201506 <- crop(P_201506, BOX_ELDER)  
BOX_ELDER_P_201507 <- crop(P_201507, BOX_ELDER)  
BOX_ELDER_P_201508 <- crop(P_201508, BOX_ELDER)  
BOX_ELDER_P_201509 <- crop(P_201509, BOX_ELDER)  
BOX_ELDER_P_201510 <- crop(P_201510, BOX_ELDER)  
BOX_ELDER_P_201511 <- crop(P_201511, BOX_ELDER)  
BOX_ELDER_P_201512 <- crop(P_201512, BOX_ELDER)  
#2016
BOX_ELDER_P_201601 <- crop(P_201601, BOX_ELDER) 
BOX_ELDER_P_201602 <- crop(P_201602, BOX_ELDER)
BOX_ELDER_P_201603 <- crop(P_201603, BOX_ELDER)
BOX_ELDER_P_201604 <- crop(P_201604, BOX_ELDER)
BOX_ELDER_P_201605 <- crop(P_201605, BOX_ELDER)
BOX_ELDER_P_201606 <- crop(P_201606, BOX_ELDER)  
BOX_ELDER_P_201607 <- crop(P_201607, BOX_ELDER)  
BOX_ELDER_P_201608 <- crop(P_201608, BOX_ELDER)  
BOX_ELDER_P_201609 <- crop(P_201609, BOX_ELDER)  
BOX_ELDER_P_201610 <- crop(P_201610, BOX_ELDER)  
BOX_ELDER_P_201611 <- crop(P_201611, BOX_ELDER)  
BOX_ELDER_P_201612 <- crop(P_201612, BOX_ELDER)  
#2017
BOX_ELDER_P_201701 <- crop(P_201701, BOX_ELDER) 
BOX_ELDER_P_201702 <- crop(P_201702, BOX_ELDER)
BOX_ELDER_P_201703 <- crop(P_201703, BOX_ELDER)
BOX_ELDER_P_201704 <- crop(P_201704, BOX_ELDER)
BOX_ELDER_P_201705 <- crop(P_201705, BOX_ELDER)
BOX_ELDER_P_201706 <- crop(P_201706, BOX_ELDER)  
BOX_ELDER_P_201707 <- crop(P_201707, BOX_ELDER)  
BOX_ELDER_P_201708 <- crop(P_201708, BOX_ELDER)  
BOX_ELDER_P_201709 <- crop(P_201709, BOX_ELDER)  
BOX_ELDER_P_201710 <- crop(P_201710, BOX_ELDER)  
BOX_ELDER_P_201711 <- crop(P_201711, BOX_ELDER)  
BOX_ELDER_P_201712 <- crop(P_201712, BOX_ELDER)  

#2018

BOX_ELDER_P_201801 <- crop(P_201801, BOX_ELDER) 
BOX_ELDER_P_201802 <- crop(P_201802, BOX_ELDER)
BOX_ELDER_P_201803 <- crop(P_201803, BOX_ELDER)
BOX_ELDER_P_201804 <- crop(P_201804, BOX_ELDER)
BOX_ELDER_P_201805 <- crop(P_201805, BOX_ELDER)
BOX_ELDER_P_201806 <- crop(P_201806, BOX_ELDER)  
BOX_ELDER_P_201807 <- crop(P_201807, BOX_ELDER)  
BOX_ELDER_P_201808 <- crop(P_201808, BOX_ELDER)  
BOX_ELDER_P_201809 <- crop(P_201809, BOX_ELDER)  
BOX_ELDER_P_201810 <- crop(P_201810, BOX_ELDER)  
BOX_ELDER_P_201811 <- crop(P_201811, BOX_ELDER)  
BOX_ELDER_P_201812 <- crop(P_201812, BOX_ELDER)  

 
# Mean Monthly Precipitation
#2000
BOX_ELDER_P_200001_mean <- cellStats(BOX_ELDER_P_200001, mean)
BOX_ELDER_P_200002_mean <- cellStats(BOX_ELDER_P_200002, mean)
BOX_ELDER_P_200003_mean <- cellStats(BOX_ELDER_P_200003, mean)
BOX_ELDER_P_200004_mean <- cellStats(BOX_ELDER_P_200004, mean)
BOX_ELDER_P_200005_mean <- cellStats(BOX_ELDER_P_200005, mean)
BOX_ELDER_P_200006_mean <- cellStats(BOX_ELDER_P_200006, mean)
BOX_ELDER_P_200007_mean <- cellStats(BOX_ELDER_P_200007, mean)
BOX_ELDER_P_200008_mean <- cellStats(BOX_ELDER_P_200008, mean)
BOX_ELDER_P_200009_mean <- cellStats(BOX_ELDER_P_200009, mean)
BOX_ELDER_P_200010_mean <- cellStats(BOX_ELDER_P_200010, mean)
BOX_ELDER_P_200011_mean <- cellStats(BOX_ELDER_P_200011, mean)
BOX_ELDER_P_200012_mean <- cellStats(BOX_ELDER_P_200012, mean)
#2001
BOX_ELDER_P_200101_mean <- cellStats(BOX_ELDER_P_200101, mean)
BOX_ELDER_P_200102_mean <- cellStats(BOX_ELDER_P_200102, mean)
BOX_ELDER_P_200103_mean <- cellStats(BOX_ELDER_P_200103, mean)
BOX_ELDER_P_200104_mean <- cellStats(BOX_ELDER_P_200104, mean)
BOX_ELDER_P_200105_mean <- cellStats(BOX_ELDER_P_200105, mean)
BOX_ELDER_P_200106_mean <- cellStats(BOX_ELDER_P_200106, mean)
BOX_ELDER_P_200107_mean <- cellStats(BOX_ELDER_P_200107, mean)
BOX_ELDER_P_200108_mean <- cellStats(BOX_ELDER_P_200108, mean)
BOX_ELDER_P_200109_mean <- cellStats(BOX_ELDER_P_200109, mean)
BOX_ELDER_P_200110_mean <- cellStats(BOX_ELDER_P_200110, mean)
BOX_ELDER_P_200111_mean <- cellStats(BOX_ELDER_P_200111, mean)
BOX_ELDER_P_200112_mean <- cellStats(BOX_ELDER_P_200112, mean)

#2002
BOX_ELDER_P_200201_mean <- cellStats(BOX_ELDER_P_200201, mean)
BOX_ELDER_P_200202_mean <- cellStats(BOX_ELDER_P_200202, mean)
BOX_ELDER_P_200203_mean <- cellStats(BOX_ELDER_P_200203, mean)
BOX_ELDER_P_200204_mean <- cellStats(BOX_ELDER_P_200204, mean)
BOX_ELDER_P_200205_mean <- cellStats(BOX_ELDER_P_200205, mean)
BOX_ELDER_P_200206_mean <- cellStats(BOX_ELDER_P_200206, mean)
BOX_ELDER_P_200207_mean <- cellStats(BOX_ELDER_P_200207, mean)
BOX_ELDER_P_200208_mean <- cellStats(BOX_ELDER_P_200208, mean)
BOX_ELDER_P_200209_mean <- cellStats(BOX_ELDER_P_200209, mean)
BOX_ELDER_P_200210_mean <- cellStats(BOX_ELDER_P_200210, mean)
BOX_ELDER_P_200211_mean <- cellStats(BOX_ELDER_P_200211, mean)
BOX_ELDER_P_200212_mean <- cellStats(BOX_ELDER_P_200212, mean)

#2003
BOX_ELDER_P_200301_mean <- cellStats(BOX_ELDER_P_200301, mean)
BOX_ELDER_P_200302_mean <- cellStats(BOX_ELDER_P_200302, mean)
BOX_ELDER_P_200303_mean <- cellStats(BOX_ELDER_P_200303, mean)
BOX_ELDER_P_200304_mean <- cellStats(BOX_ELDER_P_200304, mean)
BOX_ELDER_P_200305_mean <- cellStats(BOX_ELDER_P_200305, mean)
BOX_ELDER_P_200306_mean <- cellStats(BOX_ELDER_P_200306, mean)
BOX_ELDER_P_200307_mean <- cellStats(BOX_ELDER_P_200307, mean)
BOX_ELDER_P_200308_mean <- cellStats(BOX_ELDER_P_200308, mean)
BOX_ELDER_P_200309_mean <- cellStats(BOX_ELDER_P_200309, mean)
BOX_ELDER_P_200310_mean <- cellStats(BOX_ELDER_P_200310, mean)
BOX_ELDER_P_200311_mean <- cellStats(BOX_ELDER_P_200311, mean)
BOX_ELDER_P_200312_mean <- cellStats(BOX_ELDER_P_200312, mean)

#2004

BOX_ELDER_P_200401_mean <- cellStats(BOX_ELDER_P_200401, mean)
BOX_ELDER_P_200402_mean <- cellStats(BOX_ELDER_P_200402, mean)
BOX_ELDER_P_200403_mean <- cellStats(BOX_ELDER_P_200403, mean)
BOX_ELDER_P_200404_mean <- cellStats(BOX_ELDER_P_200404, mean)
BOX_ELDER_P_200405_mean <- cellStats(BOX_ELDER_P_200405, mean)
BOX_ELDER_P_200406_mean <- cellStats(BOX_ELDER_P_200406, mean)
BOX_ELDER_P_200407_mean <- cellStats(BOX_ELDER_P_200407, mean)
BOX_ELDER_P_200408_mean <- cellStats(BOX_ELDER_P_200408, mean)
BOX_ELDER_P_200409_mean <- cellStats(BOX_ELDER_P_200409, mean)
BOX_ELDER_P_200410_mean <- cellStats(BOX_ELDER_P_200410, mean)
BOX_ELDER_P_200411_mean <- cellStats(BOX_ELDER_P_200411, mean)
BOX_ELDER_P_200412_mean <- cellStats(BOX_ELDER_P_200412, mean)

#2005

BOX_ELDER_P_200501_mean <- cellStats(BOX_ELDER_P_200501, mean)
BOX_ELDER_P_200502_mean <- cellStats(BOX_ELDER_P_200502, mean)
BOX_ELDER_P_200503_mean <- cellStats(BOX_ELDER_P_200503, mean)
BOX_ELDER_P_200504_mean <- cellStats(BOX_ELDER_P_200504, mean)
BOX_ELDER_P_200505_mean <- cellStats(BOX_ELDER_P_200505, mean)
BOX_ELDER_P_200506_mean <- cellStats(BOX_ELDER_P_200506, mean)
BOX_ELDER_P_200507_mean <- cellStats(BOX_ELDER_P_200507, mean)
BOX_ELDER_P_200508_mean <- cellStats(BOX_ELDER_P_200508, mean)
BOX_ELDER_P_200509_mean <- cellStats(BOX_ELDER_P_200509, mean)
BOX_ELDER_P_200510_mean <- cellStats(BOX_ELDER_P_200510, mean)
BOX_ELDER_P_200511_mean <- cellStats(BOX_ELDER_P_200511, mean)
BOX_ELDER_P_200512_mean <- cellStats(BOX_ELDER_P_200512, mean)

#2006

BOX_ELDER_P_200601_mean <- cellStats(BOX_ELDER_P_200601, mean)
BOX_ELDER_P_200602_mean <- cellStats(BOX_ELDER_P_200602, mean)
BOX_ELDER_P_200603_mean <- cellStats(BOX_ELDER_P_200603, mean)
BOX_ELDER_P_200604_mean <- cellStats(BOX_ELDER_P_200604, mean)
BOX_ELDER_P_200605_mean <- cellStats(BOX_ELDER_P_200605, mean)
BOX_ELDER_P_200606_mean <- cellStats(BOX_ELDER_P_200606, mean)
BOX_ELDER_P_200607_mean <- cellStats(BOX_ELDER_P_200607, mean)
BOX_ELDER_P_200608_mean <- cellStats(BOX_ELDER_P_200608, mean)
BOX_ELDER_P_200609_mean <- cellStats(BOX_ELDER_P_200609, mean)
BOX_ELDER_P_200610_mean <- cellStats(BOX_ELDER_P_200610, mean)
BOX_ELDER_P_200611_mean <- cellStats(BOX_ELDER_P_200611, mean)
BOX_ELDER_P_200612_mean <- cellStats(BOX_ELDER_P_200612, mean)

#2007

BOX_ELDER_P_200701_mean <- cellStats(BOX_ELDER_P_200701, mean)
BOX_ELDER_P_200702_mean <- cellStats(BOX_ELDER_P_200702, mean)
BOX_ELDER_P_200703_mean <- cellStats(BOX_ELDER_P_200703, mean)
BOX_ELDER_P_200704_mean <- cellStats(BOX_ELDER_P_200704, mean)
BOX_ELDER_P_200705_mean <- cellStats(BOX_ELDER_P_200705, mean)
BOX_ELDER_P_200706_mean <- cellStats(BOX_ELDER_P_200706, mean)
BOX_ELDER_P_200707_mean <- cellStats(BOX_ELDER_P_200707, mean)
BOX_ELDER_P_200708_mean <- cellStats(BOX_ELDER_P_200708, mean)
BOX_ELDER_P_200709_mean <- cellStats(BOX_ELDER_P_200709, mean)
BOX_ELDER_P_200710_mean <- cellStats(BOX_ELDER_P_200710, mean)
BOX_ELDER_P_200711_mean <- cellStats(BOX_ELDER_P_200711, mean)
BOX_ELDER_P_200712_mean <- cellStats(BOX_ELDER_P_200712, mean)

#2008

BOX_ELDER_P_200801_mean <- cellStats(BOX_ELDER_P_200801, mean)
BOX_ELDER_P_200802_mean <- cellStats(BOX_ELDER_P_200802, mean)
BOX_ELDER_P_200803_mean <- cellStats(BOX_ELDER_P_200803, mean)
BOX_ELDER_P_200804_mean <- cellStats(BOX_ELDER_P_200804, mean)
BOX_ELDER_P_200805_mean <- cellStats(BOX_ELDER_P_200805, mean)
BOX_ELDER_P_200806_mean <- cellStats(BOX_ELDER_P_200806, mean)
BOX_ELDER_P_200807_mean <- cellStats(BOX_ELDER_P_200807, mean)
BOX_ELDER_P_200808_mean <- cellStats(BOX_ELDER_P_200808, mean)
BOX_ELDER_P_200809_mean <- cellStats(BOX_ELDER_P_200809, mean)
BOX_ELDER_P_200810_mean <- cellStats(BOX_ELDER_P_200810, mean)
BOX_ELDER_P_200811_mean <- cellStats(BOX_ELDER_P_200811, mean)
BOX_ELDER_P_200812_mean <- cellStats(BOX_ELDER_P_200812, mean)

#2009

BOX_ELDER_P_200901_mean <- cellStats(BOX_ELDER_P_200901, mean)
BOX_ELDER_P_200902_mean <- cellStats(BOX_ELDER_P_200902, mean)
BOX_ELDER_P_200903_mean <- cellStats(BOX_ELDER_P_200903, mean)
BOX_ELDER_P_200904_mean <- cellStats(BOX_ELDER_P_200904, mean)
BOX_ELDER_P_200905_mean <- cellStats(BOX_ELDER_P_200905, mean)
BOX_ELDER_P_200906_mean <- cellStats(BOX_ELDER_P_200906, mean)
BOX_ELDER_P_200907_mean <- cellStats(BOX_ELDER_P_200907, mean)
BOX_ELDER_P_200908_mean <- cellStats(BOX_ELDER_P_200908, mean)
BOX_ELDER_P_200909_mean <- cellStats(BOX_ELDER_P_200909, mean)
BOX_ELDER_P_200910_mean <- cellStats(BOX_ELDER_P_200910, mean)
BOX_ELDER_P_200911_mean <- cellStats(BOX_ELDER_P_200911, mean)
BOX_ELDER_P_200912_mean <- cellStats(BOX_ELDER_P_200912, mean)

#2010

BOX_ELDER_P_201001_mean <- cellStats(BOX_ELDER_P_201001, mean)
BOX_ELDER_P_201002_mean <- cellStats(BOX_ELDER_P_201002, mean)
BOX_ELDER_P_201003_mean <- cellStats(BOX_ELDER_P_201003, mean)
BOX_ELDER_P_201004_mean <- cellStats(BOX_ELDER_P_201004, mean)
BOX_ELDER_P_201005_mean <- cellStats(BOX_ELDER_P_201005, mean)
BOX_ELDER_P_201006_mean <- cellStats(BOX_ELDER_P_201006, mean)
BOX_ELDER_P_201007_mean <- cellStats(BOX_ELDER_P_201007, mean)
BOX_ELDER_P_201008_mean <- cellStats(BOX_ELDER_P_201008, mean)
BOX_ELDER_P_201009_mean <- cellStats(BOX_ELDER_P_201009, mean)
BOX_ELDER_P_201010_mean <- cellStats(BOX_ELDER_P_201010, mean)
BOX_ELDER_P_201011_mean <- cellStats(BOX_ELDER_P_201011, mean)
BOX_ELDER_P_201012_mean <- cellStats(BOX_ELDER_P_201012, mean)

#2011

BOX_ELDER_P_201101_mean <- cellStats(BOX_ELDER_P_201101, mean)
BOX_ELDER_P_201102_mean <- cellStats(BOX_ELDER_P_201102, mean)
BOX_ELDER_P_201103_mean <- cellStats(BOX_ELDER_P_201103, mean)
BOX_ELDER_P_201104_mean <- cellStats(BOX_ELDER_P_201104, mean)
BOX_ELDER_P_201105_mean <- cellStats(BOX_ELDER_P_201105, mean)
BOX_ELDER_P_201106_mean <- cellStats(BOX_ELDER_P_201106, mean)
BOX_ELDER_P_201107_mean <- cellStats(BOX_ELDER_P_201107, mean)
BOX_ELDER_P_201108_mean <- cellStats(BOX_ELDER_P_201108, mean)
BOX_ELDER_P_201109_mean <- cellStats(BOX_ELDER_P_201109, mean)
BOX_ELDER_P_201110_mean <- cellStats(BOX_ELDER_P_201110, mean)
BOX_ELDER_P_201111_mean <- cellStats(BOX_ELDER_P_201111, mean)
BOX_ELDER_P_201112_mean <- cellStats(BOX_ELDER_P_201112, mean)

#2012
BOX_ELDER_P_201201_mean <- cellStats(BOX_ELDER_P_201201, mean)
BOX_ELDER_P_201202_mean <- cellStats(BOX_ELDER_P_201202, mean)
BOX_ELDER_P_201203_mean <- cellStats(BOX_ELDER_P_201203, mean)
BOX_ELDER_P_201204_mean <- cellStats(BOX_ELDER_P_201204, mean)
BOX_ELDER_P_201205_mean <- cellStats(BOX_ELDER_P_201205, mean)
BOX_ELDER_P_201206_mean <- cellStats(BOX_ELDER_P_201206, mean)
BOX_ELDER_P_201207_mean <- cellStats(BOX_ELDER_P_201207, mean)
BOX_ELDER_P_201208_mean <- cellStats(BOX_ELDER_P_201208, mean)
BOX_ELDER_P_201209_mean <- cellStats(BOX_ELDER_P_201209, mean)
BOX_ELDER_P_201210_mean <- cellStats(BOX_ELDER_P_201210, mean)
BOX_ELDER_P_201211_mean <- cellStats(BOX_ELDER_P_201211, mean)
BOX_ELDER_P_201212_mean <- cellStats(BOX_ELDER_P_201212, mean)

#2013
BOX_ELDER_P_201301_mean <- cellStats(BOX_ELDER_P_201301, mean)
BOX_ELDER_P_201302_mean <- cellStats(BOX_ELDER_P_201302, mean)
BOX_ELDER_P_201303_mean <- cellStats(BOX_ELDER_P_201303, mean)
BOX_ELDER_P_201304_mean <- cellStats(BOX_ELDER_P_201304, mean)
BOX_ELDER_P_201305_mean <- cellStats(BOX_ELDER_P_201305, mean)
BOX_ELDER_P_201306_mean <- cellStats(BOX_ELDER_P_201306, mean)
BOX_ELDER_P_201307_mean <- cellStats(BOX_ELDER_P_201307, mean)
BOX_ELDER_P_201308_mean <- cellStats(BOX_ELDER_P_201308, mean)
BOX_ELDER_P_201309_mean <- cellStats(BOX_ELDER_P_201309, mean)
BOX_ELDER_P_201310_mean <- cellStats(BOX_ELDER_P_201310, mean)
BOX_ELDER_P_201311_mean <- cellStats(BOX_ELDER_P_201311, mean)
BOX_ELDER_P_201312_mean <- cellStats(BOX_ELDER_P_201312, mean)

#2014
BOX_ELDER_P_201401_mean <- cellStats(BOX_ELDER_P_201401, mean)
BOX_ELDER_P_201402_mean <- cellStats(BOX_ELDER_P_201402, mean)
BOX_ELDER_P_201403_mean <- cellStats(BOX_ELDER_P_201403, mean)
BOX_ELDER_P_201404_mean <- cellStats(BOX_ELDER_P_201404, mean)
BOX_ELDER_P_201405_mean <- cellStats(BOX_ELDER_P_201405, mean)
BOX_ELDER_P_201406_mean <- cellStats(BOX_ELDER_P_201406, mean)
BOX_ELDER_P_201407_mean <- cellStats(BOX_ELDER_P_201407, mean)
BOX_ELDER_P_201408_mean <- cellStats(BOX_ELDER_P_201408, mean)
BOX_ELDER_P_201409_mean <- cellStats(BOX_ELDER_P_201409, mean)
BOX_ELDER_P_201410_mean <- cellStats(BOX_ELDER_P_201410, mean)
BOX_ELDER_P_201411_mean <- cellStats(BOX_ELDER_P_201411, mean)
BOX_ELDER_P_201412_mean <- cellStats(BOX_ELDER_P_201412, mean)

#2015
BOX_ELDER_P_201501_mean <- cellStats(BOX_ELDER_P_201501, mean)
BOX_ELDER_P_201502_mean <- cellStats(BOX_ELDER_P_201502, mean)
BOX_ELDER_P_201503_mean <- cellStats(BOX_ELDER_P_201503, mean)
BOX_ELDER_P_201504_mean <- cellStats(BOX_ELDER_P_201504, mean)
BOX_ELDER_P_201505_mean <- cellStats(BOX_ELDER_P_201505, mean)
BOX_ELDER_P_201506_mean <- cellStats(BOX_ELDER_P_201506, mean)
BOX_ELDER_P_201507_mean <- cellStats(BOX_ELDER_P_201507, mean)
BOX_ELDER_P_201508_mean <- cellStats(BOX_ELDER_P_201508, mean)
BOX_ELDER_P_201509_mean <- cellStats(BOX_ELDER_P_201509, mean)
BOX_ELDER_P_201510_mean <- cellStats(BOX_ELDER_P_201510, mean)
BOX_ELDER_P_201511_mean <- cellStats(BOX_ELDER_P_201511, mean)
BOX_ELDER_P_201512_mean <- cellStats(BOX_ELDER_P_201512, mean)

#2016
BOX_ELDER_P_201601_mean <- cellStats(BOX_ELDER_P_201601, mean)
BOX_ELDER_P_201602_mean <- cellStats(BOX_ELDER_P_201602, mean)
BOX_ELDER_P_201603_mean <- cellStats(BOX_ELDER_P_201603, mean)
BOX_ELDER_P_201604_mean <- cellStats(BOX_ELDER_P_201604, mean)
BOX_ELDER_P_201605_mean <- cellStats(BOX_ELDER_P_201605, mean)
BOX_ELDER_P_201606_mean <- cellStats(BOX_ELDER_P_201606, mean)
BOX_ELDER_P_201607_mean <- cellStats(BOX_ELDER_P_201607, mean)
BOX_ELDER_P_201608_mean <- cellStats(BOX_ELDER_P_201608, mean)
BOX_ELDER_P_201609_mean <- cellStats(BOX_ELDER_P_201609, mean)
BOX_ELDER_P_201610_mean <- cellStats(BOX_ELDER_P_201610, mean)
BOX_ELDER_P_201611_mean <- cellStats(BOX_ELDER_P_201611, mean)
BOX_ELDER_P_201612_mean <- cellStats(BOX_ELDER_P_201612, mean)

#2017
BOX_ELDER_P_201701_mean <- cellStats(BOX_ELDER_P_201701, mean)
BOX_ELDER_P_201702_mean <- cellStats(BOX_ELDER_P_201702, mean)
BOX_ELDER_P_201703_mean <- cellStats(BOX_ELDER_P_201703, mean)
BOX_ELDER_P_201704_mean <- cellStats(BOX_ELDER_P_201704, mean)
BOX_ELDER_P_201705_mean <- cellStats(BOX_ELDER_P_201705, mean)
BOX_ELDER_P_201706_mean <- cellStats(BOX_ELDER_P_201706, mean)
BOX_ELDER_P_201707_mean <- cellStats(BOX_ELDER_P_201707, mean)
BOX_ELDER_P_201708_mean <- cellStats(BOX_ELDER_P_201708, mean)
BOX_ELDER_P_201709_mean <- cellStats(BOX_ELDER_P_201709, mean)
BOX_ELDER_P_201710_mean <- cellStats(BOX_ELDER_P_201710, mean)
BOX_ELDER_P_201711_mean <- cellStats(BOX_ELDER_P_201711, mean)
BOX_ELDER_P_201712_mean <- cellStats(BOX_ELDER_P_201712, mean)

#2018
BOX_ELDER_P_201801_mean <- cellStats(BOX_ELDER_P_201801, mean)
BOX_ELDER_P_201802_mean <- cellStats(BOX_ELDER_P_201802, mean)
BOX_ELDER_P_201803_mean <- cellStats(BOX_ELDER_P_201803, mean)
BOX_ELDER_P_201804_mean <- cellStats(BOX_ELDER_P_201804, mean)
BOX_ELDER_P_201805_mean <- cellStats(BOX_ELDER_P_201805, mean)
BOX_ELDER_P_201806_mean <- cellStats(BOX_ELDER_P_201806, mean)
BOX_ELDER_P_201807_mean <- cellStats(BOX_ELDER_P_201807, mean)
BOX_ELDER_P_201808_mean <- cellStats(BOX_ELDER_P_201808, mean)
BOX_ELDER_P_201809_mean <- cellStats(BOX_ELDER_P_201809, mean)
BOX_ELDER_P_201810_mean <- cellStats(BOX_ELDER_P_201810, mean)
BOX_ELDER_P_201811_mean <- cellStats(BOX_ELDER_P_201811, mean)
BOX_ELDER_P_201812_mean <- cellStats(BOX_ELDER_P_201812, mean)



# Beaver
# Box Elder
#2000
BEAVER_P_200001 <- crop(P_200001, BEAVER) 
BEAVER_P_200002 <- crop(P_200002, BEAVER)
BEAVER_P_200003 <- crop(P_200003, BEAVER)
BEAVER_P_200004 <- crop(P_200004, BEAVER)
BEAVER_P_200005 <- crop(P_200005, BEAVER)
BEAVER_P_200006 <- crop(P_200006, BEAVER)  
BEAVER_P_200007 <- crop(P_200007, BEAVER)  
BEAVER_P_200008 <- crop(P_200008, BEAVER)  
BEAVER_P_200009 <- crop(P_200009, BEAVER)  
BEAVER_P_200010 <- crop(P_200010, BEAVER)  
BEAVER_P_200011 <- crop(P_200011, BEAVER)  
BEAVER_P_200012 <- crop(P_200012, BEAVER)  
#2001
BEAVER_P_200101 <- crop(P_200101, BEAVER) 
BEAVER_P_200102 <- crop(P_200102, BEAVER)
BEAVER_P_200103 <- crop(P_200103, BEAVER)
BEAVER_P_200104 <- crop(P_200104, BEAVER)
BEAVER_P_200105 <- crop(P_200105, BEAVER)
BEAVER_P_200106 <- crop(P_200106, BEAVER)  
BEAVER_P_200107 <- crop(P_200107, BEAVER)  
BEAVER_P_200108 <- crop(P_200108, BEAVER)  
BEAVER_P_200109 <- crop(P_200109, BEAVER)  
BEAVER_P_200110 <- crop(P_200110, BEAVER)  
BEAVER_P_200111 <- crop(P_200111, BEAVER)  
BEAVER_P_200112 <- crop(P_200112, BEAVER)  

#2002
BEAVER_P_200201 <- crop(P_200201, BEAVER) 
BEAVER_P_200202 <- crop(P_200202, BEAVER)
BEAVER_P_200203 <- crop(P_200203, BEAVER)
BEAVER_P_200204 <- crop(P_200204, BEAVER)
BEAVER_P_200205 <- crop(P_200205, BEAVER)
BEAVER_P_200206 <- crop(P_200206, BEAVER)  
BEAVER_P_200207 <- crop(P_200207, BEAVER)  
BEAVER_P_200208 <- crop(P_200208, BEAVER)  
BEAVER_P_200209 <- crop(P_200209, BEAVER)  
BEAVER_P_200210 <- crop(P_200210, BEAVER)  
BEAVER_P_200211 <- crop(P_200211, BEAVER)  
BEAVER_P_200212 <- crop(P_200212, BEAVER)  
#2003
BEAVER_P_200301 <- crop(P_200301, BEAVER) 
BEAVER_P_200302 <- crop(P_200302, BEAVER)
BEAVER_P_200303 <- crop(P_200303, BEAVER)
BEAVER_P_200304 <- crop(P_200304, BEAVER)
BEAVER_P_200305 <- crop(P_200305, BEAVER)
BEAVER_P_200306 <- crop(P_200306, BEAVER)  
BEAVER_P_200307 <- crop(P_200307, BEAVER)  
BEAVER_P_200308 <- crop(P_200308, BEAVER)  
BEAVER_P_200309 <- crop(P_200309, BEAVER)  
BEAVER_P_200310 <- crop(P_200310, BEAVER)  
BEAVER_P_200311 <- crop(P_200311, BEAVER)  
BEAVER_P_200312 <- crop(P_200312, BEAVER)  
#2004
BEAVER_P_200401 <- crop(P_200401, BEAVER) 
BEAVER_P_200402 <- crop(P_200402, BEAVER)
BEAVER_P_200403 <- crop(P_200403, BEAVER)
BEAVER_P_200404 <- crop(P_200404, BEAVER)
BEAVER_P_200405 <- crop(P_200405, BEAVER)
BEAVER_P_200406 <- crop(P_200406, BEAVER)  
BEAVER_P_200407 <- crop(P_200407, BEAVER)  
BEAVER_P_200408 <- crop(P_200408, BEAVER)  
BEAVER_P_200409 <- crop(P_200409, BEAVER)  
BEAVER_P_200410 <- crop(P_200410, BEAVER)  
BEAVER_P_200411 <- crop(P_200411, BEAVER)  
BEAVER_P_200412 <- crop(P_200412, BEAVER)  
#2005
BEAVER_P_200501 <- crop(P_200501, BEAVER) 
BEAVER_P_200502 <- crop(P_200502, BEAVER)
BEAVER_P_200503 <- crop(P_200503, BEAVER)
BEAVER_P_200504 <- crop(P_200504, BEAVER)
BEAVER_P_200505 <- crop(P_200505, BEAVER)
BEAVER_P_200506 <- crop(P_200506, BEAVER)  
BEAVER_P_200507 <- crop(P_200507, BEAVER)  
BEAVER_P_200508 <- crop(P_200508, BEAVER)  
BEAVER_P_200509 <- crop(P_200509, BEAVER)  
BEAVER_P_200510 <- crop(P_200510, BEAVER)  
BEAVER_P_200511 <- crop(P_200511, BEAVER)  
BEAVER_P_200512 <- crop(P_200512, BEAVER)  
#2006
BEAVER_P_200601 <- crop(P_200601, BEAVER) 
BEAVER_P_200602 <- crop(P_200602, BEAVER)
BEAVER_P_200603 <- crop(P_200603, BEAVER)
BEAVER_P_200604 <- crop(P_200604, BEAVER)
BEAVER_P_200605 <- crop(P_200605, BEAVER)
BEAVER_P_200606 <- crop(P_200606, BEAVER)  
BEAVER_P_200607 <- crop(P_200607, BEAVER)  
BEAVER_P_200608 <- crop(P_200608, BEAVER)  
BEAVER_P_200609 <- crop(P_200609, BEAVER)  
BEAVER_P_200610 <- crop(P_200610, BEAVER)  
BEAVER_P_200611 <- crop(P_200611, BEAVER)  
BEAVER_P_200612 <- crop(P_200612, BEAVER)  
#2007
BEAVER_P_200701 <- crop(P_200701, BEAVER) 
BEAVER_P_200702 <- crop(P_200702, BEAVER)
BEAVER_P_200703 <- crop(P_200703, BEAVER)
BEAVER_P_200704 <- crop(P_200704, BEAVER)
BEAVER_P_200705 <- crop(P_200705, BEAVER)
BEAVER_P_200706 <- crop(P_200706, BEAVER)  
BEAVER_P_200707 <- crop(P_200707, BEAVER)  
BEAVER_P_200708 <- crop(P_200708, BEAVER)  
BEAVER_P_200709 <- crop(P_200709, BEAVER)  
BEAVER_P_200710 <- crop(P_200710, BEAVER)  
BEAVER_P_200711 <- crop(P_200711, BEAVER)  
BEAVER_P_200712 <- crop(P_200712, BEAVER)  
#2008
BEAVER_P_200801 <- crop(P_200801, BEAVER) 
BEAVER_P_200802 <- crop(P_200802, BEAVER)
BEAVER_P_200803 <- crop(P_200803, BEAVER)
BEAVER_P_200804 <- crop(P_200804, BEAVER)
BEAVER_P_200805 <- crop(P_200805, BEAVER)
BEAVER_P_200806 <- crop(P_200806, BEAVER)  
BEAVER_P_200807 <- crop(P_200807, BEAVER)  
BEAVER_P_200808 <- crop(P_200808, BEAVER)  
BEAVER_P_200809 <- crop(P_200809, BEAVER)  
BEAVER_P_200810 <- crop(P_200810, BEAVER)  
BEAVER_P_200811 <- crop(P_200811, BEAVER)  
BEAVER_P_200812 <- crop(P_200812, BEAVER)  
#2009
BEAVER_P_200901 <- crop(P_200901, BEAVER) 
BEAVER_P_200902 <- crop(P_200902, BEAVER)
BEAVER_P_200903 <- crop(P_200903, BEAVER)
BEAVER_P_200904 <- crop(P_200904, BEAVER)
BEAVER_P_200905 <- crop(P_200905, BEAVER)
BEAVER_P_200906 <- crop(P_200906, BEAVER)  
BEAVER_P_200907 <- crop(P_200907, BEAVER)  
BEAVER_P_200908 <- crop(P_200908, BEAVER)  
BEAVER_P_200909 <- crop(P_200909, BEAVER)  
BEAVER_P_200910 <- crop(P_200910, BEAVER)  
BEAVER_P_200911 <- crop(P_200911, BEAVER)  
BEAVER_P_200912 <- crop(P_200912, BEAVER)  
#2010
BEAVER_P_201001 <- crop(P_201001, BEAVER) 
BEAVER_P_201002 <- crop(P_201002, BEAVER)
BEAVER_P_201003 <- crop(P_201003, BEAVER)
BEAVER_P_201004 <- crop(P_201004, BEAVER)
BEAVER_P_201005 <- crop(P_201005, BEAVER)
BEAVER_P_201006 <- crop(P_201006, BEAVER)  
BEAVER_P_201007 <- crop(P_201007, BEAVER)  
BEAVER_P_201008 <- crop(P_201008, BEAVER)  
BEAVER_P_201009 <- crop(P_201009, BEAVER)  
BEAVER_P_201010 <- crop(P_201010, BEAVER)  
BEAVER_P_201011 <- crop(P_201011, BEAVER)  
BEAVER_P_201012 <- crop(P_201012, BEAVER)  
#2011
BEAVER_P_201101 <- crop(P_201101, BEAVER) 
BEAVER_P_201102 <- crop(P_201102, BEAVER)
BEAVER_P_201103 <- crop(P_201103, BEAVER)
BEAVER_P_201104 <- crop(P_201104, BEAVER)
BEAVER_P_201105 <- crop(P_201105, BEAVER)
BEAVER_P_201106 <- crop(P_201106, BEAVER)  
BEAVER_P_201107 <- crop(P_201107, BEAVER)  
BEAVER_P_201108 <- crop(P_201108, BEAVER)  
BEAVER_P_201109 <- crop(P_201109, BEAVER)  
BEAVER_P_201110 <- crop(P_201110, BEAVER)  
BEAVER_P_201111 <- crop(P_201111, BEAVER)  
BEAVER_P_201112 <- crop(P_201112, BEAVER)  
#2012
BEAVER_P_201201 <- crop(P_201201, BEAVER) 
BEAVER_P_201202 <- crop(P_201202, BEAVER)
BEAVER_P_201203 <- crop(P_201203, BEAVER)
BEAVER_P_201204 <- crop(P_201204, BEAVER)
BEAVER_P_201205 <- crop(P_201205, BEAVER)
BEAVER_P_201206 <- crop(P_201206, BEAVER)  
BEAVER_P_201207 <- crop(P_201207, BEAVER)  
BEAVER_P_201208 <- crop(P_201208, BEAVER)  
BEAVER_P_201209 <- crop(P_201209, BEAVER)  
BEAVER_P_201210 <- crop(P_201210, BEAVER)  
BEAVER_P_201211 <- crop(P_201211, BEAVER)  
BEAVER_P_201212 <- crop(P_201212, BEAVER)  
#2013
BEAVER_P_201301 <- crop(P_201301, BEAVER) 
BEAVER_P_201302 <- crop(P_201302, BEAVER)
BEAVER_P_201303 <- crop(P_201303, BEAVER)
BEAVER_P_201304 <- crop(P_201304, BEAVER)
BEAVER_P_201305 <- crop(P_201305, BEAVER)
BEAVER_P_201306 <- crop(P_201306, BEAVER)  
BEAVER_P_201307 <- crop(P_201307, BEAVER)  
BEAVER_P_201308 <- crop(P_201308, BEAVER)  
BEAVER_P_201309 <- crop(P_201309, BEAVER)  
BEAVER_P_201310 <- crop(P_201310, BEAVER)  
BEAVER_P_201311 <- crop(P_201311, BEAVER)  
BEAVER_P_201312 <- crop(P_201312, BEAVER)  
#2014
BEAVER_P_201401 <- crop(P_201401, BEAVER) 
BEAVER_P_201402 <- crop(P_201402, BEAVER)
BEAVER_P_201403 <- crop(P_201403, BEAVER)
BEAVER_P_201404 <- crop(P_201404, BEAVER)
BEAVER_P_201405 <- crop(P_201405, BEAVER)
BEAVER_P_201406 <- crop(P_201406, BEAVER)  
BEAVER_P_201407 <- crop(P_201407, BEAVER)  
BEAVER_P_201408 <- crop(P_201408, BEAVER)  
BEAVER_P_201409 <- crop(P_201409, BEAVER)  
BEAVER_P_201410 <- crop(P_201410, BEAVER)  
BEAVER_P_201411 <- crop(P_201411, BEAVER)  
BEAVER_P_201412 <- crop(P_201412, BEAVER)  
#2015
BEAVER_P_201501 <- crop(P_201501, BEAVER) 
BEAVER_P_201502 <- crop(P_201502, BEAVER)
BEAVER_P_201503 <- crop(P_201503, BEAVER)
BEAVER_P_201504 <- crop(P_201504, BEAVER)
BEAVER_P_201505 <- crop(P_201505, BEAVER)
BEAVER_P_201506 <- crop(P_201506, BEAVER)  
BEAVER_P_201507 <- crop(P_201507, BEAVER)  
BEAVER_P_201508 <- crop(P_201508, BEAVER)  
BEAVER_P_201509 <- crop(P_201509, BEAVER)  
BEAVER_P_201510 <- crop(P_201510, BEAVER)  
BEAVER_P_201511 <- crop(P_201511, BEAVER)  
BEAVER_P_201512 <- crop(P_201512, BEAVER)  
#2016
BEAVER_P_201601 <- crop(P_201601, BEAVER) 
BEAVER_P_201602 <- crop(P_201602, BEAVER)
BEAVER_P_201603 <- crop(P_201603, BEAVER)
BEAVER_P_201604 <- crop(P_201604, BEAVER)
BEAVER_P_201605 <- crop(P_201605, BEAVER)
BEAVER_P_201606 <- crop(P_201606, BEAVER)  
BEAVER_P_201607 <- crop(P_201607, BEAVER)  
BEAVER_P_201608 <- crop(P_201608, BEAVER)  
BEAVER_P_201609 <- crop(P_201609, BEAVER)  
BEAVER_P_201610 <- crop(P_201610, BEAVER)  
BEAVER_P_201611 <- crop(P_201611, BEAVER)  
BEAVER_P_201612 <- crop(P_201612, BEAVER)  
#2017
BEAVER_P_201701 <- crop(P_201701, BEAVER) 
BEAVER_P_201702 <- crop(P_201702, BEAVER)
BEAVER_P_201703 <- crop(P_201703, BEAVER)
BEAVER_P_201704 <- crop(P_201704, BEAVER)
BEAVER_P_201705 <- crop(P_201705, BEAVER)
BEAVER_P_201706 <- crop(P_201706, BEAVER)  
BEAVER_P_201707 <- crop(P_201707, BEAVER)  
BEAVER_P_201708 <- crop(P_201708, BEAVER)  
BEAVER_P_201709 <- crop(P_201709, BEAVER)  
BEAVER_P_201710 <- crop(P_201710, BEAVER)  
BEAVER_P_201711 <- crop(P_201711, BEAVER)  
BEAVER_P_201712 <- crop(P_201712, BEAVER)  

#2018

BEAVER_P_201801 <- crop(P_201801, BEAVER) 
BEAVER_P_201802 <- crop(P_201802, BEAVER)
BEAVER_P_201803 <- crop(P_201803, BEAVER)
BEAVER_P_201804 <- crop(P_201804, BEAVER)
BEAVER_P_201805 <- crop(P_201805, BEAVER)
BEAVER_P_201806 <- crop(P_201806, BEAVER)  
BEAVER_P_201807 <- crop(P_201807, BEAVER)  
BEAVER_P_201808 <- crop(P_201808, BEAVER)  
BEAVER_P_201809 <- crop(P_201809, BEAVER)  
BEAVER_P_201810 <- crop(P_201810, BEAVER)  
BEAVER_P_201811 <- crop(P_201811, BEAVER)  
BEAVER_P_201812 <- crop(P_201812, BEAVER)  


# Mean Monthly Precipitation
#2000
BEAVER_P_200001_mean <- cellStats(BEAVER_P_200001, mean)
BEAVER_P_200002_mean <- cellStats(BEAVER_P_200002, mean)
BEAVER_P_200003_mean <- cellStats(BEAVER_P_200003, mean)
BEAVER_P_200004_mean <- cellStats(BEAVER_P_200004, mean)
BEAVER_P_200005_mean <- cellStats(BEAVER_P_200005, mean)
BEAVER_P_200006_mean <- cellStats(BEAVER_P_200006, mean)
BEAVER_P_200007_mean <- cellStats(BEAVER_P_200007, mean)
BEAVER_P_200008_mean <- cellStats(BEAVER_P_200008, mean)
BEAVER_P_200009_mean <- cellStats(BEAVER_P_200009, mean)
BEAVER_P_200010_mean <- cellStats(BEAVER_P_200010, mean)
BEAVER_P_200011_mean <- cellStats(BEAVER_P_200011, mean)
BEAVER_P_200012_mean <- cellStats(BEAVER_P_200012, mean)
#2001
BEAVER_P_200101_mean <- cellStats(BEAVER_P_200101, mean)
BEAVER_P_200102_mean <- cellStats(BEAVER_P_200102, mean)
BEAVER_P_200103_mean <- cellStats(BEAVER_P_200103, mean)
BEAVER_P_200104_mean <- cellStats(BEAVER_P_200104, mean)
BEAVER_P_200105_mean <- cellStats(BEAVER_P_200105, mean)
BEAVER_P_200106_mean <- cellStats(BEAVER_P_200106, mean)
BEAVER_P_200107_mean <- cellStats(BEAVER_P_200107, mean)
BEAVER_P_200108_mean <- cellStats(BEAVER_P_200108, mean)
BEAVER_P_200109_mean <- cellStats(BEAVER_P_200109, mean)
BEAVER_P_200110_mean <- cellStats(BEAVER_P_200110, mean)
BEAVER_P_200111_mean <- cellStats(BEAVER_P_200111, mean)
BEAVER_P_200112_mean <- cellStats(BEAVER_P_200112, mean)

#2002
BEAVER_P_200201_mean <- cellStats(BEAVER_P_200201, mean)
BEAVER_P_200202_mean <- cellStats(BEAVER_P_200202, mean)
BEAVER_P_200203_mean <- cellStats(BEAVER_P_200203, mean)
BEAVER_P_200204_mean <- cellStats(BEAVER_P_200204, mean)
BEAVER_P_200205_mean <- cellStats(BEAVER_P_200205, mean)
BEAVER_P_200206_mean <- cellStats(BEAVER_P_200206, mean)
BEAVER_P_200207_mean <- cellStats(BEAVER_P_200207, mean)
BEAVER_P_200208_mean <- cellStats(BEAVER_P_200208, mean)
BEAVER_P_200209_mean <- cellStats(BEAVER_P_200209, mean)
BEAVER_P_200210_mean <- cellStats(BEAVER_P_200210, mean)
BEAVER_P_200211_mean <- cellStats(BEAVER_P_200211, mean)
BEAVER_P_200212_mean <- cellStats(BEAVER_P_200212, mean)

#2003
BEAVER_P_200301_mean <- cellStats(BEAVER_P_200301, mean)
BEAVER_P_200302_mean <- cellStats(BEAVER_P_200302, mean)
BEAVER_P_200303_mean <- cellStats(BEAVER_P_200303, mean)
BEAVER_P_200304_mean <- cellStats(BEAVER_P_200304, mean)
BEAVER_P_200305_mean <- cellStats(BEAVER_P_200305, mean)
BEAVER_P_200306_mean <- cellStats(BEAVER_P_200306, mean)
BEAVER_P_200307_mean <- cellStats(BEAVER_P_200307, mean)
BEAVER_P_200308_mean <- cellStats(BEAVER_P_200308, mean)
BEAVER_P_200309_mean <- cellStats(BEAVER_P_200309, mean)
BEAVER_P_200310_mean <- cellStats(BEAVER_P_200310, mean)
BEAVER_P_200311_mean <- cellStats(BEAVER_P_200311, mean)
BEAVER_P_200312_mean <- cellStats(BEAVER_P_200312, mean)

#2004

BEAVER_P_200401_mean <- cellStats(BEAVER_P_200401, mean)
BEAVER_P_200402_mean <- cellStats(BEAVER_P_200402, mean)
BEAVER_P_200403_mean <- cellStats(BEAVER_P_200403, mean)
BEAVER_P_200404_mean <- cellStats(BEAVER_P_200404, mean)
BEAVER_P_200405_mean <- cellStats(BEAVER_P_200405, mean)
BEAVER_P_200406_mean <- cellStats(BEAVER_P_200406, mean)
BEAVER_P_200407_mean <- cellStats(BEAVER_P_200407, mean)
BEAVER_P_200408_mean <- cellStats(BEAVER_P_200408, mean)
BEAVER_P_200409_mean <- cellStats(BEAVER_P_200409, mean)
BEAVER_P_200410_mean <- cellStats(BEAVER_P_200410, mean)
BEAVER_P_200411_mean <- cellStats(BEAVER_P_200411, mean)
BEAVER_P_200412_mean <- cellStats(BEAVER_P_200412, mean)

#2005

BEAVER_P_200501_mean <- cellStats(BEAVER_P_200501, mean)
BEAVER_P_200502_mean <- cellStats(BEAVER_P_200502, mean)
BEAVER_P_200503_mean <- cellStats(BEAVER_P_200503, mean)
BEAVER_P_200504_mean <- cellStats(BEAVER_P_200504, mean)
BEAVER_P_200505_mean <- cellStats(BEAVER_P_200505, mean)
BEAVER_P_200506_mean <- cellStats(BEAVER_P_200506, mean)
BEAVER_P_200507_mean <- cellStats(BEAVER_P_200507, mean)
BEAVER_P_200508_mean <- cellStats(BEAVER_P_200508, mean)
BEAVER_P_200509_mean <- cellStats(BEAVER_P_200509, mean)
BEAVER_P_200510_mean <- cellStats(BEAVER_P_200510, mean)
BEAVER_P_200511_mean <- cellStats(BEAVER_P_200511, mean)
BEAVER_P_200512_mean <- cellStats(BEAVER_P_200512, mean)

#2006

BEAVER_P_200601_mean <- cellStats(BEAVER_P_200601, mean)
BEAVER_P_200602_mean <- cellStats(BEAVER_P_200602, mean)
BEAVER_P_200603_mean <- cellStats(BEAVER_P_200603, mean)
BEAVER_P_200604_mean <- cellStats(BEAVER_P_200604, mean)
BEAVER_P_200605_mean <- cellStats(BEAVER_P_200605, mean)
BEAVER_P_200606_mean <- cellStats(BEAVER_P_200606, mean)
BEAVER_P_200607_mean <- cellStats(BEAVER_P_200607, mean)
BEAVER_P_200608_mean <- cellStats(BEAVER_P_200608, mean)
BEAVER_P_200609_mean <- cellStats(BEAVER_P_200609, mean)
BEAVER_P_200610_mean <- cellStats(BEAVER_P_200610, mean)
BEAVER_P_200611_mean <- cellStats(BEAVER_P_200611, mean)
BEAVER_P_200612_mean <- cellStats(BEAVER_P_200612, mean)

#2007

BEAVER_P_200701_mean <- cellStats(BEAVER_P_200701, mean)
BEAVER_P_200702_mean <- cellStats(BEAVER_P_200702, mean)
BEAVER_P_200703_mean <- cellStats(BEAVER_P_200703, mean)
BEAVER_P_200704_mean <- cellStats(BEAVER_P_200704, mean)
BEAVER_P_200705_mean <- cellStats(BEAVER_P_200705, mean)
BEAVER_P_200706_mean <- cellStats(BEAVER_P_200706, mean)
BEAVER_P_200707_mean <- cellStats(BEAVER_P_200707, mean)
BEAVER_P_200708_mean <- cellStats(BEAVER_P_200708, mean)
BEAVER_P_200709_mean <- cellStats(BEAVER_P_200709, mean)
BEAVER_P_200710_mean <- cellStats(BEAVER_P_200710, mean)
BEAVER_P_200711_mean <- cellStats(BEAVER_P_200711, mean)
BEAVER_P_200712_mean <- cellStats(BEAVER_P_200712, mean)

#2008

BEAVER_P_200801_mean <- cellStats(BEAVER_P_200801, mean)
BEAVER_P_200802_mean <- cellStats(BEAVER_P_200802, mean)
BEAVER_P_200803_mean <- cellStats(BEAVER_P_200803, mean)
BEAVER_P_200804_mean <- cellStats(BEAVER_P_200804, mean)
BEAVER_P_200805_mean <- cellStats(BEAVER_P_200805, mean)
BEAVER_P_200806_mean <- cellStats(BEAVER_P_200806, mean)
BEAVER_P_200807_mean <- cellStats(BEAVER_P_200807, mean)
BEAVER_P_200808_mean <- cellStats(BEAVER_P_200808, mean)
BEAVER_P_200809_mean <- cellStats(BEAVER_P_200809, mean)
BEAVER_P_200810_mean <- cellStats(BEAVER_P_200810, mean)
BEAVER_P_200811_mean <- cellStats(BEAVER_P_200811, mean)
BEAVER_P_200812_mean <- cellStats(BEAVER_P_200812, mean)

#2009

BEAVER_P_200901_mean <- cellStats(BEAVER_P_200901, mean)
BEAVER_P_200902_mean <- cellStats(BEAVER_P_200902, mean)
BEAVER_P_200903_mean <- cellStats(BEAVER_P_200903, mean)
BEAVER_P_200904_mean <- cellStats(BEAVER_P_200904, mean)
BEAVER_P_200905_mean <- cellStats(BEAVER_P_200905, mean)
BEAVER_P_200906_mean <- cellStats(BEAVER_P_200906, mean)
BEAVER_P_200907_mean <- cellStats(BEAVER_P_200907, mean)
BEAVER_P_200908_mean <- cellStats(BEAVER_P_200908, mean)
BEAVER_P_200909_mean <- cellStats(BEAVER_P_200909, mean)
BEAVER_P_200910_mean <- cellStats(BEAVER_P_200910, mean)
BEAVER_P_200911_mean <- cellStats(BEAVER_P_200911, mean)
BEAVER_P_200912_mean <- cellStats(BEAVER_P_200912, mean)

#2010

BEAVER_P_201001_mean <- cellStats(BEAVER_P_201001, mean)
BEAVER_P_201002_mean <- cellStats(BEAVER_P_201002, mean)
BEAVER_P_201003_mean <- cellStats(BEAVER_P_201003, mean)
BEAVER_P_201004_mean <- cellStats(BEAVER_P_201004, mean)
BEAVER_P_201005_mean <- cellStats(BEAVER_P_201005, mean)
BEAVER_P_201006_mean <- cellStats(BEAVER_P_201006, mean)
BEAVER_P_201007_mean <- cellStats(BEAVER_P_201007, mean)
BEAVER_P_201008_mean <- cellStats(BEAVER_P_201008, mean)
BEAVER_P_201009_mean <- cellStats(BEAVER_P_201009, mean)
BEAVER_P_201010_mean <- cellStats(BEAVER_P_201010, mean)
BEAVER_P_201011_mean <- cellStats(BEAVER_P_201011, mean)
BEAVER_P_201012_mean <- cellStats(BEAVER_P_201012, mean)

#2011

BEAVER_P_201101_mean <- cellStats(BEAVER_P_201101, mean)
BEAVER_P_201102_mean <- cellStats(BEAVER_P_201102, mean)
BEAVER_P_201103_mean <- cellStats(BEAVER_P_201103, mean)
BEAVER_P_201104_mean <- cellStats(BEAVER_P_201104, mean)
BEAVER_P_201105_mean <- cellStats(BEAVER_P_201105, mean)
BEAVER_P_201106_mean <- cellStats(BEAVER_P_201106, mean)
BEAVER_P_201107_mean <- cellStats(BEAVER_P_201107, mean)
BEAVER_P_201108_mean <- cellStats(BEAVER_P_201108, mean)
BEAVER_P_201109_mean <- cellStats(BEAVER_P_201109, mean)
BEAVER_P_201110_mean <- cellStats(BEAVER_P_201110, mean)
BEAVER_P_201111_mean <- cellStats(BEAVER_P_201111, mean)
BEAVER_P_201112_mean <- cellStats(BEAVER_P_201112, mean)

#2012
BEAVER_P_201201_mean <- cellStats(BEAVER_P_201201, mean)
BEAVER_P_201202_mean <- cellStats(BEAVER_P_201202, mean)
BEAVER_P_201203_mean <- cellStats(BEAVER_P_201203, mean)
BEAVER_P_201204_mean <- cellStats(BEAVER_P_201204, mean)
BEAVER_P_201205_mean <- cellStats(BEAVER_P_201205, mean)
BEAVER_P_201206_mean <- cellStats(BEAVER_P_201206, mean)
BEAVER_P_201207_mean <- cellStats(BEAVER_P_201207, mean)
BEAVER_P_201208_mean <- cellStats(BEAVER_P_201208, mean)
BEAVER_P_201209_mean <- cellStats(BEAVER_P_201209, mean)
BEAVER_P_201210_mean <- cellStats(BEAVER_P_201210, mean)
BEAVER_P_201211_mean <- cellStats(BEAVER_P_201211, mean)
BEAVER_P_201212_mean <- cellStats(BEAVER_P_201212, mean)

#2013
BEAVER_P_201301_mean <- cellStats(BEAVER_P_201301, mean)
BEAVER_P_201302_mean <- cellStats(BEAVER_P_201302, mean)
BEAVER_P_201303_mean <- cellStats(BEAVER_P_201303, mean)
BEAVER_P_201304_mean <- cellStats(BEAVER_P_201304, mean)
BEAVER_P_201305_mean <- cellStats(BEAVER_P_201305, mean)
BEAVER_P_201306_mean <- cellStats(BEAVER_P_201306, mean)
BEAVER_P_201307_mean <- cellStats(BEAVER_P_201307, mean)
BEAVER_P_201308_mean <- cellStats(BEAVER_P_201308, mean)
BEAVER_P_201309_mean <- cellStats(BEAVER_P_201309, mean)
BEAVER_P_201310_mean <- cellStats(BEAVER_P_201310, mean)
BEAVER_P_201311_mean <- cellStats(BEAVER_P_201311, mean)
BEAVER_P_201312_mean <- cellStats(BEAVER_P_201312, mean)

#2014
BEAVER_P_201401_mean <- cellStats(BEAVER_P_201401, mean)
BEAVER_P_201402_mean <- cellStats(BEAVER_P_201402, mean)
BEAVER_P_201403_mean <- cellStats(BEAVER_P_201403, mean)
BEAVER_P_201404_mean <- cellStats(BEAVER_P_201404, mean)
BEAVER_P_201405_mean <- cellStats(BEAVER_P_201405, mean)
BEAVER_P_201406_mean <- cellStats(BEAVER_P_201406, mean)
BEAVER_P_201407_mean <- cellStats(BEAVER_P_201407, mean)
BEAVER_P_201408_mean <- cellStats(BEAVER_P_201408, mean)
BEAVER_P_201409_mean <- cellStats(BEAVER_P_201409, mean)
BEAVER_P_201410_mean <- cellStats(BEAVER_P_201410, mean)
BEAVER_P_201411_mean <- cellStats(BEAVER_P_201411, mean)
BEAVER_P_201412_mean <- cellStats(BEAVER_P_201412, mean)

#2015
BEAVER_P_201501_mean <- cellStats(BEAVER_P_201501, mean)
BEAVER_P_201502_mean <- cellStats(BEAVER_P_201502, mean)
BEAVER_P_201503_mean <- cellStats(BEAVER_P_201503, mean)
BEAVER_P_201504_mean <- cellStats(BEAVER_P_201504, mean)
BEAVER_P_201505_mean <- cellStats(BEAVER_P_201505, mean)
BEAVER_P_201506_mean <- cellStats(BEAVER_P_201506, mean)
BEAVER_P_201507_mean <- cellStats(BEAVER_P_201507, mean)
BEAVER_P_201508_mean <- cellStats(BEAVER_P_201508, mean)
BEAVER_P_201509_mean <- cellStats(BEAVER_P_201509, mean)
BEAVER_P_201510_mean <- cellStats(BEAVER_P_201510, mean)
BEAVER_P_201511_mean <- cellStats(BEAVER_P_201511, mean)
BEAVER_P_201512_mean <- cellStats(BEAVER_P_201512, mean)

#2016
BEAVER_P_201601_mean <- cellStats(BEAVER_P_201601, mean)
BEAVER_P_201602_mean <- cellStats(BEAVER_P_201602, mean)
BEAVER_P_201603_mean <- cellStats(BEAVER_P_201603, mean)
BEAVER_P_201604_mean <- cellStats(BEAVER_P_201604, mean)
BEAVER_P_201605_mean <- cellStats(BEAVER_P_201605, mean)
BEAVER_P_201606_mean <- cellStats(BEAVER_P_201606, mean)
BEAVER_P_201607_mean <- cellStats(BEAVER_P_201607, mean)
BEAVER_P_201608_mean <- cellStats(BEAVER_P_201608, mean)
BEAVER_P_201609_mean <- cellStats(BEAVER_P_201609, mean)
BEAVER_P_201610_mean <- cellStats(BEAVER_P_201610, mean)
BEAVER_P_201611_mean <- cellStats(BEAVER_P_201611, mean)
BEAVER_P_201612_mean <- cellStats(BEAVER_P_201612, mean)

#2017
BEAVER_P_201701_mean <- cellStats(BEAVER_P_201701, mean)
BEAVER_P_201702_mean <- cellStats(BEAVER_P_201702, mean)
BEAVER_P_201703_mean <- cellStats(BEAVER_P_201703, mean)
BEAVER_P_201704_mean <- cellStats(BEAVER_P_201704, mean)
BEAVER_P_201705_mean <- cellStats(BEAVER_P_201705, mean)
BEAVER_P_201706_mean <- cellStats(BEAVER_P_201706, mean)
BEAVER_P_201707_mean <- cellStats(BEAVER_P_201707, mean)
BEAVER_P_201708_mean <- cellStats(BEAVER_P_201708, mean)
BEAVER_P_201709_mean <- cellStats(BEAVER_P_201709, mean)
BEAVER_P_201710_mean <- cellStats(BEAVER_P_201710, mean)
BEAVER_P_201711_mean <- cellStats(BEAVER_P_201711, mean)
BEAVER_P_201712_mean <- cellStats(BEAVER_P_201712, mean)

#2018
BEAVER_P_201801_mean <- cellStats(BEAVER_P_201801, mean)
BEAVER_P_201802_mean <- cellStats(BEAVER_P_201802, mean)
BEAVER_P_201803_mean <- cellStats(BEAVER_P_201803, mean)
BEAVER_P_201804_mean <- cellStats(BEAVER_P_201804, mean)
BEAVER_P_201805_mean <- cellStats(BEAVER_P_201805, mean)
BEAVER_P_201806_mean <- cellStats(BEAVER_P_201806, mean)
BEAVER_P_201807_mean <- cellStats(BEAVER_P_201807, mean)
BEAVER_P_201808_mean <- cellStats(BEAVER_P_201808, mean)
BEAVER_P_201809_mean <- cellStats(BEAVER_P_201809, mean)
BEAVER_P_201810_mean <- cellStats(BEAVER_P_201810, mean)
BEAVER_P_201811_mean <- cellStats(BEAVER_P_201811, mean)
BEAVER_P_201812_mean <- cellStats(BEAVER_P_201812, mean)

# CACHE
#2000
CACHE_P_200001 <- crop(P_200001, CACHE) 
CACHE_P_200002 <- crop(P_200002, CACHE)
CACHE_P_200003 <- crop(P_200003, CACHE)
CACHE_P_200004 <- crop(P_200004, CACHE)
CACHE_P_200005 <- crop(P_200005, CACHE)
CACHE_P_200006 <- crop(P_200006, CACHE)  
CACHE_P_200007 <- crop(P_200007, CACHE)  
CACHE_P_200008 <- crop(P_200008, CACHE)  
CACHE_P_200009 <- crop(P_200009, CACHE)  
CACHE_P_200010 <- crop(P_200010, CACHE)  
CACHE_P_200011 <- crop(P_200011, CACHE)  
CACHE_P_200012 <- crop(P_200012, CACHE)  
#2001
CACHE_P_200101 <- crop(P_200101, CACHE) 
CACHE_P_200102 <- crop(P_200102, CACHE)
CACHE_P_200103 <- crop(P_200103, CACHE)
CACHE_P_200104 <- crop(P_200104, CACHE)
CACHE_P_200105 <- crop(P_200105, CACHE)
CACHE_P_200106 <- crop(P_200106, CACHE)  
CACHE_P_200107 <- crop(P_200107, CACHE)  
CACHE_P_200108 <- crop(P_200108, CACHE)  
CACHE_P_200109 <- crop(P_200109, CACHE)  
CACHE_P_200110 <- crop(P_200110, CACHE)  
CACHE_P_200111 <- crop(P_200111, CACHE)  
CACHE_P_200112 <- crop(P_200112, CACHE)  

#2002
CACHE_P_200201 <- crop(P_200201, CACHE) 
CACHE_P_200202 <- crop(P_200202, CACHE)
CACHE_P_200203 <- crop(P_200203, CACHE)
CACHE_P_200204 <- crop(P_200204, CACHE)
CACHE_P_200205 <- crop(P_200205, CACHE)
CACHE_P_200206 <- crop(P_200206, CACHE)  
CACHE_P_200207 <- crop(P_200207, CACHE)  
CACHE_P_200208 <- crop(P_200208, CACHE)  
CACHE_P_200209 <- crop(P_200209, CACHE)  
CACHE_P_200210 <- crop(P_200210, CACHE)  
CACHE_P_200211 <- crop(P_200211, CACHE)  
CACHE_P_200212 <- crop(P_200212, CACHE)  
#2003
CACHE_P_200301 <- crop(P_200301, CACHE) 
CACHE_P_200302 <- crop(P_200302, CACHE)
CACHE_P_200303 <- crop(P_200303, CACHE)
CACHE_P_200304 <- crop(P_200304, CACHE)
CACHE_P_200305 <- crop(P_200305, CACHE)
CACHE_P_200306 <- crop(P_200306, CACHE)  
CACHE_P_200307 <- crop(P_200307, CACHE)  
CACHE_P_200308 <- crop(P_200308, CACHE)  
CACHE_P_200309 <- crop(P_200309, CACHE)  
CACHE_P_200310 <- crop(P_200310, CACHE)  
CACHE_P_200311 <- crop(P_200311, CACHE)  
CACHE_P_200312 <- crop(P_200312, CACHE)  
#2004
CACHE_P_200401 <- crop(P_200401, CACHE) 
CACHE_P_200402 <- crop(P_200402, CACHE)
CACHE_P_200403 <- crop(P_200403, CACHE)
CACHE_P_200404 <- crop(P_200404, CACHE)
CACHE_P_200405 <- crop(P_200405, CACHE)
CACHE_P_200406 <- crop(P_200406, CACHE)  
CACHE_P_200407 <- crop(P_200407, CACHE)  
CACHE_P_200408 <- crop(P_200408, CACHE)  
CACHE_P_200409 <- crop(P_200409, CACHE)  
CACHE_P_200410 <- crop(P_200410, CACHE)  
CACHE_P_200411 <- crop(P_200411, CACHE)  
CACHE_P_200412 <- crop(P_200412, CACHE)  
#2005
CACHE_P_200501 <- crop(P_200501, CACHE) 
CACHE_P_200502 <- crop(P_200502, CACHE)
CACHE_P_200503 <- crop(P_200503, CACHE)
CACHE_P_200504 <- crop(P_200504, CACHE)
CACHE_P_200505 <- crop(P_200505, CACHE)
CACHE_P_200506 <- crop(P_200506, CACHE)  
CACHE_P_200507 <- crop(P_200507, CACHE)  
CACHE_P_200508 <- crop(P_200508, CACHE)  
CACHE_P_200509 <- crop(P_200509, CACHE)  
CACHE_P_200510 <- crop(P_200510, CACHE)  
CACHE_P_200511 <- crop(P_200511, CACHE)  
CACHE_P_200512 <- crop(P_200512, CACHE)  
#2006
CACHE_P_200601 <- crop(P_200601, CACHE) 
CACHE_P_200602 <- crop(P_200602, CACHE)
CACHE_P_200603 <- crop(P_200603, CACHE)
CACHE_P_200604 <- crop(P_200604, CACHE)
CACHE_P_200605 <- crop(P_200605, CACHE)
CACHE_P_200606 <- crop(P_200606, CACHE)  
CACHE_P_200607 <- crop(P_200607, CACHE)  
CACHE_P_200608 <- crop(P_200608, CACHE)  
CACHE_P_200609 <- crop(P_200609, CACHE)  
CACHE_P_200610 <- crop(P_200610, CACHE)  
CACHE_P_200611 <- crop(P_200611, CACHE)  
CACHE_P_200612 <- crop(P_200612, CACHE)  
#2007
CACHE_P_200701 <- crop(P_200701, CACHE) 
CACHE_P_200702 <- crop(P_200702, CACHE)
CACHE_P_200703 <- crop(P_200703, CACHE)
CACHE_P_200704 <- crop(P_200704, CACHE)
CACHE_P_200705 <- crop(P_200705, CACHE)
CACHE_P_200706 <- crop(P_200706, CACHE)  
CACHE_P_200707 <- crop(P_200707, CACHE)  
CACHE_P_200708 <- crop(P_200708, CACHE)  
CACHE_P_200709 <- crop(P_200709, CACHE)  
CACHE_P_200710 <- crop(P_200710, CACHE)  
CACHE_P_200711 <- crop(P_200711, CACHE)  
CACHE_P_200712 <- crop(P_200712, CACHE)  
#2008
CACHE_P_200801 <- crop(P_200801, CACHE) 
CACHE_P_200802 <- crop(P_200802, CACHE)
CACHE_P_200803 <- crop(P_200803, CACHE)
CACHE_P_200804 <- crop(P_200804, CACHE)
CACHE_P_200805 <- crop(P_200805, CACHE)
CACHE_P_200806 <- crop(P_200806, CACHE)  
CACHE_P_200807 <- crop(P_200807, CACHE)  
CACHE_P_200808 <- crop(P_200808, CACHE)  
CACHE_P_200809 <- crop(P_200809, CACHE)  
CACHE_P_200810 <- crop(P_200810, CACHE)  
CACHE_P_200811 <- crop(P_200811, CACHE)  
CACHE_P_200812 <- crop(P_200812, CACHE)  
#2009
CACHE_P_200901 <- crop(P_200901, CACHE) 
CACHE_P_200902 <- crop(P_200902, CACHE)
CACHE_P_200903 <- crop(P_200903, CACHE)
CACHE_P_200904 <- crop(P_200904, CACHE)
CACHE_P_200905 <- crop(P_200905, CACHE)
CACHE_P_200906 <- crop(P_200906, CACHE)  
CACHE_P_200907 <- crop(P_200907, CACHE)  
CACHE_P_200908 <- crop(P_200908, CACHE)  
CACHE_P_200909 <- crop(P_200909, CACHE)  
CACHE_P_200910 <- crop(P_200910, CACHE)  
CACHE_P_200911 <- crop(P_200911, CACHE)  
CACHE_P_200912 <- crop(P_200912, CACHE)  
#2010
CACHE_P_201001 <- crop(P_201001, CACHE) 
CACHE_P_201002 <- crop(P_201002, CACHE)
CACHE_P_201003 <- crop(P_201003, CACHE)
CACHE_P_201004 <- crop(P_201004, CACHE)
CACHE_P_201005 <- crop(P_201005, CACHE)
CACHE_P_201006 <- crop(P_201006, CACHE)  
CACHE_P_201007 <- crop(P_201007, CACHE)  
CACHE_P_201008 <- crop(P_201008, CACHE)  
CACHE_P_201009 <- crop(P_201009, CACHE)  
CACHE_P_201010 <- crop(P_201010, CACHE)  
CACHE_P_201011 <- crop(P_201011, CACHE)  
CACHE_P_201012 <- crop(P_201012, CACHE)  
#2011
CACHE_P_201101 <- crop(P_201101, CACHE) 
CACHE_P_201102 <- crop(P_201102, CACHE)
CACHE_P_201103 <- crop(P_201103, CACHE)
CACHE_P_201104 <- crop(P_201104, CACHE)
CACHE_P_201105 <- crop(P_201105, CACHE)
CACHE_P_201106 <- crop(P_201106, CACHE)  
CACHE_P_201107 <- crop(P_201107, CACHE)  
CACHE_P_201108 <- crop(P_201108, CACHE)  
CACHE_P_201109 <- crop(P_201109, CACHE)  
CACHE_P_201110 <- crop(P_201110, CACHE)  
CACHE_P_201111 <- crop(P_201111, CACHE)  
CACHE_P_201112 <- crop(P_201112, CACHE)  
#2012
CACHE_P_201201 <- crop(P_201201, CACHE) 
CACHE_P_201202 <- crop(P_201202, CACHE)
CACHE_P_201203 <- crop(P_201203, CACHE)
CACHE_P_201204 <- crop(P_201204, CACHE)
CACHE_P_201205 <- crop(P_201205, CACHE)
CACHE_P_201206 <- crop(P_201206, CACHE)  
CACHE_P_201207 <- crop(P_201207, CACHE)  
CACHE_P_201208 <- crop(P_201208, CACHE)  
CACHE_P_201209 <- crop(P_201209, CACHE)  
CACHE_P_201210 <- crop(P_201210, CACHE)  
CACHE_P_201211 <- crop(P_201211, CACHE)  
CACHE_P_201212 <- crop(P_201212, CACHE)  
#2013
CACHE_P_201301 <- crop(P_201301, CACHE) 
CACHE_P_201302 <- crop(P_201302, CACHE)
CACHE_P_201303 <- crop(P_201303, CACHE)
CACHE_P_201304 <- crop(P_201304, CACHE)
CACHE_P_201305 <- crop(P_201305, CACHE)
CACHE_P_201306 <- crop(P_201306, CACHE)  
CACHE_P_201307 <- crop(P_201307, CACHE)  
CACHE_P_201308 <- crop(P_201308, CACHE)  
CACHE_P_201309 <- crop(P_201309, CACHE)  
CACHE_P_201310 <- crop(P_201310, CACHE)  
CACHE_P_201311 <- crop(P_201311, CACHE)  
CACHE_P_201312 <- crop(P_201312, CACHE)  
#2014
CACHE_P_201401 <- crop(P_201401, CACHE) 
CACHE_P_201402 <- crop(P_201402, CACHE)
CACHE_P_201403 <- crop(P_201403, CACHE)
CACHE_P_201404 <- crop(P_201404, CACHE)
CACHE_P_201405 <- crop(P_201405, CACHE)
CACHE_P_201406 <- crop(P_201406, CACHE)  
CACHE_P_201407 <- crop(P_201407, CACHE)  
CACHE_P_201408 <- crop(P_201408, CACHE)  
CACHE_P_201409 <- crop(P_201409, CACHE)  
CACHE_P_201410 <- crop(P_201410, CACHE)  
CACHE_P_201411 <- crop(P_201411, CACHE)  
CACHE_P_201412 <- crop(P_201412, CACHE)  
#2015
CACHE_P_201501 <- crop(P_201501, CACHE) 
CACHE_P_201502 <- crop(P_201502, CACHE)
CACHE_P_201503 <- crop(P_201503, CACHE)
CACHE_P_201504 <- crop(P_201504, CACHE)
CACHE_P_201505 <- crop(P_201505, CACHE)
CACHE_P_201506 <- crop(P_201506, CACHE)  
CACHE_P_201507 <- crop(P_201507, CACHE)  
CACHE_P_201508 <- crop(P_201508, CACHE)  
CACHE_P_201509 <- crop(P_201509, CACHE)  
CACHE_P_201510 <- crop(P_201510, CACHE)  
CACHE_P_201511 <- crop(P_201511, CACHE)  
CACHE_P_201512 <- crop(P_201512, CACHE)  
#2016
CACHE_P_201601 <- crop(P_201601, CACHE) 
CACHE_P_201602 <- crop(P_201602, CACHE)
CACHE_P_201603 <- crop(P_201603, CACHE)
CACHE_P_201604 <- crop(P_201604, CACHE)
CACHE_P_201605 <- crop(P_201605, CACHE)
CACHE_P_201606 <- crop(P_201606, CACHE)  
CACHE_P_201607 <- crop(P_201607, CACHE)  
CACHE_P_201608 <- crop(P_201608, CACHE)  
CACHE_P_201609 <- crop(P_201609, CACHE)  
CACHE_P_201610 <- crop(P_201610, CACHE)  
CACHE_P_201611 <- crop(P_201611, CACHE)  
CACHE_P_201612 <- crop(P_201612, CACHE)  
#2017
CACHE_P_201701 <- crop(P_201701, CACHE) 
CACHE_P_201702 <- crop(P_201702, CACHE)
CACHE_P_201703 <- crop(P_201703, CACHE)
CACHE_P_201704 <- crop(P_201704, CACHE)
CACHE_P_201705 <- crop(P_201705, CACHE)
CACHE_P_201706 <- crop(P_201706, CACHE)  
CACHE_P_201707 <- crop(P_201707, CACHE)  
CACHE_P_201708 <- crop(P_201708, CACHE)  
CACHE_P_201709 <- crop(P_201709, CACHE)  
CACHE_P_201710 <- crop(P_201710, CACHE)  
CACHE_P_201711 <- crop(P_201711, CACHE)  
CACHE_P_201712 <- crop(P_201712, CACHE)  

#2018

CACHE_P_201801 <- crop(P_201801, CACHE) 
CACHE_P_201802 <- crop(P_201802, CACHE)
CACHE_P_201803 <- crop(P_201803, CACHE)
CACHE_P_201804 <- crop(P_201804, CACHE)
CACHE_P_201805 <- crop(P_201805, CACHE)
CACHE_P_201806 <- crop(P_201806, CACHE)  
CACHE_P_201807 <- crop(P_201807, CACHE)  
CACHE_P_201808 <- crop(P_201808, CACHE)  
CACHE_P_201809 <- crop(P_201809, CACHE)  
CACHE_P_201810 <- crop(P_201810, CACHE)  
CACHE_P_201811 <- crop(P_201811, CACHE)  
CACHE_P_201812 <- crop(P_201812, CACHE)  


# Mean Monthly Precipitation
#2000
CACHE_P_200001_mean <- cellStats(CACHE_P_200001, mean)
CACHE_P_200002_mean <- cellStats(CACHE_P_200002, mean)
CACHE_P_200003_mean <- cellStats(CACHE_P_200003, mean)
CACHE_P_200004_mean <- cellStats(CACHE_P_200004, mean)
CACHE_P_200005_mean <- cellStats(CACHE_P_200005, mean)
CACHE_P_200006_mean <- cellStats(CACHE_P_200006, mean)
CACHE_P_200007_mean <- cellStats(CACHE_P_200007, mean)
CACHE_P_200008_mean <- cellStats(CACHE_P_200008, mean)
CACHE_P_200009_mean <- cellStats(CACHE_P_200009, mean)
CACHE_P_200010_mean <- cellStats(CACHE_P_200010, mean)
CACHE_P_200011_mean <- cellStats(CACHE_P_200011, mean)
CACHE_P_200012_mean <- cellStats(CACHE_P_200012, mean)
#2001
CACHE_P_200101_mean <- cellStats(CACHE_P_200101, mean)
CACHE_P_200102_mean <- cellStats(CACHE_P_200102, mean)
CACHE_P_200103_mean <- cellStats(CACHE_P_200103, mean)
CACHE_P_200104_mean <- cellStats(CACHE_P_200104, mean)
CACHE_P_200105_mean <- cellStats(CACHE_P_200105, mean)
CACHE_P_200106_mean <- cellStats(CACHE_P_200106, mean)
CACHE_P_200107_mean <- cellStats(CACHE_P_200107, mean)
CACHE_P_200108_mean <- cellStats(CACHE_P_200108, mean)
CACHE_P_200109_mean <- cellStats(CACHE_P_200109, mean)
CACHE_P_200110_mean <- cellStats(CACHE_P_200110, mean)
CACHE_P_200111_mean <- cellStats(CACHE_P_200111, mean)
CACHE_P_200112_mean <- cellStats(CACHE_P_200112, mean)

#2002
CACHE_P_200201_mean <- cellStats(CACHE_P_200201, mean)
CACHE_P_200202_mean <- cellStats(CACHE_P_200202, mean)
CACHE_P_200203_mean <- cellStats(CACHE_P_200203, mean)
CACHE_P_200204_mean <- cellStats(CACHE_P_200204, mean)
CACHE_P_200205_mean <- cellStats(CACHE_P_200205, mean)
CACHE_P_200206_mean <- cellStats(CACHE_P_200206, mean)
CACHE_P_200207_mean <- cellStats(CACHE_P_200207, mean)
CACHE_P_200208_mean <- cellStats(CACHE_P_200208, mean)
CACHE_P_200209_mean <- cellStats(CACHE_P_200209, mean)
CACHE_P_200210_mean <- cellStats(CACHE_P_200210, mean)
CACHE_P_200211_mean <- cellStats(CACHE_P_200211, mean)
CACHE_P_200212_mean <- cellStats(CACHE_P_200212, mean)

#2003
CACHE_P_200301_mean <- cellStats(CACHE_P_200301, mean)
CACHE_P_200302_mean <- cellStats(CACHE_P_200302, mean)
CACHE_P_200303_mean <- cellStats(CACHE_P_200303, mean)
CACHE_P_200304_mean <- cellStats(CACHE_P_200304, mean)
CACHE_P_200305_mean <- cellStats(CACHE_P_200305, mean)
CACHE_P_200306_mean <- cellStats(CACHE_P_200306, mean)
CACHE_P_200307_mean <- cellStats(CACHE_P_200307, mean)
CACHE_P_200308_mean <- cellStats(CACHE_P_200308, mean)
CACHE_P_200309_mean <- cellStats(CACHE_P_200309, mean)
CACHE_P_200310_mean <- cellStats(CACHE_P_200310, mean)
CACHE_P_200311_mean <- cellStats(CACHE_P_200311, mean)
CACHE_P_200312_mean <- cellStats(CACHE_P_200312, mean)

#2004

CACHE_P_200401_mean <- cellStats(CACHE_P_200401, mean)
CACHE_P_200402_mean <- cellStats(CACHE_P_200402, mean)
CACHE_P_200403_mean <- cellStats(CACHE_P_200403, mean)
CACHE_P_200404_mean <- cellStats(CACHE_P_200404, mean)
CACHE_P_200405_mean <- cellStats(CACHE_P_200405, mean)
CACHE_P_200406_mean <- cellStats(CACHE_P_200406, mean)
CACHE_P_200407_mean <- cellStats(CACHE_P_200407, mean)
CACHE_P_200408_mean <- cellStats(CACHE_P_200408, mean)
CACHE_P_200409_mean <- cellStats(CACHE_P_200409, mean)
CACHE_P_200410_mean <- cellStats(CACHE_P_200410, mean)
CACHE_P_200411_mean <- cellStats(CACHE_P_200411, mean)
CACHE_P_200412_mean <- cellStats(CACHE_P_200412, mean)

#2005

CACHE_P_200501_mean <- cellStats(CACHE_P_200501, mean)
CACHE_P_200502_mean <- cellStats(CACHE_P_200502, mean)
CACHE_P_200503_mean <- cellStats(CACHE_P_200503, mean)
CACHE_P_200504_mean <- cellStats(CACHE_P_200504, mean)
CACHE_P_200505_mean <- cellStats(CACHE_P_200505, mean)
CACHE_P_200506_mean <- cellStats(CACHE_P_200506, mean)
CACHE_P_200507_mean <- cellStats(CACHE_P_200507, mean)
CACHE_P_200508_mean <- cellStats(CACHE_P_200508, mean)
CACHE_P_200509_mean <- cellStats(CACHE_P_200509, mean)
CACHE_P_200510_mean <- cellStats(CACHE_P_200510, mean)
CACHE_P_200511_mean <- cellStats(CACHE_P_200511, mean)
CACHE_P_200512_mean <- cellStats(CACHE_P_200512, mean)

#2006

CACHE_P_200601_mean <- cellStats(CACHE_P_200601, mean)
CACHE_P_200602_mean <- cellStats(CACHE_P_200602, mean)
CACHE_P_200603_mean <- cellStats(CACHE_P_200603, mean)
CACHE_P_200604_mean <- cellStats(CACHE_P_200604, mean)
CACHE_P_200605_mean <- cellStats(CACHE_P_200605, mean)
CACHE_P_200606_mean <- cellStats(CACHE_P_200606, mean)
CACHE_P_200607_mean <- cellStats(CACHE_P_200607, mean)
CACHE_P_200608_mean <- cellStats(CACHE_P_200608, mean)
CACHE_P_200609_mean <- cellStats(CACHE_P_200609, mean)
CACHE_P_200610_mean <- cellStats(CACHE_P_200610, mean)
CACHE_P_200611_mean <- cellStats(CACHE_P_200611, mean)
CACHE_P_200612_mean <- cellStats(CACHE_P_200612, mean)

#2007

CACHE_P_200701_mean <- cellStats(CACHE_P_200701, mean)
CACHE_P_200702_mean <- cellStats(CACHE_P_200702, mean)
CACHE_P_200703_mean <- cellStats(CACHE_P_200703, mean)
CACHE_P_200704_mean <- cellStats(CACHE_P_200704, mean)
CACHE_P_200705_mean <- cellStats(CACHE_P_200705, mean)
CACHE_P_200706_mean <- cellStats(CACHE_P_200706, mean)
CACHE_P_200707_mean <- cellStats(CACHE_P_200707, mean)
CACHE_P_200708_mean <- cellStats(CACHE_P_200708, mean)
CACHE_P_200709_mean <- cellStats(CACHE_P_200709, mean)
CACHE_P_200710_mean <- cellStats(CACHE_P_200710, mean)
CACHE_P_200711_mean <- cellStats(CACHE_P_200711, mean)
CACHE_P_200712_mean <- cellStats(CACHE_P_200712, mean)

#2008

CACHE_P_200801_mean <- cellStats(CACHE_P_200801, mean)
CACHE_P_200802_mean <- cellStats(CACHE_P_200802, mean)
CACHE_P_200803_mean <- cellStats(CACHE_P_200803, mean)
CACHE_P_200804_mean <- cellStats(CACHE_P_200804, mean)
CACHE_P_200805_mean <- cellStats(CACHE_P_200805, mean)
CACHE_P_200806_mean <- cellStats(CACHE_P_200806, mean)
CACHE_P_200807_mean <- cellStats(CACHE_P_200807, mean)
CACHE_P_200808_mean <- cellStats(CACHE_P_200808, mean)
CACHE_P_200809_mean <- cellStats(CACHE_P_200809, mean)
CACHE_P_200810_mean <- cellStats(CACHE_P_200810, mean)
CACHE_P_200811_mean <- cellStats(CACHE_P_200811, mean)
CACHE_P_200812_mean <- cellStats(CACHE_P_200812, mean)

#2009

CACHE_P_200901_mean <- cellStats(CACHE_P_200901, mean)
CACHE_P_200902_mean <- cellStats(CACHE_P_200902, mean)
CACHE_P_200903_mean <- cellStats(CACHE_P_200903, mean)
CACHE_P_200904_mean <- cellStats(CACHE_P_200904, mean)
CACHE_P_200905_mean <- cellStats(CACHE_P_200905, mean)
CACHE_P_200906_mean <- cellStats(CACHE_P_200906, mean)
CACHE_P_200907_mean <- cellStats(CACHE_P_200907, mean)
CACHE_P_200908_mean <- cellStats(CACHE_P_200908, mean)
CACHE_P_200909_mean <- cellStats(CACHE_P_200909, mean)
CACHE_P_200910_mean <- cellStats(CACHE_P_200910, mean)
CACHE_P_200911_mean <- cellStats(CACHE_P_200911, mean)
CACHE_P_200912_mean <- cellStats(CACHE_P_200912, mean)

#2010

CACHE_P_201001_mean <- cellStats(CACHE_P_201001, mean)
CACHE_P_201002_mean <- cellStats(CACHE_P_201002, mean)
CACHE_P_201003_mean <- cellStats(CACHE_P_201003, mean)
CACHE_P_201004_mean <- cellStats(CACHE_P_201004, mean)
CACHE_P_201005_mean <- cellStats(CACHE_P_201005, mean)
CACHE_P_201006_mean <- cellStats(CACHE_P_201006, mean)
CACHE_P_201007_mean <- cellStats(CACHE_P_201007, mean)
CACHE_P_201008_mean <- cellStats(CACHE_P_201008, mean)
CACHE_P_201009_mean <- cellStats(CACHE_P_201009, mean)
CACHE_P_201010_mean <- cellStats(CACHE_P_201010, mean)
CACHE_P_201011_mean <- cellStats(CACHE_P_201011, mean)
CACHE_P_201012_mean <- cellStats(CACHE_P_201012, mean)

#2011

CACHE_P_201101_mean <- cellStats(CACHE_P_201101, mean)
CACHE_P_201102_mean <- cellStats(CACHE_P_201102, mean)
CACHE_P_201103_mean <- cellStats(CACHE_P_201103, mean)
CACHE_P_201104_mean <- cellStats(CACHE_P_201104, mean)
CACHE_P_201105_mean <- cellStats(CACHE_P_201105, mean)
CACHE_P_201106_mean <- cellStats(CACHE_P_201106, mean)
CACHE_P_201107_mean <- cellStats(CACHE_P_201107, mean)
CACHE_P_201108_mean <- cellStats(CACHE_P_201108, mean)
CACHE_P_201109_mean <- cellStats(CACHE_P_201109, mean)
CACHE_P_201110_mean <- cellStats(CACHE_P_201110, mean)
CACHE_P_201111_mean <- cellStats(CACHE_P_201111, mean)
CACHE_P_201112_mean <- cellStats(CACHE_P_201112, mean)

#2012
CACHE_P_201201_mean <- cellStats(CACHE_P_201201, mean)
CACHE_P_201202_mean <- cellStats(CACHE_P_201202, mean)
CACHE_P_201203_mean <- cellStats(CACHE_P_201203, mean)
CACHE_P_201204_mean <- cellStats(CACHE_P_201204, mean)
CACHE_P_201205_mean <- cellStats(CACHE_P_201205, mean)
CACHE_P_201206_mean <- cellStats(CACHE_P_201206, mean)
CACHE_P_201207_mean <- cellStats(CACHE_P_201207, mean)
CACHE_P_201208_mean <- cellStats(CACHE_P_201208, mean)
CACHE_P_201209_mean <- cellStats(CACHE_P_201209, mean)
CACHE_P_201210_mean <- cellStats(CACHE_P_201210, mean)
CACHE_P_201211_mean <- cellStats(CACHE_P_201211, mean)
CACHE_P_201212_mean <- cellStats(CACHE_P_201212, mean)

#2013
CACHE_P_201301_mean <- cellStats(CACHE_P_201301, mean)
CACHE_P_201302_mean <- cellStats(CACHE_P_201302, mean)
CACHE_P_201303_mean <- cellStats(CACHE_P_201303, mean)
CACHE_P_201304_mean <- cellStats(CACHE_P_201304, mean)
CACHE_P_201305_mean <- cellStats(CACHE_P_201305, mean)
CACHE_P_201306_mean <- cellStats(CACHE_P_201306, mean)
CACHE_P_201307_mean <- cellStats(CACHE_P_201307, mean)
CACHE_P_201308_mean <- cellStats(CACHE_P_201308, mean)
CACHE_P_201309_mean <- cellStats(CACHE_P_201309, mean)
CACHE_P_201310_mean <- cellStats(CACHE_P_201310, mean)
CACHE_P_201311_mean <- cellStats(CACHE_P_201311, mean)
CACHE_P_201312_mean <- cellStats(CACHE_P_201312, mean)

#2014
CACHE_P_201401_mean <- cellStats(CACHE_P_201401, mean)
CACHE_P_201402_mean <- cellStats(CACHE_P_201402, mean)
CACHE_P_201403_mean <- cellStats(CACHE_P_201403, mean)
CACHE_P_201404_mean <- cellStats(CACHE_P_201404, mean)
CACHE_P_201405_mean <- cellStats(CACHE_P_201405, mean)
CACHE_P_201406_mean <- cellStats(CACHE_P_201406, mean)
CACHE_P_201407_mean <- cellStats(CACHE_P_201407, mean)
CACHE_P_201408_mean <- cellStats(CACHE_P_201408, mean)
CACHE_P_201409_mean <- cellStats(CACHE_P_201409, mean)
CACHE_P_201410_mean <- cellStats(CACHE_P_201410, mean)
CACHE_P_201411_mean <- cellStats(CACHE_P_201411, mean)
CACHE_P_201412_mean <- cellStats(CACHE_P_201412, mean)

#2015
CACHE_P_201501_mean <- cellStats(CACHE_P_201501, mean)
CACHE_P_201502_mean <- cellStats(CACHE_P_201502, mean)
CACHE_P_201503_mean <- cellStats(CACHE_P_201503, mean)
CACHE_P_201504_mean <- cellStats(CACHE_P_201504, mean)
CACHE_P_201505_mean <- cellStats(CACHE_P_201505, mean)
CACHE_P_201506_mean <- cellStats(CACHE_P_201506, mean)
CACHE_P_201507_mean <- cellStats(CACHE_P_201507, mean)
CACHE_P_201508_mean <- cellStats(CACHE_P_201508, mean)
CACHE_P_201509_mean <- cellStats(CACHE_P_201509, mean)
CACHE_P_201510_mean <- cellStats(CACHE_P_201510, mean)
CACHE_P_201511_mean <- cellStats(CACHE_P_201511, mean)
CACHE_P_201512_mean <- cellStats(CACHE_P_201512, mean)

#2016
CACHE_P_201601_mean <- cellStats(CACHE_P_201601, mean)
CACHE_P_201602_mean <- cellStats(CACHE_P_201602, mean)
CACHE_P_201603_mean <- cellStats(CACHE_P_201603, mean)
CACHE_P_201604_mean <- cellStats(CACHE_P_201604, mean)
CACHE_P_201605_mean <- cellStats(CACHE_P_201605, mean)
CACHE_P_201606_mean <- cellStats(CACHE_P_201606, mean)
CACHE_P_201607_mean <- cellStats(CACHE_P_201607, mean)
CACHE_P_201608_mean <- cellStats(CACHE_P_201608, mean)
CACHE_P_201609_mean <- cellStats(CACHE_P_201609, mean)
CACHE_P_201610_mean <- cellStats(CACHE_P_201610, mean)
CACHE_P_201611_mean <- cellStats(CACHE_P_201611, mean)
CACHE_P_201612_mean <- cellStats(CACHE_P_201612, mean)

#2017
CACHE_P_201701_mean <- cellStats(CACHE_P_201701, mean)
CACHE_P_201702_mean <- cellStats(CACHE_P_201702, mean)
CACHE_P_201703_mean <- cellStats(CACHE_P_201703, mean)
CACHE_P_201704_mean <- cellStats(CACHE_P_201704, mean)
CACHE_P_201705_mean <- cellStats(CACHE_P_201705, mean)
CACHE_P_201706_mean <- cellStats(CACHE_P_201706, mean)
CACHE_P_201707_mean <- cellStats(CACHE_P_201707, mean)
CACHE_P_201708_mean <- cellStats(CACHE_P_201708, mean)
CACHE_P_201709_mean <- cellStats(CACHE_P_201709, mean)
CACHE_P_201710_mean <- cellStats(CACHE_P_201710, mean)
CACHE_P_201711_mean <- cellStats(CACHE_P_201711, mean)
CACHE_P_201712_mean <- cellStats(CACHE_P_201712, mean)

#2018
CACHE_P_201801_mean <- cellStats(CACHE_P_201801, mean)
CACHE_P_201802_mean <- cellStats(CACHE_P_201802, mean)
CACHE_P_201803_mean <- cellStats(CACHE_P_201803, mean)
CACHE_P_201804_mean <- cellStats(CACHE_P_201804, mean)
CACHE_P_201805_mean <- cellStats(CACHE_P_201805, mean)
CACHE_P_201806_mean <- cellStats(CACHE_P_201806, mean)
CACHE_P_201807_mean <- cellStats(CACHE_P_201807, mean)
CACHE_P_201808_mean <- cellStats(CACHE_P_201808, mean)
CACHE_P_201809_mean <- cellStats(CACHE_P_201809, mean)
CACHE_P_201810_mean <- cellStats(CACHE_P_201810, mean)
CACHE_P_201811_mean <- cellStats(CACHE_P_201811, mean)
CACHE_P_201812_mean <- cellStats(CACHE_P_201812, mean)

# CARBON

#2000
CARBON_P_200001 <- crop(P_200001, CARBON) 
CARBON_P_200002 <- crop(P_200002, CARBON)
CARBON_P_200003 <- crop(P_200003, CARBON)
CARBON_P_200004 <- crop(P_200004, CARBON)
CARBON_P_200005 <- crop(P_200005, CARBON)
CARBON_P_200006 <- crop(P_200006, CARBON)  
CARBON_P_200007 <- crop(P_200007, CARBON)  
CARBON_P_200008 <- crop(P_200008, CARBON)  
CARBON_P_200009 <- crop(P_200009, CARBON)  
CARBON_P_200010 <- crop(P_200010, CARBON)  
CARBON_P_200011 <- crop(P_200011, CARBON)  
CARBON_P_200012 <- crop(P_200012, CARBON)  
#2001
CARBON_P_200101 <- crop(P_200101, CARBON) 
CARBON_P_200102 <- crop(P_200102, CARBON)
CARBON_P_200103 <- crop(P_200103, CARBON)
CARBON_P_200104 <- crop(P_200104, CARBON)
CARBON_P_200105 <- crop(P_200105, CARBON)
CARBON_P_200106 <- crop(P_200106, CARBON)  
CARBON_P_200107 <- crop(P_200107, CARBON)  
CARBON_P_200108 <- crop(P_200108, CARBON)  
CARBON_P_200109 <- crop(P_200109, CARBON)  
CARBON_P_200110 <- crop(P_200110, CARBON)  
CARBON_P_200111 <- crop(P_200111, CARBON)  
CARBON_P_200112 <- crop(P_200112, CARBON)  

#2002
CARBON_P_200201 <- crop(P_200201, CARBON) 
CARBON_P_200202 <- crop(P_200202, CARBON)
CARBON_P_200203 <- crop(P_200203, CARBON)
CARBON_P_200204 <- crop(P_200204, CARBON)
CARBON_P_200205 <- crop(P_200205, CARBON)
CARBON_P_200206 <- crop(P_200206, CARBON)  
CARBON_P_200207 <- crop(P_200207, CARBON)  
CARBON_P_200208 <- crop(P_200208, CARBON)  
CARBON_P_200209 <- crop(P_200209, CARBON)  
CARBON_P_200210 <- crop(P_200210, CARBON)  
CARBON_P_200211 <- crop(P_200211, CARBON)  
CARBON_P_200212 <- crop(P_200212, CARBON)  
#2003
CARBON_P_200301 <- crop(P_200301, CARBON) 
CARBON_P_200302 <- crop(P_200302, CARBON)
CARBON_P_200303 <- crop(P_200303, CARBON)
CARBON_P_200304 <- crop(P_200304, CARBON)
CARBON_P_200305 <- crop(P_200305, CARBON)
CARBON_P_200306 <- crop(P_200306, CARBON)  
CARBON_P_200307 <- crop(P_200307, CARBON)  
CARBON_P_200308 <- crop(P_200308, CARBON)  
CARBON_P_200309 <- crop(P_200309, CARBON)  
CARBON_P_200310 <- crop(P_200310, CARBON)  
CARBON_P_200311 <- crop(P_200311, CARBON)  
CARBON_P_200312 <- crop(P_200312, CARBON)  
#2004
CARBON_P_200401 <- crop(P_200401, CARBON) 
CARBON_P_200402 <- crop(P_200402, CARBON)
CARBON_P_200403 <- crop(P_200403, CARBON)
CARBON_P_200404 <- crop(P_200404, CARBON)
CARBON_P_200405 <- crop(P_200405, CARBON)
CARBON_P_200406 <- crop(P_200406, CARBON)  
CARBON_P_200407 <- crop(P_200407, CARBON)  
CARBON_P_200408 <- crop(P_200408, CARBON)  
CARBON_P_200409 <- crop(P_200409, CARBON)  
CARBON_P_200410 <- crop(P_200410, CARBON)  
CARBON_P_200411 <- crop(P_200411, CARBON)  
CARBON_P_200412 <- crop(P_200412, CARBON)  
#2005
CARBON_P_200501 <- crop(P_200501, CARBON) 
CARBON_P_200502 <- crop(P_200502, CARBON)
CARBON_P_200503 <- crop(P_200503, CARBON)
CARBON_P_200504 <- crop(P_200504, CARBON)
CARBON_P_200505 <- crop(P_200505, CARBON)
CARBON_P_200506 <- crop(P_200506, CARBON)  
CARBON_P_200507 <- crop(P_200507, CARBON)  
CARBON_P_200508 <- crop(P_200508, CARBON)  
CARBON_P_200509 <- crop(P_200509, CARBON)  
CARBON_P_200510 <- crop(P_200510, CARBON)  
CARBON_P_200511 <- crop(P_200511, CARBON)  
CARBON_P_200512 <- crop(P_200512, CARBON)  
#2006
CARBON_P_200601 <- crop(P_200601, CARBON) 
CARBON_P_200602 <- crop(P_200602, CARBON)
CARBON_P_200603 <- crop(P_200603, CARBON)
CARBON_P_200604 <- crop(P_200604, CARBON)
CARBON_P_200605 <- crop(P_200605, CARBON)
CARBON_P_200606 <- crop(P_200606, CARBON)  
CARBON_P_200607 <- crop(P_200607, CARBON)  
CARBON_P_200608 <- crop(P_200608, CARBON)  
CARBON_P_200609 <- crop(P_200609, CARBON)  
CARBON_P_200610 <- crop(P_200610, CARBON)  
CARBON_P_200611 <- crop(P_200611, CARBON)  
CARBON_P_200612 <- crop(P_200612, CARBON)  
#2007
CARBON_P_200701 <- crop(P_200701, CARBON) 
CARBON_P_200702 <- crop(P_200702, CARBON)
CARBON_P_200703 <- crop(P_200703, CARBON)
CARBON_P_200704 <- crop(P_200704, CARBON)
CARBON_P_200705 <- crop(P_200705, CARBON)
CARBON_P_200706 <- crop(P_200706, CARBON)  
CARBON_P_200707 <- crop(P_200707, CARBON)  
CARBON_P_200708 <- crop(P_200708, CARBON)  
CARBON_P_200709 <- crop(P_200709, CARBON)  
CARBON_P_200710 <- crop(P_200710, CARBON)  
CARBON_P_200711 <- crop(P_200711, CARBON)  
CARBON_P_200712 <- crop(P_200712, CARBON)  
#2008
CARBON_P_200801 <- crop(P_200801, CARBON) 
CARBON_P_200802 <- crop(P_200802, CARBON)
CARBON_P_200803 <- crop(P_200803, CARBON)
CARBON_P_200804 <- crop(P_200804, CARBON)
CARBON_P_200805 <- crop(P_200805, CARBON)
CARBON_P_200806 <- crop(P_200806, CARBON)  
CARBON_P_200807 <- crop(P_200807, CARBON)  
CARBON_P_200808 <- crop(P_200808, CARBON)  
CARBON_P_200809 <- crop(P_200809, CARBON)  
CARBON_P_200810 <- crop(P_200810, CARBON)  
CARBON_P_200811 <- crop(P_200811, CARBON)  
CARBON_P_200812 <- crop(P_200812, CARBON)  
#2009
CARBON_P_200901 <- crop(P_200901, CARBON) 
CARBON_P_200902 <- crop(P_200902, CARBON)
CARBON_P_200903 <- crop(P_200903, CARBON)
CARBON_P_200904 <- crop(P_200904, CARBON)
CARBON_P_200905 <- crop(P_200905, CARBON)
CARBON_P_200906 <- crop(P_200906, CARBON)  
CARBON_P_200907 <- crop(P_200907, CARBON)  
CARBON_P_200908 <- crop(P_200908, CARBON)  
CARBON_P_200909 <- crop(P_200909, CARBON)  
CARBON_P_200910 <- crop(P_200910, CARBON)  
CARBON_P_200911 <- crop(P_200911, CARBON)  
CARBON_P_200912 <- crop(P_200912, CARBON)  
#2010
CARBON_P_201001 <- crop(P_201001, CARBON) 
CARBON_P_201002 <- crop(P_201002, CARBON)
CARBON_P_201003 <- crop(P_201003, CARBON)
CARBON_P_201004 <- crop(P_201004, CARBON)
CARBON_P_201005 <- crop(P_201005, CARBON)
CARBON_P_201006 <- crop(P_201006, CARBON)  
CARBON_P_201007 <- crop(P_201007, CARBON)  
CARBON_P_201008 <- crop(P_201008, CARBON)  
CARBON_P_201009 <- crop(P_201009, CARBON)  
CARBON_P_201010 <- crop(P_201010, CARBON)  
CARBON_P_201011 <- crop(P_201011, CARBON)  
CARBON_P_201012 <- crop(P_201012, CARBON)  
#2011
CARBON_P_201101 <- crop(P_201101, CARBON) 
CARBON_P_201102 <- crop(P_201102, CARBON)
CARBON_P_201103 <- crop(P_201103, CARBON)
CARBON_P_201104 <- crop(P_201104, CARBON)
CARBON_P_201105 <- crop(P_201105, CARBON)
CARBON_P_201106 <- crop(P_201106, CARBON)  
CARBON_P_201107 <- crop(P_201107, CARBON)  
CARBON_P_201108 <- crop(P_201108, CARBON)  
CARBON_P_201109 <- crop(P_201109, CARBON)  
CARBON_P_201110 <- crop(P_201110, CARBON)  
CARBON_P_201111 <- crop(P_201111, CARBON)  
CARBON_P_201112 <- crop(P_201112, CARBON)  
#2012
CARBON_P_201201 <- crop(P_201201, CARBON) 
CARBON_P_201202 <- crop(P_201202, CARBON)
CARBON_P_201203 <- crop(P_201203, CARBON)
CARBON_P_201204 <- crop(P_201204, CARBON)
CARBON_P_201205 <- crop(P_201205, CARBON)
CARBON_P_201206 <- crop(P_201206, CARBON)  
CARBON_P_201207 <- crop(P_201207, CARBON)  
CARBON_P_201208 <- crop(P_201208, CARBON)  
CARBON_P_201209 <- crop(P_201209, CARBON)  
CARBON_P_201210 <- crop(P_201210, CARBON)  
CARBON_P_201211 <- crop(P_201211, CARBON)  
CARBON_P_201212 <- crop(P_201212, CARBON)  
#2013
CARBON_P_201301 <- crop(P_201301, CARBON) 
CARBON_P_201302 <- crop(P_201302, CARBON)
CARBON_P_201303 <- crop(P_201303, CARBON)
CARBON_P_201304 <- crop(P_201304, CARBON)
CARBON_P_201305 <- crop(P_201305, CARBON)
CARBON_P_201306 <- crop(P_201306, CARBON)  
CARBON_P_201307 <- crop(P_201307, CARBON)  
CARBON_P_201308 <- crop(P_201308, CARBON)  
CARBON_P_201309 <- crop(P_201309, CARBON)  
CARBON_P_201310 <- crop(P_201310, CARBON)  
CARBON_P_201311 <- crop(P_201311, CARBON)  
CARBON_P_201312 <- crop(P_201312, CARBON)  
#2014
CARBON_P_201401 <- crop(P_201401, CARBON) 
CARBON_P_201402 <- crop(P_201402, CARBON)
CARBON_P_201403 <- crop(P_201403, CARBON)
CARBON_P_201404 <- crop(P_201404, CARBON)
CARBON_P_201405 <- crop(P_201405, CARBON)
CARBON_P_201406 <- crop(P_201406, CARBON)  
CARBON_P_201407 <- crop(P_201407, CARBON)  
CARBON_P_201408 <- crop(P_201408, CARBON)  
CARBON_P_201409 <- crop(P_201409, CARBON)  
CARBON_P_201410 <- crop(P_201410, CARBON)  
CARBON_P_201411 <- crop(P_201411, CARBON)  
CARBON_P_201412 <- crop(P_201412, CARBON)  
#2015
CARBON_P_201501 <- crop(P_201501, CARBON) 
CARBON_P_201502 <- crop(P_201502, CARBON)
CARBON_P_201503 <- crop(P_201503, CARBON)
CARBON_P_201504 <- crop(P_201504, CARBON)
CARBON_P_201505 <- crop(P_201505, CARBON)
CARBON_P_201506 <- crop(P_201506, CARBON)  
CARBON_P_201507 <- crop(P_201507, CARBON)  
CARBON_P_201508 <- crop(P_201508, CARBON)  
CARBON_P_201509 <- crop(P_201509, CARBON)  
CARBON_P_201510 <- crop(P_201510, CARBON)  
CARBON_P_201511 <- crop(P_201511, CARBON)  
CARBON_P_201512 <- crop(P_201512, CARBON)  
#2016
CARBON_P_201601 <- crop(P_201601, CARBON) 
CARBON_P_201602 <- crop(P_201602, CARBON)
CARBON_P_201603 <- crop(P_201603, CARBON)
CARBON_P_201604 <- crop(P_201604, CARBON)
CARBON_P_201605 <- crop(P_201605, CARBON)
CARBON_P_201606 <- crop(P_201606, CARBON)  
CARBON_P_201607 <- crop(P_201607, CARBON)  
CARBON_P_201608 <- crop(P_201608, CARBON)  
CARBON_P_201609 <- crop(P_201609, CARBON)  
CARBON_P_201610 <- crop(P_201610, CARBON)  
CARBON_P_201611 <- crop(P_201611, CARBON)  
CARBON_P_201612 <- crop(P_201612, CARBON)  
#2017
CARBON_P_201701 <- crop(P_201701, CARBON) 
CARBON_P_201702 <- crop(P_201702, CARBON)
CARBON_P_201703 <- crop(P_201703, CARBON)
CARBON_P_201704 <- crop(P_201704, CARBON)
CARBON_P_201705 <- crop(P_201705, CARBON)
CARBON_P_201706 <- crop(P_201706, CARBON)  
CARBON_P_201707 <- crop(P_201707, CARBON)  
CARBON_P_201708 <- crop(P_201708, CARBON)  
CARBON_P_201709 <- crop(P_201709, CARBON)  
CARBON_P_201710 <- crop(P_201710, CARBON)  
CARBON_P_201711 <- crop(P_201711, CARBON)  
CARBON_P_201712 <- crop(P_201712, CARBON)  

#2018

CARBON_P_201801 <- crop(P_201801, CARBON) 
CARBON_P_201802 <- crop(P_201802, CARBON)
CARBON_P_201803 <- crop(P_201803, CARBON)
CARBON_P_201804 <- crop(P_201804, CARBON)
CARBON_P_201805 <- crop(P_201805, CARBON)
CARBON_P_201806 <- crop(P_201806, CARBON)  
CARBON_P_201807 <- crop(P_201807, CARBON)  
CARBON_P_201808 <- crop(P_201808, CARBON)  
CARBON_P_201809 <- crop(P_201809, CARBON)  
CARBON_P_201810 <- crop(P_201810, CARBON)  
CARBON_P_201811 <- crop(P_201811, CARBON)  
CARBON_P_201812 <- crop(P_201812, CARBON)  


# Mean Monthly Precipitation
#2000
CARBON_P_200001_mean <- cellStats(CARBON_P_200001, mean)
CARBON_P_200002_mean <- cellStats(CARBON_P_200002, mean)
CARBON_P_200003_mean <- cellStats(CARBON_P_200003, mean)
CARBON_P_200004_mean <- cellStats(CARBON_P_200004, mean)
CARBON_P_200005_mean <- cellStats(CARBON_P_200005, mean)
CARBON_P_200006_mean <- cellStats(CARBON_P_200006, mean)
CARBON_P_200007_mean <- cellStats(CARBON_P_200007, mean)
CARBON_P_200008_mean <- cellStats(CARBON_P_200008, mean)
CARBON_P_200009_mean <- cellStats(CARBON_P_200009, mean)
CARBON_P_200010_mean <- cellStats(CARBON_P_200010, mean)
CARBON_P_200011_mean <- cellStats(CARBON_P_200011, mean)
CARBON_P_200012_mean <- cellStats(CARBON_P_200012, mean)
#2001
CARBON_P_200101_mean <- cellStats(CARBON_P_200101, mean)
CARBON_P_200102_mean <- cellStats(CARBON_P_200102, mean)
CARBON_P_200103_mean <- cellStats(CARBON_P_200103, mean)
CARBON_P_200104_mean <- cellStats(CARBON_P_200104, mean)
CARBON_P_200105_mean <- cellStats(CARBON_P_200105, mean)
CARBON_P_200106_mean <- cellStats(CARBON_P_200106, mean)
CARBON_P_200107_mean <- cellStats(CARBON_P_200107, mean)
CARBON_P_200108_mean <- cellStats(CARBON_P_200108, mean)
CARBON_P_200109_mean <- cellStats(CARBON_P_200109, mean)
CARBON_P_200110_mean <- cellStats(CARBON_P_200110, mean)
CARBON_P_200111_mean <- cellStats(CARBON_P_200111, mean)
CARBON_P_200112_mean <- cellStats(CARBON_P_200112, mean)

#2002
CARBON_P_200201_mean <- cellStats(CARBON_P_200201, mean)
CARBON_P_200202_mean <- cellStats(CARBON_P_200202, mean)
CARBON_P_200203_mean <- cellStats(CARBON_P_200203, mean)
CARBON_P_200204_mean <- cellStats(CARBON_P_200204, mean)
CARBON_P_200205_mean <- cellStats(CARBON_P_200205, mean)
CARBON_P_200206_mean <- cellStats(CARBON_P_200206, mean)
CARBON_P_200207_mean <- cellStats(CARBON_P_200207, mean)
CARBON_P_200208_mean <- cellStats(CARBON_P_200208, mean)
CARBON_P_200209_mean <- cellStats(CARBON_P_200209, mean)
CARBON_P_200210_mean <- cellStats(CARBON_P_200210, mean)
CARBON_P_200211_mean <- cellStats(CARBON_P_200211, mean)
CARBON_P_200212_mean <- cellStats(CARBON_P_200212, mean)

#2003
CARBON_P_200301_mean <- cellStats(CARBON_P_200301, mean)
CARBON_P_200302_mean <- cellStats(CARBON_P_200302, mean)
CARBON_P_200303_mean <- cellStats(CARBON_P_200303, mean)
CARBON_P_200304_mean <- cellStats(CARBON_P_200304, mean)
CARBON_P_200305_mean <- cellStats(CARBON_P_200305, mean)
CARBON_P_200306_mean <- cellStats(CARBON_P_200306, mean)
CARBON_P_200307_mean <- cellStats(CARBON_P_200307, mean)
CARBON_P_200308_mean <- cellStats(CARBON_P_200308, mean)
CARBON_P_200309_mean <- cellStats(CARBON_P_200309, mean)
CARBON_P_200310_mean <- cellStats(CARBON_P_200310, mean)
CARBON_P_200311_mean <- cellStats(CARBON_P_200311, mean)
CARBON_P_200312_mean <- cellStats(CARBON_P_200312, mean)

#2004

CARBON_P_200401_mean <- cellStats(CARBON_P_200401, mean)
CARBON_P_200402_mean <- cellStats(CARBON_P_200402, mean)
CARBON_P_200403_mean <- cellStats(CARBON_P_200403, mean)
CARBON_P_200404_mean <- cellStats(CARBON_P_200404, mean)
CARBON_P_200405_mean <- cellStats(CARBON_P_200405, mean)
CARBON_P_200406_mean <- cellStats(CARBON_P_200406, mean)
CARBON_P_200407_mean <- cellStats(CARBON_P_200407, mean)
CARBON_P_200408_mean <- cellStats(CARBON_P_200408, mean)
CARBON_P_200409_mean <- cellStats(CARBON_P_200409, mean)
CARBON_P_200410_mean <- cellStats(CARBON_P_200410, mean)
CARBON_P_200411_mean <- cellStats(CARBON_P_200411, mean)
CARBON_P_200412_mean <- cellStats(CARBON_P_200412, mean)

#2005

CARBON_P_200501_mean <- cellStats(CARBON_P_200501, mean)
CARBON_P_200502_mean <- cellStats(CARBON_P_200502, mean)
CARBON_P_200503_mean <- cellStats(CARBON_P_200503, mean)
CARBON_P_200504_mean <- cellStats(CARBON_P_200504, mean)
CARBON_P_200505_mean <- cellStats(CARBON_P_200505, mean)
CARBON_P_200506_mean <- cellStats(CARBON_P_200506, mean)
CARBON_P_200507_mean <- cellStats(CARBON_P_200507, mean)
CARBON_P_200508_mean <- cellStats(CARBON_P_200508, mean)
CARBON_P_200509_mean <- cellStats(CARBON_P_200509, mean)
CARBON_P_200510_mean <- cellStats(CARBON_P_200510, mean)
CARBON_P_200511_mean <- cellStats(CARBON_P_200511, mean)
CARBON_P_200512_mean <- cellStats(CARBON_P_200512, mean)

#2006

CARBON_P_200601_mean <- cellStats(CARBON_P_200601, mean)
CARBON_P_200602_mean <- cellStats(CARBON_P_200602, mean)
CARBON_P_200603_mean <- cellStats(CARBON_P_200603, mean)
CARBON_P_200604_mean <- cellStats(CARBON_P_200604, mean)
CARBON_P_200605_mean <- cellStats(CARBON_P_200605, mean)
CARBON_P_200606_mean <- cellStats(CARBON_P_200606, mean)
CARBON_P_200607_mean <- cellStats(CARBON_P_200607, mean)
CARBON_P_200608_mean <- cellStats(CARBON_P_200608, mean)
CARBON_P_200609_mean <- cellStats(CARBON_P_200609, mean)
CARBON_P_200610_mean <- cellStats(CARBON_P_200610, mean)
CARBON_P_200611_mean <- cellStats(CARBON_P_200611, mean)
CARBON_P_200612_mean <- cellStats(CARBON_P_200612, mean)

#2007

CARBON_P_200701_mean <- cellStats(CARBON_P_200701, mean)
CARBON_P_200702_mean <- cellStats(CARBON_P_200702, mean)
CARBON_P_200703_mean <- cellStats(CARBON_P_200703, mean)
CARBON_P_200704_mean <- cellStats(CARBON_P_200704, mean)
CARBON_P_200705_mean <- cellStats(CARBON_P_200705, mean)
CARBON_P_200706_mean <- cellStats(CARBON_P_200706, mean)
CARBON_P_200707_mean <- cellStats(CARBON_P_200707, mean)
CARBON_P_200708_mean <- cellStats(CARBON_P_200708, mean)
CARBON_P_200709_mean <- cellStats(CARBON_P_200709, mean)
CARBON_P_200710_mean <- cellStats(CARBON_P_200710, mean)
CARBON_P_200711_mean <- cellStats(CARBON_P_200711, mean)
CARBON_P_200712_mean <- cellStats(CARBON_P_200712, mean)

#2008

CARBON_P_200801_mean <- cellStats(CARBON_P_200801, mean)
CARBON_P_200802_mean <- cellStats(CARBON_P_200802, mean)
CARBON_P_200803_mean <- cellStats(CARBON_P_200803, mean)
CARBON_P_200804_mean <- cellStats(CARBON_P_200804, mean)
CARBON_P_200805_mean <- cellStats(CARBON_P_200805, mean)
CARBON_P_200806_mean <- cellStats(CARBON_P_200806, mean)
CARBON_P_200807_mean <- cellStats(CARBON_P_200807, mean)
CARBON_P_200808_mean <- cellStats(CARBON_P_200808, mean)
CARBON_P_200809_mean <- cellStats(CARBON_P_200809, mean)
CARBON_P_200810_mean <- cellStats(CARBON_P_200810, mean)
CARBON_P_200811_mean <- cellStats(CARBON_P_200811, mean)
CARBON_P_200812_mean <- cellStats(CARBON_P_200812, mean)

#2009

CARBON_P_200901_mean <- cellStats(CARBON_P_200901, mean)
CARBON_P_200902_mean <- cellStats(CARBON_P_200902, mean)
CARBON_P_200903_mean <- cellStats(CARBON_P_200903, mean)
CARBON_P_200904_mean <- cellStats(CARBON_P_200904, mean)
CARBON_P_200905_mean <- cellStats(CARBON_P_200905, mean)
CARBON_P_200906_mean <- cellStats(CARBON_P_200906, mean)
CARBON_P_200907_mean <- cellStats(CARBON_P_200907, mean)
CARBON_P_200908_mean <- cellStats(CARBON_P_200908, mean)
CARBON_P_200909_mean <- cellStats(CARBON_P_200909, mean)
CARBON_P_200910_mean <- cellStats(CARBON_P_200910, mean)
CARBON_P_200911_mean <- cellStats(CARBON_P_200911, mean)
CARBON_P_200912_mean <- cellStats(CARBON_P_200912, mean)

#2010

CARBON_P_201001_mean <- cellStats(CARBON_P_201001, mean)
CARBON_P_201002_mean <- cellStats(CARBON_P_201002, mean)
CARBON_P_201003_mean <- cellStats(CARBON_P_201003, mean)
CARBON_P_201004_mean <- cellStats(CARBON_P_201004, mean)
CARBON_P_201005_mean <- cellStats(CARBON_P_201005, mean)
CARBON_P_201006_mean <- cellStats(CARBON_P_201006, mean)
CARBON_P_201007_mean <- cellStats(CARBON_P_201007, mean)
CARBON_P_201008_mean <- cellStats(CARBON_P_201008, mean)
CARBON_P_201009_mean <- cellStats(CARBON_P_201009, mean)
CARBON_P_201010_mean <- cellStats(CARBON_P_201010, mean)
CARBON_P_201011_mean <- cellStats(CARBON_P_201011, mean)
CARBON_P_201012_mean <- cellStats(CARBON_P_201012, mean)

#2011

CARBON_P_201101_mean <- cellStats(CARBON_P_201101, mean)
CARBON_P_201102_mean <- cellStats(CARBON_P_201102, mean)
CARBON_P_201103_mean <- cellStats(CARBON_P_201103, mean)
CARBON_P_201104_mean <- cellStats(CARBON_P_201104, mean)
CARBON_P_201105_mean <- cellStats(CARBON_P_201105, mean)
CARBON_P_201106_mean <- cellStats(CARBON_P_201106, mean)
CARBON_P_201107_mean <- cellStats(CARBON_P_201107, mean)
CARBON_P_201108_mean <- cellStats(CARBON_P_201108, mean)
CARBON_P_201109_mean <- cellStats(CARBON_P_201109, mean)
CARBON_P_201110_mean <- cellStats(CARBON_P_201110, mean)
CARBON_P_201111_mean <- cellStats(CARBON_P_201111, mean)
CARBON_P_201112_mean <- cellStats(CARBON_P_201112, mean)

#2012
CARBON_P_201201_mean <- cellStats(CARBON_P_201201, mean)
CARBON_P_201202_mean <- cellStats(CARBON_P_201202, mean)
CARBON_P_201203_mean <- cellStats(CARBON_P_201203, mean)
CARBON_P_201204_mean <- cellStats(CARBON_P_201204, mean)
CARBON_P_201205_mean <- cellStats(CARBON_P_201205, mean)
CARBON_P_201206_mean <- cellStats(CARBON_P_201206, mean)
CARBON_P_201207_mean <- cellStats(CARBON_P_201207, mean)
CARBON_P_201208_mean <- cellStats(CARBON_P_201208, mean)
CARBON_P_201209_mean <- cellStats(CARBON_P_201209, mean)
CARBON_P_201210_mean <- cellStats(CARBON_P_201210, mean)
CARBON_P_201211_mean <- cellStats(CARBON_P_201211, mean)
CARBON_P_201212_mean <- cellStats(CARBON_P_201212, mean)

#2013
CARBON_P_201301_mean <- cellStats(CARBON_P_201301, mean)
CARBON_P_201302_mean <- cellStats(CARBON_P_201302, mean)
CARBON_P_201303_mean <- cellStats(CARBON_P_201303, mean)
CARBON_P_201304_mean <- cellStats(CARBON_P_201304, mean)
CARBON_P_201305_mean <- cellStats(CARBON_P_201305, mean)
CARBON_P_201306_mean <- cellStats(CARBON_P_201306, mean)
CARBON_P_201307_mean <- cellStats(CARBON_P_201307, mean)
CARBON_P_201308_mean <- cellStats(CARBON_P_201308, mean)
CARBON_P_201309_mean <- cellStats(CARBON_P_201309, mean)
CARBON_P_201310_mean <- cellStats(CARBON_P_201310, mean)
CARBON_P_201311_mean <- cellStats(CARBON_P_201311, mean)
CARBON_P_201312_mean <- cellStats(CARBON_P_201312, mean)

#2014
CARBON_P_201401_mean <- cellStats(CARBON_P_201401, mean)
CARBON_P_201402_mean <- cellStats(CARBON_P_201402, mean)
CARBON_P_201403_mean <- cellStats(CARBON_P_201403, mean)
CARBON_P_201404_mean <- cellStats(CARBON_P_201404, mean)
CARBON_P_201405_mean <- cellStats(CARBON_P_201405, mean)
CARBON_P_201406_mean <- cellStats(CARBON_P_201406, mean)
CARBON_P_201407_mean <- cellStats(CARBON_P_201407, mean)
CARBON_P_201408_mean <- cellStats(CARBON_P_201408, mean)
CARBON_P_201409_mean <- cellStats(CARBON_P_201409, mean)
CARBON_P_201410_mean <- cellStats(CARBON_P_201410, mean)
CARBON_P_201411_mean <- cellStats(CARBON_P_201411, mean)
CARBON_P_201412_mean <- cellStats(CARBON_P_201412, mean)

#2015
CARBON_P_201501_mean <- cellStats(CARBON_P_201501, mean)
CARBON_P_201502_mean <- cellStats(CARBON_P_201502, mean)
CARBON_P_201503_mean <- cellStats(CARBON_P_201503, mean)
CARBON_P_201504_mean <- cellStats(CARBON_P_201504, mean)
CARBON_P_201505_mean <- cellStats(CARBON_P_201505, mean)
CARBON_P_201506_mean <- cellStats(CARBON_P_201506, mean)
CARBON_P_201507_mean <- cellStats(CARBON_P_201507, mean)
CARBON_P_201508_mean <- cellStats(CARBON_P_201508, mean)
CARBON_P_201509_mean <- cellStats(CARBON_P_201509, mean)
CARBON_P_201510_mean <- cellStats(CARBON_P_201510, mean)
CARBON_P_201511_mean <- cellStats(CARBON_P_201511, mean)
CARBON_P_201512_mean <- cellStats(CARBON_P_201512, mean)

#2016
CARBON_P_201601_mean <- cellStats(CARBON_P_201601, mean)
CARBON_P_201602_mean <- cellStats(CARBON_P_201602, mean)
CARBON_P_201603_mean <- cellStats(CARBON_P_201603, mean)
CARBON_P_201604_mean <- cellStats(CARBON_P_201604, mean)
CARBON_P_201605_mean <- cellStats(CARBON_P_201605, mean)
CARBON_P_201606_mean <- cellStats(CARBON_P_201606, mean)
CARBON_P_201607_mean <- cellStats(CARBON_P_201607, mean)
CARBON_P_201608_mean <- cellStats(CARBON_P_201608, mean)
CARBON_P_201609_mean <- cellStats(CARBON_P_201609, mean)
CARBON_P_201610_mean <- cellStats(CARBON_P_201610, mean)
CARBON_P_201611_mean <- cellStats(CARBON_P_201611, mean)
CARBON_P_201612_mean <- cellStats(CARBON_P_201612, mean)

#2017
CARBON_P_201701_mean <- cellStats(CARBON_P_201701, mean)
CARBON_P_201702_mean <- cellStats(CARBON_P_201702, mean)
CARBON_P_201703_mean <- cellStats(CARBON_P_201703, mean)
CARBON_P_201704_mean <- cellStats(CARBON_P_201704, mean)
CARBON_P_201705_mean <- cellStats(CARBON_P_201705, mean)
CARBON_P_201706_mean <- cellStats(CARBON_P_201706, mean)
CARBON_P_201707_mean <- cellStats(CARBON_P_201707, mean)
CARBON_P_201708_mean <- cellStats(CARBON_P_201708, mean)
CARBON_P_201709_mean <- cellStats(CARBON_P_201709, mean)
CARBON_P_201710_mean <- cellStats(CARBON_P_201710, mean)
CARBON_P_201711_mean <- cellStats(CARBON_P_201711, mean)
CARBON_P_201712_mean <- cellStats(CARBON_P_201712, mean)

#2018
CARBON_P_201801_mean <- cellStats(CARBON_P_201801, mean)
CARBON_P_201802_mean <- cellStats(CARBON_P_201802, mean)
CARBON_P_201803_mean <- cellStats(CARBON_P_201803, mean)
CARBON_P_201804_mean <- cellStats(CARBON_P_201804, mean)
CARBON_P_201805_mean <- cellStats(CARBON_P_201805, mean)
CARBON_P_201806_mean <- cellStats(CARBON_P_201806, mean)
CARBON_P_201807_mean <- cellStats(CARBON_P_201807, mean)
CARBON_P_201808_mean <- cellStats(CARBON_P_201808, mean)
CARBON_P_201809_mean <- cellStats(CARBON_P_201809, mean)
CARBON_P_201810_mean <- cellStats(CARBON_P_201810, mean)
CARBON_P_201811_mean <- cellStats(CARBON_P_201811, mean)
CARBON_P_201812_mean <- cellStats(CARBON_P_201812, mean)

# DAVIS

#2000
DAVIS_P_200001 <- crop(P_200001, DAVIS) 
DAVIS_P_200002 <- crop(P_200002, DAVIS)
DAVIS_P_200003 <- crop(P_200003, DAVIS)
DAVIS_P_200004 <- crop(P_200004, DAVIS)
DAVIS_P_200005 <- crop(P_200005, DAVIS)
DAVIS_P_200006 <- crop(P_200006, DAVIS)  
DAVIS_P_200007 <- crop(P_200007, DAVIS)  
DAVIS_P_200008 <- crop(P_200008, DAVIS)  
DAVIS_P_200009 <- crop(P_200009, DAVIS)  
DAVIS_P_200010 <- crop(P_200010, DAVIS)  
DAVIS_P_200011 <- crop(P_200011, DAVIS)  
DAVIS_P_200012 <- crop(P_200012, DAVIS)  
#2001
DAVIS_P_200101 <- crop(P_200101, DAVIS) 
DAVIS_P_200102 <- crop(P_200102, DAVIS)
DAVIS_P_200103 <- crop(P_200103, DAVIS)
DAVIS_P_200104 <- crop(P_200104, DAVIS)
DAVIS_P_200105 <- crop(P_200105, DAVIS)
DAVIS_P_200106 <- crop(P_200106, DAVIS)  
DAVIS_P_200107 <- crop(P_200107, DAVIS)  
DAVIS_P_200108 <- crop(P_200108, DAVIS)  
DAVIS_P_200109 <- crop(P_200109, DAVIS)  
DAVIS_P_200110 <- crop(P_200110, DAVIS)  
DAVIS_P_200111 <- crop(P_200111, DAVIS)  
DAVIS_P_200112 <- crop(P_200112, DAVIS)  

#2002
DAVIS_P_200201 <- crop(P_200201, DAVIS) 
DAVIS_P_200202 <- crop(P_200202, DAVIS)
DAVIS_P_200203 <- crop(P_200203, DAVIS)
DAVIS_P_200204 <- crop(P_200204, DAVIS)
DAVIS_P_200205 <- crop(P_200205, DAVIS)
DAVIS_P_200206 <- crop(P_200206, DAVIS)  
DAVIS_P_200207 <- crop(P_200207, DAVIS)  
DAVIS_P_200208 <- crop(P_200208, DAVIS)  
DAVIS_P_200209 <- crop(P_200209, DAVIS)  
DAVIS_P_200210 <- crop(P_200210, DAVIS)  
DAVIS_P_200211 <- crop(P_200211, DAVIS)  
DAVIS_P_200212 <- crop(P_200212, DAVIS)  
#2003
DAVIS_P_200301 <- crop(P_200301, DAVIS) 
DAVIS_P_200302 <- crop(P_200302, DAVIS)
DAVIS_P_200303 <- crop(P_200303, DAVIS)
DAVIS_P_200304 <- crop(P_200304, DAVIS)
DAVIS_P_200305 <- crop(P_200305, DAVIS)
DAVIS_P_200306 <- crop(P_200306, DAVIS)  
DAVIS_P_200307 <- crop(P_200307, DAVIS)  
DAVIS_P_200308 <- crop(P_200308, DAVIS)  
DAVIS_P_200309 <- crop(P_200309, DAVIS)  
DAVIS_P_200310 <- crop(P_200310, DAVIS)  
DAVIS_P_200311 <- crop(P_200311, DAVIS)  
DAVIS_P_200312 <- crop(P_200312, DAVIS)  
#2004
DAVIS_P_200401 <- crop(P_200401, DAVIS) 
DAVIS_P_200402 <- crop(P_200402, DAVIS)
DAVIS_P_200403 <- crop(P_200403, DAVIS)
DAVIS_P_200404 <- crop(P_200404, DAVIS)
DAVIS_P_200405 <- crop(P_200405, DAVIS)
DAVIS_P_200406 <- crop(P_200406, DAVIS)  
DAVIS_P_200407 <- crop(P_200407, DAVIS)  
DAVIS_P_200408 <- crop(P_200408, DAVIS)  
DAVIS_P_200409 <- crop(P_200409, DAVIS)  
DAVIS_P_200410 <- crop(P_200410, DAVIS)  
DAVIS_P_200411 <- crop(P_200411, DAVIS)  
DAVIS_P_200412 <- crop(P_200412, DAVIS)  
#2005
DAVIS_P_200501 <- crop(P_200501, DAVIS) 
DAVIS_P_200502 <- crop(P_200502, DAVIS)
DAVIS_P_200503 <- crop(P_200503, DAVIS)
DAVIS_P_200504 <- crop(P_200504, DAVIS)
DAVIS_P_200505 <- crop(P_200505, DAVIS)
DAVIS_P_200506 <- crop(P_200506, DAVIS)  
DAVIS_P_200507 <- crop(P_200507, DAVIS)  
DAVIS_P_200508 <- crop(P_200508, DAVIS)  
DAVIS_P_200509 <- crop(P_200509, DAVIS)  
DAVIS_P_200510 <- crop(P_200510, DAVIS)  
DAVIS_P_200511 <- crop(P_200511, DAVIS)  
DAVIS_P_200512 <- crop(P_200512, DAVIS)  
#2006
DAVIS_P_200601 <- crop(P_200601, DAVIS) 
DAVIS_P_200602 <- crop(P_200602, DAVIS)
DAVIS_P_200603 <- crop(P_200603, DAVIS)
DAVIS_P_200604 <- crop(P_200604, DAVIS)
DAVIS_P_200605 <- crop(P_200605, DAVIS)
DAVIS_P_200606 <- crop(P_200606, DAVIS)  
DAVIS_P_200607 <- crop(P_200607, DAVIS)  
DAVIS_P_200608 <- crop(P_200608, DAVIS)  
DAVIS_P_200609 <- crop(P_200609, DAVIS)  
DAVIS_P_200610 <- crop(P_200610, DAVIS)  
DAVIS_P_200611 <- crop(P_200611, DAVIS)  
DAVIS_P_200612 <- crop(P_200612, DAVIS)  
#2007
DAVIS_P_200701 <- crop(P_200701, DAVIS) 
DAVIS_P_200702 <- crop(P_200702, DAVIS)
DAVIS_P_200703 <- crop(P_200703, DAVIS)
DAVIS_P_200704 <- crop(P_200704, DAVIS)
DAVIS_P_200705 <- crop(P_200705, DAVIS)
DAVIS_P_200706 <- crop(P_200706, DAVIS)  
DAVIS_P_200707 <- crop(P_200707, DAVIS)  
DAVIS_P_200708 <- crop(P_200708, DAVIS)  
DAVIS_P_200709 <- crop(P_200709, DAVIS)  
DAVIS_P_200710 <- crop(P_200710, DAVIS)  
DAVIS_P_200711 <- crop(P_200711, DAVIS)  
DAVIS_P_200712 <- crop(P_200712, DAVIS)  
#2008
DAVIS_P_200801 <- crop(P_200801, DAVIS) 
DAVIS_P_200802 <- crop(P_200802, DAVIS)
DAVIS_P_200803 <- crop(P_200803, DAVIS)
DAVIS_P_200804 <- crop(P_200804, DAVIS)
DAVIS_P_200805 <- crop(P_200805, DAVIS)
DAVIS_P_200806 <- crop(P_200806, DAVIS)  
DAVIS_P_200807 <- crop(P_200807, DAVIS)  
DAVIS_P_200808 <- crop(P_200808, DAVIS)  
DAVIS_P_200809 <- crop(P_200809, DAVIS)  
DAVIS_P_200810 <- crop(P_200810, DAVIS)  
DAVIS_P_200811 <- crop(P_200811, DAVIS)  
DAVIS_P_200812 <- crop(P_200812, DAVIS)  
#2009
DAVIS_P_200901 <- crop(P_200901, DAVIS) 
DAVIS_P_200902 <- crop(P_200902, DAVIS)
DAVIS_P_200903 <- crop(P_200903, DAVIS)
DAVIS_P_200904 <- crop(P_200904, DAVIS)
DAVIS_P_200905 <- crop(P_200905, DAVIS)
DAVIS_P_200906 <- crop(P_200906, DAVIS)  
DAVIS_P_200907 <- crop(P_200907, DAVIS)  
DAVIS_P_200908 <- crop(P_200908, DAVIS)  
DAVIS_P_200909 <- crop(P_200909, DAVIS)  
DAVIS_P_200910 <- crop(P_200910, DAVIS)  
DAVIS_P_200911 <- crop(P_200911, DAVIS)  
DAVIS_P_200912 <- crop(P_200912, DAVIS)  
#2010
DAVIS_P_201001 <- crop(P_201001, DAVIS) 
DAVIS_P_201002 <- crop(P_201002, DAVIS)
DAVIS_P_201003 <- crop(P_201003, DAVIS)
DAVIS_P_201004 <- crop(P_201004, DAVIS)
DAVIS_P_201005 <- crop(P_201005, DAVIS)
DAVIS_P_201006 <- crop(P_201006, DAVIS)  
DAVIS_P_201007 <- crop(P_201007, DAVIS)  
DAVIS_P_201008 <- crop(P_201008, DAVIS)  
DAVIS_P_201009 <- crop(P_201009, DAVIS)  
DAVIS_P_201010 <- crop(P_201010, DAVIS)  
DAVIS_P_201011 <- crop(P_201011, DAVIS)  
DAVIS_P_201012 <- crop(P_201012, DAVIS)  
#2011
DAVIS_P_201101 <- crop(P_201101, DAVIS) 
DAVIS_P_201102 <- crop(P_201102, DAVIS)
DAVIS_P_201103 <- crop(P_201103, DAVIS)
DAVIS_P_201104 <- crop(P_201104, DAVIS)
DAVIS_P_201105 <- crop(P_201105, DAVIS)
DAVIS_P_201106 <- crop(P_201106, DAVIS)  
DAVIS_P_201107 <- crop(P_201107, DAVIS)  
DAVIS_P_201108 <- crop(P_201108, DAVIS)  
DAVIS_P_201109 <- crop(P_201109, DAVIS)  
DAVIS_P_201110 <- crop(P_201110, DAVIS)  
DAVIS_P_201111 <- crop(P_201111, DAVIS)  
DAVIS_P_201112 <- crop(P_201112, DAVIS)  
#2012
DAVIS_P_201201 <- crop(P_201201, DAVIS) 
DAVIS_P_201202 <- crop(P_201202, DAVIS)
DAVIS_P_201203 <- crop(P_201203, DAVIS)
DAVIS_P_201204 <- crop(P_201204, DAVIS)
DAVIS_P_201205 <- crop(P_201205, DAVIS)
DAVIS_P_201206 <- crop(P_201206, DAVIS)  
DAVIS_P_201207 <- crop(P_201207, DAVIS)  
DAVIS_P_201208 <- crop(P_201208, DAVIS)  
DAVIS_P_201209 <- crop(P_201209, DAVIS)  
DAVIS_P_201210 <- crop(P_201210, DAVIS)  
DAVIS_P_201211 <- crop(P_201211, DAVIS)  
DAVIS_P_201212 <- crop(P_201212, DAVIS)  
#2013
DAVIS_P_201301 <- crop(P_201301, DAVIS) 
DAVIS_P_201302 <- crop(P_201302, DAVIS)
DAVIS_P_201303 <- crop(P_201303, DAVIS)
DAVIS_P_201304 <- crop(P_201304, DAVIS)
DAVIS_P_201305 <- crop(P_201305, DAVIS)
DAVIS_P_201306 <- crop(P_201306, DAVIS)  
DAVIS_P_201307 <- crop(P_201307, DAVIS)  
DAVIS_P_201308 <- crop(P_201308, DAVIS)  
DAVIS_P_201309 <- crop(P_201309, DAVIS)  
DAVIS_P_201310 <- crop(P_201310, DAVIS)  
DAVIS_P_201311 <- crop(P_201311, DAVIS)  
DAVIS_P_201312 <- crop(P_201312, DAVIS)  
#2014
DAVIS_P_201401 <- crop(P_201401, DAVIS) 
DAVIS_P_201402 <- crop(P_201402, DAVIS)
DAVIS_P_201403 <- crop(P_201403, DAVIS)
DAVIS_P_201404 <- crop(P_201404, DAVIS)
DAVIS_P_201405 <- crop(P_201405, DAVIS)
DAVIS_P_201406 <- crop(P_201406, DAVIS)  
DAVIS_P_201407 <- crop(P_201407, DAVIS)  
DAVIS_P_201408 <- crop(P_201408, DAVIS)  
DAVIS_P_201409 <- crop(P_201409, DAVIS)  
DAVIS_P_201410 <- crop(P_201410, DAVIS)  
DAVIS_P_201411 <- crop(P_201411, DAVIS)  
DAVIS_P_201412 <- crop(P_201412, DAVIS)  
#2015
DAVIS_P_201501 <- crop(P_201501, DAVIS) 
DAVIS_P_201502 <- crop(P_201502, DAVIS)
DAVIS_P_201503 <- crop(P_201503, DAVIS)
DAVIS_P_201504 <- crop(P_201504, DAVIS)
DAVIS_P_201505 <- crop(P_201505, DAVIS)
DAVIS_P_201506 <- crop(P_201506, DAVIS)  
DAVIS_P_201507 <- crop(P_201507, DAVIS)  
DAVIS_P_201508 <- crop(P_201508, DAVIS)  
DAVIS_P_201509 <- crop(P_201509, DAVIS)  
DAVIS_P_201510 <- crop(P_201510, DAVIS)  
DAVIS_P_201511 <- crop(P_201511, DAVIS)  
DAVIS_P_201512 <- crop(P_201512, DAVIS)  
#2016
DAVIS_P_201601 <- crop(P_201601, DAVIS) 
DAVIS_P_201602 <- crop(P_201602, DAVIS)
DAVIS_P_201603 <- crop(P_201603, DAVIS)
DAVIS_P_201604 <- crop(P_201604, DAVIS)
DAVIS_P_201605 <- crop(P_201605, DAVIS)
DAVIS_P_201606 <- crop(P_201606, DAVIS)  
DAVIS_P_201607 <- crop(P_201607, DAVIS)  
DAVIS_P_201608 <- crop(P_201608, DAVIS)  
DAVIS_P_201609 <- crop(P_201609, DAVIS)  
DAVIS_P_201610 <- crop(P_201610, DAVIS)  
DAVIS_P_201611 <- crop(P_201611, DAVIS)  
DAVIS_P_201612 <- crop(P_201612, DAVIS)  
#2017
DAVIS_P_201701 <- crop(P_201701, DAVIS) 
DAVIS_P_201702 <- crop(P_201702, DAVIS)
DAVIS_P_201703 <- crop(P_201703, DAVIS)
DAVIS_P_201704 <- crop(P_201704, DAVIS)
DAVIS_P_201705 <- crop(P_201705, DAVIS)
DAVIS_P_201706 <- crop(P_201706, DAVIS)  
DAVIS_P_201707 <- crop(P_201707, DAVIS)  
DAVIS_P_201708 <- crop(P_201708, DAVIS)  
DAVIS_P_201709 <- crop(P_201709, DAVIS)  
DAVIS_P_201710 <- crop(P_201710, DAVIS)  
DAVIS_P_201711 <- crop(P_201711, DAVIS)  
DAVIS_P_201712 <- crop(P_201712, DAVIS)  

#2018

DAVIS_P_201801 <- crop(P_201801, DAVIS) 
DAVIS_P_201802 <- crop(P_201802, DAVIS)
DAVIS_P_201803 <- crop(P_201803, DAVIS)
DAVIS_P_201804 <- crop(P_201804, DAVIS)
DAVIS_P_201805 <- crop(P_201805, DAVIS)
DAVIS_P_201806 <- crop(P_201806, DAVIS)  
DAVIS_P_201807 <- crop(P_201807, DAVIS)  
DAVIS_P_201808 <- crop(P_201808, DAVIS)  
DAVIS_P_201809 <- crop(P_201809, DAVIS)  
DAVIS_P_201810 <- crop(P_201810, DAVIS)  
DAVIS_P_201811 <- crop(P_201811, DAVIS)  
DAVIS_P_201812 <- crop(P_201812, DAVIS)  


# Mean Monthly Precipitation
#2000
DAVIS_P_200001_mean <- cellStats(DAVIS_P_200001, mean)
DAVIS_P_200002_mean <- cellStats(DAVIS_P_200002, mean)
DAVIS_P_200003_mean <- cellStats(DAVIS_P_200003, mean)
DAVIS_P_200004_mean <- cellStats(DAVIS_P_200004, mean)
DAVIS_P_200005_mean <- cellStats(DAVIS_P_200005, mean)
DAVIS_P_200006_mean <- cellStats(DAVIS_P_200006, mean)
DAVIS_P_200007_mean <- cellStats(DAVIS_P_200007, mean)
DAVIS_P_200008_mean <- cellStats(DAVIS_P_200008, mean)
DAVIS_P_200009_mean <- cellStats(DAVIS_P_200009, mean)
DAVIS_P_200010_mean <- cellStats(DAVIS_P_200010, mean)
DAVIS_P_200011_mean <- cellStats(DAVIS_P_200011, mean)
DAVIS_P_200012_mean <- cellStats(DAVIS_P_200012, mean)
#2001
DAVIS_P_200101_mean <- cellStats(DAVIS_P_200101, mean)
DAVIS_P_200102_mean <- cellStats(DAVIS_P_200102, mean)
DAVIS_P_200103_mean <- cellStats(DAVIS_P_200103, mean)
DAVIS_P_200104_mean <- cellStats(DAVIS_P_200104, mean)
DAVIS_P_200105_mean <- cellStats(DAVIS_P_200105, mean)
DAVIS_P_200106_mean <- cellStats(DAVIS_P_200106, mean)
DAVIS_P_200107_mean <- cellStats(DAVIS_P_200107, mean)
DAVIS_P_200108_mean <- cellStats(DAVIS_P_200108, mean)
DAVIS_P_200109_mean <- cellStats(DAVIS_P_200109, mean)
DAVIS_P_200110_mean <- cellStats(DAVIS_P_200110, mean)
DAVIS_P_200111_mean <- cellStats(DAVIS_P_200111, mean)
DAVIS_P_200112_mean <- cellStats(DAVIS_P_200112, mean)

#2002
DAVIS_P_200201_mean <- cellStats(DAVIS_P_200201, mean)
DAVIS_P_200202_mean <- cellStats(DAVIS_P_200202, mean)
DAVIS_P_200203_mean <- cellStats(DAVIS_P_200203, mean)
DAVIS_P_200204_mean <- cellStats(DAVIS_P_200204, mean)
DAVIS_P_200205_mean <- cellStats(DAVIS_P_200205, mean)
DAVIS_P_200206_mean <- cellStats(DAVIS_P_200206, mean)
DAVIS_P_200207_mean <- cellStats(DAVIS_P_200207, mean)
DAVIS_P_200208_mean <- cellStats(DAVIS_P_200208, mean)
DAVIS_P_200209_mean <- cellStats(DAVIS_P_200209, mean)
DAVIS_P_200210_mean <- cellStats(DAVIS_P_200210, mean)
DAVIS_P_200211_mean <- cellStats(DAVIS_P_200211, mean)
DAVIS_P_200212_mean <- cellStats(DAVIS_P_200212, mean)

#2003
DAVIS_P_200301_mean <- cellStats(DAVIS_P_200301, mean)
DAVIS_P_200302_mean <- cellStats(DAVIS_P_200302, mean)
DAVIS_P_200303_mean <- cellStats(DAVIS_P_200303, mean)
DAVIS_P_200304_mean <- cellStats(DAVIS_P_200304, mean)
DAVIS_P_200305_mean <- cellStats(DAVIS_P_200305, mean)
DAVIS_P_200306_mean <- cellStats(DAVIS_P_200306, mean)
DAVIS_P_200307_mean <- cellStats(DAVIS_P_200307, mean)
DAVIS_P_200308_mean <- cellStats(DAVIS_P_200308, mean)
DAVIS_P_200309_mean <- cellStats(DAVIS_P_200309, mean)
DAVIS_P_200310_mean <- cellStats(DAVIS_P_200310, mean)
DAVIS_P_200311_mean <- cellStats(DAVIS_P_200311, mean)
DAVIS_P_200312_mean <- cellStats(DAVIS_P_200312, mean)

#2004

DAVIS_P_200401_mean <- cellStats(DAVIS_P_200401, mean)
DAVIS_P_200402_mean <- cellStats(DAVIS_P_200402, mean)
DAVIS_P_200403_mean <- cellStats(DAVIS_P_200403, mean)
DAVIS_P_200404_mean <- cellStats(DAVIS_P_200404, mean)
DAVIS_P_200405_mean <- cellStats(DAVIS_P_200405, mean)
DAVIS_P_200406_mean <- cellStats(DAVIS_P_200406, mean)
DAVIS_P_200407_mean <- cellStats(DAVIS_P_200407, mean)
DAVIS_P_200408_mean <- cellStats(DAVIS_P_200408, mean)
DAVIS_P_200409_mean <- cellStats(DAVIS_P_200409, mean)
DAVIS_P_200410_mean <- cellStats(DAVIS_P_200410, mean)
DAVIS_P_200411_mean <- cellStats(DAVIS_P_200411, mean)
DAVIS_P_200412_mean <- cellStats(DAVIS_P_200412, mean)

#2005

DAVIS_P_200501_mean <- cellStats(DAVIS_P_200501, mean)
DAVIS_P_200502_mean <- cellStats(DAVIS_P_200502, mean)
DAVIS_P_200503_mean <- cellStats(DAVIS_P_200503, mean)
DAVIS_P_200504_mean <- cellStats(DAVIS_P_200504, mean)
DAVIS_P_200505_mean <- cellStats(DAVIS_P_200505, mean)
DAVIS_P_200506_mean <- cellStats(DAVIS_P_200506, mean)
DAVIS_P_200507_mean <- cellStats(DAVIS_P_200507, mean)
DAVIS_P_200508_mean <- cellStats(DAVIS_P_200508, mean)
DAVIS_P_200509_mean <- cellStats(DAVIS_P_200509, mean)
DAVIS_P_200510_mean <- cellStats(DAVIS_P_200510, mean)
DAVIS_P_200511_mean <- cellStats(DAVIS_P_200511, mean)
DAVIS_P_200512_mean <- cellStats(DAVIS_P_200512, mean)

#2006

DAVIS_P_200601_mean <- cellStats(DAVIS_P_200601, mean)
DAVIS_P_200602_mean <- cellStats(DAVIS_P_200602, mean)
DAVIS_P_200603_mean <- cellStats(DAVIS_P_200603, mean)
DAVIS_P_200604_mean <- cellStats(DAVIS_P_200604, mean)
DAVIS_P_200605_mean <- cellStats(DAVIS_P_200605, mean)
DAVIS_P_200606_mean <- cellStats(DAVIS_P_200606, mean)
DAVIS_P_200607_mean <- cellStats(DAVIS_P_200607, mean)
DAVIS_P_200608_mean <- cellStats(DAVIS_P_200608, mean)
DAVIS_P_200609_mean <- cellStats(DAVIS_P_200609, mean)
DAVIS_P_200610_mean <- cellStats(DAVIS_P_200610, mean)
DAVIS_P_200611_mean <- cellStats(DAVIS_P_200611, mean)
DAVIS_P_200612_mean <- cellStats(DAVIS_P_200612, mean)

#2007

DAVIS_P_200701_mean <- cellStats(DAVIS_P_200701, mean)
DAVIS_P_200702_mean <- cellStats(DAVIS_P_200702, mean)
DAVIS_P_200703_mean <- cellStats(DAVIS_P_200703, mean)
DAVIS_P_200704_mean <- cellStats(DAVIS_P_200704, mean)
DAVIS_P_200705_mean <- cellStats(DAVIS_P_200705, mean)
DAVIS_P_200706_mean <- cellStats(DAVIS_P_200706, mean)
DAVIS_P_200707_mean <- cellStats(DAVIS_P_200707, mean)
DAVIS_P_200708_mean <- cellStats(DAVIS_P_200708, mean)
DAVIS_P_200709_mean <- cellStats(DAVIS_P_200709, mean)
DAVIS_P_200710_mean <- cellStats(DAVIS_P_200710, mean)
DAVIS_P_200711_mean <- cellStats(DAVIS_P_200711, mean)
DAVIS_P_200712_mean <- cellStats(DAVIS_P_200712, mean)

#2008

DAVIS_P_200801_mean <- cellStats(DAVIS_P_200801, mean)
DAVIS_P_200802_mean <- cellStats(DAVIS_P_200802, mean)
DAVIS_P_200803_mean <- cellStats(DAVIS_P_200803, mean)
DAVIS_P_200804_mean <- cellStats(DAVIS_P_200804, mean)
DAVIS_P_200805_mean <- cellStats(DAVIS_P_200805, mean)
DAVIS_P_200806_mean <- cellStats(DAVIS_P_200806, mean)
DAVIS_P_200807_mean <- cellStats(DAVIS_P_200807, mean)
DAVIS_P_200808_mean <- cellStats(DAVIS_P_200808, mean)
DAVIS_P_200809_mean <- cellStats(DAVIS_P_200809, mean)
DAVIS_P_200810_mean <- cellStats(DAVIS_P_200810, mean)
DAVIS_P_200811_mean <- cellStats(DAVIS_P_200811, mean)
DAVIS_P_200812_mean <- cellStats(DAVIS_P_200812, mean)

#2009

DAVIS_P_200901_mean <- cellStats(DAVIS_P_200901, mean)
DAVIS_P_200902_mean <- cellStats(DAVIS_P_200902, mean)
DAVIS_P_200903_mean <- cellStats(DAVIS_P_200903, mean)
DAVIS_P_200904_mean <- cellStats(DAVIS_P_200904, mean)
DAVIS_P_200905_mean <- cellStats(DAVIS_P_200905, mean)
DAVIS_P_200906_mean <- cellStats(DAVIS_P_200906, mean)
DAVIS_P_200907_mean <- cellStats(DAVIS_P_200907, mean)
DAVIS_P_200908_mean <- cellStats(DAVIS_P_200908, mean)
DAVIS_P_200909_mean <- cellStats(DAVIS_P_200909, mean)
DAVIS_P_200910_mean <- cellStats(DAVIS_P_200910, mean)
DAVIS_P_200911_mean <- cellStats(DAVIS_P_200911, mean)
DAVIS_P_200912_mean <- cellStats(DAVIS_P_200912, mean)

#2010

DAVIS_P_201001_mean <- cellStats(DAVIS_P_201001, mean)
DAVIS_P_201002_mean <- cellStats(DAVIS_P_201002, mean)
DAVIS_P_201003_mean <- cellStats(DAVIS_P_201003, mean)
DAVIS_P_201004_mean <- cellStats(DAVIS_P_201004, mean)
DAVIS_P_201005_mean <- cellStats(DAVIS_P_201005, mean)
DAVIS_P_201006_mean <- cellStats(DAVIS_P_201006, mean)
DAVIS_P_201007_mean <- cellStats(DAVIS_P_201007, mean)
DAVIS_P_201008_mean <- cellStats(DAVIS_P_201008, mean)
DAVIS_P_201009_mean <- cellStats(DAVIS_P_201009, mean)
DAVIS_P_201010_mean <- cellStats(DAVIS_P_201010, mean)
DAVIS_P_201011_mean <- cellStats(DAVIS_P_201011, mean)
DAVIS_P_201012_mean <- cellStats(DAVIS_P_201012, mean)

#2011

DAVIS_P_201101_mean <- cellStats(DAVIS_P_201101, mean)
DAVIS_P_201102_mean <- cellStats(DAVIS_P_201102, mean)
DAVIS_P_201103_mean <- cellStats(DAVIS_P_201103, mean)
DAVIS_P_201104_mean <- cellStats(DAVIS_P_201104, mean)
DAVIS_P_201105_mean <- cellStats(DAVIS_P_201105, mean)
DAVIS_P_201106_mean <- cellStats(DAVIS_P_201106, mean)
DAVIS_P_201107_mean <- cellStats(DAVIS_P_201107, mean)
DAVIS_P_201108_mean <- cellStats(DAVIS_P_201108, mean)
DAVIS_P_201109_mean <- cellStats(DAVIS_P_201109, mean)
DAVIS_P_201110_mean <- cellStats(DAVIS_P_201110, mean)
DAVIS_P_201111_mean <- cellStats(DAVIS_P_201111, mean)
DAVIS_P_201112_mean <- cellStats(DAVIS_P_201112, mean)

#2012
DAVIS_P_201201_mean <- cellStats(DAVIS_P_201201, mean)
DAVIS_P_201202_mean <- cellStats(DAVIS_P_201202, mean)
DAVIS_P_201203_mean <- cellStats(DAVIS_P_201203, mean)
DAVIS_P_201204_mean <- cellStats(DAVIS_P_201204, mean)
DAVIS_P_201205_mean <- cellStats(DAVIS_P_201205, mean)
DAVIS_P_201206_mean <- cellStats(DAVIS_P_201206, mean)
DAVIS_P_201207_mean <- cellStats(DAVIS_P_201207, mean)
DAVIS_P_201208_mean <- cellStats(DAVIS_P_201208, mean)
DAVIS_P_201209_mean <- cellStats(DAVIS_P_201209, mean)
DAVIS_P_201210_mean <- cellStats(DAVIS_P_201210, mean)
DAVIS_P_201211_mean <- cellStats(DAVIS_P_201211, mean)
DAVIS_P_201212_mean <- cellStats(DAVIS_P_201212, mean)

#2013
DAVIS_P_201301_mean <- cellStats(DAVIS_P_201301, mean)
DAVIS_P_201302_mean <- cellStats(DAVIS_P_201302, mean)
DAVIS_P_201303_mean <- cellStats(DAVIS_P_201303, mean)
DAVIS_P_201304_mean <- cellStats(DAVIS_P_201304, mean)
DAVIS_P_201305_mean <- cellStats(DAVIS_P_201305, mean)
DAVIS_P_201306_mean <- cellStats(DAVIS_P_201306, mean)
DAVIS_P_201307_mean <- cellStats(DAVIS_P_201307, mean)
DAVIS_P_201308_mean <- cellStats(DAVIS_P_201308, mean)
DAVIS_P_201309_mean <- cellStats(DAVIS_P_201309, mean)
DAVIS_P_201310_mean <- cellStats(DAVIS_P_201310, mean)
DAVIS_P_201311_mean <- cellStats(DAVIS_P_201311, mean)
DAVIS_P_201312_mean <- cellStats(DAVIS_P_201312, mean)

#2014
DAVIS_P_201401_mean <- cellStats(DAVIS_P_201401, mean)
DAVIS_P_201402_mean <- cellStats(DAVIS_P_201402, mean)
DAVIS_P_201403_mean <- cellStats(DAVIS_P_201403, mean)
DAVIS_P_201404_mean <- cellStats(DAVIS_P_201404, mean)
DAVIS_P_201405_mean <- cellStats(DAVIS_P_201405, mean)
DAVIS_P_201406_mean <- cellStats(DAVIS_P_201406, mean)
DAVIS_P_201407_mean <- cellStats(DAVIS_P_201407, mean)
DAVIS_P_201408_mean <- cellStats(DAVIS_P_201408, mean)
DAVIS_P_201409_mean <- cellStats(DAVIS_P_201409, mean)
DAVIS_P_201410_mean <- cellStats(DAVIS_P_201410, mean)
DAVIS_P_201411_mean <- cellStats(DAVIS_P_201411, mean)
DAVIS_P_201412_mean <- cellStats(DAVIS_P_201412, mean)

#2015
DAVIS_P_201501_mean <- cellStats(DAVIS_P_201501, mean)
DAVIS_P_201502_mean <- cellStats(DAVIS_P_201502, mean)
DAVIS_P_201503_mean <- cellStats(DAVIS_P_201503, mean)
DAVIS_P_201504_mean <- cellStats(DAVIS_P_201504, mean)
DAVIS_P_201505_mean <- cellStats(DAVIS_P_201505, mean)
DAVIS_P_201506_mean <- cellStats(DAVIS_P_201506, mean)
DAVIS_P_201507_mean <- cellStats(DAVIS_P_201507, mean)
DAVIS_P_201508_mean <- cellStats(DAVIS_P_201508, mean)
DAVIS_P_201509_mean <- cellStats(DAVIS_P_201509, mean)
DAVIS_P_201510_mean <- cellStats(DAVIS_P_201510, mean)
DAVIS_P_201511_mean <- cellStats(DAVIS_P_201511, mean)
DAVIS_P_201512_mean <- cellStats(DAVIS_P_201512, mean)

#2016
DAVIS_P_201601_mean <- cellStats(DAVIS_P_201601, mean)
DAVIS_P_201602_mean <- cellStats(DAVIS_P_201602, mean)
DAVIS_P_201603_mean <- cellStats(DAVIS_P_201603, mean)
DAVIS_P_201604_mean <- cellStats(DAVIS_P_201604, mean)
DAVIS_P_201605_mean <- cellStats(DAVIS_P_201605, mean)
DAVIS_P_201606_mean <- cellStats(DAVIS_P_201606, mean)
DAVIS_P_201607_mean <- cellStats(DAVIS_P_201607, mean)
DAVIS_P_201608_mean <- cellStats(DAVIS_P_201608, mean)
DAVIS_P_201609_mean <- cellStats(DAVIS_P_201609, mean)
DAVIS_P_201610_mean <- cellStats(DAVIS_P_201610, mean)
DAVIS_P_201611_mean <- cellStats(DAVIS_P_201611, mean)
DAVIS_P_201612_mean <- cellStats(DAVIS_P_201612, mean)

#2017
DAVIS_P_201701_mean <- cellStats(DAVIS_P_201701, mean)
DAVIS_P_201702_mean <- cellStats(DAVIS_P_201702, mean)
DAVIS_P_201703_mean <- cellStats(DAVIS_P_201703, mean)
DAVIS_P_201704_mean <- cellStats(DAVIS_P_201704, mean)
DAVIS_P_201705_mean <- cellStats(DAVIS_P_201705, mean)
DAVIS_P_201706_mean <- cellStats(DAVIS_P_201706, mean)
DAVIS_P_201707_mean <- cellStats(DAVIS_P_201707, mean)
DAVIS_P_201708_mean <- cellStats(DAVIS_P_201708, mean)
DAVIS_P_201709_mean <- cellStats(DAVIS_P_201709, mean)
DAVIS_P_201710_mean <- cellStats(DAVIS_P_201710, mean)
DAVIS_P_201711_mean <- cellStats(DAVIS_P_201711, mean)
DAVIS_P_201712_mean <- cellStats(DAVIS_P_201712, mean)

#2018
DAVIS_P_201801_mean <- cellStats(DAVIS_P_201801, mean)
DAVIS_P_201802_mean <- cellStats(DAVIS_P_201802, mean)
DAVIS_P_201803_mean <- cellStats(DAVIS_P_201803, mean)
DAVIS_P_201804_mean <- cellStats(DAVIS_P_201804, mean)
DAVIS_P_201805_mean <- cellStats(DAVIS_P_201805, mean)
DAVIS_P_201806_mean <- cellStats(DAVIS_P_201806, mean)
DAVIS_P_201807_mean <- cellStats(DAVIS_P_201807, mean)
DAVIS_P_201808_mean <- cellStats(DAVIS_P_201808, mean)
DAVIS_P_201809_mean <- cellStats(DAVIS_P_201809, mean)
DAVIS_P_201810_mean <- cellStats(DAVIS_P_201810, mean)
DAVIS_P_201811_mean <- cellStats(DAVIS_P_201811, mean)
DAVIS_P_201812_mean <- cellStats(DAVIS_P_201812, mean)

# DAGGETT

#2000
DAGGETT_P_200001 <- crop(P_200001, DAGGETT) 
DAGGETT_P_200002 <- crop(P_200002, DAGGETT)
DAGGETT_P_200003 <- crop(P_200003, DAGGETT)
DAGGETT_P_200004 <- crop(P_200004, DAGGETT)
DAGGETT_P_200005 <- crop(P_200005, DAGGETT)
DAGGETT_P_200006 <- crop(P_200006, DAGGETT)  
DAGGETT_P_200007 <- crop(P_200007, DAGGETT)  
DAGGETT_P_200008 <- crop(P_200008, DAGGETT)  
DAGGETT_P_200009 <- crop(P_200009, DAGGETT)  
DAGGETT_P_200010 <- crop(P_200010, DAGGETT)  
DAGGETT_P_200011 <- crop(P_200011, DAGGETT)  
DAGGETT_P_200012 <- crop(P_200012, DAGGETT)  
#2001
DAGGETT_P_200101 <- crop(P_200101, DAGGETT) 
DAGGETT_P_200102 <- crop(P_200102, DAGGETT)
DAGGETT_P_200103 <- crop(P_200103, DAGGETT)
DAGGETT_P_200104 <- crop(P_200104, DAGGETT)
DAGGETT_P_200105 <- crop(P_200105, DAGGETT)
DAGGETT_P_200106 <- crop(P_200106, DAGGETT)  
DAGGETT_P_200107 <- crop(P_200107, DAGGETT)  
DAGGETT_P_200108 <- crop(P_200108, DAGGETT)  
DAGGETT_P_200109 <- crop(P_200109, DAGGETT)  
DAGGETT_P_200110 <- crop(P_200110, DAGGETT)  
DAGGETT_P_200111 <- crop(P_200111, DAGGETT)  
DAGGETT_P_200112 <- crop(P_200112, DAGGETT)  

#2002
DAGGETT_P_200201 <- crop(P_200201, DAGGETT) 
DAGGETT_P_200202 <- crop(P_200202, DAGGETT)
DAGGETT_P_200203 <- crop(P_200203, DAGGETT)
DAGGETT_P_200204 <- crop(P_200204, DAGGETT)
DAGGETT_P_200205 <- crop(P_200205, DAGGETT)
DAGGETT_P_200206 <- crop(P_200206, DAGGETT)  
DAGGETT_P_200207 <- crop(P_200207, DAGGETT)  
DAGGETT_P_200208 <- crop(P_200208, DAGGETT)  
DAGGETT_P_200209 <- crop(P_200209, DAGGETT)  
DAGGETT_P_200210 <- crop(P_200210, DAGGETT)  
DAGGETT_P_200211 <- crop(P_200211, DAGGETT)  
DAGGETT_P_200212 <- crop(P_200212, DAGGETT)  
#2003
DAGGETT_P_200301 <- crop(P_200301, DAGGETT) 
DAGGETT_P_200302 <- crop(P_200302, DAGGETT)
DAGGETT_P_200303 <- crop(P_200303, DAGGETT)
DAGGETT_P_200304 <- crop(P_200304, DAGGETT)
DAGGETT_P_200305 <- crop(P_200305, DAGGETT)
DAGGETT_P_200306 <- crop(P_200306, DAGGETT)  
DAGGETT_P_200307 <- crop(P_200307, DAGGETT)  
DAGGETT_P_200308 <- crop(P_200308, DAGGETT)  
DAGGETT_P_200309 <- crop(P_200309, DAGGETT)  
DAGGETT_P_200310 <- crop(P_200310, DAGGETT)  
DAGGETT_P_200311 <- crop(P_200311, DAGGETT)  
DAGGETT_P_200312 <- crop(P_200312, DAGGETT)  
#2004
DAGGETT_P_200401 <- crop(P_200401, DAGGETT) 
DAGGETT_P_200402 <- crop(P_200402, DAGGETT)
DAGGETT_P_200403 <- crop(P_200403, DAGGETT)
DAGGETT_P_200404 <- crop(P_200404, DAGGETT)
DAGGETT_P_200405 <- crop(P_200405, DAGGETT)
DAGGETT_P_200406 <- crop(P_200406, DAGGETT)  
DAGGETT_P_200407 <- crop(P_200407, DAGGETT)  
DAGGETT_P_200408 <- crop(P_200408, DAGGETT)  
DAGGETT_P_200409 <- crop(P_200409, DAGGETT)  
DAGGETT_P_200410 <- crop(P_200410, DAGGETT)  
DAGGETT_P_200411 <- crop(P_200411, DAGGETT)  
DAGGETT_P_200412 <- crop(P_200412, DAGGETT)  
#2005
DAGGETT_P_200501 <- crop(P_200501, DAGGETT) 
DAGGETT_P_200502 <- crop(P_200502, DAGGETT)
DAGGETT_P_200503 <- crop(P_200503, DAGGETT)
DAGGETT_P_200504 <- crop(P_200504, DAGGETT)
DAGGETT_P_200505 <- crop(P_200505, DAGGETT)
DAGGETT_P_200506 <- crop(P_200506, DAGGETT)  
DAGGETT_P_200507 <- crop(P_200507, DAGGETT)  
DAGGETT_P_200508 <- crop(P_200508, DAGGETT)  
DAGGETT_P_200509 <- crop(P_200509, DAGGETT)  
DAGGETT_P_200510 <- crop(P_200510, DAGGETT)  
DAGGETT_P_200511 <- crop(P_200511, DAGGETT)  
DAGGETT_P_200512 <- crop(P_200512, DAGGETT)  
#2006
DAGGETT_P_200601 <- crop(P_200601, DAGGETT) 
DAGGETT_P_200602 <- crop(P_200602, DAGGETT)
DAGGETT_P_200603 <- crop(P_200603, DAGGETT)
DAGGETT_P_200604 <- crop(P_200604, DAGGETT)
DAGGETT_P_200605 <- crop(P_200605, DAGGETT)
DAGGETT_P_200606 <- crop(P_200606, DAGGETT)  
DAGGETT_P_200607 <- crop(P_200607, DAGGETT)  
DAGGETT_P_200608 <- crop(P_200608, DAGGETT)  
DAGGETT_P_200609 <- crop(P_200609, DAGGETT)  
DAGGETT_P_200610 <- crop(P_200610, DAGGETT)  
DAGGETT_P_200611 <- crop(P_200611, DAGGETT)  
DAGGETT_P_200612 <- crop(P_200612, DAGGETT)  
#2007
DAGGETT_P_200701 <- crop(P_200701, DAGGETT) 
DAGGETT_P_200702 <- crop(P_200702, DAGGETT)
DAGGETT_P_200703 <- crop(P_200703, DAGGETT)
DAGGETT_P_200704 <- crop(P_200704, DAGGETT)
DAGGETT_P_200705 <- crop(P_200705, DAGGETT)
DAGGETT_P_200706 <- crop(P_200706, DAGGETT)  
DAGGETT_P_200707 <- crop(P_200707, DAGGETT)  
DAGGETT_P_200708 <- crop(P_200708, DAGGETT)  
DAGGETT_P_200709 <- crop(P_200709, DAGGETT)  
DAGGETT_P_200710 <- crop(P_200710, DAGGETT)  
DAGGETT_P_200711 <- crop(P_200711, DAGGETT)  
DAGGETT_P_200712 <- crop(P_200712, DAGGETT)  
#2008
DAGGETT_P_200801 <- crop(P_200801, DAGGETT) 
DAGGETT_P_200802 <- crop(P_200802, DAGGETT)
DAGGETT_P_200803 <- crop(P_200803, DAGGETT)
DAGGETT_P_200804 <- crop(P_200804, DAGGETT)
DAGGETT_P_200805 <- crop(P_200805, DAGGETT)
DAGGETT_P_200806 <- crop(P_200806, DAGGETT)  
DAGGETT_P_200807 <- crop(P_200807, DAGGETT)  
DAGGETT_P_200808 <- crop(P_200808, DAGGETT)  
DAGGETT_P_200809 <- crop(P_200809, DAGGETT)  
DAGGETT_P_200810 <- crop(P_200810, DAGGETT)  
DAGGETT_P_200811 <- crop(P_200811, DAGGETT)  
DAGGETT_P_200812 <- crop(P_200812, DAGGETT)  
#2009
DAGGETT_P_200901 <- crop(P_200901, DAGGETT) 
DAGGETT_P_200902 <- crop(P_200902, DAGGETT)
DAGGETT_P_200903 <- crop(P_200903, DAGGETT)
DAGGETT_P_200904 <- crop(P_200904, DAGGETT)
DAGGETT_P_200905 <- crop(P_200905, DAGGETT)
DAGGETT_P_200906 <- crop(P_200906, DAGGETT)  
DAGGETT_P_200907 <- crop(P_200907, DAGGETT)  
DAGGETT_P_200908 <- crop(P_200908, DAGGETT)  
DAGGETT_P_200909 <- crop(P_200909, DAGGETT)  
DAGGETT_P_200910 <- crop(P_200910, DAGGETT)  
DAGGETT_P_200911 <- crop(P_200911, DAGGETT)  
DAGGETT_P_200912 <- crop(P_200912, DAGGETT)  
#2010
DAGGETT_P_201001 <- crop(P_201001, DAGGETT) 
DAGGETT_P_201002 <- crop(P_201002, DAGGETT)
DAGGETT_P_201003 <- crop(P_201003, DAGGETT)
DAGGETT_P_201004 <- crop(P_201004, DAGGETT)
DAGGETT_P_201005 <- crop(P_201005, DAGGETT)
DAGGETT_P_201006 <- crop(P_201006, DAGGETT)  
DAGGETT_P_201007 <- crop(P_201007, DAGGETT)  
DAGGETT_P_201008 <- crop(P_201008, DAGGETT)  
DAGGETT_P_201009 <- crop(P_201009, DAGGETT)  
DAGGETT_P_201010 <- crop(P_201010, DAGGETT)  
DAGGETT_P_201011 <- crop(P_201011, DAGGETT)  
DAGGETT_P_201012 <- crop(P_201012, DAGGETT)  
#2011
DAGGETT_P_201101 <- crop(P_201101, DAGGETT) 
DAGGETT_P_201102 <- crop(P_201102, DAGGETT)
DAGGETT_P_201103 <- crop(P_201103, DAGGETT)
DAGGETT_P_201104 <- crop(P_201104, DAGGETT)
DAGGETT_P_201105 <- crop(P_201105, DAGGETT)
DAGGETT_P_201106 <- crop(P_201106, DAGGETT)  
DAGGETT_P_201107 <- crop(P_201107, DAGGETT)  
DAGGETT_P_201108 <- crop(P_201108, DAGGETT)  
DAGGETT_P_201109 <- crop(P_201109, DAGGETT)  
DAGGETT_P_201110 <- crop(P_201110, DAGGETT)  
DAGGETT_P_201111 <- crop(P_201111, DAGGETT)  
DAGGETT_P_201112 <- crop(P_201112, DAGGETT)  
#2012
DAGGETT_P_201201 <- crop(P_201201, DAGGETT) 
DAGGETT_P_201202 <- crop(P_201202, DAGGETT)
DAGGETT_P_201203 <- crop(P_201203, DAGGETT)
DAGGETT_P_201204 <- crop(P_201204, DAGGETT)
DAGGETT_P_201205 <- crop(P_201205, DAGGETT)
DAGGETT_P_201206 <- crop(P_201206, DAGGETT)  
DAGGETT_P_201207 <- crop(P_201207, DAGGETT)  
DAGGETT_P_201208 <- crop(P_201208, DAGGETT)  
DAGGETT_P_201209 <- crop(P_201209, DAGGETT)  
DAGGETT_P_201210 <- crop(P_201210, DAGGETT)  
DAGGETT_P_201211 <- crop(P_201211, DAGGETT)  
DAGGETT_P_201212 <- crop(P_201212, DAGGETT)  
#2013
DAGGETT_P_201301 <- crop(P_201301, DAGGETT) 
DAGGETT_P_201302 <- crop(P_201302, DAGGETT)
DAGGETT_P_201303 <- crop(P_201303, DAGGETT)
DAGGETT_P_201304 <- crop(P_201304, DAGGETT)
DAGGETT_P_201305 <- crop(P_201305, DAGGETT)
DAGGETT_P_201306 <- crop(P_201306, DAGGETT)  
DAGGETT_P_201307 <- crop(P_201307, DAGGETT)  
DAGGETT_P_201308 <- crop(P_201308, DAGGETT)  
DAGGETT_P_201309 <- crop(P_201309, DAGGETT)  
DAGGETT_P_201310 <- crop(P_201310, DAGGETT)  
DAGGETT_P_201311 <- crop(P_201311, DAGGETT)  
DAGGETT_P_201312 <- crop(P_201312, DAGGETT)  
#2014
DAGGETT_P_201401 <- crop(P_201401, DAGGETT) 
DAGGETT_P_201402 <- crop(P_201402, DAGGETT)
DAGGETT_P_201403 <- crop(P_201403, DAGGETT)
DAGGETT_P_201404 <- crop(P_201404, DAGGETT)
DAGGETT_P_201405 <- crop(P_201405, DAGGETT)
DAGGETT_P_201406 <- crop(P_201406, DAGGETT)  
DAGGETT_P_201407 <- crop(P_201407, DAGGETT)  
DAGGETT_P_201408 <- crop(P_201408, DAGGETT)  
DAGGETT_P_201409 <- crop(P_201409, DAGGETT)  
DAGGETT_P_201410 <- crop(P_201410, DAGGETT)  
DAGGETT_P_201411 <- crop(P_201411, DAGGETT)  
DAGGETT_P_201412 <- crop(P_201412, DAGGETT)  
#2015
DAGGETT_P_201501 <- crop(P_201501, DAGGETT) 
DAGGETT_P_201502 <- crop(P_201502, DAGGETT)
DAGGETT_P_201503 <- crop(P_201503, DAGGETT)
DAGGETT_P_201504 <- crop(P_201504, DAGGETT)
DAGGETT_P_201505 <- crop(P_201505, DAGGETT)
DAGGETT_P_201506 <- crop(P_201506, DAGGETT)  
DAGGETT_P_201507 <- crop(P_201507, DAGGETT)  
DAGGETT_P_201508 <- crop(P_201508, DAGGETT)  
DAGGETT_P_201509 <- crop(P_201509, DAGGETT)  
DAGGETT_P_201510 <- crop(P_201510, DAGGETT)  
DAGGETT_P_201511 <- crop(P_201511, DAGGETT)  
DAGGETT_P_201512 <- crop(P_201512, DAGGETT)  
#2016
DAGGETT_P_201601 <- crop(P_201601, DAGGETT) 
DAGGETT_P_201602 <- crop(P_201602, DAGGETT)
DAGGETT_P_201603 <- crop(P_201603, DAGGETT)
DAGGETT_P_201604 <- crop(P_201604, DAGGETT)
DAGGETT_P_201605 <- crop(P_201605, DAGGETT)
DAGGETT_P_201606 <- crop(P_201606, DAGGETT)  
DAGGETT_P_201607 <- crop(P_201607, DAGGETT)  
DAGGETT_P_201608 <- crop(P_201608, DAGGETT)  
DAGGETT_P_201609 <- crop(P_201609, DAGGETT)  
DAGGETT_P_201610 <- crop(P_201610, DAGGETT)  
DAGGETT_P_201611 <- crop(P_201611, DAGGETT)  
DAGGETT_P_201612 <- crop(P_201612, DAGGETT)  
#2017
DAGGETT_P_201701 <- crop(P_201701, DAGGETT) 
DAGGETT_P_201702 <- crop(P_201702, DAGGETT)
DAGGETT_P_201703 <- crop(P_201703, DAGGETT)
DAGGETT_P_201704 <- crop(P_201704, DAGGETT)
DAGGETT_P_201705 <- crop(P_201705, DAGGETT)
DAGGETT_P_201706 <- crop(P_201706, DAGGETT)  
DAGGETT_P_201707 <- crop(P_201707, DAGGETT)  
DAGGETT_P_201708 <- crop(P_201708, DAGGETT)  
DAGGETT_P_201709 <- crop(P_201709, DAGGETT)  
DAGGETT_P_201710 <- crop(P_201710, DAGGETT)  
DAGGETT_P_201711 <- crop(P_201711, DAGGETT)  
DAGGETT_P_201712 <- crop(P_201712, DAGGETT)  

#2018

DAGGETT_P_201801 <- crop(P_201801, DAGGETT) 
DAGGETT_P_201802 <- crop(P_201802, DAGGETT)
DAGGETT_P_201803 <- crop(P_201803, DAGGETT)
DAGGETT_P_201804 <- crop(P_201804, DAGGETT)
DAGGETT_P_201805 <- crop(P_201805, DAGGETT)
DAGGETT_P_201806 <- crop(P_201806, DAGGETT)  
DAGGETT_P_201807 <- crop(P_201807, DAGGETT)  
DAGGETT_P_201808 <- crop(P_201808, DAGGETT)  
DAGGETT_P_201809 <- crop(P_201809, DAGGETT)  
DAGGETT_P_201810 <- crop(P_201810, DAGGETT)  
DAGGETT_P_201811 <- crop(P_201811, DAGGETT)  
DAGGETT_P_201812 <- crop(P_201812, DAGGETT)  


# Mean Monthly Precipitation
#2000
DAGGETT_P_200001_mean <- cellStats(DAGGETT_P_200001, mean)
DAGGETT_P_200002_mean <- cellStats(DAGGETT_P_200002, mean)
DAGGETT_P_200003_mean <- cellStats(DAGGETT_P_200003, mean)
DAGGETT_P_200004_mean <- cellStats(DAGGETT_P_200004, mean)
DAGGETT_P_200005_mean <- cellStats(DAGGETT_P_200005, mean)
DAGGETT_P_200006_mean <- cellStats(DAGGETT_P_200006, mean)
DAGGETT_P_200007_mean <- cellStats(DAGGETT_P_200007, mean)
DAGGETT_P_200008_mean <- cellStats(DAGGETT_P_200008, mean)
DAGGETT_P_200009_mean <- cellStats(DAGGETT_P_200009, mean)
DAGGETT_P_200010_mean <- cellStats(DAGGETT_P_200010, mean)
DAGGETT_P_200011_mean <- cellStats(DAGGETT_P_200011, mean)
DAGGETT_P_200012_mean <- cellStats(DAGGETT_P_200012, mean)
#2001
DAGGETT_P_200101_mean <- cellStats(DAGGETT_P_200101, mean)
DAGGETT_P_200102_mean <- cellStats(DAGGETT_P_200102, mean)
DAGGETT_P_200103_mean <- cellStats(DAGGETT_P_200103, mean)
DAGGETT_P_200104_mean <- cellStats(DAGGETT_P_200104, mean)
DAGGETT_P_200105_mean <- cellStats(DAGGETT_P_200105, mean)
DAGGETT_P_200106_mean <- cellStats(DAGGETT_P_200106, mean)
DAGGETT_P_200107_mean <- cellStats(DAGGETT_P_200107, mean)
DAGGETT_P_200108_mean <- cellStats(DAGGETT_P_200108, mean)
DAGGETT_P_200109_mean <- cellStats(DAGGETT_P_200109, mean)
DAGGETT_P_200110_mean <- cellStats(DAGGETT_P_200110, mean)
DAGGETT_P_200111_mean <- cellStats(DAGGETT_P_200111, mean)
DAGGETT_P_200112_mean <- cellStats(DAGGETT_P_200112, mean)

#2002
DAGGETT_P_200201_mean <- cellStats(DAGGETT_P_200201, mean)
DAGGETT_P_200202_mean <- cellStats(DAGGETT_P_200202, mean)
DAGGETT_P_200203_mean <- cellStats(DAGGETT_P_200203, mean)
DAGGETT_P_200204_mean <- cellStats(DAGGETT_P_200204, mean)
DAGGETT_P_200205_mean <- cellStats(DAGGETT_P_200205, mean)
DAGGETT_P_200206_mean <- cellStats(DAGGETT_P_200206, mean)
DAGGETT_P_200207_mean <- cellStats(DAGGETT_P_200207, mean)
DAGGETT_P_200208_mean <- cellStats(DAGGETT_P_200208, mean)
DAGGETT_P_200209_mean <- cellStats(DAGGETT_P_200209, mean)
DAGGETT_P_200210_mean <- cellStats(DAGGETT_P_200210, mean)
DAGGETT_P_200211_mean <- cellStats(DAGGETT_P_200211, mean)
DAGGETT_P_200212_mean <- cellStats(DAGGETT_P_200212, mean)

#2003
DAGGETT_P_200301_mean <- cellStats(DAGGETT_P_200301, mean)
DAGGETT_P_200302_mean <- cellStats(DAGGETT_P_200302, mean)
DAGGETT_P_200303_mean <- cellStats(DAGGETT_P_200303, mean)
DAGGETT_P_200304_mean <- cellStats(DAGGETT_P_200304, mean)
DAGGETT_P_200305_mean <- cellStats(DAGGETT_P_200305, mean)
DAGGETT_P_200306_mean <- cellStats(DAGGETT_P_200306, mean)
DAGGETT_P_200307_mean <- cellStats(DAGGETT_P_200307, mean)
DAGGETT_P_200308_mean <- cellStats(DAGGETT_P_200308, mean)
DAGGETT_P_200309_mean <- cellStats(DAGGETT_P_200309, mean)
DAGGETT_P_200310_mean <- cellStats(DAGGETT_P_200310, mean)
DAGGETT_P_200311_mean <- cellStats(DAGGETT_P_200311, mean)
DAGGETT_P_200312_mean <- cellStats(DAGGETT_P_200312, mean)

#2004

DAGGETT_P_200401_mean <- cellStats(DAGGETT_P_200401, mean)
DAGGETT_P_200402_mean <- cellStats(DAGGETT_P_200402, mean)
DAGGETT_P_200403_mean <- cellStats(DAGGETT_P_200403, mean)
DAGGETT_P_200404_mean <- cellStats(DAGGETT_P_200404, mean)
DAGGETT_P_200405_mean <- cellStats(DAGGETT_P_200405, mean)
DAGGETT_P_200406_mean <- cellStats(DAGGETT_P_200406, mean)
DAGGETT_P_200407_mean <- cellStats(DAGGETT_P_200407, mean)
DAGGETT_P_200408_mean <- cellStats(DAGGETT_P_200408, mean)
DAGGETT_P_200409_mean <- cellStats(DAGGETT_P_200409, mean)
DAGGETT_P_200410_mean <- cellStats(DAGGETT_P_200410, mean)
DAGGETT_P_200411_mean <- cellStats(DAGGETT_P_200411, mean)
DAGGETT_P_200412_mean <- cellStats(DAGGETT_P_200412, mean)

#2005

DAGGETT_P_200501_mean <- cellStats(DAGGETT_P_200501, mean)
DAGGETT_P_200502_mean <- cellStats(DAGGETT_P_200502, mean)
DAGGETT_P_200503_mean <- cellStats(DAGGETT_P_200503, mean)
DAGGETT_P_200504_mean <- cellStats(DAGGETT_P_200504, mean)
DAGGETT_P_200505_mean <- cellStats(DAGGETT_P_200505, mean)
DAGGETT_P_200506_mean <- cellStats(DAGGETT_P_200506, mean)
DAGGETT_P_200507_mean <- cellStats(DAGGETT_P_200507, mean)
DAGGETT_P_200508_mean <- cellStats(DAGGETT_P_200508, mean)
DAGGETT_P_200509_mean <- cellStats(DAGGETT_P_200509, mean)
DAGGETT_P_200510_mean <- cellStats(DAGGETT_P_200510, mean)
DAGGETT_P_200511_mean <- cellStats(DAGGETT_P_200511, mean)
DAGGETT_P_200512_mean <- cellStats(DAGGETT_P_200512, mean)

#2006

DAGGETT_P_200601_mean <- cellStats(DAGGETT_P_200601, mean)
DAGGETT_P_200602_mean <- cellStats(DAGGETT_P_200602, mean)
DAGGETT_P_200603_mean <- cellStats(DAGGETT_P_200603, mean)
DAGGETT_P_200604_mean <- cellStats(DAGGETT_P_200604, mean)
DAGGETT_P_200605_mean <- cellStats(DAGGETT_P_200605, mean)
DAGGETT_P_200606_mean <- cellStats(DAGGETT_P_200606, mean)
DAGGETT_P_200607_mean <- cellStats(DAGGETT_P_200607, mean)
DAGGETT_P_200608_mean <- cellStats(DAGGETT_P_200608, mean)
DAGGETT_P_200609_mean <- cellStats(DAGGETT_P_200609, mean)
DAGGETT_P_200610_mean <- cellStats(DAGGETT_P_200610, mean)
DAGGETT_P_200611_mean <- cellStats(DAGGETT_P_200611, mean)
DAGGETT_P_200612_mean <- cellStats(DAGGETT_P_200612, mean)

#2007

DAGGETT_P_200701_mean <- cellStats(DAGGETT_P_200701, mean)
DAGGETT_P_200702_mean <- cellStats(DAGGETT_P_200702, mean)
DAGGETT_P_200703_mean <- cellStats(DAGGETT_P_200703, mean)
DAGGETT_P_200704_mean <- cellStats(DAGGETT_P_200704, mean)
DAGGETT_P_200705_mean <- cellStats(DAGGETT_P_200705, mean)
DAGGETT_P_200706_mean <- cellStats(DAGGETT_P_200706, mean)
DAGGETT_P_200707_mean <- cellStats(DAGGETT_P_200707, mean)
DAGGETT_P_200708_mean <- cellStats(DAGGETT_P_200708, mean)
DAGGETT_P_200709_mean <- cellStats(DAGGETT_P_200709, mean)
DAGGETT_P_200710_mean <- cellStats(DAGGETT_P_200710, mean)
DAGGETT_P_200711_mean <- cellStats(DAGGETT_P_200711, mean)
DAGGETT_P_200712_mean <- cellStats(DAGGETT_P_200712, mean)

#2008

DAGGETT_P_200801_mean <- cellStats(DAGGETT_P_200801, mean)
DAGGETT_P_200802_mean <- cellStats(DAGGETT_P_200802, mean)
DAGGETT_P_200803_mean <- cellStats(DAGGETT_P_200803, mean)
DAGGETT_P_200804_mean <- cellStats(DAGGETT_P_200804, mean)
DAGGETT_P_200805_mean <- cellStats(DAGGETT_P_200805, mean)
DAGGETT_P_200806_mean <- cellStats(DAGGETT_P_200806, mean)
DAGGETT_P_200807_mean <- cellStats(DAGGETT_P_200807, mean)
DAGGETT_P_200808_mean <- cellStats(DAGGETT_P_200808, mean)
DAGGETT_P_200809_mean <- cellStats(DAGGETT_P_200809, mean)
DAGGETT_P_200810_mean <- cellStats(DAGGETT_P_200810, mean)
DAGGETT_P_200811_mean <- cellStats(DAGGETT_P_200811, mean)
DAGGETT_P_200812_mean <- cellStats(DAGGETT_P_200812, mean)

#2009

DAGGETT_P_200901_mean <- cellStats(DAGGETT_P_200901, mean)
DAGGETT_P_200902_mean <- cellStats(DAGGETT_P_200902, mean)
DAGGETT_P_200903_mean <- cellStats(DAGGETT_P_200903, mean)
DAGGETT_P_200904_mean <- cellStats(DAGGETT_P_200904, mean)
DAGGETT_P_200905_mean <- cellStats(DAGGETT_P_200905, mean)
DAGGETT_P_200906_mean <- cellStats(DAGGETT_P_200906, mean)
DAGGETT_P_200907_mean <- cellStats(DAGGETT_P_200907, mean)
DAGGETT_P_200908_mean <- cellStats(DAGGETT_P_200908, mean)
DAGGETT_P_200909_mean <- cellStats(DAGGETT_P_200909, mean)
DAGGETT_P_200910_mean <- cellStats(DAGGETT_P_200910, mean)
DAGGETT_P_200911_mean <- cellStats(DAGGETT_P_200911, mean)
DAGGETT_P_200912_mean <- cellStats(DAGGETT_P_200912, mean)

#2010

DAGGETT_P_201001_mean <- cellStats(DAGGETT_P_201001, mean)
DAGGETT_P_201002_mean <- cellStats(DAGGETT_P_201002, mean)
DAGGETT_P_201003_mean <- cellStats(DAGGETT_P_201003, mean)
DAGGETT_P_201004_mean <- cellStats(DAGGETT_P_201004, mean)
DAGGETT_P_201005_mean <- cellStats(DAGGETT_P_201005, mean)
DAGGETT_P_201006_mean <- cellStats(DAGGETT_P_201006, mean)
DAGGETT_P_201007_mean <- cellStats(DAGGETT_P_201007, mean)
DAGGETT_P_201008_mean <- cellStats(DAGGETT_P_201008, mean)
DAGGETT_P_201009_mean <- cellStats(DAGGETT_P_201009, mean)
DAGGETT_P_201010_mean <- cellStats(DAGGETT_P_201010, mean)
DAGGETT_P_201011_mean <- cellStats(DAGGETT_P_201011, mean)
DAGGETT_P_201012_mean <- cellStats(DAGGETT_P_201012, mean)

#2011

DAGGETT_P_201101_mean <- cellStats(DAGGETT_P_201101, mean)
DAGGETT_P_201102_mean <- cellStats(DAGGETT_P_201102, mean)
DAGGETT_P_201103_mean <- cellStats(DAGGETT_P_201103, mean)
DAGGETT_P_201104_mean <- cellStats(DAGGETT_P_201104, mean)
DAGGETT_P_201105_mean <- cellStats(DAGGETT_P_201105, mean)
DAGGETT_P_201106_mean <- cellStats(DAGGETT_P_201106, mean)
DAGGETT_P_201107_mean <- cellStats(DAGGETT_P_201107, mean)
DAGGETT_P_201108_mean <- cellStats(DAGGETT_P_201108, mean)
DAGGETT_P_201109_mean <- cellStats(DAGGETT_P_201109, mean)
DAGGETT_P_201110_mean <- cellStats(DAGGETT_P_201110, mean)
DAGGETT_P_201111_mean <- cellStats(DAGGETT_P_201111, mean)
DAGGETT_P_201112_mean <- cellStats(DAGGETT_P_201112, mean)

#2012
DAGGETT_P_201201_mean <- cellStats(DAGGETT_P_201201, mean)
DAGGETT_P_201202_mean <- cellStats(DAGGETT_P_201202, mean)
DAGGETT_P_201203_mean <- cellStats(DAGGETT_P_201203, mean)
DAGGETT_P_201204_mean <- cellStats(DAGGETT_P_201204, mean)
DAGGETT_P_201205_mean <- cellStats(DAGGETT_P_201205, mean)
DAGGETT_P_201206_mean <- cellStats(DAGGETT_P_201206, mean)
DAGGETT_P_201207_mean <- cellStats(DAGGETT_P_201207, mean)
DAGGETT_P_201208_mean <- cellStats(DAGGETT_P_201208, mean)
DAGGETT_P_201209_mean <- cellStats(DAGGETT_P_201209, mean)
DAGGETT_P_201210_mean <- cellStats(DAGGETT_P_201210, mean)
DAGGETT_P_201211_mean <- cellStats(DAGGETT_P_201211, mean)
DAGGETT_P_201212_mean <- cellStats(DAGGETT_P_201212, mean)

#2013
DAGGETT_P_201301_mean <- cellStats(DAGGETT_P_201301, mean)
DAGGETT_P_201302_mean <- cellStats(DAGGETT_P_201302, mean)
DAGGETT_P_201303_mean <- cellStats(DAGGETT_P_201303, mean)
DAGGETT_P_201304_mean <- cellStats(DAGGETT_P_201304, mean)
DAGGETT_P_201305_mean <- cellStats(DAGGETT_P_201305, mean)
DAGGETT_P_201306_mean <- cellStats(DAGGETT_P_201306, mean)
DAGGETT_P_201307_mean <- cellStats(DAGGETT_P_201307, mean)
DAGGETT_P_201308_mean <- cellStats(DAGGETT_P_201308, mean)
DAGGETT_P_201309_mean <- cellStats(DAGGETT_P_201309, mean)
DAGGETT_P_201310_mean <- cellStats(DAGGETT_P_201310, mean)
DAGGETT_P_201311_mean <- cellStats(DAGGETT_P_201311, mean)
DAGGETT_P_201312_mean <- cellStats(DAGGETT_P_201312, mean)

#2014
DAGGETT_P_201401_mean <- cellStats(DAGGETT_P_201401, mean)
DAGGETT_P_201402_mean <- cellStats(DAGGETT_P_201402, mean)
DAGGETT_P_201403_mean <- cellStats(DAGGETT_P_201403, mean)
DAGGETT_P_201404_mean <- cellStats(DAGGETT_P_201404, mean)
DAGGETT_P_201405_mean <- cellStats(DAGGETT_P_201405, mean)
DAGGETT_P_201406_mean <- cellStats(DAGGETT_P_201406, mean)
DAGGETT_P_201407_mean <- cellStats(DAGGETT_P_201407, mean)
DAGGETT_P_201408_mean <- cellStats(DAGGETT_P_201408, mean)
DAGGETT_P_201409_mean <- cellStats(DAGGETT_P_201409, mean)
DAGGETT_P_201410_mean <- cellStats(DAGGETT_P_201410, mean)
DAGGETT_P_201411_mean <- cellStats(DAGGETT_P_201411, mean)
DAGGETT_P_201412_mean <- cellStats(DAGGETT_P_201412, mean)

#2015
DAGGETT_P_201501_mean <- cellStats(DAGGETT_P_201501, mean)
DAGGETT_P_201502_mean <- cellStats(DAGGETT_P_201502, mean)
DAGGETT_P_201503_mean <- cellStats(DAGGETT_P_201503, mean)
DAGGETT_P_201504_mean <- cellStats(DAGGETT_P_201504, mean)
DAGGETT_P_201505_mean <- cellStats(DAGGETT_P_201505, mean)
DAGGETT_P_201506_mean <- cellStats(DAGGETT_P_201506, mean)
DAGGETT_P_201507_mean <- cellStats(DAGGETT_P_201507, mean)
DAGGETT_P_201508_mean <- cellStats(DAGGETT_P_201508, mean)
DAGGETT_P_201509_mean <- cellStats(DAGGETT_P_201509, mean)
DAGGETT_P_201510_mean <- cellStats(DAGGETT_P_201510, mean)
DAGGETT_P_201511_mean <- cellStats(DAGGETT_P_201511, mean)
DAGGETT_P_201512_mean <- cellStats(DAGGETT_P_201512, mean)

#2016
DAGGETT_P_201601_mean <- cellStats(DAGGETT_P_201601, mean)
DAGGETT_P_201602_mean <- cellStats(DAGGETT_P_201602, mean)
DAGGETT_P_201603_mean <- cellStats(DAGGETT_P_201603, mean)
DAGGETT_P_201604_mean <- cellStats(DAGGETT_P_201604, mean)
DAGGETT_P_201605_mean <- cellStats(DAGGETT_P_201605, mean)
DAGGETT_P_201606_mean <- cellStats(DAGGETT_P_201606, mean)
DAGGETT_P_201607_mean <- cellStats(DAGGETT_P_201607, mean)
DAGGETT_P_201608_mean <- cellStats(DAGGETT_P_201608, mean)
DAGGETT_P_201609_mean <- cellStats(DAGGETT_P_201609, mean)
DAGGETT_P_201610_mean <- cellStats(DAGGETT_P_201610, mean)
DAGGETT_P_201611_mean <- cellStats(DAGGETT_P_201611, mean)
DAGGETT_P_201612_mean <- cellStats(DAGGETT_P_201612, mean)

#2017
DAGGETT_P_201701_mean <- cellStats(DAGGETT_P_201701, mean)
DAGGETT_P_201702_mean <- cellStats(DAGGETT_P_201702, mean)
DAGGETT_P_201703_mean <- cellStats(DAGGETT_P_201703, mean)
DAGGETT_P_201704_mean <- cellStats(DAGGETT_P_201704, mean)
DAGGETT_P_201705_mean <- cellStats(DAGGETT_P_201705, mean)
DAGGETT_P_201706_mean <- cellStats(DAGGETT_P_201706, mean)
DAGGETT_P_201707_mean <- cellStats(DAGGETT_P_201707, mean)
DAGGETT_P_201708_mean <- cellStats(DAGGETT_P_201708, mean)
DAGGETT_P_201709_mean <- cellStats(DAGGETT_P_201709, mean)
DAGGETT_P_201710_mean <- cellStats(DAGGETT_P_201710, mean)
DAGGETT_P_201711_mean <- cellStats(DAGGETT_P_201711, mean)
DAGGETT_P_201712_mean <- cellStats(DAGGETT_P_201712, mean)

#2018
DAGGETT_P_201801_mean <- cellStats(DAGGETT_P_201801, mean)
DAGGETT_P_201802_mean <- cellStats(DAGGETT_P_201802, mean)
DAGGETT_P_201803_mean <- cellStats(DAGGETT_P_201803, mean)
DAGGETT_P_201804_mean <- cellStats(DAGGETT_P_201804, mean)
DAGGETT_P_201805_mean <- cellStats(DAGGETT_P_201805, mean)
DAGGETT_P_201806_mean <- cellStats(DAGGETT_P_201806, mean)
DAGGETT_P_201807_mean <- cellStats(DAGGETT_P_201807, mean)
DAGGETT_P_201808_mean <- cellStats(DAGGETT_P_201808, mean)
DAGGETT_P_201809_mean <- cellStats(DAGGETT_P_201809, mean)
DAGGETT_P_201810_mean <- cellStats(DAGGETT_P_201810, mean)
DAGGETT_P_201811_mean <- cellStats(DAGGETT_P_201811, mean)
DAGGETT_P_201812_mean <- cellStats(DAGGETT_P_201812, mean)

# DUCHESNE

#2000
DUCHESNE_P_200001 <- crop(P_200001, DUCHESNE) 
DUCHESNE_P_200002 <- crop(P_200002, DUCHESNE)
DUCHESNE_P_200003 <- crop(P_200003, DUCHESNE)
DUCHESNE_P_200004 <- crop(P_200004, DUCHESNE)
DUCHESNE_P_200005 <- crop(P_200005, DUCHESNE)
DUCHESNE_P_200006 <- crop(P_200006, DUCHESNE)  
DUCHESNE_P_200007 <- crop(P_200007, DUCHESNE)  
DUCHESNE_P_200008 <- crop(P_200008, DUCHESNE)  
DUCHESNE_P_200009 <- crop(P_200009, DUCHESNE)  
DUCHESNE_P_200010 <- crop(P_200010, DUCHESNE)  
DUCHESNE_P_200011 <- crop(P_200011, DUCHESNE)  
DUCHESNE_P_200012 <- crop(P_200012, DUCHESNE)  
#2001
DUCHESNE_P_200101 <- crop(P_200101, DUCHESNE) 
DUCHESNE_P_200102 <- crop(P_200102, DUCHESNE)
DUCHESNE_P_200103 <- crop(P_200103, DUCHESNE)
DUCHESNE_P_200104 <- crop(P_200104, DUCHESNE)
DUCHESNE_P_200105 <- crop(P_200105, DUCHESNE)
DUCHESNE_P_200106 <- crop(P_200106, DUCHESNE)  
DUCHESNE_P_200107 <- crop(P_200107, DUCHESNE)  
DUCHESNE_P_200108 <- crop(P_200108, DUCHESNE)  
DUCHESNE_P_200109 <- crop(P_200109, DUCHESNE)  
DUCHESNE_P_200110 <- crop(P_200110, DUCHESNE)  
DUCHESNE_P_200111 <- crop(P_200111, DUCHESNE)  
DUCHESNE_P_200112 <- crop(P_200112, DUCHESNE)  

#2002
DUCHESNE_P_200201 <- crop(P_200201, DUCHESNE) 
DUCHESNE_P_200202 <- crop(P_200202, DUCHESNE)
DUCHESNE_P_200203 <- crop(P_200203, DUCHESNE)
DUCHESNE_P_200204 <- crop(P_200204, DUCHESNE)
DUCHESNE_P_200205 <- crop(P_200205, DUCHESNE)
DUCHESNE_P_200206 <- crop(P_200206, DUCHESNE)  
DUCHESNE_P_200207 <- crop(P_200207, DUCHESNE)  
DUCHESNE_P_200208 <- crop(P_200208, DUCHESNE)  
DUCHESNE_P_200209 <- crop(P_200209, DUCHESNE)  
DUCHESNE_P_200210 <- crop(P_200210, DUCHESNE)  
DUCHESNE_P_200211 <- crop(P_200211, DUCHESNE)  
DUCHESNE_P_200212 <- crop(P_200212, DUCHESNE)  
#2003
DUCHESNE_P_200301 <- crop(P_200301, DUCHESNE) 
DUCHESNE_P_200302 <- crop(P_200302, DUCHESNE)
DUCHESNE_P_200303 <- crop(P_200303, DUCHESNE)
DUCHESNE_P_200304 <- crop(P_200304, DUCHESNE)
DUCHESNE_P_200305 <- crop(P_200305, DUCHESNE)
DUCHESNE_P_200306 <- crop(P_200306, DUCHESNE)  
DUCHESNE_P_200307 <- crop(P_200307, DUCHESNE)  
DUCHESNE_P_200308 <- crop(P_200308, DUCHESNE)  
DUCHESNE_P_200309 <- crop(P_200309, DUCHESNE)  
DUCHESNE_P_200310 <- crop(P_200310, DUCHESNE)  
DUCHESNE_P_200311 <- crop(P_200311, DUCHESNE)  
DUCHESNE_P_200312 <- crop(P_200312, DUCHESNE)  
#2004
DUCHESNE_P_200401 <- crop(P_200401, DUCHESNE) 
DUCHESNE_P_200402 <- crop(P_200402, DUCHESNE)
DUCHESNE_P_200403 <- crop(P_200403, DUCHESNE)
DUCHESNE_P_200404 <- crop(P_200404, DUCHESNE)
DUCHESNE_P_200405 <- crop(P_200405, DUCHESNE)
DUCHESNE_P_200406 <- crop(P_200406, DUCHESNE)  
DUCHESNE_P_200407 <- crop(P_200407, DUCHESNE)  
DUCHESNE_P_200408 <- crop(P_200408, DUCHESNE)  
DUCHESNE_P_200409 <- crop(P_200409, DUCHESNE)  
DUCHESNE_P_200410 <- crop(P_200410, DUCHESNE)  
DUCHESNE_P_200411 <- crop(P_200411, DUCHESNE)  
DUCHESNE_P_200412 <- crop(P_200412, DUCHESNE)  
#2005
DUCHESNE_P_200501 <- crop(P_200501, DUCHESNE) 
DUCHESNE_P_200502 <- crop(P_200502, DUCHESNE)
DUCHESNE_P_200503 <- crop(P_200503, DUCHESNE)
DUCHESNE_P_200504 <- crop(P_200504, DUCHESNE)
DUCHESNE_P_200505 <- crop(P_200505, DUCHESNE)
DUCHESNE_P_200506 <- crop(P_200506, DUCHESNE)  
DUCHESNE_P_200507 <- crop(P_200507, DUCHESNE)  
DUCHESNE_P_200508 <- crop(P_200508, DUCHESNE)  
DUCHESNE_P_200509 <- crop(P_200509, DUCHESNE)  
DUCHESNE_P_200510 <- crop(P_200510, DUCHESNE)  
DUCHESNE_P_200511 <- crop(P_200511, DUCHESNE)  
DUCHESNE_P_200512 <- crop(P_200512, DUCHESNE)  
#2006
DUCHESNE_P_200601 <- crop(P_200601, DUCHESNE) 
DUCHESNE_P_200602 <- crop(P_200602, DUCHESNE)
DUCHESNE_P_200603 <- crop(P_200603, DUCHESNE)
DUCHESNE_P_200604 <- crop(P_200604, DUCHESNE)
DUCHESNE_P_200605 <- crop(P_200605, DUCHESNE)
DUCHESNE_P_200606 <- crop(P_200606, DUCHESNE)  
DUCHESNE_P_200607 <- crop(P_200607, DUCHESNE)  
DUCHESNE_P_200608 <- crop(P_200608, DUCHESNE)  
DUCHESNE_P_200609 <- crop(P_200609, DUCHESNE)  
DUCHESNE_P_200610 <- crop(P_200610, DUCHESNE)  
DUCHESNE_P_200611 <- crop(P_200611, DUCHESNE)  
DUCHESNE_P_200612 <- crop(P_200612, DUCHESNE)  
#2007
DUCHESNE_P_200701 <- crop(P_200701, DUCHESNE) 
DUCHESNE_P_200702 <- crop(P_200702, DUCHESNE)
DUCHESNE_P_200703 <- crop(P_200703, DUCHESNE)
DUCHESNE_P_200704 <- crop(P_200704, DUCHESNE)
DUCHESNE_P_200705 <- crop(P_200705, DUCHESNE)
DUCHESNE_P_200706 <- crop(P_200706, DUCHESNE)  
DUCHESNE_P_200707 <- crop(P_200707, DUCHESNE)  
DUCHESNE_P_200708 <- crop(P_200708, DUCHESNE)  
DUCHESNE_P_200709 <- crop(P_200709, DUCHESNE)  
DUCHESNE_P_200710 <- crop(P_200710, DUCHESNE)  
DUCHESNE_P_200711 <- crop(P_200711, DUCHESNE)  
DUCHESNE_P_200712 <- crop(P_200712, DUCHESNE)  
#2008
DUCHESNE_P_200801 <- crop(P_200801, DUCHESNE) 
DUCHESNE_P_200802 <- crop(P_200802, DUCHESNE)
DUCHESNE_P_200803 <- crop(P_200803, DUCHESNE)
DUCHESNE_P_200804 <- crop(P_200804, DUCHESNE)
DUCHESNE_P_200805 <- crop(P_200805, DUCHESNE)
DUCHESNE_P_200806 <- crop(P_200806, DUCHESNE)  
DUCHESNE_P_200807 <- crop(P_200807, DUCHESNE)  
DUCHESNE_P_200808 <- crop(P_200808, DUCHESNE)  
DUCHESNE_P_200809 <- crop(P_200809, DUCHESNE)  
DUCHESNE_P_200810 <- crop(P_200810, DUCHESNE)  
DUCHESNE_P_200811 <- crop(P_200811, DUCHESNE)  
DUCHESNE_P_200812 <- crop(P_200812, DUCHESNE)  
#2009
DUCHESNE_P_200901 <- crop(P_200901, DUCHESNE) 
DUCHESNE_P_200902 <- crop(P_200902, DUCHESNE)
DUCHESNE_P_200903 <- crop(P_200903, DUCHESNE)
DUCHESNE_P_200904 <- crop(P_200904, DUCHESNE)
DUCHESNE_P_200905 <- crop(P_200905, DUCHESNE)
DUCHESNE_P_200906 <- crop(P_200906, DUCHESNE)  
DUCHESNE_P_200907 <- crop(P_200907, DUCHESNE)  
DUCHESNE_P_200908 <- crop(P_200908, DUCHESNE)  
DUCHESNE_P_200909 <- crop(P_200909, DUCHESNE)  
DUCHESNE_P_200910 <- crop(P_200910, DUCHESNE)  
DUCHESNE_P_200911 <- crop(P_200911, DUCHESNE)  
DUCHESNE_P_200912 <- crop(P_200912, DUCHESNE)  
#2010
DUCHESNE_P_201001 <- crop(P_201001, DUCHESNE) 
DUCHESNE_P_201002 <- crop(P_201002, DUCHESNE)
DUCHESNE_P_201003 <- crop(P_201003, DUCHESNE)
DUCHESNE_P_201004 <- crop(P_201004, DUCHESNE)
DUCHESNE_P_201005 <- crop(P_201005, DUCHESNE)
DUCHESNE_P_201006 <- crop(P_201006, DUCHESNE)  
DUCHESNE_P_201007 <- crop(P_201007, DUCHESNE)  
DUCHESNE_P_201008 <- crop(P_201008, DUCHESNE)  
DUCHESNE_P_201009 <- crop(P_201009, DUCHESNE)  
DUCHESNE_P_201010 <- crop(P_201010, DUCHESNE)  
DUCHESNE_P_201011 <- crop(P_201011, DUCHESNE)  
DUCHESNE_P_201012 <- crop(P_201012, DUCHESNE)  
#2011
DUCHESNE_P_201101 <- crop(P_201101, DUCHESNE) 
DUCHESNE_P_201102 <- crop(P_201102, DUCHESNE)
DUCHESNE_P_201103 <- crop(P_201103, DUCHESNE)
DUCHESNE_P_201104 <- crop(P_201104, DUCHESNE)
DUCHESNE_P_201105 <- crop(P_201105, DUCHESNE)
DUCHESNE_P_201106 <- crop(P_201106, DUCHESNE)  
DUCHESNE_P_201107 <- crop(P_201107, DUCHESNE)  
DUCHESNE_P_201108 <- crop(P_201108, DUCHESNE)  
DUCHESNE_P_201109 <- crop(P_201109, DUCHESNE)  
DUCHESNE_P_201110 <- crop(P_201110, DUCHESNE)  
DUCHESNE_P_201111 <- crop(P_201111, DUCHESNE)  
DUCHESNE_P_201112 <- crop(P_201112, DUCHESNE)  
#2012
DUCHESNE_P_201201 <- crop(P_201201, DUCHESNE) 
DUCHESNE_P_201202 <- crop(P_201202, DUCHESNE)
DUCHESNE_P_201203 <- crop(P_201203, DUCHESNE)
DUCHESNE_P_201204 <- crop(P_201204, DUCHESNE)
DUCHESNE_P_201205 <- crop(P_201205, DUCHESNE)
DUCHESNE_P_201206 <- crop(P_201206, DUCHESNE)  
DUCHESNE_P_201207 <- crop(P_201207, DUCHESNE)  
DUCHESNE_P_201208 <- crop(P_201208, DUCHESNE)  
DUCHESNE_P_201209 <- crop(P_201209, DUCHESNE)  
DUCHESNE_P_201210 <- crop(P_201210, DUCHESNE)  
DUCHESNE_P_201211 <- crop(P_201211, DUCHESNE)  
DUCHESNE_P_201212 <- crop(P_201212, DUCHESNE)  
#2013
DUCHESNE_P_201301 <- crop(P_201301, DUCHESNE) 
DUCHESNE_P_201302 <- crop(P_201302, DUCHESNE)
DUCHESNE_P_201303 <- crop(P_201303, DUCHESNE)
DUCHESNE_P_201304 <- crop(P_201304, DUCHESNE)
DUCHESNE_P_201305 <- crop(P_201305, DUCHESNE)
DUCHESNE_P_201306 <- crop(P_201306, DUCHESNE)  
DUCHESNE_P_201307 <- crop(P_201307, DUCHESNE)  
DUCHESNE_P_201308 <- crop(P_201308, DUCHESNE)  
DUCHESNE_P_201309 <- crop(P_201309, DUCHESNE)  
DUCHESNE_P_201310 <- crop(P_201310, DUCHESNE)  
DUCHESNE_P_201311 <- crop(P_201311, DUCHESNE)  
DUCHESNE_P_201312 <- crop(P_201312, DUCHESNE)  
#2014
DUCHESNE_P_201401 <- crop(P_201401, DUCHESNE) 
DUCHESNE_P_201402 <- crop(P_201402, DUCHESNE)
DUCHESNE_P_201403 <- crop(P_201403, DUCHESNE)
DUCHESNE_P_201404 <- crop(P_201404, DUCHESNE)
DUCHESNE_P_201405 <- crop(P_201405, DUCHESNE)
DUCHESNE_P_201406 <- crop(P_201406, DUCHESNE)  
DUCHESNE_P_201407 <- crop(P_201407, DUCHESNE)  
DUCHESNE_P_201408 <- crop(P_201408, DUCHESNE)  
DUCHESNE_P_201409 <- crop(P_201409, DUCHESNE)  
DUCHESNE_P_201410 <- crop(P_201410, DUCHESNE)  
DUCHESNE_P_201411 <- crop(P_201411, DUCHESNE)  
DUCHESNE_P_201412 <- crop(P_201412, DUCHESNE)  
#2015
DUCHESNE_P_201501 <- crop(P_201501, DUCHESNE) 
DUCHESNE_P_201502 <- crop(P_201502, DUCHESNE)
DUCHESNE_P_201503 <- crop(P_201503, DUCHESNE)
DUCHESNE_P_201504 <- crop(P_201504, DUCHESNE)
DUCHESNE_P_201505 <- crop(P_201505, DUCHESNE)
DUCHESNE_P_201506 <- crop(P_201506, DUCHESNE)  
DUCHESNE_P_201507 <- crop(P_201507, DUCHESNE)  
DUCHESNE_P_201508 <- crop(P_201508, DUCHESNE)  
DUCHESNE_P_201509 <- crop(P_201509, DUCHESNE)  
DUCHESNE_P_201510 <- crop(P_201510, DUCHESNE)  
DUCHESNE_P_201511 <- crop(P_201511, DUCHESNE)  
DUCHESNE_P_201512 <- crop(P_201512, DUCHESNE)  
#2016
DUCHESNE_P_201601 <- crop(P_201601, DUCHESNE) 
DUCHESNE_P_201602 <- crop(P_201602, DUCHESNE)
DUCHESNE_P_201603 <- crop(P_201603, DUCHESNE)
DUCHESNE_P_201604 <- crop(P_201604, DUCHESNE)
DUCHESNE_P_201605 <- crop(P_201605, DUCHESNE)
DUCHESNE_P_201606 <- crop(P_201606, DUCHESNE)  
DUCHESNE_P_201607 <- crop(P_201607, DUCHESNE)  
DUCHESNE_P_201608 <- crop(P_201608, DUCHESNE)  
DUCHESNE_P_201609 <- crop(P_201609, DUCHESNE)  
DUCHESNE_P_201610 <- crop(P_201610, DUCHESNE)  
DUCHESNE_P_201611 <- crop(P_201611, DUCHESNE)  
DUCHESNE_P_201612 <- crop(P_201612, DUCHESNE)  
#2017
DUCHESNE_P_201701 <- crop(P_201701, DUCHESNE) 
DUCHESNE_P_201702 <- crop(P_201702, DUCHESNE)
DUCHESNE_P_201703 <- crop(P_201703, DUCHESNE)
DUCHESNE_P_201704 <- crop(P_201704, DUCHESNE)
DUCHESNE_P_201705 <- crop(P_201705, DUCHESNE)
DUCHESNE_P_201706 <- crop(P_201706, DUCHESNE)  
DUCHESNE_P_201707 <- crop(P_201707, DUCHESNE)  
DUCHESNE_P_201708 <- crop(P_201708, DUCHESNE)  
DUCHESNE_P_201709 <- crop(P_201709, DUCHESNE)  
DUCHESNE_P_201710 <- crop(P_201710, DUCHESNE)  
DUCHESNE_P_201711 <- crop(P_201711, DUCHESNE)  
DUCHESNE_P_201712 <- crop(P_201712, DUCHESNE)  

#2018

DUCHESNE_P_201801 <- crop(P_201801, DUCHESNE) 
DUCHESNE_P_201802 <- crop(P_201802, DUCHESNE)
DUCHESNE_P_201803 <- crop(P_201803, DUCHESNE)
DUCHESNE_P_201804 <- crop(P_201804, DUCHESNE)
DUCHESNE_P_201805 <- crop(P_201805, DUCHESNE)
DUCHESNE_P_201806 <- crop(P_201806, DUCHESNE)  
DUCHESNE_P_201807 <- crop(P_201807, DUCHESNE)  
DUCHESNE_P_201808 <- crop(P_201808, DUCHESNE)  
DUCHESNE_P_201809 <- crop(P_201809, DUCHESNE)  
DUCHESNE_P_201810 <- crop(P_201810, DUCHESNE)  
DUCHESNE_P_201811 <- crop(P_201811, DUCHESNE)  
DUCHESNE_P_201812 <- crop(P_201812, DUCHESNE)  


# Mean Monthly Precipitation
#2000
DUCHESNE_P_200001_mean <- cellStats(DUCHESNE_P_200001, mean)
DUCHESNE_P_200002_mean <- cellStats(DUCHESNE_P_200002, mean)
DUCHESNE_P_200003_mean <- cellStats(DUCHESNE_P_200003, mean)
DUCHESNE_P_200004_mean <- cellStats(DUCHESNE_P_200004, mean)
DUCHESNE_P_200005_mean <- cellStats(DUCHESNE_P_200005, mean)
DUCHESNE_P_200006_mean <- cellStats(DUCHESNE_P_200006, mean)
DUCHESNE_P_200007_mean <- cellStats(DUCHESNE_P_200007, mean)
DUCHESNE_P_200008_mean <- cellStats(DUCHESNE_P_200008, mean)
DUCHESNE_P_200009_mean <- cellStats(DUCHESNE_P_200009, mean)
DUCHESNE_P_200010_mean <- cellStats(DUCHESNE_P_200010, mean)
DUCHESNE_P_200011_mean <- cellStats(DUCHESNE_P_200011, mean)
DUCHESNE_P_200012_mean <- cellStats(DUCHESNE_P_200012, mean)
#2001
DUCHESNE_P_200101_mean <- cellStats(DUCHESNE_P_200101, mean)
DUCHESNE_P_200102_mean <- cellStats(DUCHESNE_P_200102, mean)
DUCHESNE_P_200103_mean <- cellStats(DUCHESNE_P_200103, mean)
DUCHESNE_P_200104_mean <- cellStats(DUCHESNE_P_200104, mean)
DUCHESNE_P_200105_mean <- cellStats(DUCHESNE_P_200105, mean)
DUCHESNE_P_200106_mean <- cellStats(DUCHESNE_P_200106, mean)
DUCHESNE_P_200107_mean <- cellStats(DUCHESNE_P_200107, mean)
DUCHESNE_P_200108_mean <- cellStats(DUCHESNE_P_200108, mean)
DUCHESNE_P_200109_mean <- cellStats(DUCHESNE_P_200109, mean)
DUCHESNE_P_200110_mean <- cellStats(DUCHESNE_P_200110, mean)
DUCHESNE_P_200111_mean <- cellStats(DUCHESNE_P_200111, mean)
DUCHESNE_P_200112_mean <- cellStats(DUCHESNE_P_200112, mean)

#2002
DUCHESNE_P_200201_mean <- cellStats(DUCHESNE_P_200201, mean)
DUCHESNE_P_200202_mean <- cellStats(DUCHESNE_P_200202, mean)
DUCHESNE_P_200203_mean <- cellStats(DUCHESNE_P_200203, mean)
DUCHESNE_P_200204_mean <- cellStats(DUCHESNE_P_200204, mean)
DUCHESNE_P_200205_mean <- cellStats(DUCHESNE_P_200205, mean)
DUCHESNE_P_200206_mean <- cellStats(DUCHESNE_P_200206, mean)
DUCHESNE_P_200207_mean <- cellStats(DUCHESNE_P_200207, mean)
DUCHESNE_P_200208_mean <- cellStats(DUCHESNE_P_200208, mean)
DUCHESNE_P_200209_mean <- cellStats(DUCHESNE_P_200209, mean)
DUCHESNE_P_200210_mean <- cellStats(DUCHESNE_P_200210, mean)
DUCHESNE_P_200211_mean <- cellStats(DUCHESNE_P_200211, mean)
DUCHESNE_P_200212_mean <- cellStats(DUCHESNE_P_200212, mean)

#2003
DUCHESNE_P_200301_mean <- cellStats(DUCHESNE_P_200301, mean)
DUCHESNE_P_200302_mean <- cellStats(DUCHESNE_P_200302, mean)
DUCHESNE_P_200303_mean <- cellStats(DUCHESNE_P_200303, mean)
DUCHESNE_P_200304_mean <- cellStats(DUCHESNE_P_200304, mean)
DUCHESNE_P_200305_mean <- cellStats(DUCHESNE_P_200305, mean)
DUCHESNE_P_200306_mean <- cellStats(DUCHESNE_P_200306, mean)
DUCHESNE_P_200307_mean <- cellStats(DUCHESNE_P_200307, mean)
DUCHESNE_P_200308_mean <- cellStats(DUCHESNE_P_200308, mean)
DUCHESNE_P_200309_mean <- cellStats(DUCHESNE_P_200309, mean)
DUCHESNE_P_200310_mean <- cellStats(DUCHESNE_P_200310, mean)
DUCHESNE_P_200311_mean <- cellStats(DUCHESNE_P_200311, mean)
DUCHESNE_P_200312_mean <- cellStats(DUCHESNE_P_200312, mean)

#2004

DUCHESNE_P_200401_mean <- cellStats(DUCHESNE_P_200401, mean)
DUCHESNE_P_200402_mean <- cellStats(DUCHESNE_P_200402, mean)
DUCHESNE_P_200403_mean <- cellStats(DUCHESNE_P_200403, mean)
DUCHESNE_P_200404_mean <- cellStats(DUCHESNE_P_200404, mean)
DUCHESNE_P_200405_mean <- cellStats(DUCHESNE_P_200405, mean)
DUCHESNE_P_200406_mean <- cellStats(DUCHESNE_P_200406, mean)
DUCHESNE_P_200407_mean <- cellStats(DUCHESNE_P_200407, mean)
DUCHESNE_P_200408_mean <- cellStats(DUCHESNE_P_200408, mean)
DUCHESNE_P_200409_mean <- cellStats(DUCHESNE_P_200409, mean)
DUCHESNE_P_200410_mean <- cellStats(DUCHESNE_P_200410, mean)
DUCHESNE_P_200411_mean <- cellStats(DUCHESNE_P_200411, mean)
DUCHESNE_P_200412_mean <- cellStats(DUCHESNE_P_200412, mean)

#2005

DUCHESNE_P_200501_mean <- cellStats(DUCHESNE_P_200501, mean)
DUCHESNE_P_200502_mean <- cellStats(DUCHESNE_P_200502, mean)
DUCHESNE_P_200503_mean <- cellStats(DUCHESNE_P_200503, mean)
DUCHESNE_P_200504_mean <- cellStats(DUCHESNE_P_200504, mean)
DUCHESNE_P_200505_mean <- cellStats(DUCHESNE_P_200505, mean)
DUCHESNE_P_200506_mean <- cellStats(DUCHESNE_P_200506, mean)
DUCHESNE_P_200507_mean <- cellStats(DUCHESNE_P_200507, mean)
DUCHESNE_P_200508_mean <- cellStats(DUCHESNE_P_200508, mean)
DUCHESNE_P_200509_mean <- cellStats(DUCHESNE_P_200509, mean)
DUCHESNE_P_200510_mean <- cellStats(DUCHESNE_P_200510, mean)
DUCHESNE_P_200511_mean <- cellStats(DUCHESNE_P_200511, mean)
DUCHESNE_P_200512_mean <- cellStats(DUCHESNE_P_200512, mean)

#2006

DUCHESNE_P_200601_mean <- cellStats(DUCHESNE_P_200601, mean)
DUCHESNE_P_200602_mean <- cellStats(DUCHESNE_P_200602, mean)
DUCHESNE_P_200603_mean <- cellStats(DUCHESNE_P_200603, mean)
DUCHESNE_P_200604_mean <- cellStats(DUCHESNE_P_200604, mean)
DUCHESNE_P_200605_mean <- cellStats(DUCHESNE_P_200605, mean)
DUCHESNE_P_200606_mean <- cellStats(DUCHESNE_P_200606, mean)
DUCHESNE_P_200607_mean <- cellStats(DUCHESNE_P_200607, mean)
DUCHESNE_P_200608_mean <- cellStats(DUCHESNE_P_200608, mean)
DUCHESNE_P_200609_mean <- cellStats(DUCHESNE_P_200609, mean)
DUCHESNE_P_200610_mean <- cellStats(DUCHESNE_P_200610, mean)
DUCHESNE_P_200611_mean <- cellStats(DUCHESNE_P_200611, mean)
DUCHESNE_P_200612_mean <- cellStats(DUCHESNE_P_200612, mean)

#2007

DUCHESNE_P_200701_mean <- cellStats(DUCHESNE_P_200701, mean)
DUCHESNE_P_200702_mean <- cellStats(DUCHESNE_P_200702, mean)
DUCHESNE_P_200703_mean <- cellStats(DUCHESNE_P_200703, mean)
DUCHESNE_P_200704_mean <- cellStats(DUCHESNE_P_200704, mean)
DUCHESNE_P_200705_mean <- cellStats(DUCHESNE_P_200705, mean)
DUCHESNE_P_200706_mean <- cellStats(DUCHESNE_P_200706, mean)
DUCHESNE_P_200707_mean <- cellStats(DUCHESNE_P_200707, mean)
DUCHESNE_P_200708_mean <- cellStats(DUCHESNE_P_200708, mean)
DUCHESNE_P_200709_mean <- cellStats(DUCHESNE_P_200709, mean)
DUCHESNE_P_200710_mean <- cellStats(DUCHESNE_P_200710, mean)
DUCHESNE_P_200711_mean <- cellStats(DUCHESNE_P_200711, mean)
DUCHESNE_P_200712_mean <- cellStats(DUCHESNE_P_200712, mean)

#2008

DUCHESNE_P_200801_mean <- cellStats(DUCHESNE_P_200801, mean)
DUCHESNE_P_200802_mean <- cellStats(DUCHESNE_P_200802, mean)
DUCHESNE_P_200803_mean <- cellStats(DUCHESNE_P_200803, mean)
DUCHESNE_P_200804_mean <- cellStats(DUCHESNE_P_200804, mean)
DUCHESNE_P_200805_mean <- cellStats(DUCHESNE_P_200805, mean)
DUCHESNE_P_200806_mean <- cellStats(DUCHESNE_P_200806, mean)
DUCHESNE_P_200807_mean <- cellStats(DUCHESNE_P_200807, mean)
DUCHESNE_P_200808_mean <- cellStats(DUCHESNE_P_200808, mean)
DUCHESNE_P_200809_mean <- cellStats(DUCHESNE_P_200809, mean)
DUCHESNE_P_200810_mean <- cellStats(DUCHESNE_P_200810, mean)
DUCHESNE_P_200811_mean <- cellStats(DUCHESNE_P_200811, mean)
DUCHESNE_P_200812_mean <- cellStats(DUCHESNE_P_200812, mean)

#2009

DUCHESNE_P_200901_mean <- cellStats(DUCHESNE_P_200901, mean)
DUCHESNE_P_200902_mean <- cellStats(DUCHESNE_P_200902, mean)
DUCHESNE_P_200903_mean <- cellStats(DUCHESNE_P_200903, mean)
DUCHESNE_P_200904_mean <- cellStats(DUCHESNE_P_200904, mean)
DUCHESNE_P_200905_mean <- cellStats(DUCHESNE_P_200905, mean)
DUCHESNE_P_200906_mean <- cellStats(DUCHESNE_P_200906, mean)
DUCHESNE_P_200907_mean <- cellStats(DUCHESNE_P_200907, mean)
DUCHESNE_P_200908_mean <- cellStats(DUCHESNE_P_200908, mean)
DUCHESNE_P_200909_mean <- cellStats(DUCHESNE_P_200909, mean)
DUCHESNE_P_200910_mean <- cellStats(DUCHESNE_P_200910, mean)
DUCHESNE_P_200911_mean <- cellStats(DUCHESNE_P_200911, mean)
DUCHESNE_P_200912_mean <- cellStats(DUCHESNE_P_200912, mean)

#2010

DUCHESNE_P_201001_mean <- cellStats(DUCHESNE_P_201001, mean)
DUCHESNE_P_201002_mean <- cellStats(DUCHESNE_P_201002, mean)
DUCHESNE_P_201003_mean <- cellStats(DUCHESNE_P_201003, mean)
DUCHESNE_P_201004_mean <- cellStats(DUCHESNE_P_201004, mean)
DUCHESNE_P_201005_mean <- cellStats(DUCHESNE_P_201005, mean)
DUCHESNE_P_201006_mean <- cellStats(DUCHESNE_P_201006, mean)
DUCHESNE_P_201007_mean <- cellStats(DUCHESNE_P_201007, mean)
DUCHESNE_P_201008_mean <- cellStats(DUCHESNE_P_201008, mean)
DUCHESNE_P_201009_mean <- cellStats(DUCHESNE_P_201009, mean)
DUCHESNE_P_201010_mean <- cellStats(DUCHESNE_P_201010, mean)
DUCHESNE_P_201011_mean <- cellStats(DUCHESNE_P_201011, mean)
DUCHESNE_P_201012_mean <- cellStats(DUCHESNE_P_201012, mean)

#2011

DUCHESNE_P_201101_mean <- cellStats(DUCHESNE_P_201101, mean)
DUCHESNE_P_201102_mean <- cellStats(DUCHESNE_P_201102, mean)
DUCHESNE_P_201103_mean <- cellStats(DUCHESNE_P_201103, mean)
DUCHESNE_P_201104_mean <- cellStats(DUCHESNE_P_201104, mean)
DUCHESNE_P_201105_mean <- cellStats(DUCHESNE_P_201105, mean)
DUCHESNE_P_201106_mean <- cellStats(DUCHESNE_P_201106, mean)
DUCHESNE_P_201107_mean <- cellStats(DUCHESNE_P_201107, mean)
DUCHESNE_P_201108_mean <- cellStats(DUCHESNE_P_201108, mean)
DUCHESNE_P_201109_mean <- cellStats(DUCHESNE_P_201109, mean)
DUCHESNE_P_201110_mean <- cellStats(DUCHESNE_P_201110, mean)
DUCHESNE_P_201111_mean <- cellStats(DUCHESNE_P_201111, mean)
DUCHESNE_P_201112_mean <- cellStats(DUCHESNE_P_201112, mean)

#2012
DUCHESNE_P_201201_mean <- cellStats(DUCHESNE_P_201201, mean)
DUCHESNE_P_201202_mean <- cellStats(DUCHESNE_P_201202, mean)
DUCHESNE_P_201203_mean <- cellStats(DUCHESNE_P_201203, mean)
DUCHESNE_P_201204_mean <- cellStats(DUCHESNE_P_201204, mean)
DUCHESNE_P_201205_mean <- cellStats(DUCHESNE_P_201205, mean)
DUCHESNE_P_201206_mean <- cellStats(DUCHESNE_P_201206, mean)
DUCHESNE_P_201207_mean <- cellStats(DUCHESNE_P_201207, mean)
DUCHESNE_P_201208_mean <- cellStats(DUCHESNE_P_201208, mean)
DUCHESNE_P_201209_mean <- cellStats(DUCHESNE_P_201209, mean)
DUCHESNE_P_201210_mean <- cellStats(DUCHESNE_P_201210, mean)
DUCHESNE_P_201211_mean <- cellStats(DUCHESNE_P_201211, mean)
DUCHESNE_P_201212_mean <- cellStats(DUCHESNE_P_201212, mean)

#2013
DUCHESNE_P_201301_mean <- cellStats(DUCHESNE_P_201301, mean)
DUCHESNE_P_201302_mean <- cellStats(DUCHESNE_P_201302, mean)
DUCHESNE_P_201303_mean <- cellStats(DUCHESNE_P_201303, mean)
DUCHESNE_P_201304_mean <- cellStats(DUCHESNE_P_201304, mean)
DUCHESNE_P_201305_mean <- cellStats(DUCHESNE_P_201305, mean)
DUCHESNE_P_201306_mean <- cellStats(DUCHESNE_P_201306, mean)
DUCHESNE_P_201307_mean <- cellStats(DUCHESNE_P_201307, mean)
DUCHESNE_P_201308_mean <- cellStats(DUCHESNE_P_201308, mean)
DUCHESNE_P_201309_mean <- cellStats(DUCHESNE_P_201309, mean)
DUCHESNE_P_201310_mean <- cellStats(DUCHESNE_P_201310, mean)
DUCHESNE_P_201311_mean <- cellStats(DUCHESNE_P_201311, mean)
DUCHESNE_P_201312_mean <- cellStats(DUCHESNE_P_201312, mean)

#2014
DUCHESNE_P_201401_mean <- cellStats(DUCHESNE_P_201401, mean)
DUCHESNE_P_201402_mean <- cellStats(DUCHESNE_P_201402, mean)
DUCHESNE_P_201403_mean <- cellStats(DUCHESNE_P_201403, mean)
DUCHESNE_P_201404_mean <- cellStats(DUCHESNE_P_201404, mean)
DUCHESNE_P_201405_mean <- cellStats(DUCHESNE_P_201405, mean)
DUCHESNE_P_201406_mean <- cellStats(DUCHESNE_P_201406, mean)
DUCHESNE_P_201407_mean <- cellStats(DUCHESNE_P_201407, mean)
DUCHESNE_P_201408_mean <- cellStats(DUCHESNE_P_201408, mean)
DUCHESNE_P_201409_mean <- cellStats(DUCHESNE_P_201409, mean)
DUCHESNE_P_201410_mean <- cellStats(DUCHESNE_P_201410, mean)
DUCHESNE_P_201411_mean <- cellStats(DUCHESNE_P_201411, mean)
DUCHESNE_P_201412_mean <- cellStats(DUCHESNE_P_201412, mean)

#2015
DUCHESNE_P_201501_mean <- cellStats(DUCHESNE_P_201501, mean)
DUCHESNE_P_201502_mean <- cellStats(DUCHESNE_P_201502, mean)
DUCHESNE_P_201503_mean <- cellStats(DUCHESNE_P_201503, mean)
DUCHESNE_P_201504_mean <- cellStats(DUCHESNE_P_201504, mean)
DUCHESNE_P_201505_mean <- cellStats(DUCHESNE_P_201505, mean)
DUCHESNE_P_201506_mean <- cellStats(DUCHESNE_P_201506, mean)
DUCHESNE_P_201507_mean <- cellStats(DUCHESNE_P_201507, mean)
DUCHESNE_P_201508_mean <- cellStats(DUCHESNE_P_201508, mean)
DUCHESNE_P_201509_mean <- cellStats(DUCHESNE_P_201509, mean)
DUCHESNE_P_201510_mean <- cellStats(DUCHESNE_P_201510, mean)
DUCHESNE_P_201511_mean <- cellStats(DUCHESNE_P_201511, mean)
DUCHESNE_P_201512_mean <- cellStats(DUCHESNE_P_201512, mean)

#2016
DUCHESNE_P_201601_mean <- cellStats(DUCHESNE_P_201601, mean)
DUCHESNE_P_201602_mean <- cellStats(DUCHESNE_P_201602, mean)
DUCHESNE_P_201603_mean <- cellStats(DUCHESNE_P_201603, mean)
DUCHESNE_P_201604_mean <- cellStats(DUCHESNE_P_201604, mean)
DUCHESNE_P_201605_mean <- cellStats(DUCHESNE_P_201605, mean)
DUCHESNE_P_201606_mean <- cellStats(DUCHESNE_P_201606, mean)
DUCHESNE_P_201607_mean <- cellStats(DUCHESNE_P_201607, mean)
DUCHESNE_P_201608_mean <- cellStats(DUCHESNE_P_201608, mean)
DUCHESNE_P_201609_mean <- cellStats(DUCHESNE_P_201609, mean)
DUCHESNE_P_201610_mean <- cellStats(DUCHESNE_P_201610, mean)
DUCHESNE_P_201611_mean <- cellStats(DUCHESNE_P_201611, mean)
DUCHESNE_P_201612_mean <- cellStats(DUCHESNE_P_201612, mean)

#2017
DUCHESNE_P_201701_mean <- cellStats(DUCHESNE_P_201701, mean)
DUCHESNE_P_201702_mean <- cellStats(DUCHESNE_P_201702, mean)
DUCHESNE_P_201703_mean <- cellStats(DUCHESNE_P_201703, mean)
DUCHESNE_P_201704_mean <- cellStats(DUCHESNE_P_201704, mean)
DUCHESNE_P_201705_mean <- cellStats(DUCHESNE_P_201705, mean)
DUCHESNE_P_201706_mean <- cellStats(DUCHESNE_P_201706, mean)
DUCHESNE_P_201707_mean <- cellStats(DUCHESNE_P_201707, mean)
DUCHESNE_P_201708_mean <- cellStats(DUCHESNE_P_201708, mean)
DUCHESNE_P_201709_mean <- cellStats(DUCHESNE_P_201709, mean)
DUCHESNE_P_201710_mean <- cellStats(DUCHESNE_P_201710, mean)
DUCHESNE_P_201711_mean <- cellStats(DUCHESNE_P_201711, mean)
DUCHESNE_P_201712_mean <- cellStats(DUCHESNE_P_201712, mean)

#2018
DUCHESNE_P_201801_mean <- cellStats(DUCHESNE_P_201801, mean)
DUCHESNE_P_201802_mean <- cellStats(DUCHESNE_P_201802, mean)
DUCHESNE_P_201803_mean <- cellStats(DUCHESNE_P_201803, mean)
DUCHESNE_P_201804_mean <- cellStats(DUCHESNE_P_201804, mean)
DUCHESNE_P_201805_mean <- cellStats(DUCHESNE_P_201805, mean)
DUCHESNE_P_201806_mean <- cellStats(DUCHESNE_P_201806, mean)
DUCHESNE_P_201807_mean <- cellStats(DUCHESNE_P_201807, mean)
DUCHESNE_P_201808_mean <- cellStats(DUCHESNE_P_201808, mean)
DUCHESNE_P_201809_mean <- cellStats(DUCHESNE_P_201809, mean)
DUCHESNE_P_201810_mean <- cellStats(DUCHESNE_P_201810, mean)
DUCHESNE_P_201811_mean <- cellStats(DUCHESNE_P_201811, mean)
DUCHESNE_P_201812_mean <- cellStats(DUCHESNE_P_201812, mean)

# EMERY

#2000
EMERY_P_200001 <- crop(P_200001, EMERY) 
EMERY_P_200002 <- crop(P_200002, EMERY)
EMERY_P_200003 <- crop(P_200003, EMERY)
EMERY_P_200004 <- crop(P_200004, EMERY)
EMERY_P_200005 <- crop(P_200005, EMERY)
EMERY_P_200006 <- crop(P_200006, EMERY)  
EMERY_P_200007 <- crop(P_200007, EMERY)  
EMERY_P_200008 <- crop(P_200008, EMERY)  
EMERY_P_200009 <- crop(P_200009, EMERY)  
EMERY_P_200010 <- crop(P_200010, EMERY)  
EMERY_P_200011 <- crop(P_200011, EMERY)  
EMERY_P_200012 <- crop(P_200012, EMERY)  
#2001
EMERY_P_200101 <- crop(P_200101, EMERY) 
EMERY_P_200102 <- crop(P_200102, EMERY)
EMERY_P_200103 <- crop(P_200103, EMERY)
EMERY_P_200104 <- crop(P_200104, EMERY)
EMERY_P_200105 <- crop(P_200105, EMERY)
EMERY_P_200106 <- crop(P_200106, EMERY)  
EMERY_P_200107 <- crop(P_200107, EMERY)  
EMERY_P_200108 <- crop(P_200108, EMERY)  
EMERY_P_200109 <- crop(P_200109, EMERY)  
EMERY_P_200110 <- crop(P_200110, EMERY)  
EMERY_P_200111 <- crop(P_200111, EMERY)  
EMERY_P_200112 <- crop(P_200112, EMERY)  

#2002
EMERY_P_200201 <- crop(P_200201, EMERY) 
EMERY_P_200202 <- crop(P_200202, EMERY)
EMERY_P_200203 <- crop(P_200203, EMERY)
EMERY_P_200204 <- crop(P_200204, EMERY)
EMERY_P_200205 <- crop(P_200205, EMERY)
EMERY_P_200206 <- crop(P_200206, EMERY)  
EMERY_P_200207 <- crop(P_200207, EMERY)  
EMERY_P_200208 <- crop(P_200208, EMERY)  
EMERY_P_200209 <- crop(P_200209, EMERY)  
EMERY_P_200210 <- crop(P_200210, EMERY)  
EMERY_P_200211 <- crop(P_200211, EMERY)  
EMERY_P_200212 <- crop(P_200212, EMERY)  
#2003
EMERY_P_200301 <- crop(P_200301, EMERY) 
EMERY_P_200302 <- crop(P_200302, EMERY)
EMERY_P_200303 <- crop(P_200303, EMERY)
EMERY_P_200304 <- crop(P_200304, EMERY)
EMERY_P_200305 <- crop(P_200305, EMERY)
EMERY_P_200306 <- crop(P_200306, EMERY)  
EMERY_P_200307 <- crop(P_200307, EMERY)  
EMERY_P_200308 <- crop(P_200308, EMERY)  
EMERY_P_200309 <- crop(P_200309, EMERY)  
EMERY_P_200310 <- crop(P_200310, EMERY)  
EMERY_P_200311 <- crop(P_200311, EMERY)  
EMERY_P_200312 <- crop(P_200312, EMERY)  
#2004
EMERY_P_200401 <- crop(P_200401, EMERY) 
EMERY_P_200402 <- crop(P_200402, EMERY)
EMERY_P_200403 <- crop(P_200403, EMERY)
EMERY_P_200404 <- crop(P_200404, EMERY)
EMERY_P_200405 <- crop(P_200405, EMERY)
EMERY_P_200406 <- crop(P_200406, EMERY)  
EMERY_P_200407 <- crop(P_200407, EMERY)  
EMERY_P_200408 <- crop(P_200408, EMERY)  
EMERY_P_200409 <- crop(P_200409, EMERY)  
EMERY_P_200410 <- crop(P_200410, EMERY)  
EMERY_P_200411 <- crop(P_200411, EMERY)  
EMERY_P_200412 <- crop(P_200412, EMERY)  
#2005
EMERY_P_200501 <- crop(P_200501, EMERY) 
EMERY_P_200502 <- crop(P_200502, EMERY)
EMERY_P_200503 <- crop(P_200503, EMERY)
EMERY_P_200504 <- crop(P_200504, EMERY)
EMERY_P_200505 <- crop(P_200505, EMERY)
EMERY_P_200506 <- crop(P_200506, EMERY)  
EMERY_P_200507 <- crop(P_200507, EMERY)  
EMERY_P_200508 <- crop(P_200508, EMERY)  
EMERY_P_200509 <- crop(P_200509, EMERY)  
EMERY_P_200510 <- crop(P_200510, EMERY)  
EMERY_P_200511 <- crop(P_200511, EMERY)  
EMERY_P_200512 <- crop(P_200512, EMERY)  
#2006
EMERY_P_200601 <- crop(P_200601, EMERY) 
EMERY_P_200602 <- crop(P_200602, EMERY)
EMERY_P_200603 <- crop(P_200603, EMERY)
EMERY_P_200604 <- crop(P_200604, EMERY)
EMERY_P_200605 <- crop(P_200605, EMERY)
EMERY_P_200606 <- crop(P_200606, EMERY)  
EMERY_P_200607 <- crop(P_200607, EMERY)  
EMERY_P_200608 <- crop(P_200608, EMERY)  
EMERY_P_200609 <- crop(P_200609, EMERY)  
EMERY_P_200610 <- crop(P_200610, EMERY)  
EMERY_P_200611 <- crop(P_200611, EMERY)  
EMERY_P_200612 <- crop(P_200612, EMERY)  
#2007
EMERY_P_200701 <- crop(P_200701, EMERY) 
EMERY_P_200702 <- crop(P_200702, EMERY)
EMERY_P_200703 <- crop(P_200703, EMERY)
EMERY_P_200704 <- crop(P_200704, EMERY)
EMERY_P_200705 <- crop(P_200705, EMERY)
EMERY_P_200706 <- crop(P_200706, EMERY)  
EMERY_P_200707 <- crop(P_200707, EMERY)  
EMERY_P_200708 <- crop(P_200708, EMERY)  
EMERY_P_200709 <- crop(P_200709, EMERY)  
EMERY_P_200710 <- crop(P_200710, EMERY)  
EMERY_P_200711 <- crop(P_200711, EMERY)  
EMERY_P_200712 <- crop(P_200712, EMERY)  
#2008
EMERY_P_200801 <- crop(P_200801, EMERY) 
EMERY_P_200802 <- crop(P_200802, EMERY)
EMERY_P_200803 <- crop(P_200803, EMERY)
EMERY_P_200804 <- crop(P_200804, EMERY)
EMERY_P_200805 <- crop(P_200805, EMERY)
EMERY_P_200806 <- crop(P_200806, EMERY)  
EMERY_P_200807 <- crop(P_200807, EMERY)  
EMERY_P_200808 <- crop(P_200808, EMERY)  
EMERY_P_200809 <- crop(P_200809, EMERY)  
EMERY_P_200810 <- crop(P_200810, EMERY)  
EMERY_P_200811 <- crop(P_200811, EMERY)  
EMERY_P_200812 <- crop(P_200812, EMERY)  
#2009
EMERY_P_200901 <- crop(P_200901, EMERY) 
EMERY_P_200902 <- crop(P_200902, EMERY)
EMERY_P_200903 <- crop(P_200903, EMERY)
EMERY_P_200904 <- crop(P_200904, EMERY)
EMERY_P_200905 <- crop(P_200905, EMERY)
EMERY_P_200906 <- crop(P_200906, EMERY)  
EMERY_P_200907 <- crop(P_200907, EMERY)  
EMERY_P_200908 <- crop(P_200908, EMERY)  
EMERY_P_200909 <- crop(P_200909, EMERY)  
EMERY_P_200910 <- crop(P_200910, EMERY)  
EMERY_P_200911 <- crop(P_200911, EMERY)  
EMERY_P_200912 <- crop(P_200912, EMERY)  
#2010
EMERY_P_201001 <- crop(P_201001, EMERY) 
EMERY_P_201002 <- crop(P_201002, EMERY)
EMERY_P_201003 <- crop(P_201003, EMERY)
EMERY_P_201004 <- crop(P_201004, EMERY)
EMERY_P_201005 <- crop(P_201005, EMERY)
EMERY_P_201006 <- crop(P_201006, EMERY)  
EMERY_P_201007 <- crop(P_201007, EMERY)  
EMERY_P_201008 <- crop(P_201008, EMERY)  
EMERY_P_201009 <- crop(P_201009, EMERY)  
EMERY_P_201010 <- crop(P_201010, EMERY)  
EMERY_P_201011 <- crop(P_201011, EMERY)  
EMERY_P_201012 <- crop(P_201012, EMERY)  
#2011
EMERY_P_201101 <- crop(P_201101, EMERY) 
EMERY_P_201102 <- crop(P_201102, EMERY)
EMERY_P_201103 <- crop(P_201103, EMERY)
EMERY_P_201104 <- crop(P_201104, EMERY)
EMERY_P_201105 <- crop(P_201105, EMERY)
EMERY_P_201106 <- crop(P_201106, EMERY)  
EMERY_P_201107 <- crop(P_201107, EMERY)  
EMERY_P_201108 <- crop(P_201108, EMERY)  
EMERY_P_201109 <- crop(P_201109, EMERY)  
EMERY_P_201110 <- crop(P_201110, EMERY)  
EMERY_P_201111 <- crop(P_201111, EMERY)  
EMERY_P_201112 <- crop(P_201112, EMERY)  
#2012
EMERY_P_201201 <- crop(P_201201, EMERY) 
EMERY_P_201202 <- crop(P_201202, EMERY)
EMERY_P_201203 <- crop(P_201203, EMERY)
EMERY_P_201204 <- crop(P_201204, EMERY)
EMERY_P_201205 <- crop(P_201205, EMERY)
EMERY_P_201206 <- crop(P_201206, EMERY)  
EMERY_P_201207 <- crop(P_201207, EMERY)  
EMERY_P_201208 <- crop(P_201208, EMERY)  
EMERY_P_201209 <- crop(P_201209, EMERY)  
EMERY_P_201210 <- crop(P_201210, EMERY)  
EMERY_P_201211 <- crop(P_201211, EMERY)  
EMERY_P_201212 <- crop(P_201212, EMERY)  
#2013
EMERY_P_201301 <- crop(P_201301, EMERY) 
EMERY_P_201302 <- crop(P_201302, EMERY)
EMERY_P_201303 <- crop(P_201303, EMERY)
EMERY_P_201304 <- crop(P_201304, EMERY)
EMERY_P_201305 <- crop(P_201305, EMERY)
EMERY_P_201306 <- crop(P_201306, EMERY)  
EMERY_P_201307 <- crop(P_201307, EMERY)  
EMERY_P_201308 <- crop(P_201308, EMERY)  
EMERY_P_201309 <- crop(P_201309, EMERY)  
EMERY_P_201310 <- crop(P_201310, EMERY)  
EMERY_P_201311 <- crop(P_201311, EMERY)  
EMERY_P_201312 <- crop(P_201312, EMERY)  
#2014
EMERY_P_201401 <- crop(P_201401, EMERY) 
EMERY_P_201402 <- crop(P_201402, EMERY)
EMERY_P_201403 <- crop(P_201403, EMERY)
EMERY_P_201404 <- crop(P_201404, EMERY)
EMERY_P_201405 <- crop(P_201405, EMERY)
EMERY_P_201406 <- crop(P_201406, EMERY)  
EMERY_P_201407 <- crop(P_201407, EMERY)  
EMERY_P_201408 <- crop(P_201408, EMERY)  
EMERY_P_201409 <- crop(P_201409, EMERY)  
EMERY_P_201410 <- crop(P_201410, EMERY)  
EMERY_P_201411 <- crop(P_201411, EMERY)  
EMERY_P_201412 <- crop(P_201412, EMERY)  
#2015
EMERY_P_201501 <- crop(P_201501, EMERY) 
EMERY_P_201502 <- crop(P_201502, EMERY)
EMERY_P_201503 <- crop(P_201503, EMERY)
EMERY_P_201504 <- crop(P_201504, EMERY)
EMERY_P_201505 <- crop(P_201505, EMERY)
EMERY_P_201506 <- crop(P_201506, EMERY)  
EMERY_P_201507 <- crop(P_201507, EMERY)  
EMERY_P_201508 <- crop(P_201508, EMERY)  
EMERY_P_201509 <- crop(P_201509, EMERY)  
EMERY_P_201510 <- crop(P_201510, EMERY)  
EMERY_P_201511 <- crop(P_201511, EMERY)  
EMERY_P_201512 <- crop(P_201512, EMERY)  
#2016
EMERY_P_201601 <- crop(P_201601, EMERY) 
EMERY_P_201602 <- crop(P_201602, EMERY)
EMERY_P_201603 <- crop(P_201603, EMERY)
EMERY_P_201604 <- crop(P_201604, EMERY)
EMERY_P_201605 <- crop(P_201605, EMERY)
EMERY_P_201606 <- crop(P_201606, EMERY)  
EMERY_P_201607 <- crop(P_201607, EMERY)  
EMERY_P_201608 <- crop(P_201608, EMERY)  
EMERY_P_201609 <- crop(P_201609, EMERY)  
EMERY_P_201610 <- crop(P_201610, EMERY)  
EMERY_P_201611 <- crop(P_201611, EMERY)  
EMERY_P_201612 <- crop(P_201612, EMERY)  
#2017
EMERY_P_201701 <- crop(P_201701, EMERY) 
EMERY_P_201702 <- crop(P_201702, EMERY)
EMERY_P_201703 <- crop(P_201703, EMERY)
EMERY_P_201704 <- crop(P_201704, EMERY)
EMERY_P_201705 <- crop(P_201705, EMERY)
EMERY_P_201706 <- crop(P_201706, EMERY)  
EMERY_P_201707 <- crop(P_201707, EMERY)  
EMERY_P_201708 <- crop(P_201708, EMERY)  
EMERY_P_201709 <- crop(P_201709, EMERY)  
EMERY_P_201710 <- crop(P_201710, EMERY)  
EMERY_P_201711 <- crop(P_201711, EMERY)  
EMERY_P_201712 <- crop(P_201712, EMERY)  

#2018

EMERY_P_201801 <- crop(P_201801, EMERY) 
EMERY_P_201802 <- crop(P_201802, EMERY)
EMERY_P_201803 <- crop(P_201803, EMERY)
EMERY_P_201804 <- crop(P_201804, EMERY)
EMERY_P_201805 <- crop(P_201805, EMERY)
EMERY_P_201806 <- crop(P_201806, EMERY)  
EMERY_P_201807 <- crop(P_201807, EMERY)  
EMERY_P_201808 <- crop(P_201808, EMERY)  
EMERY_P_201809 <- crop(P_201809, EMERY)  
EMERY_P_201810 <- crop(P_201810, EMERY)  
EMERY_P_201811 <- crop(P_201811, EMERY)  
EMERY_P_201812 <- crop(P_201812, EMERY)  


# Mean Monthly Precipitation
#2000
EMERY_P_200001_mean <- cellStats(EMERY_P_200001, mean)
EMERY_P_200002_mean <- cellStats(EMERY_P_200002, mean)
EMERY_P_200003_mean <- cellStats(EMERY_P_200003, mean)
EMERY_P_200004_mean <- cellStats(EMERY_P_200004, mean)
EMERY_P_200005_mean <- cellStats(EMERY_P_200005, mean)
EMERY_P_200006_mean <- cellStats(EMERY_P_200006, mean)
EMERY_P_200007_mean <- cellStats(EMERY_P_200007, mean)
EMERY_P_200008_mean <- cellStats(EMERY_P_200008, mean)
EMERY_P_200009_mean <- cellStats(EMERY_P_200009, mean)
EMERY_P_200010_mean <- cellStats(EMERY_P_200010, mean)
EMERY_P_200011_mean <- cellStats(EMERY_P_200011, mean)
EMERY_P_200012_mean <- cellStats(EMERY_P_200012, mean)
#2001
EMERY_P_200101_mean <- cellStats(EMERY_P_200101, mean)
EMERY_P_200102_mean <- cellStats(EMERY_P_200102, mean)
EMERY_P_200103_mean <- cellStats(EMERY_P_200103, mean)
EMERY_P_200104_mean <- cellStats(EMERY_P_200104, mean)
EMERY_P_200105_mean <- cellStats(EMERY_P_200105, mean)
EMERY_P_200106_mean <- cellStats(EMERY_P_200106, mean)
EMERY_P_200107_mean <- cellStats(EMERY_P_200107, mean)
EMERY_P_200108_mean <- cellStats(EMERY_P_200108, mean)
EMERY_P_200109_mean <- cellStats(EMERY_P_200109, mean)
EMERY_P_200110_mean <- cellStats(EMERY_P_200110, mean)
EMERY_P_200111_mean <- cellStats(EMERY_P_200111, mean)
EMERY_P_200112_mean <- cellStats(EMERY_P_200112, mean)

#2002
EMERY_P_200201_mean <- cellStats(EMERY_P_200201, mean)
EMERY_P_200202_mean <- cellStats(EMERY_P_200202, mean)
EMERY_P_200203_mean <- cellStats(EMERY_P_200203, mean)
EMERY_P_200204_mean <- cellStats(EMERY_P_200204, mean)
EMERY_P_200205_mean <- cellStats(EMERY_P_200205, mean)
EMERY_P_200206_mean <- cellStats(EMERY_P_200206, mean)
EMERY_P_200207_mean <- cellStats(EMERY_P_200207, mean)
EMERY_P_200208_mean <- cellStats(EMERY_P_200208, mean)
EMERY_P_200209_mean <- cellStats(EMERY_P_200209, mean)
EMERY_P_200210_mean <- cellStats(EMERY_P_200210, mean)
EMERY_P_200211_mean <- cellStats(EMERY_P_200211, mean)
EMERY_P_200212_mean <- cellStats(EMERY_P_200212, mean)

#2003
EMERY_P_200301_mean <- cellStats(EMERY_P_200301, mean)
EMERY_P_200302_mean <- cellStats(EMERY_P_200302, mean)
EMERY_P_200303_mean <- cellStats(EMERY_P_200303, mean)
EMERY_P_200304_mean <- cellStats(EMERY_P_200304, mean)
EMERY_P_200305_mean <- cellStats(EMERY_P_200305, mean)
EMERY_P_200306_mean <- cellStats(EMERY_P_200306, mean)
EMERY_P_200307_mean <- cellStats(EMERY_P_200307, mean)
EMERY_P_200308_mean <- cellStats(EMERY_P_200308, mean)
EMERY_P_200309_mean <- cellStats(EMERY_P_200309, mean)
EMERY_P_200310_mean <- cellStats(EMERY_P_200310, mean)
EMERY_P_200311_mean <- cellStats(EMERY_P_200311, mean)
EMERY_P_200312_mean <- cellStats(EMERY_P_200312, mean)

#2004

EMERY_P_200401_mean <- cellStats(EMERY_P_200401, mean)
EMERY_P_200402_mean <- cellStats(EMERY_P_200402, mean)
EMERY_P_200403_mean <- cellStats(EMERY_P_200403, mean)
EMERY_P_200404_mean <- cellStats(EMERY_P_200404, mean)
EMERY_P_200405_mean <- cellStats(EMERY_P_200405, mean)
EMERY_P_200406_mean <- cellStats(EMERY_P_200406, mean)
EMERY_P_200407_mean <- cellStats(EMERY_P_200407, mean)
EMERY_P_200408_mean <- cellStats(EMERY_P_200408, mean)
EMERY_P_200409_mean <- cellStats(EMERY_P_200409, mean)
EMERY_P_200410_mean <- cellStats(EMERY_P_200410, mean)
EMERY_P_200411_mean <- cellStats(EMERY_P_200411, mean)
EMERY_P_200412_mean <- cellStats(EMERY_P_200412, mean)

#2005

EMERY_P_200501_mean <- cellStats(EMERY_P_200501, mean)
EMERY_P_200502_mean <- cellStats(EMERY_P_200502, mean)
EMERY_P_200503_mean <- cellStats(EMERY_P_200503, mean)
EMERY_P_200504_mean <- cellStats(EMERY_P_200504, mean)
EMERY_P_200505_mean <- cellStats(EMERY_P_200505, mean)
EMERY_P_200506_mean <- cellStats(EMERY_P_200506, mean)
EMERY_P_200507_mean <- cellStats(EMERY_P_200507, mean)
EMERY_P_200508_mean <- cellStats(EMERY_P_200508, mean)
EMERY_P_200509_mean <- cellStats(EMERY_P_200509, mean)
EMERY_P_200510_mean <- cellStats(EMERY_P_200510, mean)
EMERY_P_200511_mean <- cellStats(EMERY_P_200511, mean)
EMERY_P_200512_mean <- cellStats(EMERY_P_200512, mean)

#2006

EMERY_P_200601_mean <- cellStats(EMERY_P_200601, mean)
EMERY_P_200602_mean <- cellStats(EMERY_P_200602, mean)
EMERY_P_200603_mean <- cellStats(EMERY_P_200603, mean)
EMERY_P_200604_mean <- cellStats(EMERY_P_200604, mean)
EMERY_P_200605_mean <- cellStats(EMERY_P_200605, mean)
EMERY_P_200606_mean <- cellStats(EMERY_P_200606, mean)
EMERY_P_200607_mean <- cellStats(EMERY_P_200607, mean)
EMERY_P_200608_mean <- cellStats(EMERY_P_200608, mean)
EMERY_P_200609_mean <- cellStats(EMERY_P_200609, mean)
EMERY_P_200610_mean <- cellStats(EMERY_P_200610, mean)
EMERY_P_200611_mean <- cellStats(EMERY_P_200611, mean)
EMERY_P_200612_mean <- cellStats(EMERY_P_200612, mean)

#2007

EMERY_P_200701_mean <- cellStats(EMERY_P_200701, mean)
EMERY_P_200702_mean <- cellStats(EMERY_P_200702, mean)
EMERY_P_200703_mean <- cellStats(EMERY_P_200703, mean)
EMERY_P_200704_mean <- cellStats(EMERY_P_200704, mean)
EMERY_P_200705_mean <- cellStats(EMERY_P_200705, mean)
EMERY_P_200706_mean <- cellStats(EMERY_P_200706, mean)
EMERY_P_200707_mean <- cellStats(EMERY_P_200707, mean)
EMERY_P_200708_mean <- cellStats(EMERY_P_200708, mean)
EMERY_P_200709_mean <- cellStats(EMERY_P_200709, mean)
EMERY_P_200710_mean <- cellStats(EMERY_P_200710, mean)
EMERY_P_200711_mean <- cellStats(EMERY_P_200711, mean)
EMERY_P_200712_mean <- cellStats(EMERY_P_200712, mean)

#2008

EMERY_P_200801_mean <- cellStats(EMERY_P_200801, mean)
EMERY_P_200802_mean <- cellStats(EMERY_P_200802, mean)
EMERY_P_200803_mean <- cellStats(EMERY_P_200803, mean)
EMERY_P_200804_mean <- cellStats(EMERY_P_200804, mean)
EMERY_P_200805_mean <- cellStats(EMERY_P_200805, mean)
EMERY_P_200806_mean <- cellStats(EMERY_P_200806, mean)
EMERY_P_200807_mean <- cellStats(EMERY_P_200807, mean)
EMERY_P_200808_mean <- cellStats(EMERY_P_200808, mean)
EMERY_P_200809_mean <- cellStats(EMERY_P_200809, mean)
EMERY_P_200810_mean <- cellStats(EMERY_P_200810, mean)
EMERY_P_200811_mean <- cellStats(EMERY_P_200811, mean)
EMERY_P_200812_mean <- cellStats(EMERY_P_200812, mean)

#2009

EMERY_P_200901_mean <- cellStats(EMERY_P_200901, mean)
EMERY_P_200902_mean <- cellStats(EMERY_P_200902, mean)
EMERY_P_200903_mean <- cellStats(EMERY_P_200903, mean)
EMERY_P_200904_mean <- cellStats(EMERY_P_200904, mean)
EMERY_P_200905_mean <- cellStats(EMERY_P_200905, mean)
EMERY_P_200906_mean <- cellStats(EMERY_P_200906, mean)
EMERY_P_200907_mean <- cellStats(EMERY_P_200907, mean)
EMERY_P_200908_mean <- cellStats(EMERY_P_200908, mean)
EMERY_P_200909_mean <- cellStats(EMERY_P_200909, mean)
EMERY_P_200910_mean <- cellStats(EMERY_P_200910, mean)
EMERY_P_200911_mean <- cellStats(EMERY_P_200911, mean)
EMERY_P_200912_mean <- cellStats(EMERY_P_200912, mean)

#2010

EMERY_P_201001_mean <- cellStats(EMERY_P_201001, mean)
EMERY_P_201002_mean <- cellStats(EMERY_P_201002, mean)
EMERY_P_201003_mean <- cellStats(EMERY_P_201003, mean)
EMERY_P_201004_mean <- cellStats(EMERY_P_201004, mean)
EMERY_P_201005_mean <- cellStats(EMERY_P_201005, mean)
EMERY_P_201006_mean <- cellStats(EMERY_P_201006, mean)
EMERY_P_201007_mean <- cellStats(EMERY_P_201007, mean)
EMERY_P_201008_mean <- cellStats(EMERY_P_201008, mean)
EMERY_P_201009_mean <- cellStats(EMERY_P_201009, mean)
EMERY_P_201010_mean <- cellStats(EMERY_P_201010, mean)
EMERY_P_201011_mean <- cellStats(EMERY_P_201011, mean)
EMERY_P_201012_mean <- cellStats(EMERY_P_201012, mean)

#2011

EMERY_P_201101_mean <- cellStats(EMERY_P_201101, mean)
EMERY_P_201102_mean <- cellStats(EMERY_P_201102, mean)
EMERY_P_201103_mean <- cellStats(EMERY_P_201103, mean)
EMERY_P_201104_mean <- cellStats(EMERY_P_201104, mean)
EMERY_P_201105_mean <- cellStats(EMERY_P_201105, mean)
EMERY_P_201106_mean <- cellStats(EMERY_P_201106, mean)
EMERY_P_201107_mean <- cellStats(EMERY_P_201107, mean)
EMERY_P_201108_mean <- cellStats(EMERY_P_201108, mean)
EMERY_P_201109_mean <- cellStats(EMERY_P_201109, mean)
EMERY_P_201110_mean <- cellStats(EMERY_P_201110, mean)
EMERY_P_201111_mean <- cellStats(EMERY_P_201111, mean)
EMERY_P_201112_mean <- cellStats(EMERY_P_201112, mean)

#2012
EMERY_P_201201_mean <- cellStats(EMERY_P_201201, mean)
EMERY_P_201202_mean <- cellStats(EMERY_P_201202, mean)
EMERY_P_201203_mean <- cellStats(EMERY_P_201203, mean)
EMERY_P_201204_mean <- cellStats(EMERY_P_201204, mean)
EMERY_P_201205_mean <- cellStats(EMERY_P_201205, mean)
EMERY_P_201206_mean <- cellStats(EMERY_P_201206, mean)
EMERY_P_201207_mean <- cellStats(EMERY_P_201207, mean)
EMERY_P_201208_mean <- cellStats(EMERY_P_201208, mean)
EMERY_P_201209_mean <- cellStats(EMERY_P_201209, mean)
EMERY_P_201210_mean <- cellStats(EMERY_P_201210, mean)
EMERY_P_201211_mean <- cellStats(EMERY_P_201211, mean)
EMERY_P_201212_mean <- cellStats(EMERY_P_201212, mean)

#2013
EMERY_P_201301_mean <- cellStats(EMERY_P_201301, mean)
EMERY_P_201302_mean <- cellStats(EMERY_P_201302, mean)
EMERY_P_201303_mean <- cellStats(EMERY_P_201303, mean)
EMERY_P_201304_mean <- cellStats(EMERY_P_201304, mean)
EMERY_P_201305_mean <- cellStats(EMERY_P_201305, mean)
EMERY_P_201306_mean <- cellStats(EMERY_P_201306, mean)
EMERY_P_201307_mean <- cellStats(EMERY_P_201307, mean)
EMERY_P_201308_mean <- cellStats(EMERY_P_201308, mean)
EMERY_P_201309_mean <- cellStats(EMERY_P_201309, mean)
EMERY_P_201310_mean <- cellStats(EMERY_P_201310, mean)
EMERY_P_201311_mean <- cellStats(EMERY_P_201311, mean)
EMERY_P_201312_mean <- cellStats(EMERY_P_201312, mean)

#2014
EMERY_P_201401_mean <- cellStats(EMERY_P_201401, mean)
EMERY_P_201402_mean <- cellStats(EMERY_P_201402, mean)
EMERY_P_201403_mean <- cellStats(EMERY_P_201403, mean)
EMERY_P_201404_mean <- cellStats(EMERY_P_201404, mean)
EMERY_P_201405_mean <- cellStats(EMERY_P_201405, mean)
EMERY_P_201406_mean <- cellStats(EMERY_P_201406, mean)
EMERY_P_201407_mean <- cellStats(EMERY_P_201407, mean)
EMERY_P_201408_mean <- cellStats(EMERY_P_201408, mean)
EMERY_P_201409_mean <- cellStats(EMERY_P_201409, mean)
EMERY_P_201410_mean <- cellStats(EMERY_P_201410, mean)
EMERY_P_201411_mean <- cellStats(EMERY_P_201411, mean)
EMERY_P_201412_mean <- cellStats(EMERY_P_201412, mean)

#2015
EMERY_P_201501_mean <- cellStats(EMERY_P_201501, mean)
EMERY_P_201502_mean <- cellStats(EMERY_P_201502, mean)
EMERY_P_201503_mean <- cellStats(EMERY_P_201503, mean)
EMERY_P_201504_mean <- cellStats(EMERY_P_201504, mean)
EMERY_P_201505_mean <- cellStats(EMERY_P_201505, mean)
EMERY_P_201506_mean <- cellStats(EMERY_P_201506, mean)
EMERY_P_201507_mean <- cellStats(EMERY_P_201507, mean)
EMERY_P_201508_mean <- cellStats(EMERY_P_201508, mean)
EMERY_P_201509_mean <- cellStats(EMERY_P_201509, mean)
EMERY_P_201510_mean <- cellStats(EMERY_P_201510, mean)
EMERY_P_201511_mean <- cellStats(EMERY_P_201511, mean)
EMERY_P_201512_mean <- cellStats(EMERY_P_201512, mean)

#2016
EMERY_P_201601_mean <- cellStats(EMERY_P_201601, mean)
EMERY_P_201602_mean <- cellStats(EMERY_P_201602, mean)
EMERY_P_201603_mean <- cellStats(EMERY_P_201603, mean)
EMERY_P_201604_mean <- cellStats(EMERY_P_201604, mean)
EMERY_P_201605_mean <- cellStats(EMERY_P_201605, mean)
EMERY_P_201606_mean <- cellStats(EMERY_P_201606, mean)
EMERY_P_201607_mean <- cellStats(EMERY_P_201607, mean)
EMERY_P_201608_mean <- cellStats(EMERY_P_201608, mean)
EMERY_P_201609_mean <- cellStats(EMERY_P_201609, mean)
EMERY_P_201610_mean <- cellStats(EMERY_P_201610, mean)
EMERY_P_201611_mean <- cellStats(EMERY_P_201611, mean)
EMERY_P_201612_mean <- cellStats(EMERY_P_201612, mean)

#2017
EMERY_P_201701_mean <- cellStats(EMERY_P_201701, mean)
EMERY_P_201702_mean <- cellStats(EMERY_P_201702, mean)
EMERY_P_201703_mean <- cellStats(EMERY_P_201703, mean)
EMERY_P_201704_mean <- cellStats(EMERY_P_201704, mean)
EMERY_P_201705_mean <- cellStats(EMERY_P_201705, mean)
EMERY_P_201706_mean <- cellStats(EMERY_P_201706, mean)
EMERY_P_201707_mean <- cellStats(EMERY_P_201707, mean)
EMERY_P_201708_mean <- cellStats(EMERY_P_201708, mean)
EMERY_P_201709_mean <- cellStats(EMERY_P_201709, mean)
EMERY_P_201710_mean <- cellStats(EMERY_P_201710, mean)
EMERY_P_201711_mean <- cellStats(EMERY_P_201711, mean)
EMERY_P_201712_mean <- cellStats(EMERY_P_201712, mean)

#2018
EMERY_P_201801_mean <- cellStats(EMERY_P_201801, mean)
EMERY_P_201802_mean <- cellStats(EMERY_P_201802, mean)
EMERY_P_201803_mean <- cellStats(EMERY_P_201803, mean)
EMERY_P_201804_mean <- cellStats(EMERY_P_201804, mean)
EMERY_P_201805_mean <- cellStats(EMERY_P_201805, mean)
EMERY_P_201806_mean <- cellStats(EMERY_P_201806, mean)
EMERY_P_201807_mean <- cellStats(EMERY_P_201807, mean)
EMERY_P_201808_mean <- cellStats(EMERY_P_201808, mean)
EMERY_P_201809_mean <- cellStats(EMERY_P_201809, mean)
EMERY_P_201810_mean <- cellStats(EMERY_P_201810, mean)
EMERY_P_201811_mean <- cellStats(EMERY_P_201811, mean)
EMERY_P_201812_mean <- cellStats(EMERY_P_201812, mean)

# GRAND


#2000
GRAND_P_200001 <- crop(P_200001, GRAND) 
GRAND_P_200002 <- crop(P_200002, GRAND)
GRAND_P_200003 <- crop(P_200003, GRAND)
GRAND_P_200004 <- crop(P_200004, GRAND)
GRAND_P_200005 <- crop(P_200005, GRAND)
GRAND_P_200006 <- crop(P_200006, GRAND)  
GRAND_P_200007 <- crop(P_200007, GRAND)  
GRAND_P_200008 <- crop(P_200008, GRAND)  
GRAND_P_200009 <- crop(P_200009, GRAND)  
GRAND_P_200010 <- crop(P_200010, GRAND)  
GRAND_P_200011 <- crop(P_200011, GRAND)  
GRAND_P_200012 <- crop(P_200012, GRAND)  
#2001
GRAND_P_200101 <- crop(P_200101, GRAND) 
GRAND_P_200102 <- crop(P_200102, GRAND)
GRAND_P_200103 <- crop(P_200103, GRAND)
GRAND_P_200104 <- crop(P_200104, GRAND)
GRAND_P_200105 <- crop(P_200105, GRAND)
GRAND_P_200106 <- crop(P_200106, GRAND)  
GRAND_P_200107 <- crop(P_200107, GRAND)  
GRAND_P_200108 <- crop(P_200108, GRAND)  
GRAND_P_200109 <- crop(P_200109, GRAND)  
GRAND_P_200110 <- crop(P_200110, GRAND)  
GRAND_P_200111 <- crop(P_200111, GRAND)  
GRAND_P_200112 <- crop(P_200112, GRAND)  

#2002
GRAND_P_200201 <- crop(P_200201, GRAND) 
GRAND_P_200202 <- crop(P_200202, GRAND)
GRAND_P_200203 <- crop(P_200203, GRAND)
GRAND_P_200204 <- crop(P_200204, GRAND)
GRAND_P_200205 <- crop(P_200205, GRAND)
GRAND_P_200206 <- crop(P_200206, GRAND)  
GRAND_P_200207 <- crop(P_200207, GRAND)  
GRAND_P_200208 <- crop(P_200208, GRAND)  
GRAND_P_200209 <- crop(P_200209, GRAND)  
GRAND_P_200210 <- crop(P_200210, GRAND)  
GRAND_P_200211 <- crop(P_200211, GRAND)  
GRAND_P_200212 <- crop(P_200212, GRAND)  
#2003
GRAND_P_200301 <- crop(P_200301, GRAND) 
GRAND_P_200302 <- crop(P_200302, GRAND)
GRAND_P_200303 <- crop(P_200303, GRAND)
GRAND_P_200304 <- crop(P_200304, GRAND)
GRAND_P_200305 <- crop(P_200305, GRAND)
GRAND_P_200306 <- crop(P_200306, GRAND)  
GRAND_P_200307 <- crop(P_200307, GRAND)  
GRAND_P_200308 <- crop(P_200308, GRAND)  
GRAND_P_200309 <- crop(P_200309, GRAND)  
GRAND_P_200310 <- crop(P_200310, GRAND)  
GRAND_P_200311 <- crop(P_200311, GRAND)  
GRAND_P_200312 <- crop(P_200312, GRAND)  
#2004
GRAND_P_200401 <- crop(P_200401, GRAND) 
GRAND_P_200402 <- crop(P_200402, GRAND)
GRAND_P_200403 <- crop(P_200403, GRAND)
GRAND_P_200404 <- crop(P_200404, GRAND)
GRAND_P_200405 <- crop(P_200405, GRAND)
GRAND_P_200406 <- crop(P_200406, GRAND)  
GRAND_P_200407 <- crop(P_200407, GRAND)  
GRAND_P_200408 <- crop(P_200408, GRAND)  
GRAND_P_200409 <- crop(P_200409, GRAND)  
GRAND_P_200410 <- crop(P_200410, GRAND)  
GRAND_P_200411 <- crop(P_200411, GRAND)  
GRAND_P_200412 <- crop(P_200412, GRAND)  
#2005
GRAND_P_200501 <- crop(P_200501, GRAND) 
GRAND_P_200502 <- crop(P_200502, GRAND)
GRAND_P_200503 <- crop(P_200503, GRAND)
GRAND_P_200504 <- crop(P_200504, GRAND)
GRAND_P_200505 <- crop(P_200505, GRAND)
GRAND_P_200506 <- crop(P_200506, GRAND)  
GRAND_P_200507 <- crop(P_200507, GRAND)  
GRAND_P_200508 <- crop(P_200508, GRAND)  
GRAND_P_200509 <- crop(P_200509, GRAND)  
GRAND_P_200510 <- crop(P_200510, GRAND)  
GRAND_P_200511 <- crop(P_200511, GRAND)  
GRAND_P_200512 <- crop(P_200512, GRAND)  
#2006
GRAND_P_200601 <- crop(P_200601, GRAND) 
GRAND_P_200602 <- crop(P_200602, GRAND)
GRAND_P_200603 <- crop(P_200603, GRAND)
GRAND_P_200604 <- crop(P_200604, GRAND)
GRAND_P_200605 <- crop(P_200605, GRAND)
GRAND_P_200606 <- crop(P_200606, GRAND)  
GRAND_P_200607 <- crop(P_200607, GRAND)  
GRAND_P_200608 <- crop(P_200608, GRAND)  
GRAND_P_200609 <- crop(P_200609, GRAND)  
GRAND_P_200610 <- crop(P_200610, GRAND)  
GRAND_P_200611 <- crop(P_200611, GRAND)  
GRAND_P_200612 <- crop(P_200612, GRAND)  
#2007
GRAND_P_200701 <- crop(P_200701, GRAND) 
GRAND_P_200702 <- crop(P_200702, GRAND)
GRAND_P_200703 <- crop(P_200703, GRAND)
GRAND_P_200704 <- crop(P_200704, GRAND)
GRAND_P_200705 <- crop(P_200705, GRAND)
GRAND_P_200706 <- crop(P_200706, GRAND)  
GRAND_P_200707 <- crop(P_200707, GRAND)  
GRAND_P_200708 <- crop(P_200708, GRAND)  
GRAND_P_200709 <- crop(P_200709, GRAND)  
GRAND_P_200710 <- crop(P_200710, GRAND)  
GRAND_P_200711 <- crop(P_200711, GRAND)  
GRAND_P_200712 <- crop(P_200712, GRAND)  
#2008
GRAND_P_200801 <- crop(P_200801, GRAND) 
GRAND_P_200802 <- crop(P_200802, GRAND)
GRAND_P_200803 <- crop(P_200803, GRAND)
GRAND_P_200804 <- crop(P_200804, GRAND)
GRAND_P_200805 <- crop(P_200805, GRAND)
GRAND_P_200806 <- crop(P_200806, GRAND)  
GRAND_P_200807 <- crop(P_200807, GRAND)  
GRAND_P_200808 <- crop(P_200808, GRAND)  
GRAND_P_200809 <- crop(P_200809, GRAND)  
GRAND_P_200810 <- crop(P_200810, GRAND)  
GRAND_P_200811 <- crop(P_200811, GRAND)  
GRAND_P_200812 <- crop(P_200812, GRAND)  
#2009
GRAND_P_200901 <- crop(P_200901, GRAND) 
GRAND_P_200902 <- crop(P_200902, GRAND)
GRAND_P_200903 <- crop(P_200903, GRAND)
GRAND_P_200904 <- crop(P_200904, GRAND)
GRAND_P_200905 <- crop(P_200905, GRAND)
GRAND_P_200906 <- crop(P_200906, GRAND)  
GRAND_P_200907 <- crop(P_200907, GRAND)  
GRAND_P_200908 <- crop(P_200908, GRAND)  
GRAND_P_200909 <- crop(P_200909, GRAND)  
GRAND_P_200910 <- crop(P_200910, GRAND)  
GRAND_P_200911 <- crop(P_200911, GRAND)  
GRAND_P_200912 <- crop(P_200912, GRAND)  
#2010
GRAND_P_201001 <- crop(P_201001, GRAND) 
GRAND_P_201002 <- crop(P_201002, GRAND)
GRAND_P_201003 <- crop(P_201003, GRAND)
GRAND_P_201004 <- crop(P_201004, GRAND)
GRAND_P_201005 <- crop(P_201005, GRAND)
GRAND_P_201006 <- crop(P_201006, GRAND)  
GRAND_P_201007 <- crop(P_201007, GRAND)  
GRAND_P_201008 <- crop(P_201008, GRAND)  
GRAND_P_201009 <- crop(P_201009, GRAND)  
GRAND_P_201010 <- crop(P_201010, GRAND)  
GRAND_P_201011 <- crop(P_201011, GRAND)  
GRAND_P_201012 <- crop(P_201012, GRAND)  
#2011
GRAND_P_201101 <- crop(P_201101, GRAND) 
GRAND_P_201102 <- crop(P_201102, GRAND)
GRAND_P_201103 <- crop(P_201103, GRAND)
GRAND_P_201104 <- crop(P_201104, GRAND)
GRAND_P_201105 <- crop(P_201105, GRAND)
GRAND_P_201106 <- crop(P_201106, GRAND)  
GRAND_P_201107 <- crop(P_201107, GRAND)  
GRAND_P_201108 <- crop(P_201108, GRAND)  
GRAND_P_201109 <- crop(P_201109, GRAND)  
GRAND_P_201110 <- crop(P_201110, GRAND)  
GRAND_P_201111 <- crop(P_201111, GRAND)  
GRAND_P_201112 <- crop(P_201112, GRAND)  
#2012
GRAND_P_201201 <- crop(P_201201, GRAND) 
GRAND_P_201202 <- crop(P_201202, GRAND)
GRAND_P_201203 <- crop(P_201203, GRAND)
GRAND_P_201204 <- crop(P_201204, GRAND)
GRAND_P_201205 <- crop(P_201205, GRAND)
GRAND_P_201206 <- crop(P_201206, GRAND)  
GRAND_P_201207 <- crop(P_201207, GRAND)  
GRAND_P_201208 <- crop(P_201208, GRAND)  
GRAND_P_201209 <- crop(P_201209, GRAND)  
GRAND_P_201210 <- crop(P_201210, GRAND)  
GRAND_P_201211 <- crop(P_201211, GRAND)  
GRAND_P_201212 <- crop(P_201212, GRAND)  
#2013
GRAND_P_201301 <- crop(P_201301, GRAND) 
GRAND_P_201302 <- crop(P_201302, GRAND)
GRAND_P_201303 <- crop(P_201303, GRAND)
GRAND_P_201304 <- crop(P_201304, GRAND)
GRAND_P_201305 <- crop(P_201305, GRAND)
GRAND_P_201306 <- crop(P_201306, GRAND)  
GRAND_P_201307 <- crop(P_201307, GRAND)  
GRAND_P_201308 <- crop(P_201308, GRAND)  
GRAND_P_201309 <- crop(P_201309, GRAND)  
GRAND_P_201310 <- crop(P_201310, GRAND)  
GRAND_P_201311 <- crop(P_201311, GRAND)  
GRAND_P_201312 <- crop(P_201312, GRAND)  
#2014
GRAND_P_201401 <- crop(P_201401, GRAND) 
GRAND_P_201402 <- crop(P_201402, GRAND)
GRAND_P_201403 <- crop(P_201403, GRAND)
GRAND_P_201404 <- crop(P_201404, GRAND)
GRAND_P_201405 <- crop(P_201405, GRAND)
GRAND_P_201406 <- crop(P_201406, GRAND)  
GRAND_P_201407 <- crop(P_201407, GRAND)  
GRAND_P_201408 <- crop(P_201408, GRAND)  
GRAND_P_201409 <- crop(P_201409, GRAND)  
GRAND_P_201410 <- crop(P_201410, GRAND)  
GRAND_P_201411 <- crop(P_201411, GRAND)  
GRAND_P_201412 <- crop(P_201412, GRAND)  
#2015
GRAND_P_201501 <- crop(P_201501, GRAND) 
GRAND_P_201502 <- crop(P_201502, GRAND)
GRAND_P_201503 <- crop(P_201503, GRAND)
GRAND_P_201504 <- crop(P_201504, GRAND)
GRAND_P_201505 <- crop(P_201505, GRAND)
GRAND_P_201506 <- crop(P_201506, GRAND)  
GRAND_P_201507 <- crop(P_201507, GRAND)  
GRAND_P_201508 <- crop(P_201508, GRAND)  
GRAND_P_201509 <- crop(P_201509, GRAND)  
GRAND_P_201510 <- crop(P_201510, GRAND)  
GRAND_P_201511 <- crop(P_201511, GRAND)  
GRAND_P_201512 <- crop(P_201512, GRAND)  
#2016
GRAND_P_201601 <- crop(P_201601, GRAND) 
GRAND_P_201602 <- crop(P_201602, GRAND)
GRAND_P_201603 <- crop(P_201603, GRAND)
GRAND_P_201604 <- crop(P_201604, GRAND)
GRAND_P_201605 <- crop(P_201605, GRAND)
GRAND_P_201606 <- crop(P_201606, GRAND)  
GRAND_P_201607 <- crop(P_201607, GRAND)  
GRAND_P_201608 <- crop(P_201608, GRAND)  
GRAND_P_201609 <- crop(P_201609, GRAND)  
GRAND_P_201610 <- crop(P_201610, GRAND)  
GRAND_P_201611 <- crop(P_201611, GRAND)  
GRAND_P_201612 <- crop(P_201612, GRAND)  
#2017
GRAND_P_201701 <- crop(P_201701, GRAND) 
GRAND_P_201702 <- crop(P_201702, GRAND)
GRAND_P_201703 <- crop(P_201703, GRAND)
GRAND_P_201704 <- crop(P_201704, GRAND)
GRAND_P_201705 <- crop(P_201705, GRAND)
GRAND_P_201706 <- crop(P_201706, GRAND)  
GRAND_P_201707 <- crop(P_201707, GRAND)  
GRAND_P_201708 <- crop(P_201708, GRAND)  
GRAND_P_201709 <- crop(P_201709, GRAND)  
GRAND_P_201710 <- crop(P_201710, GRAND)  
GRAND_P_201711 <- crop(P_201711, GRAND)  
GRAND_P_201712 <- crop(P_201712, GRAND)  

#2018

GRAND_P_201801 <- crop(P_201801, GRAND) 
GRAND_P_201802 <- crop(P_201802, GRAND)
GRAND_P_201803 <- crop(P_201803, GRAND)
GRAND_P_201804 <- crop(P_201804, GRAND)
GRAND_P_201805 <- crop(P_201805, GRAND)
GRAND_P_201806 <- crop(P_201806, GRAND)  
GRAND_P_201807 <- crop(P_201807, GRAND)  
GRAND_P_201808 <- crop(P_201808, GRAND)  
GRAND_P_201809 <- crop(P_201809, GRAND)  
GRAND_P_201810 <- crop(P_201810, GRAND)  
GRAND_P_201811 <- crop(P_201811, GRAND)  
GRAND_P_201812 <- crop(P_201812, GRAND)  


# Mean Monthly Precipitation
#2000
GRAND_P_200001_mean <- cellStats(GRAND_P_200001, mean)
GRAND_P_200002_mean <- cellStats(GRAND_P_200002, mean)
GRAND_P_200003_mean <- cellStats(GRAND_P_200003, mean)
GRAND_P_200004_mean <- cellStats(GRAND_P_200004, mean)
GRAND_P_200005_mean <- cellStats(GRAND_P_200005, mean)
GRAND_P_200006_mean <- cellStats(GRAND_P_200006, mean)
GRAND_P_200007_mean <- cellStats(GRAND_P_200007, mean)
GRAND_P_200008_mean <- cellStats(GRAND_P_200008, mean)
GRAND_P_200009_mean <- cellStats(GRAND_P_200009, mean)
GRAND_P_200010_mean <- cellStats(GRAND_P_200010, mean)
GRAND_P_200011_mean <- cellStats(GRAND_P_200011, mean)
GRAND_P_200012_mean <- cellStats(GRAND_P_200012, mean)
#2001
GRAND_P_200101_mean <- cellStats(GRAND_P_200101, mean)
GRAND_P_200102_mean <- cellStats(GRAND_P_200102, mean)
GRAND_P_200103_mean <- cellStats(GRAND_P_200103, mean)
GRAND_P_200104_mean <- cellStats(GRAND_P_200104, mean)
GRAND_P_200105_mean <- cellStats(GRAND_P_200105, mean)
GRAND_P_200106_mean <- cellStats(GRAND_P_200106, mean)
GRAND_P_200107_mean <- cellStats(GRAND_P_200107, mean)
GRAND_P_200108_mean <- cellStats(GRAND_P_200108, mean)
GRAND_P_200109_mean <- cellStats(GRAND_P_200109, mean)
GRAND_P_200110_mean <- cellStats(GRAND_P_200110, mean)
GRAND_P_200111_mean <- cellStats(GRAND_P_200111, mean)
GRAND_P_200112_mean <- cellStats(GRAND_P_200112, mean)

#2002
GRAND_P_200201_mean <- cellStats(GRAND_P_200201, mean)
GRAND_P_200202_mean <- cellStats(GRAND_P_200202, mean)
GRAND_P_200203_mean <- cellStats(GRAND_P_200203, mean)
GRAND_P_200204_mean <- cellStats(GRAND_P_200204, mean)
GRAND_P_200205_mean <- cellStats(GRAND_P_200205, mean)
GRAND_P_200206_mean <- cellStats(GRAND_P_200206, mean)
GRAND_P_200207_mean <- cellStats(GRAND_P_200207, mean)
GRAND_P_200208_mean <- cellStats(GRAND_P_200208, mean)
GRAND_P_200209_mean <- cellStats(GRAND_P_200209, mean)
GRAND_P_200210_mean <- cellStats(GRAND_P_200210, mean)
GRAND_P_200211_mean <- cellStats(GRAND_P_200211, mean)
GRAND_P_200212_mean <- cellStats(GRAND_P_200212, mean)

#2003
GRAND_P_200301_mean <- cellStats(GRAND_P_200301, mean)
GRAND_P_200302_mean <- cellStats(GRAND_P_200302, mean)
GRAND_P_200303_mean <- cellStats(GRAND_P_200303, mean)
GRAND_P_200304_mean <- cellStats(GRAND_P_200304, mean)
GRAND_P_200305_mean <- cellStats(GRAND_P_200305, mean)
GRAND_P_200306_mean <- cellStats(GRAND_P_200306, mean)
GRAND_P_200307_mean <- cellStats(GRAND_P_200307, mean)
GRAND_P_200308_mean <- cellStats(GRAND_P_200308, mean)
GRAND_P_200309_mean <- cellStats(GRAND_P_200309, mean)
GRAND_P_200310_mean <- cellStats(GRAND_P_200310, mean)
GRAND_P_200311_mean <- cellStats(GRAND_P_200311, mean)
GRAND_P_200312_mean <- cellStats(GRAND_P_200312, mean)

#2004

GRAND_P_200401_mean <- cellStats(GRAND_P_200401, mean)
GRAND_P_200402_mean <- cellStats(GRAND_P_200402, mean)
GRAND_P_200403_mean <- cellStats(GRAND_P_200403, mean)
GRAND_P_200404_mean <- cellStats(GRAND_P_200404, mean)
GRAND_P_200405_mean <- cellStats(GRAND_P_200405, mean)
GRAND_P_200406_mean <- cellStats(GRAND_P_200406, mean)
GRAND_P_200407_mean <- cellStats(GRAND_P_200407, mean)
GRAND_P_200408_mean <- cellStats(GRAND_P_200408, mean)
GRAND_P_200409_mean <- cellStats(GRAND_P_200409, mean)
GRAND_P_200410_mean <- cellStats(GRAND_P_200410, mean)
GRAND_P_200411_mean <- cellStats(GRAND_P_200411, mean)
GRAND_P_200412_mean <- cellStats(GRAND_P_200412, mean)

#2005

GRAND_P_200501_mean <- cellStats(GRAND_P_200501, mean)
GRAND_P_200502_mean <- cellStats(GRAND_P_200502, mean)
GRAND_P_200503_mean <- cellStats(GRAND_P_200503, mean)
GRAND_P_200504_mean <- cellStats(GRAND_P_200504, mean)
GRAND_P_200505_mean <- cellStats(GRAND_P_200505, mean)
GRAND_P_200506_mean <- cellStats(GRAND_P_200506, mean)
GRAND_P_200507_mean <- cellStats(GRAND_P_200507, mean)
GRAND_P_200508_mean <- cellStats(GRAND_P_200508, mean)
GRAND_P_200509_mean <- cellStats(GRAND_P_200509, mean)
GRAND_P_200510_mean <- cellStats(GRAND_P_200510, mean)
GRAND_P_200511_mean <- cellStats(GRAND_P_200511, mean)
GRAND_P_200512_mean <- cellStats(GRAND_P_200512, mean)

#2006

GRAND_P_200601_mean <- cellStats(GRAND_P_200601, mean)
GRAND_P_200602_mean <- cellStats(GRAND_P_200602, mean)
GRAND_P_200603_mean <- cellStats(GRAND_P_200603, mean)
GRAND_P_200604_mean <- cellStats(GRAND_P_200604, mean)
GRAND_P_200605_mean <- cellStats(GRAND_P_200605, mean)
GRAND_P_200606_mean <- cellStats(GRAND_P_200606, mean)
GRAND_P_200607_mean <- cellStats(GRAND_P_200607, mean)
GRAND_P_200608_mean <- cellStats(GRAND_P_200608, mean)
GRAND_P_200609_mean <- cellStats(GRAND_P_200609, mean)
GRAND_P_200610_mean <- cellStats(GRAND_P_200610, mean)
GRAND_P_200611_mean <- cellStats(GRAND_P_200611, mean)
GRAND_P_200612_mean <- cellStats(GRAND_P_200612, mean)

#2007

GRAND_P_200701_mean <- cellStats(GRAND_P_200701, mean)
GRAND_P_200702_mean <- cellStats(GRAND_P_200702, mean)
GRAND_P_200703_mean <- cellStats(GRAND_P_200703, mean)
GRAND_P_200704_mean <- cellStats(GRAND_P_200704, mean)
GRAND_P_200705_mean <- cellStats(GRAND_P_200705, mean)
GRAND_P_200706_mean <- cellStats(GRAND_P_200706, mean)
GRAND_P_200707_mean <- cellStats(GRAND_P_200707, mean)
GRAND_P_200708_mean <- cellStats(GRAND_P_200708, mean)
GRAND_P_200709_mean <- cellStats(GRAND_P_200709, mean)
GRAND_P_200710_mean <- cellStats(GRAND_P_200710, mean)
GRAND_P_200711_mean <- cellStats(GRAND_P_200711, mean)
GRAND_P_200712_mean <- cellStats(GRAND_P_200712, mean)

#2008

GRAND_P_200801_mean <- cellStats(GRAND_P_200801, mean)
GRAND_P_200802_mean <- cellStats(GRAND_P_200802, mean)
GRAND_P_200803_mean <- cellStats(GRAND_P_200803, mean)
GRAND_P_200804_mean <- cellStats(GRAND_P_200804, mean)
GRAND_P_200805_mean <- cellStats(GRAND_P_200805, mean)
GRAND_P_200806_mean <- cellStats(GRAND_P_200806, mean)
GRAND_P_200807_mean <- cellStats(GRAND_P_200807, mean)
GRAND_P_200808_mean <- cellStats(GRAND_P_200808, mean)
GRAND_P_200809_mean <- cellStats(GRAND_P_200809, mean)
GRAND_P_200810_mean <- cellStats(GRAND_P_200810, mean)
GRAND_P_200811_mean <- cellStats(GRAND_P_200811, mean)
GRAND_P_200812_mean <- cellStats(GRAND_P_200812, mean)

#2009

GRAND_P_200901_mean <- cellStats(GRAND_P_200901, mean)
GRAND_P_200902_mean <- cellStats(GRAND_P_200902, mean)
GRAND_P_200903_mean <- cellStats(GRAND_P_200903, mean)
GRAND_P_200904_mean <- cellStats(GRAND_P_200904, mean)
GRAND_P_200905_mean <- cellStats(GRAND_P_200905, mean)
GRAND_P_200906_mean <- cellStats(GRAND_P_200906, mean)
GRAND_P_200907_mean <- cellStats(GRAND_P_200907, mean)
GRAND_P_200908_mean <- cellStats(GRAND_P_200908, mean)
GRAND_P_200909_mean <- cellStats(GRAND_P_200909, mean)
GRAND_P_200910_mean <- cellStats(GRAND_P_200910, mean)
GRAND_P_200911_mean <- cellStats(GRAND_P_200911, mean)
GRAND_P_200912_mean <- cellStats(GRAND_P_200912, mean)

#2010

GRAND_P_201001_mean <- cellStats(GRAND_P_201001, mean)
GRAND_P_201002_mean <- cellStats(GRAND_P_201002, mean)
GRAND_P_201003_mean <- cellStats(GRAND_P_201003, mean)
GRAND_P_201004_mean <- cellStats(GRAND_P_201004, mean)
GRAND_P_201005_mean <- cellStats(GRAND_P_201005, mean)
GRAND_P_201006_mean <- cellStats(GRAND_P_201006, mean)
GRAND_P_201007_mean <- cellStats(GRAND_P_201007, mean)
GRAND_P_201008_mean <- cellStats(GRAND_P_201008, mean)
GRAND_P_201009_mean <- cellStats(GRAND_P_201009, mean)
GRAND_P_201010_mean <- cellStats(GRAND_P_201010, mean)
GRAND_P_201011_mean <- cellStats(GRAND_P_201011, mean)
GRAND_P_201012_mean <- cellStats(GRAND_P_201012, mean)

#2011

GRAND_P_201101_mean <- cellStats(GRAND_P_201101, mean)
GRAND_P_201102_mean <- cellStats(GRAND_P_201102, mean)
GRAND_P_201103_mean <- cellStats(GRAND_P_201103, mean)
GRAND_P_201104_mean <- cellStats(GRAND_P_201104, mean)
GRAND_P_201105_mean <- cellStats(GRAND_P_201105, mean)
GRAND_P_201106_mean <- cellStats(GRAND_P_201106, mean)
GRAND_P_201107_mean <- cellStats(GRAND_P_201107, mean)
GRAND_P_201108_mean <- cellStats(GRAND_P_201108, mean)
GRAND_P_201109_mean <- cellStats(GRAND_P_201109, mean)
GRAND_P_201110_mean <- cellStats(GRAND_P_201110, mean)
GRAND_P_201111_mean <- cellStats(GRAND_P_201111, mean)
GRAND_P_201112_mean <- cellStats(GRAND_P_201112, mean)

#2012
GRAND_P_201201_mean <- cellStats(GRAND_P_201201, mean)
GRAND_P_201202_mean <- cellStats(GRAND_P_201202, mean)
GRAND_P_201203_mean <- cellStats(GRAND_P_201203, mean)
GRAND_P_201204_mean <- cellStats(GRAND_P_201204, mean)
GRAND_P_201205_mean <- cellStats(GRAND_P_201205, mean)
GRAND_P_201206_mean <- cellStats(GRAND_P_201206, mean)
GRAND_P_201207_mean <- cellStats(GRAND_P_201207, mean)
GRAND_P_201208_mean <- cellStats(GRAND_P_201208, mean)
GRAND_P_201209_mean <- cellStats(GRAND_P_201209, mean)
GRAND_P_201210_mean <- cellStats(GRAND_P_201210, mean)
GRAND_P_201211_mean <- cellStats(GRAND_P_201211, mean)
GRAND_P_201212_mean <- cellStats(GRAND_P_201212, mean)

#2013
GRAND_P_201301_mean <- cellStats(GRAND_P_201301, mean)
GRAND_P_201302_mean <- cellStats(GRAND_P_201302, mean)
GRAND_P_201303_mean <- cellStats(GRAND_P_201303, mean)
GRAND_P_201304_mean <- cellStats(GRAND_P_201304, mean)
GRAND_P_201305_mean <- cellStats(GRAND_P_201305, mean)
GRAND_P_201306_mean <- cellStats(GRAND_P_201306, mean)
GRAND_P_201307_mean <- cellStats(GRAND_P_201307, mean)
GRAND_P_201308_mean <- cellStats(GRAND_P_201308, mean)
GRAND_P_201309_mean <- cellStats(GRAND_P_201309, mean)
GRAND_P_201310_mean <- cellStats(GRAND_P_201310, mean)
GRAND_P_201311_mean <- cellStats(GRAND_P_201311, mean)
GRAND_P_201312_mean <- cellStats(GRAND_P_201312, mean)

#2014
GRAND_P_201401_mean <- cellStats(GRAND_P_201401, mean)
GRAND_P_201402_mean <- cellStats(GRAND_P_201402, mean)
GRAND_P_201403_mean <- cellStats(GRAND_P_201403, mean)
GRAND_P_201404_mean <- cellStats(GRAND_P_201404, mean)
GRAND_P_201405_mean <- cellStats(GRAND_P_201405, mean)
GRAND_P_201406_mean <- cellStats(GRAND_P_201406, mean)
GRAND_P_201407_mean <- cellStats(GRAND_P_201407, mean)
GRAND_P_201408_mean <- cellStats(GRAND_P_201408, mean)
GRAND_P_201409_mean <- cellStats(GRAND_P_201409, mean)
GRAND_P_201410_mean <- cellStats(GRAND_P_201410, mean)
GRAND_P_201411_mean <- cellStats(GRAND_P_201411, mean)
GRAND_P_201412_mean <- cellStats(GRAND_P_201412, mean)

#2015
GRAND_P_201501_mean <- cellStats(GRAND_P_201501, mean)
GRAND_P_201502_mean <- cellStats(GRAND_P_201502, mean)
GRAND_P_201503_mean <- cellStats(GRAND_P_201503, mean)
GRAND_P_201504_mean <- cellStats(GRAND_P_201504, mean)
GRAND_P_201505_mean <- cellStats(GRAND_P_201505, mean)
GRAND_P_201506_mean <- cellStats(GRAND_P_201506, mean)
GRAND_P_201507_mean <- cellStats(GRAND_P_201507, mean)
GRAND_P_201508_mean <- cellStats(GRAND_P_201508, mean)
GRAND_P_201509_mean <- cellStats(GRAND_P_201509, mean)
GRAND_P_201510_mean <- cellStats(GRAND_P_201510, mean)
GRAND_P_201511_mean <- cellStats(GRAND_P_201511, mean)
GRAND_P_201512_mean <- cellStats(GRAND_P_201512, mean)

#2016
GRAND_P_201601_mean <- cellStats(GRAND_P_201601, mean)
GRAND_P_201602_mean <- cellStats(GRAND_P_201602, mean)
GRAND_P_201603_mean <- cellStats(GRAND_P_201603, mean)
GRAND_P_201604_mean <- cellStats(GRAND_P_201604, mean)
GRAND_P_201605_mean <- cellStats(GRAND_P_201605, mean)
GRAND_P_201606_mean <- cellStats(GRAND_P_201606, mean)
GRAND_P_201607_mean <- cellStats(GRAND_P_201607, mean)
GRAND_P_201608_mean <- cellStats(GRAND_P_201608, mean)
GRAND_P_201609_mean <- cellStats(GRAND_P_201609, mean)
GRAND_P_201610_mean <- cellStats(GRAND_P_201610, mean)
GRAND_P_201611_mean <- cellStats(GRAND_P_201611, mean)
GRAND_P_201612_mean <- cellStats(GRAND_P_201612, mean)

#2017
GRAND_P_201701_mean <- cellStats(GRAND_P_201701, mean)
GRAND_P_201702_mean <- cellStats(GRAND_P_201702, mean)
GRAND_P_201703_mean <- cellStats(GRAND_P_201703, mean)
GRAND_P_201704_mean <- cellStats(GRAND_P_201704, mean)
GRAND_P_201705_mean <- cellStats(GRAND_P_201705, mean)
GRAND_P_201706_mean <- cellStats(GRAND_P_201706, mean)
GRAND_P_201707_mean <- cellStats(GRAND_P_201707, mean)
GRAND_P_201708_mean <- cellStats(GRAND_P_201708, mean)
GRAND_P_201709_mean <- cellStats(GRAND_P_201709, mean)
GRAND_P_201710_mean <- cellStats(GRAND_P_201710, mean)
GRAND_P_201711_mean <- cellStats(GRAND_P_201711, mean)
GRAND_P_201712_mean <- cellStats(GRAND_P_201712, mean)

#2018
GRAND_P_201801_mean <- cellStats(GRAND_P_201801, mean)
GRAND_P_201802_mean <- cellStats(GRAND_P_201802, mean)
GRAND_P_201803_mean <- cellStats(GRAND_P_201803, mean)
GRAND_P_201804_mean <- cellStats(GRAND_P_201804, mean)
GRAND_P_201805_mean <- cellStats(GRAND_P_201805, mean)
GRAND_P_201806_mean <- cellStats(GRAND_P_201806, mean)
GRAND_P_201807_mean <- cellStats(GRAND_P_201807, mean)
GRAND_P_201808_mean <- cellStats(GRAND_P_201808, mean)
GRAND_P_201809_mean <- cellStats(GRAND_P_201809, mean)
GRAND_P_201810_mean <- cellStats(GRAND_P_201810, mean)
GRAND_P_201811_mean <- cellStats(GRAND_P_201811, mean)
GRAND_P_201812_mean <- cellStats(GRAND_P_201812, mean)

# GARFIELD


#2000
GARFIELD_P_200001 <- crop(P_200001, GARFIELD) 
GARFIELD_P_200002 <- crop(P_200002, GARFIELD)
GARFIELD_P_200003 <- crop(P_200003, GARFIELD)
GARFIELD_P_200004 <- crop(P_200004, GARFIELD)
GARFIELD_P_200005 <- crop(P_200005, GARFIELD)
GARFIELD_P_200006 <- crop(P_200006, GARFIELD)  
GARFIELD_P_200007 <- crop(P_200007, GARFIELD)  
GARFIELD_P_200008 <- crop(P_200008, GARFIELD)  
GARFIELD_P_200009 <- crop(P_200009, GARFIELD)  
GARFIELD_P_200010 <- crop(P_200010, GARFIELD)  
GARFIELD_P_200011 <- crop(P_200011, GARFIELD)  
GARFIELD_P_200012 <- crop(P_200012, GARFIELD)  
#2001
GARFIELD_P_200101 <- crop(P_200101, GARFIELD) 
GARFIELD_P_200102 <- crop(P_200102, GARFIELD)
GARFIELD_P_200103 <- crop(P_200103, GARFIELD)
GARFIELD_P_200104 <- crop(P_200104, GARFIELD)
GARFIELD_P_200105 <- crop(P_200105, GARFIELD)
GARFIELD_P_200106 <- crop(P_200106, GARFIELD)  
GARFIELD_P_200107 <- crop(P_200107, GARFIELD)  
GARFIELD_P_200108 <- crop(P_200108, GARFIELD)  
GARFIELD_P_200109 <- crop(P_200109, GARFIELD)  
GARFIELD_P_200110 <- crop(P_200110, GARFIELD)  
GARFIELD_P_200111 <- crop(P_200111, GARFIELD)  
GARFIELD_P_200112 <- crop(P_200112, GARFIELD)  

#2002
GARFIELD_P_200201 <- crop(P_200201, GARFIELD) 
GARFIELD_P_200202 <- crop(P_200202, GARFIELD)
GARFIELD_P_200203 <- crop(P_200203, GARFIELD)
GARFIELD_P_200204 <- crop(P_200204, GARFIELD)
GARFIELD_P_200205 <- crop(P_200205, GARFIELD)
GARFIELD_P_200206 <- crop(P_200206, GARFIELD)  
GARFIELD_P_200207 <- crop(P_200207, GARFIELD)  
GARFIELD_P_200208 <- crop(P_200208, GARFIELD)  
GARFIELD_P_200209 <- crop(P_200209, GARFIELD)  
GARFIELD_P_200210 <- crop(P_200210, GARFIELD)  
GARFIELD_P_200211 <- crop(P_200211, GARFIELD)  
GARFIELD_P_200212 <- crop(P_200212, GARFIELD)  
#2003
GARFIELD_P_200301 <- crop(P_200301, GARFIELD) 
GARFIELD_P_200302 <- crop(P_200302, GARFIELD)
GARFIELD_P_200303 <- crop(P_200303, GARFIELD)
GARFIELD_P_200304 <- crop(P_200304, GARFIELD)
GARFIELD_P_200305 <- crop(P_200305, GARFIELD)
GARFIELD_P_200306 <- crop(P_200306, GARFIELD)  
GARFIELD_P_200307 <- crop(P_200307, GARFIELD)  
GARFIELD_P_200308 <- crop(P_200308, GARFIELD)  
GARFIELD_P_200309 <- crop(P_200309, GARFIELD)  
GARFIELD_P_200310 <- crop(P_200310, GARFIELD)  
GARFIELD_P_200311 <- crop(P_200311, GARFIELD)  
GARFIELD_P_200312 <- crop(P_200312, GARFIELD)  
#2004
GARFIELD_P_200401 <- crop(P_200401, GARFIELD) 
GARFIELD_P_200402 <- crop(P_200402, GARFIELD)
GARFIELD_P_200403 <- crop(P_200403, GARFIELD)
GARFIELD_P_200404 <- crop(P_200404, GARFIELD)
GARFIELD_P_200405 <- crop(P_200405, GARFIELD)
GARFIELD_P_200406 <- crop(P_200406, GARFIELD)  
GARFIELD_P_200407 <- crop(P_200407, GARFIELD)  
GARFIELD_P_200408 <- crop(P_200408, GARFIELD)  
GARFIELD_P_200409 <- crop(P_200409, GARFIELD)  
GARFIELD_P_200410 <- crop(P_200410, GARFIELD)  
GARFIELD_P_200411 <- crop(P_200411, GARFIELD)  
GARFIELD_P_200412 <- crop(P_200412, GARFIELD)  
#2005
GARFIELD_P_200501 <- crop(P_200501, GARFIELD) 
GARFIELD_P_200502 <- crop(P_200502, GARFIELD)
GARFIELD_P_200503 <- crop(P_200503, GARFIELD)
GARFIELD_P_200504 <- crop(P_200504, GARFIELD)
GARFIELD_P_200505 <- crop(P_200505, GARFIELD)
GARFIELD_P_200506 <- crop(P_200506, GARFIELD)  
GARFIELD_P_200507 <- crop(P_200507, GARFIELD)  
GARFIELD_P_200508 <- crop(P_200508, GARFIELD)  
GARFIELD_P_200509 <- crop(P_200509, GARFIELD)  
GARFIELD_P_200510 <- crop(P_200510, GARFIELD)  
GARFIELD_P_200511 <- crop(P_200511, GARFIELD)  
GARFIELD_P_200512 <- crop(P_200512, GARFIELD)  
#2006
GARFIELD_P_200601 <- crop(P_200601, GARFIELD) 
GARFIELD_P_200602 <- crop(P_200602, GARFIELD)
GARFIELD_P_200603 <- crop(P_200603, GARFIELD)
GARFIELD_P_200604 <- crop(P_200604, GARFIELD)
GARFIELD_P_200605 <- crop(P_200605, GARFIELD)
GARFIELD_P_200606 <- crop(P_200606, GARFIELD)  
GARFIELD_P_200607 <- crop(P_200607, GARFIELD)  
GARFIELD_P_200608 <- crop(P_200608, GARFIELD)  
GARFIELD_P_200609 <- crop(P_200609, GARFIELD)  
GARFIELD_P_200610 <- crop(P_200610, GARFIELD)  
GARFIELD_P_200611 <- crop(P_200611, GARFIELD)  
GARFIELD_P_200612 <- crop(P_200612, GARFIELD)  
#2007
GARFIELD_P_200701 <- crop(P_200701, GARFIELD) 
GARFIELD_P_200702 <- crop(P_200702, GARFIELD)
GARFIELD_P_200703 <- crop(P_200703, GARFIELD)
GARFIELD_P_200704 <- crop(P_200704, GARFIELD)
GARFIELD_P_200705 <- crop(P_200705, GARFIELD)
GARFIELD_P_200706 <- crop(P_200706, GARFIELD)  
GARFIELD_P_200707 <- crop(P_200707, GARFIELD)  
GARFIELD_P_200708 <- crop(P_200708, GARFIELD)  
GARFIELD_P_200709 <- crop(P_200709, GARFIELD)  
GARFIELD_P_200710 <- crop(P_200710, GARFIELD)  
GARFIELD_P_200711 <- crop(P_200711, GARFIELD)  
GARFIELD_P_200712 <- crop(P_200712, GARFIELD)  
#2008
GARFIELD_P_200801 <- crop(P_200801, GARFIELD) 
GARFIELD_P_200802 <- crop(P_200802, GARFIELD)
GARFIELD_P_200803 <- crop(P_200803, GARFIELD)
GARFIELD_P_200804 <- crop(P_200804, GARFIELD)
GARFIELD_P_200805 <- crop(P_200805, GARFIELD)
GARFIELD_P_200806 <- crop(P_200806, GARFIELD)  
GARFIELD_P_200807 <- crop(P_200807, GARFIELD)  
GARFIELD_P_200808 <- crop(P_200808, GARFIELD)  
GARFIELD_P_200809 <- crop(P_200809, GARFIELD)  
GARFIELD_P_200810 <- crop(P_200810, GARFIELD)  
GARFIELD_P_200811 <- crop(P_200811, GARFIELD)  
GARFIELD_P_200812 <- crop(P_200812, GARFIELD)  
#2009
GARFIELD_P_200901 <- crop(P_200901, GARFIELD) 
GARFIELD_P_200902 <- crop(P_200902, GARFIELD)
GARFIELD_P_200903 <- crop(P_200903, GARFIELD)
GARFIELD_P_200904 <- crop(P_200904, GARFIELD)
GARFIELD_P_200905 <- crop(P_200905, GARFIELD)
GARFIELD_P_200906 <- crop(P_200906, GARFIELD)  
GARFIELD_P_200907 <- crop(P_200907, GARFIELD)  
GARFIELD_P_200908 <- crop(P_200908, GARFIELD)  
GARFIELD_P_200909 <- crop(P_200909, GARFIELD)  
GARFIELD_P_200910 <- crop(P_200910, GARFIELD)  
GARFIELD_P_200911 <- crop(P_200911, GARFIELD)  
GARFIELD_P_200912 <- crop(P_200912, GARFIELD)  
#2010
GARFIELD_P_201001 <- crop(P_201001, GARFIELD) 
GARFIELD_P_201002 <- crop(P_201002, GARFIELD)
GARFIELD_P_201003 <- crop(P_201003, GARFIELD)
GARFIELD_P_201004 <- crop(P_201004, GARFIELD)
GARFIELD_P_201005 <- crop(P_201005, GARFIELD)
GARFIELD_P_201006 <- crop(P_201006, GARFIELD)  
GARFIELD_P_201007 <- crop(P_201007, GARFIELD)  
GARFIELD_P_201008 <- crop(P_201008, GARFIELD)  
GARFIELD_P_201009 <- crop(P_201009, GARFIELD)  
GARFIELD_P_201010 <- crop(P_201010, GARFIELD)  
GARFIELD_P_201011 <- crop(P_201011, GARFIELD)  
GARFIELD_P_201012 <- crop(P_201012, GARFIELD)  
#2011
GARFIELD_P_201101 <- crop(P_201101, GARFIELD) 
GARFIELD_P_201102 <- crop(P_201102, GARFIELD)
GARFIELD_P_201103 <- crop(P_201103, GARFIELD)
GARFIELD_P_201104 <- crop(P_201104, GARFIELD)
GARFIELD_P_201105 <- crop(P_201105, GARFIELD)
GARFIELD_P_201106 <- crop(P_201106, GARFIELD)  
GARFIELD_P_201107 <- crop(P_201107, GARFIELD)  
GARFIELD_P_201108 <- crop(P_201108, GARFIELD)  
GARFIELD_P_201109 <- crop(P_201109, GARFIELD)  
GARFIELD_P_201110 <- crop(P_201110, GARFIELD)  
GARFIELD_P_201111 <- crop(P_201111, GARFIELD)  
GARFIELD_P_201112 <- crop(P_201112, GARFIELD)  
#2012
GARFIELD_P_201201 <- crop(P_201201, GARFIELD) 
GARFIELD_P_201202 <- crop(P_201202, GARFIELD)
GARFIELD_P_201203 <- crop(P_201203, GARFIELD)
GARFIELD_P_201204 <- crop(P_201204, GARFIELD)
GARFIELD_P_201205 <- crop(P_201205, GARFIELD)
GARFIELD_P_201206 <- crop(P_201206, GARFIELD)  
GARFIELD_P_201207 <- crop(P_201207, GARFIELD)  
GARFIELD_P_201208 <- crop(P_201208, GARFIELD)  
GARFIELD_P_201209 <- crop(P_201209, GARFIELD)  
GARFIELD_P_201210 <- crop(P_201210, GARFIELD)  
GARFIELD_P_201211 <- crop(P_201211, GARFIELD)  
GARFIELD_P_201212 <- crop(P_201212, GARFIELD)  
#2013
GARFIELD_P_201301 <- crop(P_201301, GARFIELD) 
GARFIELD_P_201302 <- crop(P_201302, GARFIELD)
GARFIELD_P_201303 <- crop(P_201303, GARFIELD)
GARFIELD_P_201304 <- crop(P_201304, GARFIELD)
GARFIELD_P_201305 <- crop(P_201305, GARFIELD)
GARFIELD_P_201306 <- crop(P_201306, GARFIELD)  
GARFIELD_P_201307 <- crop(P_201307, GARFIELD)  
GARFIELD_P_201308 <- crop(P_201308, GARFIELD)  
GARFIELD_P_201309 <- crop(P_201309, GARFIELD)  
GARFIELD_P_201310 <- crop(P_201310, GARFIELD)  
GARFIELD_P_201311 <- crop(P_201311, GARFIELD)  
GARFIELD_P_201312 <- crop(P_201312, GARFIELD)  
#2014
GARFIELD_P_201401 <- crop(P_201401, GARFIELD) 
GARFIELD_P_201402 <- crop(P_201402, GARFIELD)
GARFIELD_P_201403 <- crop(P_201403, GARFIELD)
GARFIELD_P_201404 <- crop(P_201404, GARFIELD)
GARFIELD_P_201405 <- crop(P_201405, GARFIELD)
GARFIELD_P_201406 <- crop(P_201406, GARFIELD)  
GARFIELD_P_201407 <- crop(P_201407, GARFIELD)  
GARFIELD_P_201408 <- crop(P_201408, GARFIELD)  
GARFIELD_P_201409 <- crop(P_201409, GARFIELD)  
GARFIELD_P_201410 <- crop(P_201410, GARFIELD)  
GARFIELD_P_201411 <- crop(P_201411, GARFIELD)  
GARFIELD_P_201412 <- crop(P_201412, GARFIELD)  
#2015
GARFIELD_P_201501 <- crop(P_201501, GARFIELD) 
GARFIELD_P_201502 <- crop(P_201502, GARFIELD)
GARFIELD_P_201503 <- crop(P_201503, GARFIELD)
GARFIELD_P_201504 <- crop(P_201504, GARFIELD)
GARFIELD_P_201505 <- crop(P_201505, GARFIELD)
GARFIELD_P_201506 <- crop(P_201506, GARFIELD)  
GARFIELD_P_201507 <- crop(P_201507, GARFIELD)  
GARFIELD_P_201508 <- crop(P_201508, GARFIELD)  
GARFIELD_P_201509 <- crop(P_201509, GARFIELD)  
GARFIELD_P_201510 <- crop(P_201510, GARFIELD)  
GARFIELD_P_201511 <- crop(P_201511, GARFIELD)  
GARFIELD_P_201512 <- crop(P_201512, GARFIELD)  
#2016
GARFIELD_P_201601 <- crop(P_201601, GARFIELD) 
GARFIELD_P_201602 <- crop(P_201602, GARFIELD)
GARFIELD_P_201603 <- crop(P_201603, GARFIELD)
GARFIELD_P_201604 <- crop(P_201604, GARFIELD)
GARFIELD_P_201605 <- crop(P_201605, GARFIELD)
GARFIELD_P_201606 <- crop(P_201606, GARFIELD)  
GARFIELD_P_201607 <- crop(P_201607, GARFIELD)  
GARFIELD_P_201608 <- crop(P_201608, GARFIELD)  
GARFIELD_P_201609 <- crop(P_201609, GARFIELD)  
GARFIELD_P_201610 <- crop(P_201610, GARFIELD)  
GARFIELD_P_201611 <- crop(P_201611, GARFIELD)  
GARFIELD_P_201612 <- crop(P_201612, GARFIELD)  
#2017
GARFIELD_P_201701 <- crop(P_201701, GARFIELD) 
GARFIELD_P_201702 <- crop(P_201702, GARFIELD)
GARFIELD_P_201703 <- crop(P_201703, GARFIELD)
GARFIELD_P_201704 <- crop(P_201704, GARFIELD)
GARFIELD_P_201705 <- crop(P_201705, GARFIELD)
GARFIELD_P_201706 <- crop(P_201706, GARFIELD)  
GARFIELD_P_201707 <- crop(P_201707, GARFIELD)  
GARFIELD_P_201708 <- crop(P_201708, GARFIELD)  
GARFIELD_P_201709 <- crop(P_201709, GARFIELD)  
GARFIELD_P_201710 <- crop(P_201710, GARFIELD)  
GARFIELD_P_201711 <- crop(P_201711, GARFIELD)  
GARFIELD_P_201712 <- crop(P_201712, GARFIELD)  

#2018

GARFIELD_P_201801 <- crop(P_201801, GARFIELD) 
GARFIELD_P_201802 <- crop(P_201802, GARFIELD)
GARFIELD_P_201803 <- crop(P_201803, GARFIELD)
GARFIELD_P_201804 <- crop(P_201804, GARFIELD)
GARFIELD_P_201805 <- crop(P_201805, GARFIELD)
GARFIELD_P_201806 <- crop(P_201806, GARFIELD)  
GARFIELD_P_201807 <- crop(P_201807, GARFIELD)  
GARFIELD_P_201808 <- crop(P_201808, GARFIELD)  
GARFIELD_P_201809 <- crop(P_201809, GARFIELD)  
GARFIELD_P_201810 <- crop(P_201810, GARFIELD)  
GARFIELD_P_201811 <- crop(P_201811, GARFIELD)  
GARFIELD_P_201812 <- crop(P_201812, GARFIELD)  


# Mean Monthly Precipitation
#2000
GARFIELD_P_200001_mean <- cellStats(GARFIELD_P_200001, mean)
GARFIELD_P_200002_mean <- cellStats(GARFIELD_P_200002, mean)
GARFIELD_P_200003_mean <- cellStats(GARFIELD_P_200003, mean)
GARFIELD_P_200004_mean <- cellStats(GARFIELD_P_200004, mean)
GARFIELD_P_200005_mean <- cellStats(GARFIELD_P_200005, mean)
GARFIELD_P_200006_mean <- cellStats(GARFIELD_P_200006, mean)
GARFIELD_P_200007_mean <- cellStats(GARFIELD_P_200007, mean)
GARFIELD_P_200008_mean <- cellStats(GARFIELD_P_200008, mean)
GARFIELD_P_200009_mean <- cellStats(GARFIELD_P_200009, mean)
GARFIELD_P_200010_mean <- cellStats(GARFIELD_P_200010, mean)
GARFIELD_P_200011_mean <- cellStats(GARFIELD_P_200011, mean)
GARFIELD_P_200012_mean <- cellStats(GARFIELD_P_200012, mean)
#2001
GARFIELD_P_200101_mean <- cellStats(GARFIELD_P_200101, mean)
GARFIELD_P_200102_mean <- cellStats(GARFIELD_P_200102, mean)
GARFIELD_P_200103_mean <- cellStats(GARFIELD_P_200103, mean)
GARFIELD_P_200104_mean <- cellStats(GARFIELD_P_200104, mean)
GARFIELD_P_200105_mean <- cellStats(GARFIELD_P_200105, mean)
GARFIELD_P_200106_mean <- cellStats(GARFIELD_P_200106, mean)
GARFIELD_P_200107_mean <- cellStats(GARFIELD_P_200107, mean)
GARFIELD_P_200108_mean <- cellStats(GARFIELD_P_200108, mean)
GARFIELD_P_200109_mean <- cellStats(GARFIELD_P_200109, mean)
GARFIELD_P_200110_mean <- cellStats(GARFIELD_P_200110, mean)
GARFIELD_P_200111_mean <- cellStats(GARFIELD_P_200111, mean)
GARFIELD_P_200112_mean <- cellStats(GARFIELD_P_200112, mean)

#2002
GARFIELD_P_200201_mean <- cellStats(GARFIELD_P_200201, mean)
GARFIELD_P_200202_mean <- cellStats(GARFIELD_P_200202, mean)
GARFIELD_P_200203_mean <- cellStats(GARFIELD_P_200203, mean)
GARFIELD_P_200204_mean <- cellStats(GARFIELD_P_200204, mean)
GARFIELD_P_200205_mean <- cellStats(GARFIELD_P_200205, mean)
GARFIELD_P_200206_mean <- cellStats(GARFIELD_P_200206, mean)
GARFIELD_P_200207_mean <- cellStats(GARFIELD_P_200207, mean)
GARFIELD_P_200208_mean <- cellStats(GARFIELD_P_200208, mean)
GARFIELD_P_200209_mean <- cellStats(GARFIELD_P_200209, mean)
GARFIELD_P_200210_mean <- cellStats(GARFIELD_P_200210, mean)
GARFIELD_P_200211_mean <- cellStats(GARFIELD_P_200211, mean)
GARFIELD_P_200212_mean <- cellStats(GARFIELD_P_200212, mean)

#2003
GARFIELD_P_200301_mean <- cellStats(GARFIELD_P_200301, mean)
GARFIELD_P_200302_mean <- cellStats(GARFIELD_P_200302, mean)
GARFIELD_P_200303_mean <- cellStats(GARFIELD_P_200303, mean)
GARFIELD_P_200304_mean <- cellStats(GARFIELD_P_200304, mean)
GARFIELD_P_200305_mean <- cellStats(GARFIELD_P_200305, mean)
GARFIELD_P_200306_mean <- cellStats(GARFIELD_P_200306, mean)
GARFIELD_P_200307_mean <- cellStats(GARFIELD_P_200307, mean)
GARFIELD_P_200308_mean <- cellStats(GARFIELD_P_200308, mean)
GARFIELD_P_200309_mean <- cellStats(GARFIELD_P_200309, mean)
GARFIELD_P_200310_mean <- cellStats(GARFIELD_P_200310, mean)
GARFIELD_P_200311_mean <- cellStats(GARFIELD_P_200311, mean)
GARFIELD_P_200312_mean <- cellStats(GARFIELD_P_200312, mean)

#2004

GARFIELD_P_200401_mean <- cellStats(GARFIELD_P_200401, mean)
GARFIELD_P_200402_mean <- cellStats(GARFIELD_P_200402, mean)
GARFIELD_P_200403_mean <- cellStats(GARFIELD_P_200403, mean)
GARFIELD_P_200404_mean <- cellStats(GARFIELD_P_200404, mean)
GARFIELD_P_200405_mean <- cellStats(GARFIELD_P_200405, mean)
GARFIELD_P_200406_mean <- cellStats(GARFIELD_P_200406, mean)
GARFIELD_P_200407_mean <- cellStats(GARFIELD_P_200407, mean)
GARFIELD_P_200408_mean <- cellStats(GARFIELD_P_200408, mean)
GARFIELD_P_200409_mean <- cellStats(GARFIELD_P_200409, mean)
GARFIELD_P_200410_mean <- cellStats(GARFIELD_P_200410, mean)
GARFIELD_P_200411_mean <- cellStats(GARFIELD_P_200411, mean)
GARFIELD_P_200412_mean <- cellStats(GARFIELD_P_200412, mean)

#2005

GARFIELD_P_200501_mean <- cellStats(GARFIELD_P_200501, mean)
GARFIELD_P_200502_mean <- cellStats(GARFIELD_P_200502, mean)
GARFIELD_P_200503_mean <- cellStats(GARFIELD_P_200503, mean)
GARFIELD_P_200504_mean <- cellStats(GARFIELD_P_200504, mean)
GARFIELD_P_200505_mean <- cellStats(GARFIELD_P_200505, mean)
GARFIELD_P_200506_mean <- cellStats(GARFIELD_P_200506, mean)
GARFIELD_P_200507_mean <- cellStats(GARFIELD_P_200507, mean)
GARFIELD_P_200508_mean <- cellStats(GARFIELD_P_200508, mean)
GARFIELD_P_200509_mean <- cellStats(GARFIELD_P_200509, mean)
GARFIELD_P_200510_mean <- cellStats(GARFIELD_P_200510, mean)
GARFIELD_P_200511_mean <- cellStats(GARFIELD_P_200511, mean)
GARFIELD_P_200512_mean <- cellStats(GARFIELD_P_200512, mean)

#2006

GARFIELD_P_200601_mean <- cellStats(GARFIELD_P_200601, mean)
GARFIELD_P_200602_mean <- cellStats(GARFIELD_P_200602, mean)
GARFIELD_P_200603_mean <- cellStats(GARFIELD_P_200603, mean)
GARFIELD_P_200604_mean <- cellStats(GARFIELD_P_200604, mean)
GARFIELD_P_200605_mean <- cellStats(GARFIELD_P_200605, mean)
GARFIELD_P_200606_mean <- cellStats(GARFIELD_P_200606, mean)
GARFIELD_P_200607_mean <- cellStats(GARFIELD_P_200607, mean)
GARFIELD_P_200608_mean <- cellStats(GARFIELD_P_200608, mean)
GARFIELD_P_200609_mean <- cellStats(GARFIELD_P_200609, mean)
GARFIELD_P_200610_mean <- cellStats(GARFIELD_P_200610, mean)
GARFIELD_P_200611_mean <- cellStats(GARFIELD_P_200611, mean)
GARFIELD_P_200612_mean <- cellStats(GARFIELD_P_200612, mean)

#2007

GARFIELD_P_200701_mean <- cellStats(GARFIELD_P_200701, mean)
GARFIELD_P_200702_mean <- cellStats(GARFIELD_P_200702, mean)
GARFIELD_P_200703_mean <- cellStats(GARFIELD_P_200703, mean)
GARFIELD_P_200704_mean <- cellStats(GARFIELD_P_200704, mean)
GARFIELD_P_200705_mean <- cellStats(GARFIELD_P_200705, mean)
GARFIELD_P_200706_mean <- cellStats(GARFIELD_P_200706, mean)
GARFIELD_P_200707_mean <- cellStats(GARFIELD_P_200707, mean)
GARFIELD_P_200708_mean <- cellStats(GARFIELD_P_200708, mean)
GARFIELD_P_200709_mean <- cellStats(GARFIELD_P_200709, mean)
GARFIELD_P_200710_mean <- cellStats(GARFIELD_P_200710, mean)
GARFIELD_P_200711_mean <- cellStats(GARFIELD_P_200711, mean)
GARFIELD_P_200712_mean <- cellStats(GARFIELD_P_200712, mean)

#2008

GARFIELD_P_200801_mean <- cellStats(GARFIELD_P_200801, mean)
GARFIELD_P_200802_mean <- cellStats(GARFIELD_P_200802, mean)
GARFIELD_P_200803_mean <- cellStats(GARFIELD_P_200803, mean)
GARFIELD_P_200804_mean <- cellStats(GARFIELD_P_200804, mean)
GARFIELD_P_200805_mean <- cellStats(GARFIELD_P_200805, mean)
GARFIELD_P_200806_mean <- cellStats(GARFIELD_P_200806, mean)
GARFIELD_P_200807_mean <- cellStats(GARFIELD_P_200807, mean)
GARFIELD_P_200808_mean <- cellStats(GARFIELD_P_200808, mean)
GARFIELD_P_200809_mean <- cellStats(GARFIELD_P_200809, mean)
GARFIELD_P_200810_mean <- cellStats(GARFIELD_P_200810, mean)
GARFIELD_P_200811_mean <- cellStats(GARFIELD_P_200811, mean)
GARFIELD_P_200812_mean <- cellStats(GARFIELD_P_200812, mean)

#2009

GARFIELD_P_200901_mean <- cellStats(GARFIELD_P_200901, mean)
GARFIELD_P_200902_mean <- cellStats(GARFIELD_P_200902, mean)
GARFIELD_P_200903_mean <- cellStats(GARFIELD_P_200903, mean)
GARFIELD_P_200904_mean <- cellStats(GARFIELD_P_200904, mean)
GARFIELD_P_200905_mean <- cellStats(GARFIELD_P_200905, mean)
GARFIELD_P_200906_mean <- cellStats(GARFIELD_P_200906, mean)
GARFIELD_P_200907_mean <- cellStats(GARFIELD_P_200907, mean)
GARFIELD_P_200908_mean <- cellStats(GARFIELD_P_200908, mean)
GARFIELD_P_200909_mean <- cellStats(GARFIELD_P_200909, mean)
GARFIELD_P_200910_mean <- cellStats(GARFIELD_P_200910, mean)
GARFIELD_P_200911_mean <- cellStats(GARFIELD_P_200911, mean)
GARFIELD_P_200912_mean <- cellStats(GARFIELD_P_200912, mean)

#2010

GARFIELD_P_201001_mean <- cellStats(GARFIELD_P_201001, mean)
GARFIELD_P_201002_mean <- cellStats(GARFIELD_P_201002, mean)
GARFIELD_P_201003_mean <- cellStats(GARFIELD_P_201003, mean)
GARFIELD_P_201004_mean <- cellStats(GARFIELD_P_201004, mean)
GARFIELD_P_201005_mean <- cellStats(GARFIELD_P_201005, mean)
GARFIELD_P_201006_mean <- cellStats(GARFIELD_P_201006, mean)
GARFIELD_P_201007_mean <- cellStats(GARFIELD_P_201007, mean)
GARFIELD_P_201008_mean <- cellStats(GARFIELD_P_201008, mean)
GARFIELD_P_201009_mean <- cellStats(GARFIELD_P_201009, mean)
GARFIELD_P_201010_mean <- cellStats(GARFIELD_P_201010, mean)
GARFIELD_P_201011_mean <- cellStats(GARFIELD_P_201011, mean)
GARFIELD_P_201012_mean <- cellStats(GARFIELD_P_201012, mean)

#2011

GARFIELD_P_201101_mean <- cellStats(GARFIELD_P_201101, mean)
GARFIELD_P_201102_mean <- cellStats(GARFIELD_P_201102, mean)
GARFIELD_P_201103_mean <- cellStats(GARFIELD_P_201103, mean)
GARFIELD_P_201104_mean <- cellStats(GARFIELD_P_201104, mean)
GARFIELD_P_201105_mean <- cellStats(GARFIELD_P_201105, mean)
GARFIELD_P_201106_mean <- cellStats(GARFIELD_P_201106, mean)
GARFIELD_P_201107_mean <- cellStats(GARFIELD_P_201107, mean)
GARFIELD_P_201108_mean <- cellStats(GARFIELD_P_201108, mean)
GARFIELD_P_201109_mean <- cellStats(GARFIELD_P_201109, mean)
GARFIELD_P_201110_mean <- cellStats(GARFIELD_P_201110, mean)
GARFIELD_P_201111_mean <- cellStats(GARFIELD_P_201111, mean)
GARFIELD_P_201112_mean <- cellStats(GARFIELD_P_201112, mean)

#2012
GARFIELD_P_201201_mean <- cellStats(GARFIELD_P_201201, mean)
GARFIELD_P_201202_mean <- cellStats(GARFIELD_P_201202, mean)
GARFIELD_P_201203_mean <- cellStats(GARFIELD_P_201203, mean)
GARFIELD_P_201204_mean <- cellStats(GARFIELD_P_201204, mean)
GARFIELD_P_201205_mean <- cellStats(GARFIELD_P_201205, mean)
GARFIELD_P_201206_mean <- cellStats(GARFIELD_P_201206, mean)
GARFIELD_P_201207_mean <- cellStats(GARFIELD_P_201207, mean)
GARFIELD_P_201208_mean <- cellStats(GARFIELD_P_201208, mean)
GARFIELD_P_201209_mean <- cellStats(GARFIELD_P_201209, mean)
GARFIELD_P_201210_mean <- cellStats(GARFIELD_P_201210, mean)
GARFIELD_P_201211_mean <- cellStats(GARFIELD_P_201211, mean)
GARFIELD_P_201212_mean <- cellStats(GARFIELD_P_201212, mean)

#2013
GARFIELD_P_201301_mean <- cellStats(GARFIELD_P_201301, mean)
GARFIELD_P_201302_mean <- cellStats(GARFIELD_P_201302, mean)
GARFIELD_P_201303_mean <- cellStats(GARFIELD_P_201303, mean)
GARFIELD_P_201304_mean <- cellStats(GARFIELD_P_201304, mean)
GARFIELD_P_201305_mean <- cellStats(GARFIELD_P_201305, mean)
GARFIELD_P_201306_mean <- cellStats(GARFIELD_P_201306, mean)
GARFIELD_P_201307_mean <- cellStats(GARFIELD_P_201307, mean)
GARFIELD_P_201308_mean <- cellStats(GARFIELD_P_201308, mean)
GARFIELD_P_201309_mean <- cellStats(GARFIELD_P_201309, mean)
GARFIELD_P_201310_mean <- cellStats(GARFIELD_P_201310, mean)
GARFIELD_P_201311_mean <- cellStats(GARFIELD_P_201311, mean)
GARFIELD_P_201312_mean <- cellStats(GARFIELD_P_201312, mean)

#2014
GARFIELD_P_201401_mean <- cellStats(GARFIELD_P_201401, mean)
GARFIELD_P_201402_mean <- cellStats(GARFIELD_P_201402, mean)
GARFIELD_P_201403_mean <- cellStats(GARFIELD_P_201403, mean)
GARFIELD_P_201404_mean <- cellStats(GARFIELD_P_201404, mean)
GARFIELD_P_201405_mean <- cellStats(GARFIELD_P_201405, mean)
GARFIELD_P_201406_mean <- cellStats(GARFIELD_P_201406, mean)
GARFIELD_P_201407_mean <- cellStats(GARFIELD_P_201407, mean)
GARFIELD_P_201408_mean <- cellStats(GARFIELD_P_201408, mean)
GARFIELD_P_201409_mean <- cellStats(GARFIELD_P_201409, mean)
GARFIELD_P_201410_mean <- cellStats(GARFIELD_P_201410, mean)
GARFIELD_P_201411_mean <- cellStats(GARFIELD_P_201411, mean)
GARFIELD_P_201412_mean <- cellStats(GARFIELD_P_201412, mean)

#2015
GARFIELD_P_201501_mean <- cellStats(GARFIELD_P_201501, mean)
GARFIELD_P_201502_mean <- cellStats(GARFIELD_P_201502, mean)
GARFIELD_P_201503_mean <- cellStats(GARFIELD_P_201503, mean)
GARFIELD_P_201504_mean <- cellStats(GARFIELD_P_201504, mean)
GARFIELD_P_201505_mean <- cellStats(GARFIELD_P_201505, mean)
GARFIELD_P_201506_mean <- cellStats(GARFIELD_P_201506, mean)
GARFIELD_P_201507_mean <- cellStats(GARFIELD_P_201507, mean)
GARFIELD_P_201508_mean <- cellStats(GARFIELD_P_201508, mean)
GARFIELD_P_201509_mean <- cellStats(GARFIELD_P_201509, mean)
GARFIELD_P_201510_mean <- cellStats(GARFIELD_P_201510, mean)
GARFIELD_P_201511_mean <- cellStats(GARFIELD_P_201511, mean)
GARFIELD_P_201512_mean <- cellStats(GARFIELD_P_201512, mean)

#2016
GARFIELD_P_201601_mean <- cellStats(GARFIELD_P_201601, mean)
GARFIELD_P_201602_mean <- cellStats(GARFIELD_P_201602, mean)
GARFIELD_P_201603_mean <- cellStats(GARFIELD_P_201603, mean)
GARFIELD_P_201604_mean <- cellStats(GARFIELD_P_201604, mean)
GARFIELD_P_201605_mean <- cellStats(GARFIELD_P_201605, mean)
GARFIELD_P_201606_mean <- cellStats(GARFIELD_P_201606, mean)
GARFIELD_P_201607_mean <- cellStats(GARFIELD_P_201607, mean)
GARFIELD_P_201608_mean <- cellStats(GARFIELD_P_201608, mean)
GARFIELD_P_201609_mean <- cellStats(GARFIELD_P_201609, mean)
GARFIELD_P_201610_mean <- cellStats(GARFIELD_P_201610, mean)
GARFIELD_P_201611_mean <- cellStats(GARFIELD_P_201611, mean)
GARFIELD_P_201612_mean <- cellStats(GARFIELD_P_201612, mean)

#2017
GARFIELD_P_201701_mean <- cellStats(GARFIELD_P_201701, mean)
GARFIELD_P_201702_mean <- cellStats(GARFIELD_P_201702, mean)
GARFIELD_P_201703_mean <- cellStats(GARFIELD_P_201703, mean)
GARFIELD_P_201704_mean <- cellStats(GARFIELD_P_201704, mean)
GARFIELD_P_201705_mean <- cellStats(GARFIELD_P_201705, mean)
GARFIELD_P_201706_mean <- cellStats(GARFIELD_P_201706, mean)
GARFIELD_P_201707_mean <- cellStats(GARFIELD_P_201707, mean)
GARFIELD_P_201708_mean <- cellStats(GARFIELD_P_201708, mean)
GARFIELD_P_201709_mean <- cellStats(GARFIELD_P_201709, mean)
GARFIELD_P_201710_mean <- cellStats(GARFIELD_P_201710, mean)
GARFIELD_P_201711_mean <- cellStats(GARFIELD_P_201711, mean)
GARFIELD_P_201712_mean <- cellStats(GARFIELD_P_201712, mean)

#2018
GARFIELD_P_201801_mean <- cellStats(GARFIELD_P_201801, mean)
GARFIELD_P_201802_mean <- cellStats(GARFIELD_P_201802, mean)
GARFIELD_P_201803_mean <- cellStats(GARFIELD_P_201803, mean)
GARFIELD_P_201804_mean <- cellStats(GARFIELD_P_201804, mean)
GARFIELD_P_201805_mean <- cellStats(GARFIELD_P_201805, mean)
GARFIELD_P_201806_mean <- cellStats(GARFIELD_P_201806, mean)
GARFIELD_P_201807_mean <- cellStats(GARFIELD_P_201807, mean)
GARFIELD_P_201808_mean <- cellStats(GARFIELD_P_201808, mean)
GARFIELD_P_201809_mean <- cellStats(GARFIELD_P_201809, mean)
GARFIELD_P_201810_mean <- cellStats(GARFIELD_P_201810, mean)
GARFIELD_P_201811_mean <- cellStats(GARFIELD_P_201811, mean)
GARFIELD_P_201812_mean <- cellStats(GARFIELD_P_201812, mean)

# IRON

#2000
IRON_P_200001 <- crop(P_200001, IRON) 
IRON_P_200002 <- crop(P_200002, IRON)
IRON_P_200003 <- crop(P_200003, IRON)
IRON_P_200004 <- crop(P_200004, IRON)
IRON_P_200005 <- crop(P_200005, IRON)
IRON_P_200006 <- crop(P_200006, IRON)  
IRON_P_200007 <- crop(P_200007, IRON)  
IRON_P_200008 <- crop(P_200008, IRON)  
IRON_P_200009 <- crop(P_200009, IRON)  
IRON_P_200010 <- crop(P_200010, IRON)  
IRON_P_200011 <- crop(P_200011, IRON)  
IRON_P_200012 <- crop(P_200012, IRON)  
#2001
IRON_P_200101 <- crop(P_200101, IRON) 
IRON_P_200102 <- crop(P_200102, IRON)
IRON_P_200103 <- crop(P_200103, IRON)
IRON_P_200104 <- crop(P_200104, IRON)
IRON_P_200105 <- crop(P_200105, IRON)
IRON_P_200106 <- crop(P_200106, IRON)  
IRON_P_200107 <- crop(P_200107, IRON)  
IRON_P_200108 <- crop(P_200108, IRON)  
IRON_P_200109 <- crop(P_200109, IRON)  
IRON_P_200110 <- crop(P_200110, IRON)  
IRON_P_200111 <- crop(P_200111, IRON)  
IRON_P_200112 <- crop(P_200112, IRON)  

#2002
IRON_P_200201 <- crop(P_200201, IRON) 
IRON_P_200202 <- crop(P_200202, IRON)
IRON_P_200203 <- crop(P_200203, IRON)
IRON_P_200204 <- crop(P_200204, IRON)
IRON_P_200205 <- crop(P_200205, IRON)
IRON_P_200206 <- crop(P_200206, IRON)  
IRON_P_200207 <- crop(P_200207, IRON)  
IRON_P_200208 <- crop(P_200208, IRON)  
IRON_P_200209 <- crop(P_200209, IRON)  
IRON_P_200210 <- crop(P_200210, IRON)  
IRON_P_200211 <- crop(P_200211, IRON)  
IRON_P_200212 <- crop(P_200212, IRON)  
#2003
IRON_P_200301 <- crop(P_200301, IRON) 
IRON_P_200302 <- crop(P_200302, IRON)
IRON_P_200303 <- crop(P_200303, IRON)
IRON_P_200304 <- crop(P_200304, IRON)
IRON_P_200305 <- crop(P_200305, IRON)
IRON_P_200306 <- crop(P_200306, IRON)  
IRON_P_200307 <- crop(P_200307, IRON)  
IRON_P_200308 <- crop(P_200308, IRON)  
IRON_P_200309 <- crop(P_200309, IRON)  
IRON_P_200310 <- crop(P_200310, IRON)  
IRON_P_200311 <- crop(P_200311, IRON)  
IRON_P_200312 <- crop(P_200312, IRON)  
#2004
IRON_P_200401 <- crop(P_200401, IRON) 
IRON_P_200402 <- crop(P_200402, IRON)
IRON_P_200403 <- crop(P_200403, IRON)
IRON_P_200404 <- crop(P_200404, IRON)
IRON_P_200405 <- crop(P_200405, IRON)
IRON_P_200406 <- crop(P_200406, IRON)  
IRON_P_200407 <- crop(P_200407, IRON)  
IRON_P_200408 <- crop(P_200408, IRON)  
IRON_P_200409 <- crop(P_200409, IRON)  
IRON_P_200410 <- crop(P_200410, IRON)  
IRON_P_200411 <- crop(P_200411, IRON)  
IRON_P_200412 <- crop(P_200412, IRON)  
#2005
IRON_P_200501 <- crop(P_200501, IRON) 
IRON_P_200502 <- crop(P_200502, IRON)
IRON_P_200503 <- crop(P_200503, IRON)
IRON_P_200504 <- crop(P_200504, IRON)
IRON_P_200505 <- crop(P_200505, IRON)
IRON_P_200506 <- crop(P_200506, IRON)  
IRON_P_200507 <- crop(P_200507, IRON)  
IRON_P_200508 <- crop(P_200508, IRON)  
IRON_P_200509 <- crop(P_200509, IRON)  
IRON_P_200510 <- crop(P_200510, IRON)  
IRON_P_200511 <- crop(P_200511, IRON)  
IRON_P_200512 <- crop(P_200512, IRON)  
#2006
IRON_P_200601 <- crop(P_200601, IRON) 
IRON_P_200602 <- crop(P_200602, IRON)
IRON_P_200603 <- crop(P_200603, IRON)
IRON_P_200604 <- crop(P_200604, IRON)
IRON_P_200605 <- crop(P_200605, IRON)
IRON_P_200606 <- crop(P_200606, IRON)  
IRON_P_200607 <- crop(P_200607, IRON)  
IRON_P_200608 <- crop(P_200608, IRON)  
IRON_P_200609 <- crop(P_200609, IRON)  
IRON_P_200610 <- crop(P_200610, IRON)  
IRON_P_200611 <- crop(P_200611, IRON)  
IRON_P_200612 <- crop(P_200612, IRON)  
#2007
IRON_P_200701 <- crop(P_200701, IRON) 
IRON_P_200702 <- crop(P_200702, IRON)
IRON_P_200703 <- crop(P_200703, IRON)
IRON_P_200704 <- crop(P_200704, IRON)
IRON_P_200705 <- crop(P_200705, IRON)
IRON_P_200706 <- crop(P_200706, IRON)  
IRON_P_200707 <- crop(P_200707, IRON)  
IRON_P_200708 <- crop(P_200708, IRON)  
IRON_P_200709 <- crop(P_200709, IRON)  
IRON_P_200710 <- crop(P_200710, IRON)  
IRON_P_200711 <- crop(P_200711, IRON)  
IRON_P_200712 <- crop(P_200712, IRON)  
#2008
IRON_P_200801 <- crop(P_200801, IRON) 
IRON_P_200802 <- crop(P_200802, IRON)
IRON_P_200803 <- crop(P_200803, IRON)
IRON_P_200804 <- crop(P_200804, IRON)
IRON_P_200805 <- crop(P_200805, IRON)
IRON_P_200806 <- crop(P_200806, IRON)  
IRON_P_200807 <- crop(P_200807, IRON)  
IRON_P_200808 <- crop(P_200808, IRON)  
IRON_P_200809 <- crop(P_200809, IRON)  
IRON_P_200810 <- crop(P_200810, IRON)  
IRON_P_200811 <- crop(P_200811, IRON)  
IRON_P_200812 <- crop(P_200812, IRON)  
#2009
IRON_P_200901 <- crop(P_200901, IRON) 
IRON_P_200902 <- crop(P_200902, IRON)
IRON_P_200903 <- crop(P_200903, IRON)
IRON_P_200904 <- crop(P_200904, IRON)
IRON_P_200905 <- crop(P_200905, IRON)
IRON_P_200906 <- crop(P_200906, IRON)  
IRON_P_200907 <- crop(P_200907, IRON)  
IRON_P_200908 <- crop(P_200908, IRON)  
IRON_P_200909 <- crop(P_200909, IRON)  
IRON_P_200910 <- crop(P_200910, IRON)  
IRON_P_200911 <- crop(P_200911, IRON)  
IRON_P_200912 <- crop(P_200912, IRON)  
#2010
IRON_P_201001 <- crop(P_201001, IRON) 
IRON_P_201002 <- crop(P_201002, IRON)
IRON_P_201003 <- crop(P_201003, IRON)
IRON_P_201004 <- crop(P_201004, IRON)
IRON_P_201005 <- crop(P_201005, IRON)
IRON_P_201006 <- crop(P_201006, IRON)  
IRON_P_201007 <- crop(P_201007, IRON)  
IRON_P_201008 <- crop(P_201008, IRON)  
IRON_P_201009 <- crop(P_201009, IRON)  
IRON_P_201010 <- crop(P_201010, IRON)  
IRON_P_201011 <- crop(P_201011, IRON)  
IRON_P_201012 <- crop(P_201012, IRON)  
#2011
IRON_P_201101 <- crop(P_201101, IRON) 
IRON_P_201102 <- crop(P_201102, IRON)
IRON_P_201103 <- crop(P_201103, IRON)
IRON_P_201104 <- crop(P_201104, IRON)
IRON_P_201105 <- crop(P_201105, IRON)
IRON_P_201106 <- crop(P_201106, IRON)  
IRON_P_201107 <- crop(P_201107, IRON)  
IRON_P_201108 <- crop(P_201108, IRON)  
IRON_P_201109 <- crop(P_201109, IRON)  
IRON_P_201110 <- crop(P_201110, IRON)  
IRON_P_201111 <- crop(P_201111, IRON)  
IRON_P_201112 <- crop(P_201112, IRON)  
#2012
IRON_P_201201 <- crop(P_201201, IRON) 
IRON_P_201202 <- crop(P_201202, IRON)
IRON_P_201203 <- crop(P_201203, IRON)
IRON_P_201204 <- crop(P_201204, IRON)
IRON_P_201205 <- crop(P_201205, IRON)
IRON_P_201206 <- crop(P_201206, IRON)  
IRON_P_201207 <- crop(P_201207, IRON)  
IRON_P_201208 <- crop(P_201208, IRON)  
IRON_P_201209 <- crop(P_201209, IRON)  
IRON_P_201210 <- crop(P_201210, IRON)  
IRON_P_201211 <- crop(P_201211, IRON)  
IRON_P_201212 <- crop(P_201212, IRON)  
#2013
IRON_P_201301 <- crop(P_201301, IRON) 
IRON_P_201302 <- crop(P_201302, IRON)
IRON_P_201303 <- crop(P_201303, IRON)
IRON_P_201304 <- crop(P_201304, IRON)
IRON_P_201305 <- crop(P_201305, IRON)
IRON_P_201306 <- crop(P_201306, IRON)  
IRON_P_201307 <- crop(P_201307, IRON)  
IRON_P_201308 <- crop(P_201308, IRON)  
IRON_P_201309 <- crop(P_201309, IRON)  
IRON_P_201310 <- crop(P_201310, IRON)  
IRON_P_201311 <- crop(P_201311, IRON)  
IRON_P_201312 <- crop(P_201312, IRON)  
#2014
IRON_P_201401 <- crop(P_201401, IRON) 
IRON_P_201402 <- crop(P_201402, IRON)
IRON_P_201403 <- crop(P_201403, IRON)
IRON_P_201404 <- crop(P_201404, IRON)
IRON_P_201405 <- crop(P_201405, IRON)
IRON_P_201406 <- crop(P_201406, IRON)  
IRON_P_201407 <- crop(P_201407, IRON)  
IRON_P_201408 <- crop(P_201408, IRON)  
IRON_P_201409 <- crop(P_201409, IRON)  
IRON_P_201410 <- crop(P_201410, IRON)  
IRON_P_201411 <- crop(P_201411, IRON)  
IRON_P_201412 <- crop(P_201412, IRON)  
#2015
IRON_P_201501 <- crop(P_201501, IRON) 
IRON_P_201502 <- crop(P_201502, IRON)
IRON_P_201503 <- crop(P_201503, IRON)
IRON_P_201504 <- crop(P_201504, IRON)
IRON_P_201505 <- crop(P_201505, IRON)
IRON_P_201506 <- crop(P_201506, IRON)  
IRON_P_201507 <- crop(P_201507, IRON)  
IRON_P_201508 <- crop(P_201508, IRON)  
IRON_P_201509 <- crop(P_201509, IRON)  
IRON_P_201510 <- crop(P_201510, IRON)  
IRON_P_201511 <- crop(P_201511, IRON)  
IRON_P_201512 <- crop(P_201512, IRON)  
#2016
IRON_P_201601 <- crop(P_201601, IRON) 
IRON_P_201602 <- crop(P_201602, IRON)
IRON_P_201603 <- crop(P_201603, IRON)
IRON_P_201604 <- crop(P_201604, IRON)
IRON_P_201605 <- crop(P_201605, IRON)
IRON_P_201606 <- crop(P_201606, IRON)  
IRON_P_201607 <- crop(P_201607, IRON)  
IRON_P_201608 <- crop(P_201608, IRON)  
IRON_P_201609 <- crop(P_201609, IRON)  
IRON_P_201610 <- crop(P_201610, IRON)  
IRON_P_201611 <- crop(P_201611, IRON)  
IRON_P_201612 <- crop(P_201612, IRON)  
#2017
IRON_P_201701 <- crop(P_201701, IRON) 
IRON_P_201702 <- crop(P_201702, IRON)
IRON_P_201703 <- crop(P_201703, IRON)
IRON_P_201704 <- crop(P_201704, IRON)
IRON_P_201705 <- crop(P_201705, IRON)
IRON_P_201706 <- crop(P_201706, IRON)  
IRON_P_201707 <- crop(P_201707, IRON)  
IRON_P_201708 <- crop(P_201708, IRON)  
IRON_P_201709 <- crop(P_201709, IRON)  
IRON_P_201710 <- crop(P_201710, IRON)  
IRON_P_201711 <- crop(P_201711, IRON)  
IRON_P_201712 <- crop(P_201712, IRON)  

#2018

IRON_P_201801 <- crop(P_201801, IRON) 
IRON_P_201802 <- crop(P_201802, IRON)
IRON_P_201803 <- crop(P_201803, IRON)
IRON_P_201804 <- crop(P_201804, IRON)
IRON_P_201805 <- crop(P_201805, IRON)
IRON_P_201806 <- crop(P_201806, IRON)  
IRON_P_201807 <- crop(P_201807, IRON)  
IRON_P_201808 <- crop(P_201808, IRON)  
IRON_P_201809 <- crop(P_201809, IRON)  
IRON_P_201810 <- crop(P_201810, IRON)  
IRON_P_201811 <- crop(P_201811, IRON)  
IRON_P_201812 <- crop(P_201812, IRON)  


# Mean Monthly Precipitation
#2000
IRON_P_200001_mean <- cellStats(IRON_P_200001, mean)
IRON_P_200002_mean <- cellStats(IRON_P_200002, mean)
IRON_P_200003_mean <- cellStats(IRON_P_200003, mean)
IRON_P_200004_mean <- cellStats(IRON_P_200004, mean)
IRON_P_200005_mean <- cellStats(IRON_P_200005, mean)
IRON_P_200006_mean <- cellStats(IRON_P_200006, mean)
IRON_P_200007_mean <- cellStats(IRON_P_200007, mean)
IRON_P_200008_mean <- cellStats(IRON_P_200008, mean)
IRON_P_200009_mean <- cellStats(IRON_P_200009, mean)
IRON_P_200010_mean <- cellStats(IRON_P_200010, mean)
IRON_P_200011_mean <- cellStats(IRON_P_200011, mean)
IRON_P_200012_mean <- cellStats(IRON_P_200012, mean)
#2001
IRON_P_200101_mean <- cellStats(IRON_P_200101, mean)
IRON_P_200102_mean <- cellStats(IRON_P_200102, mean)
IRON_P_200103_mean <- cellStats(IRON_P_200103, mean)
IRON_P_200104_mean <- cellStats(IRON_P_200104, mean)
IRON_P_200105_mean <- cellStats(IRON_P_200105, mean)
IRON_P_200106_mean <- cellStats(IRON_P_200106, mean)
IRON_P_200107_mean <- cellStats(IRON_P_200107, mean)
IRON_P_200108_mean <- cellStats(IRON_P_200108, mean)
IRON_P_200109_mean <- cellStats(IRON_P_200109, mean)
IRON_P_200110_mean <- cellStats(IRON_P_200110, mean)
IRON_P_200111_mean <- cellStats(IRON_P_200111, mean)
IRON_P_200112_mean <- cellStats(IRON_P_200112, mean)

#2002
IRON_P_200201_mean <- cellStats(IRON_P_200201, mean)
IRON_P_200202_mean <- cellStats(IRON_P_200202, mean)
IRON_P_200203_mean <- cellStats(IRON_P_200203, mean)
IRON_P_200204_mean <- cellStats(IRON_P_200204, mean)
IRON_P_200205_mean <- cellStats(IRON_P_200205, mean)
IRON_P_200206_mean <- cellStats(IRON_P_200206, mean)
IRON_P_200207_mean <- cellStats(IRON_P_200207, mean)
IRON_P_200208_mean <- cellStats(IRON_P_200208, mean)
IRON_P_200209_mean <- cellStats(IRON_P_200209, mean)
IRON_P_200210_mean <- cellStats(IRON_P_200210, mean)
IRON_P_200211_mean <- cellStats(IRON_P_200211, mean)
IRON_P_200212_mean <- cellStats(IRON_P_200212, mean)

#2003
IRON_P_200301_mean <- cellStats(IRON_P_200301, mean)
IRON_P_200302_mean <- cellStats(IRON_P_200302, mean)
IRON_P_200303_mean <- cellStats(IRON_P_200303, mean)
IRON_P_200304_mean <- cellStats(IRON_P_200304, mean)
IRON_P_200305_mean <- cellStats(IRON_P_200305, mean)
IRON_P_200306_mean <- cellStats(IRON_P_200306, mean)
IRON_P_200307_mean <- cellStats(IRON_P_200307, mean)
IRON_P_200308_mean <- cellStats(IRON_P_200308, mean)
IRON_P_200309_mean <- cellStats(IRON_P_200309, mean)
IRON_P_200310_mean <- cellStats(IRON_P_200310, mean)
IRON_P_200311_mean <- cellStats(IRON_P_200311, mean)
IRON_P_200312_mean <- cellStats(IRON_P_200312, mean)

#2004

IRON_P_200401_mean <- cellStats(IRON_P_200401, mean)
IRON_P_200402_mean <- cellStats(IRON_P_200402, mean)
IRON_P_200403_mean <- cellStats(IRON_P_200403, mean)
IRON_P_200404_mean <- cellStats(IRON_P_200404, mean)
IRON_P_200405_mean <- cellStats(IRON_P_200405, mean)
IRON_P_200406_mean <- cellStats(IRON_P_200406, mean)
IRON_P_200407_mean <- cellStats(IRON_P_200407, mean)
IRON_P_200408_mean <- cellStats(IRON_P_200408, mean)
IRON_P_200409_mean <- cellStats(IRON_P_200409, mean)
IRON_P_200410_mean <- cellStats(IRON_P_200410, mean)
IRON_P_200411_mean <- cellStats(IRON_P_200411, mean)
IRON_P_200412_mean <- cellStats(IRON_P_200412, mean)

#2005

IRON_P_200501_mean <- cellStats(IRON_P_200501, mean)
IRON_P_200502_mean <- cellStats(IRON_P_200502, mean)
IRON_P_200503_mean <- cellStats(IRON_P_200503, mean)
IRON_P_200504_mean <- cellStats(IRON_P_200504, mean)
IRON_P_200505_mean <- cellStats(IRON_P_200505, mean)
IRON_P_200506_mean <- cellStats(IRON_P_200506, mean)
IRON_P_200507_mean <- cellStats(IRON_P_200507, mean)
IRON_P_200508_mean <- cellStats(IRON_P_200508, mean)
IRON_P_200509_mean <- cellStats(IRON_P_200509, mean)
IRON_P_200510_mean <- cellStats(IRON_P_200510, mean)
IRON_P_200511_mean <- cellStats(IRON_P_200511, mean)
IRON_P_200512_mean <- cellStats(IRON_P_200512, mean)

#2006

IRON_P_200601_mean <- cellStats(IRON_P_200601, mean)
IRON_P_200602_mean <- cellStats(IRON_P_200602, mean)
IRON_P_200603_mean <- cellStats(IRON_P_200603, mean)
IRON_P_200604_mean <- cellStats(IRON_P_200604, mean)
IRON_P_200605_mean <- cellStats(IRON_P_200605, mean)
IRON_P_200606_mean <- cellStats(IRON_P_200606, mean)
IRON_P_200607_mean <- cellStats(IRON_P_200607, mean)
IRON_P_200608_mean <- cellStats(IRON_P_200608, mean)
IRON_P_200609_mean <- cellStats(IRON_P_200609, mean)
IRON_P_200610_mean <- cellStats(IRON_P_200610, mean)
IRON_P_200611_mean <- cellStats(IRON_P_200611, mean)
IRON_P_200612_mean <- cellStats(IRON_P_200612, mean)

#2007

IRON_P_200701_mean <- cellStats(IRON_P_200701, mean)
IRON_P_200702_mean <- cellStats(IRON_P_200702, mean)
IRON_P_200703_mean <- cellStats(IRON_P_200703, mean)
IRON_P_200704_mean <- cellStats(IRON_P_200704, mean)
IRON_P_200705_mean <- cellStats(IRON_P_200705, mean)
IRON_P_200706_mean <- cellStats(IRON_P_200706, mean)
IRON_P_200707_mean <- cellStats(IRON_P_200707, mean)
IRON_P_200708_mean <- cellStats(IRON_P_200708, mean)
IRON_P_200709_mean <- cellStats(IRON_P_200709, mean)
IRON_P_200710_mean <- cellStats(IRON_P_200710, mean)
IRON_P_200711_mean <- cellStats(IRON_P_200711, mean)
IRON_P_200712_mean <- cellStats(IRON_P_200712, mean)

#2008

IRON_P_200801_mean <- cellStats(IRON_P_200801, mean)
IRON_P_200802_mean <- cellStats(IRON_P_200802, mean)
IRON_P_200803_mean <- cellStats(IRON_P_200803, mean)
IRON_P_200804_mean <- cellStats(IRON_P_200804, mean)
IRON_P_200805_mean <- cellStats(IRON_P_200805, mean)
IRON_P_200806_mean <- cellStats(IRON_P_200806, mean)
IRON_P_200807_mean <- cellStats(IRON_P_200807, mean)
IRON_P_200808_mean <- cellStats(IRON_P_200808, mean)
IRON_P_200809_mean <- cellStats(IRON_P_200809, mean)
IRON_P_200810_mean <- cellStats(IRON_P_200810, mean)
IRON_P_200811_mean <- cellStats(IRON_P_200811, mean)
IRON_P_200812_mean <- cellStats(IRON_P_200812, mean)

#2009

IRON_P_200901_mean <- cellStats(IRON_P_200901, mean)
IRON_P_200902_mean <- cellStats(IRON_P_200902, mean)
IRON_P_200903_mean <- cellStats(IRON_P_200903, mean)
IRON_P_200904_mean <- cellStats(IRON_P_200904, mean)
IRON_P_200905_mean <- cellStats(IRON_P_200905, mean)
IRON_P_200906_mean <- cellStats(IRON_P_200906, mean)
IRON_P_200907_mean <- cellStats(IRON_P_200907, mean)
IRON_P_200908_mean <- cellStats(IRON_P_200908, mean)
IRON_P_200909_mean <- cellStats(IRON_P_200909, mean)
IRON_P_200910_mean <- cellStats(IRON_P_200910, mean)
IRON_P_200911_mean <- cellStats(IRON_P_200911, mean)
IRON_P_200912_mean <- cellStats(IRON_P_200912, mean)

#2010

IRON_P_201001_mean <- cellStats(IRON_P_201001, mean)
IRON_P_201002_mean <- cellStats(IRON_P_201002, mean)
IRON_P_201003_mean <- cellStats(IRON_P_201003, mean)
IRON_P_201004_mean <- cellStats(IRON_P_201004, mean)
IRON_P_201005_mean <- cellStats(IRON_P_201005, mean)
IRON_P_201006_mean <- cellStats(IRON_P_201006, mean)
IRON_P_201007_mean <- cellStats(IRON_P_201007, mean)
IRON_P_201008_mean <- cellStats(IRON_P_201008, mean)
IRON_P_201009_mean <- cellStats(IRON_P_201009, mean)
IRON_P_201010_mean <- cellStats(IRON_P_201010, mean)
IRON_P_201011_mean <- cellStats(IRON_P_201011, mean)
IRON_P_201012_mean <- cellStats(IRON_P_201012, mean)

#2011

IRON_P_201101_mean <- cellStats(IRON_P_201101, mean)
IRON_P_201102_mean <- cellStats(IRON_P_201102, mean)
IRON_P_201103_mean <- cellStats(IRON_P_201103, mean)
IRON_P_201104_mean <- cellStats(IRON_P_201104, mean)
IRON_P_201105_mean <- cellStats(IRON_P_201105, mean)
IRON_P_201106_mean <- cellStats(IRON_P_201106, mean)
IRON_P_201107_mean <- cellStats(IRON_P_201107, mean)
IRON_P_201108_mean <- cellStats(IRON_P_201108, mean)
IRON_P_201109_mean <- cellStats(IRON_P_201109, mean)
IRON_P_201110_mean <- cellStats(IRON_P_201110, mean)
IRON_P_201111_mean <- cellStats(IRON_P_201111, mean)
IRON_P_201112_mean <- cellStats(IRON_P_201112, mean)

#2012
IRON_P_201201_mean <- cellStats(IRON_P_201201, mean)
IRON_P_201202_mean <- cellStats(IRON_P_201202, mean)
IRON_P_201203_mean <- cellStats(IRON_P_201203, mean)
IRON_P_201204_mean <- cellStats(IRON_P_201204, mean)
IRON_P_201205_mean <- cellStats(IRON_P_201205, mean)
IRON_P_201206_mean <- cellStats(IRON_P_201206, mean)
IRON_P_201207_mean <- cellStats(IRON_P_201207, mean)
IRON_P_201208_mean <- cellStats(IRON_P_201208, mean)
IRON_P_201209_mean <- cellStats(IRON_P_201209, mean)
IRON_P_201210_mean <- cellStats(IRON_P_201210, mean)
IRON_P_201211_mean <- cellStats(IRON_P_201211, mean)
IRON_P_201212_mean <- cellStats(IRON_P_201212, mean)

#2013
IRON_P_201301_mean <- cellStats(IRON_P_201301, mean)
IRON_P_201302_mean <- cellStats(IRON_P_201302, mean)
IRON_P_201303_mean <- cellStats(IRON_P_201303, mean)
IRON_P_201304_mean <- cellStats(IRON_P_201304, mean)
IRON_P_201305_mean <- cellStats(IRON_P_201305, mean)
IRON_P_201306_mean <- cellStats(IRON_P_201306, mean)
IRON_P_201307_mean <- cellStats(IRON_P_201307, mean)
IRON_P_201308_mean <- cellStats(IRON_P_201308, mean)
IRON_P_201309_mean <- cellStats(IRON_P_201309, mean)
IRON_P_201310_mean <- cellStats(IRON_P_201310, mean)
IRON_P_201311_mean <- cellStats(IRON_P_201311, mean)
IRON_P_201312_mean <- cellStats(IRON_P_201312, mean)

#2014
IRON_P_201401_mean <- cellStats(IRON_P_201401, mean)
IRON_P_201402_mean <- cellStats(IRON_P_201402, mean)
IRON_P_201403_mean <- cellStats(IRON_P_201403, mean)
IRON_P_201404_mean <- cellStats(IRON_P_201404, mean)
IRON_P_201405_mean <- cellStats(IRON_P_201405, mean)
IRON_P_201406_mean <- cellStats(IRON_P_201406, mean)
IRON_P_201407_mean <- cellStats(IRON_P_201407, mean)
IRON_P_201408_mean <- cellStats(IRON_P_201408, mean)
IRON_P_201409_mean <- cellStats(IRON_P_201409, mean)
IRON_P_201410_mean <- cellStats(IRON_P_201410, mean)
IRON_P_201411_mean <- cellStats(IRON_P_201411, mean)
IRON_P_201412_mean <- cellStats(IRON_P_201412, mean)

#2015
IRON_P_201501_mean <- cellStats(IRON_P_201501, mean)
IRON_P_201502_mean <- cellStats(IRON_P_201502, mean)
IRON_P_201503_mean <- cellStats(IRON_P_201503, mean)
IRON_P_201504_mean <- cellStats(IRON_P_201504, mean)
IRON_P_201505_mean <- cellStats(IRON_P_201505, mean)
IRON_P_201506_mean <- cellStats(IRON_P_201506, mean)
IRON_P_201507_mean <- cellStats(IRON_P_201507, mean)
IRON_P_201508_mean <- cellStats(IRON_P_201508, mean)
IRON_P_201509_mean <- cellStats(IRON_P_201509, mean)
IRON_P_201510_mean <- cellStats(IRON_P_201510, mean)
IRON_P_201511_mean <- cellStats(IRON_P_201511, mean)
IRON_P_201512_mean <- cellStats(IRON_P_201512, mean)

#2016
IRON_P_201601_mean <- cellStats(IRON_P_201601, mean)
IRON_P_201602_mean <- cellStats(IRON_P_201602, mean)
IRON_P_201603_mean <- cellStats(IRON_P_201603, mean)
IRON_P_201604_mean <- cellStats(IRON_P_201604, mean)
IRON_P_201605_mean <- cellStats(IRON_P_201605, mean)
IRON_P_201606_mean <- cellStats(IRON_P_201606, mean)
IRON_P_201607_mean <- cellStats(IRON_P_201607, mean)
IRON_P_201608_mean <- cellStats(IRON_P_201608, mean)
IRON_P_201609_mean <- cellStats(IRON_P_201609, mean)
IRON_P_201610_mean <- cellStats(IRON_P_201610, mean)
IRON_P_201611_mean <- cellStats(IRON_P_201611, mean)
IRON_P_201612_mean <- cellStats(IRON_P_201612, mean)

#2017
IRON_P_201701_mean <- cellStats(IRON_P_201701, mean)
IRON_P_201702_mean <- cellStats(IRON_P_201702, mean)
IRON_P_201703_mean <- cellStats(IRON_P_201703, mean)
IRON_P_201704_mean <- cellStats(IRON_P_201704, mean)
IRON_P_201705_mean <- cellStats(IRON_P_201705, mean)
IRON_P_201706_mean <- cellStats(IRON_P_201706, mean)
IRON_P_201707_mean <- cellStats(IRON_P_201707, mean)
IRON_P_201708_mean <- cellStats(IRON_P_201708, mean)
IRON_P_201709_mean <- cellStats(IRON_P_201709, mean)
IRON_P_201710_mean <- cellStats(IRON_P_201710, mean)
IRON_P_201711_mean <- cellStats(IRON_P_201711, mean)
IRON_P_201712_mean <- cellStats(IRON_P_201712, mean)

#2018
IRON_P_201801_mean <- cellStats(IRON_P_201801, mean)
IRON_P_201802_mean <- cellStats(IRON_P_201802, mean)
IRON_P_201803_mean <- cellStats(IRON_P_201803, mean)
IRON_P_201804_mean <- cellStats(IRON_P_201804, mean)
IRON_P_201805_mean <- cellStats(IRON_P_201805, mean)
IRON_P_201806_mean <- cellStats(IRON_P_201806, mean)
IRON_P_201807_mean <- cellStats(IRON_P_201807, mean)
IRON_P_201808_mean <- cellStats(IRON_P_201808, mean)
IRON_P_201809_mean <- cellStats(IRON_P_201809, mean)
IRON_P_201810_mean <- cellStats(IRON_P_201810, mean)
IRON_P_201811_mean <- cellStats(IRON_P_201811, mean)
IRON_P_201812_mean <- cellStats(IRON_P_201812, mean)

# JUAB

#2000
JUAB_P_200001 <- crop(P_200001, JUAB) 
JUAB_P_200002 <- crop(P_200002, JUAB)
JUAB_P_200003 <- crop(P_200003, JUAB)
JUAB_P_200004 <- crop(P_200004, JUAB)
JUAB_P_200005 <- crop(P_200005, JUAB)
JUAB_P_200006 <- crop(P_200006, JUAB)  
JUAB_P_200007 <- crop(P_200007, JUAB)  
JUAB_P_200008 <- crop(P_200008, JUAB)  
JUAB_P_200009 <- crop(P_200009, JUAB)  
JUAB_P_200010 <- crop(P_200010, JUAB)  
JUAB_P_200011 <- crop(P_200011, JUAB)  
JUAB_P_200012 <- crop(P_200012, JUAB)  
#2001
JUAB_P_200101 <- crop(P_200101, JUAB) 
JUAB_P_200102 <- crop(P_200102, JUAB)
JUAB_P_200103 <- crop(P_200103, JUAB)
JUAB_P_200104 <- crop(P_200104, JUAB)
JUAB_P_200105 <- crop(P_200105, JUAB)
JUAB_P_200106 <- crop(P_200106, JUAB)  
JUAB_P_200107 <- crop(P_200107, JUAB)  
JUAB_P_200108 <- crop(P_200108, JUAB)  
JUAB_P_200109 <- crop(P_200109, JUAB)  
JUAB_P_200110 <- crop(P_200110, JUAB)  
JUAB_P_200111 <- crop(P_200111, JUAB)  
JUAB_P_200112 <- crop(P_200112, JUAB)  

#2002
JUAB_P_200201 <- crop(P_200201, JUAB) 
JUAB_P_200202 <- crop(P_200202, JUAB)
JUAB_P_200203 <- crop(P_200203, JUAB)
JUAB_P_200204 <- crop(P_200204, JUAB)
JUAB_P_200205 <- crop(P_200205, JUAB)
JUAB_P_200206 <- crop(P_200206, JUAB)  
JUAB_P_200207 <- crop(P_200207, JUAB)  
JUAB_P_200208 <- crop(P_200208, JUAB)  
JUAB_P_200209 <- crop(P_200209, JUAB)  
JUAB_P_200210 <- crop(P_200210, JUAB)  
JUAB_P_200211 <- crop(P_200211, JUAB)  
JUAB_P_200212 <- crop(P_200212, JUAB)  
#2003
JUAB_P_200301 <- crop(P_200301, JUAB) 
JUAB_P_200302 <- crop(P_200302, JUAB)
JUAB_P_200303 <- crop(P_200303, JUAB)
JUAB_P_200304 <- crop(P_200304, JUAB)
JUAB_P_200305 <- crop(P_200305, JUAB)
JUAB_P_200306 <- crop(P_200306, JUAB)  
JUAB_P_200307 <- crop(P_200307, JUAB)  
JUAB_P_200308 <- crop(P_200308, JUAB)  
JUAB_P_200309 <- crop(P_200309, JUAB)  
JUAB_P_200310 <- crop(P_200310, JUAB)  
JUAB_P_200311 <- crop(P_200311, JUAB)  
JUAB_P_200312 <- crop(P_200312, JUAB)  
#2004
JUAB_P_200401 <- crop(P_200401, JUAB) 
JUAB_P_200402 <- crop(P_200402, JUAB)
JUAB_P_200403 <- crop(P_200403, JUAB)
JUAB_P_200404 <- crop(P_200404, JUAB)
JUAB_P_200405 <- crop(P_200405, JUAB)
JUAB_P_200406 <- crop(P_200406, JUAB)  
JUAB_P_200407 <- crop(P_200407, JUAB)  
JUAB_P_200408 <- crop(P_200408, JUAB)  
JUAB_P_200409 <- crop(P_200409, JUAB)  
JUAB_P_200410 <- crop(P_200410, JUAB)  
JUAB_P_200411 <- crop(P_200411, JUAB)  
JUAB_P_200412 <- crop(P_200412, JUAB)  
#2005
JUAB_P_200501 <- crop(P_200501, JUAB) 
JUAB_P_200502 <- crop(P_200502, JUAB)
JUAB_P_200503 <- crop(P_200503, JUAB)
JUAB_P_200504 <- crop(P_200504, JUAB)
JUAB_P_200505 <- crop(P_200505, JUAB)
JUAB_P_200506 <- crop(P_200506, JUAB)  
JUAB_P_200507 <- crop(P_200507, JUAB)  
JUAB_P_200508 <- crop(P_200508, JUAB)  
JUAB_P_200509 <- crop(P_200509, JUAB)  
JUAB_P_200510 <- crop(P_200510, JUAB)  
JUAB_P_200511 <- crop(P_200511, JUAB)  
JUAB_P_200512 <- crop(P_200512, JUAB)  
#2006
JUAB_P_200601 <- crop(P_200601, JUAB) 
JUAB_P_200602 <- crop(P_200602, JUAB)
JUAB_P_200603 <- crop(P_200603, JUAB)
JUAB_P_200604 <- crop(P_200604, JUAB)
JUAB_P_200605 <- crop(P_200605, JUAB)
JUAB_P_200606 <- crop(P_200606, JUAB)  
JUAB_P_200607 <- crop(P_200607, JUAB)  
JUAB_P_200608 <- crop(P_200608, JUAB)  
JUAB_P_200609 <- crop(P_200609, JUAB)  
JUAB_P_200610 <- crop(P_200610, JUAB)  
JUAB_P_200611 <- crop(P_200611, JUAB)  
JUAB_P_200612 <- crop(P_200612, JUAB)  
#2007
JUAB_P_200701 <- crop(P_200701, JUAB) 
JUAB_P_200702 <- crop(P_200702, JUAB)
JUAB_P_200703 <- crop(P_200703, JUAB)
JUAB_P_200704 <- crop(P_200704, JUAB)
JUAB_P_200705 <- crop(P_200705, JUAB)
JUAB_P_200706 <- crop(P_200706, JUAB)  
JUAB_P_200707 <- crop(P_200707, JUAB)  
JUAB_P_200708 <- crop(P_200708, JUAB)  
JUAB_P_200709 <- crop(P_200709, JUAB)  
JUAB_P_200710 <- crop(P_200710, JUAB)  
JUAB_P_200711 <- crop(P_200711, JUAB)  
JUAB_P_200712 <- crop(P_200712, JUAB)  
#2008
JUAB_P_200801 <- crop(P_200801, JUAB) 
JUAB_P_200802 <- crop(P_200802, JUAB)
JUAB_P_200803 <- crop(P_200803, JUAB)
JUAB_P_200804 <- crop(P_200804, JUAB)
JUAB_P_200805 <- crop(P_200805, JUAB)
JUAB_P_200806 <- crop(P_200806, JUAB)  
JUAB_P_200807 <- crop(P_200807, JUAB)  
JUAB_P_200808 <- crop(P_200808, JUAB)  
JUAB_P_200809 <- crop(P_200809, JUAB)  
JUAB_P_200810 <- crop(P_200810, JUAB)  
JUAB_P_200811 <- crop(P_200811, JUAB)  
JUAB_P_200812 <- crop(P_200812, JUAB)  
#2009
JUAB_P_200901 <- crop(P_200901, JUAB) 
JUAB_P_200902 <- crop(P_200902, JUAB)
JUAB_P_200903 <- crop(P_200903, JUAB)
JUAB_P_200904 <- crop(P_200904, JUAB)
JUAB_P_200905 <- crop(P_200905, JUAB)
JUAB_P_200906 <- crop(P_200906, JUAB)  
JUAB_P_200907 <- crop(P_200907, JUAB)  
JUAB_P_200908 <- crop(P_200908, JUAB)  
JUAB_P_200909 <- crop(P_200909, JUAB)  
JUAB_P_200910 <- crop(P_200910, JUAB)  
JUAB_P_200911 <- crop(P_200911, JUAB)  
JUAB_P_200912 <- crop(P_200912, JUAB)  
#2010
JUAB_P_201001 <- crop(P_201001, JUAB) 
JUAB_P_201002 <- crop(P_201002, JUAB)
JUAB_P_201003 <- crop(P_201003, JUAB)
JUAB_P_201004 <- crop(P_201004, JUAB)
JUAB_P_201005 <- crop(P_201005, JUAB)
JUAB_P_201006 <- crop(P_201006, JUAB)  
JUAB_P_201007 <- crop(P_201007, JUAB)  
JUAB_P_201008 <- crop(P_201008, JUAB)  
JUAB_P_201009 <- crop(P_201009, JUAB)  
JUAB_P_201010 <- crop(P_201010, JUAB)  
JUAB_P_201011 <- crop(P_201011, JUAB)  
JUAB_P_201012 <- crop(P_201012, JUAB)  
#2011
JUAB_P_201101 <- crop(P_201101, JUAB) 
JUAB_P_201102 <- crop(P_201102, JUAB)
JUAB_P_201103 <- crop(P_201103, JUAB)
JUAB_P_201104 <- crop(P_201104, JUAB)
JUAB_P_201105 <- crop(P_201105, JUAB)
JUAB_P_201106 <- crop(P_201106, JUAB)  
JUAB_P_201107 <- crop(P_201107, JUAB)  
JUAB_P_201108 <- crop(P_201108, JUAB)  
JUAB_P_201109 <- crop(P_201109, JUAB)  
JUAB_P_201110 <- crop(P_201110, JUAB)  
JUAB_P_201111 <- crop(P_201111, JUAB)  
JUAB_P_201112 <- crop(P_201112, JUAB)  
#2012
JUAB_P_201201 <- crop(P_201201, JUAB) 
JUAB_P_201202 <- crop(P_201202, JUAB)
JUAB_P_201203 <- crop(P_201203, JUAB)
JUAB_P_201204 <- crop(P_201204, JUAB)
JUAB_P_201205 <- crop(P_201205, JUAB)
JUAB_P_201206 <- crop(P_201206, JUAB)  
JUAB_P_201207 <- crop(P_201207, JUAB)  
JUAB_P_201208 <- crop(P_201208, JUAB)  
JUAB_P_201209 <- crop(P_201209, JUAB)  
JUAB_P_201210 <- crop(P_201210, JUAB)  
JUAB_P_201211 <- crop(P_201211, JUAB)  
JUAB_P_201212 <- crop(P_201212, JUAB)  
#2013
JUAB_P_201301 <- crop(P_201301, JUAB) 
JUAB_P_201302 <- crop(P_201302, JUAB)
JUAB_P_201303 <- crop(P_201303, JUAB)
JUAB_P_201304 <- crop(P_201304, JUAB)
JUAB_P_201305 <- crop(P_201305, JUAB)
JUAB_P_201306 <- crop(P_201306, JUAB)  
JUAB_P_201307 <- crop(P_201307, JUAB)  
JUAB_P_201308 <- crop(P_201308, JUAB)  
JUAB_P_201309 <- crop(P_201309, JUAB)  
JUAB_P_201310 <- crop(P_201310, JUAB)  
JUAB_P_201311 <- crop(P_201311, JUAB)  
JUAB_P_201312 <- crop(P_201312, JUAB)  
#2014
JUAB_P_201401 <- crop(P_201401, JUAB) 
JUAB_P_201402 <- crop(P_201402, JUAB)
JUAB_P_201403 <- crop(P_201403, JUAB)
JUAB_P_201404 <- crop(P_201404, JUAB)
JUAB_P_201405 <- crop(P_201405, JUAB)
JUAB_P_201406 <- crop(P_201406, JUAB)  
JUAB_P_201407 <- crop(P_201407, JUAB)  
JUAB_P_201408 <- crop(P_201408, JUAB)  
JUAB_P_201409 <- crop(P_201409, JUAB)  
JUAB_P_201410 <- crop(P_201410, JUAB)  
JUAB_P_201411 <- crop(P_201411, JUAB)  
JUAB_P_201412 <- crop(P_201412, JUAB)  
#2015
JUAB_P_201501 <- crop(P_201501, JUAB) 
JUAB_P_201502 <- crop(P_201502, JUAB)
JUAB_P_201503 <- crop(P_201503, JUAB)
JUAB_P_201504 <- crop(P_201504, JUAB)
JUAB_P_201505 <- crop(P_201505, JUAB)
JUAB_P_201506 <- crop(P_201506, JUAB)  
JUAB_P_201507 <- crop(P_201507, JUAB)  
JUAB_P_201508 <- crop(P_201508, JUAB)  
JUAB_P_201509 <- crop(P_201509, JUAB)  
JUAB_P_201510 <- crop(P_201510, JUAB)  
JUAB_P_201511 <- crop(P_201511, JUAB)  
JUAB_P_201512 <- crop(P_201512, JUAB)  
#2016
JUAB_P_201601 <- crop(P_201601, JUAB) 
JUAB_P_201602 <- crop(P_201602, JUAB)
JUAB_P_201603 <- crop(P_201603, JUAB)
JUAB_P_201604 <- crop(P_201604, JUAB)
JUAB_P_201605 <- crop(P_201605, JUAB)
JUAB_P_201606 <- crop(P_201606, JUAB)  
JUAB_P_201607 <- crop(P_201607, JUAB)  
JUAB_P_201608 <- crop(P_201608, JUAB)  
JUAB_P_201609 <- crop(P_201609, JUAB)  
JUAB_P_201610 <- crop(P_201610, JUAB)  
JUAB_P_201611 <- crop(P_201611, JUAB)  
JUAB_P_201612 <- crop(P_201612, JUAB)  
#2017
JUAB_P_201701 <- crop(P_201701, JUAB) 
JUAB_P_201702 <- crop(P_201702, JUAB)
JUAB_P_201703 <- crop(P_201703, JUAB)
JUAB_P_201704 <- crop(P_201704, JUAB)
JUAB_P_201705 <- crop(P_201705, JUAB)
JUAB_P_201706 <- crop(P_201706, JUAB)  
JUAB_P_201707 <- crop(P_201707, JUAB)  
JUAB_P_201708 <- crop(P_201708, JUAB)  
JUAB_P_201709 <- crop(P_201709, JUAB)  
JUAB_P_201710 <- crop(P_201710, JUAB)  
JUAB_P_201711 <- crop(P_201711, JUAB)  
JUAB_P_201712 <- crop(P_201712, JUAB)  

#2018

JUAB_P_201801 <- crop(P_201801, JUAB) 
JUAB_P_201802 <- crop(P_201802, JUAB)
JUAB_P_201803 <- crop(P_201803, JUAB)
JUAB_P_201804 <- crop(P_201804, JUAB)
JUAB_P_201805 <- crop(P_201805, JUAB)
JUAB_P_201806 <- crop(P_201806, JUAB)  
JUAB_P_201807 <- crop(P_201807, JUAB)  
JUAB_P_201808 <- crop(P_201808, JUAB)  
JUAB_P_201809 <- crop(P_201809, JUAB)  
JUAB_P_201810 <- crop(P_201810, JUAB)  
JUAB_P_201811 <- crop(P_201811, JUAB)  
JUAB_P_201812 <- crop(P_201812, JUAB)  


# Mean Monthly Precipitation
#2000
JUAB_P_200001_mean <- cellStats(JUAB_P_200001, mean)
JUAB_P_200002_mean <- cellStats(JUAB_P_200002, mean)
JUAB_P_200003_mean <- cellStats(JUAB_P_200003, mean)
JUAB_P_200004_mean <- cellStats(JUAB_P_200004, mean)
JUAB_P_200005_mean <- cellStats(JUAB_P_200005, mean)
JUAB_P_200006_mean <- cellStats(JUAB_P_200006, mean)
JUAB_P_200007_mean <- cellStats(JUAB_P_200007, mean)
JUAB_P_200008_mean <- cellStats(JUAB_P_200008, mean)
JUAB_P_200009_mean <- cellStats(JUAB_P_200009, mean)
JUAB_P_200010_mean <- cellStats(JUAB_P_200010, mean)
JUAB_P_200011_mean <- cellStats(JUAB_P_200011, mean)
JUAB_P_200012_mean <- cellStats(JUAB_P_200012, mean)
#2001
JUAB_P_200101_mean <- cellStats(JUAB_P_200101, mean)
JUAB_P_200102_mean <- cellStats(JUAB_P_200102, mean)
JUAB_P_200103_mean <- cellStats(JUAB_P_200103, mean)
JUAB_P_200104_mean <- cellStats(JUAB_P_200104, mean)
JUAB_P_200105_mean <- cellStats(JUAB_P_200105, mean)
JUAB_P_200106_mean <- cellStats(JUAB_P_200106, mean)
JUAB_P_200107_mean <- cellStats(JUAB_P_200107, mean)
JUAB_P_200108_mean <- cellStats(JUAB_P_200108, mean)
JUAB_P_200109_mean <- cellStats(JUAB_P_200109, mean)
JUAB_P_200110_mean <- cellStats(JUAB_P_200110, mean)
JUAB_P_200111_mean <- cellStats(JUAB_P_200111, mean)
JUAB_P_200112_mean <- cellStats(JUAB_P_200112, mean)

#2002
JUAB_P_200201_mean <- cellStats(JUAB_P_200201, mean)
JUAB_P_200202_mean <- cellStats(JUAB_P_200202, mean)
JUAB_P_200203_mean <- cellStats(JUAB_P_200203, mean)
JUAB_P_200204_mean <- cellStats(JUAB_P_200204, mean)
JUAB_P_200205_mean <- cellStats(JUAB_P_200205, mean)
JUAB_P_200206_mean <- cellStats(JUAB_P_200206, mean)
JUAB_P_200207_mean <- cellStats(JUAB_P_200207, mean)
JUAB_P_200208_mean <- cellStats(JUAB_P_200208, mean)
JUAB_P_200209_mean <- cellStats(JUAB_P_200209, mean)
JUAB_P_200210_mean <- cellStats(JUAB_P_200210, mean)
JUAB_P_200211_mean <- cellStats(JUAB_P_200211, mean)
JUAB_P_200212_mean <- cellStats(JUAB_P_200212, mean)

#2003
JUAB_P_200301_mean <- cellStats(JUAB_P_200301, mean)
JUAB_P_200302_mean <- cellStats(JUAB_P_200302, mean)
JUAB_P_200303_mean <- cellStats(JUAB_P_200303, mean)
JUAB_P_200304_mean <- cellStats(JUAB_P_200304, mean)
JUAB_P_200305_mean <- cellStats(JUAB_P_200305, mean)
JUAB_P_200306_mean <- cellStats(JUAB_P_200306, mean)
JUAB_P_200307_mean <- cellStats(JUAB_P_200307, mean)
JUAB_P_200308_mean <- cellStats(JUAB_P_200308, mean)
JUAB_P_200309_mean <- cellStats(JUAB_P_200309, mean)
JUAB_P_200310_mean <- cellStats(JUAB_P_200310, mean)
JUAB_P_200311_mean <- cellStats(JUAB_P_200311, mean)
JUAB_P_200312_mean <- cellStats(JUAB_P_200312, mean)

#2004

JUAB_P_200401_mean <- cellStats(JUAB_P_200401, mean)
JUAB_P_200402_mean <- cellStats(JUAB_P_200402, mean)
JUAB_P_200403_mean <- cellStats(JUAB_P_200403, mean)
JUAB_P_200404_mean <- cellStats(JUAB_P_200404, mean)
JUAB_P_200405_mean <- cellStats(JUAB_P_200405, mean)
JUAB_P_200406_mean <- cellStats(JUAB_P_200406, mean)
JUAB_P_200407_mean <- cellStats(JUAB_P_200407, mean)
JUAB_P_200408_mean <- cellStats(JUAB_P_200408, mean)
JUAB_P_200409_mean <- cellStats(JUAB_P_200409, mean)
JUAB_P_200410_mean <- cellStats(JUAB_P_200410, mean)
JUAB_P_200411_mean <- cellStats(JUAB_P_200411, mean)
JUAB_P_200412_mean <- cellStats(JUAB_P_200412, mean)

#2005

JUAB_P_200501_mean <- cellStats(JUAB_P_200501, mean)
JUAB_P_200502_mean <- cellStats(JUAB_P_200502, mean)
JUAB_P_200503_mean <- cellStats(JUAB_P_200503, mean)
JUAB_P_200504_mean <- cellStats(JUAB_P_200504, mean)
JUAB_P_200505_mean <- cellStats(JUAB_P_200505, mean)
JUAB_P_200506_mean <- cellStats(JUAB_P_200506, mean)
JUAB_P_200507_mean <- cellStats(JUAB_P_200507, mean)
JUAB_P_200508_mean <- cellStats(JUAB_P_200508, mean)
JUAB_P_200509_mean <- cellStats(JUAB_P_200509, mean)
JUAB_P_200510_mean <- cellStats(JUAB_P_200510, mean)
JUAB_P_200511_mean <- cellStats(JUAB_P_200511, mean)
JUAB_P_200512_mean <- cellStats(JUAB_P_200512, mean)

#2006

JUAB_P_200601_mean <- cellStats(JUAB_P_200601, mean)
JUAB_P_200602_mean <- cellStats(JUAB_P_200602, mean)
JUAB_P_200603_mean <- cellStats(JUAB_P_200603, mean)
JUAB_P_200604_mean <- cellStats(JUAB_P_200604, mean)
JUAB_P_200605_mean <- cellStats(JUAB_P_200605, mean)
JUAB_P_200606_mean <- cellStats(JUAB_P_200606, mean)
JUAB_P_200607_mean <- cellStats(JUAB_P_200607, mean)
JUAB_P_200608_mean <- cellStats(JUAB_P_200608, mean)
JUAB_P_200609_mean <- cellStats(JUAB_P_200609, mean)
JUAB_P_200610_mean <- cellStats(JUAB_P_200610, mean)
JUAB_P_200611_mean <- cellStats(JUAB_P_200611, mean)
JUAB_P_200612_mean <- cellStats(JUAB_P_200612, mean)

#2007

JUAB_P_200701_mean <- cellStats(JUAB_P_200701, mean)
JUAB_P_200702_mean <- cellStats(JUAB_P_200702, mean)
JUAB_P_200703_mean <- cellStats(JUAB_P_200703, mean)
JUAB_P_200704_mean <- cellStats(JUAB_P_200704, mean)
JUAB_P_200705_mean <- cellStats(JUAB_P_200705, mean)
JUAB_P_200706_mean <- cellStats(JUAB_P_200706, mean)
JUAB_P_200707_mean <- cellStats(JUAB_P_200707, mean)
JUAB_P_200708_mean <- cellStats(JUAB_P_200708, mean)
JUAB_P_200709_mean <- cellStats(JUAB_P_200709, mean)
JUAB_P_200710_mean <- cellStats(JUAB_P_200710, mean)
JUAB_P_200711_mean <- cellStats(JUAB_P_200711, mean)
JUAB_P_200712_mean <- cellStats(JUAB_P_200712, mean)

#2008

JUAB_P_200801_mean <- cellStats(JUAB_P_200801, mean)
JUAB_P_200802_mean <- cellStats(JUAB_P_200802, mean)
JUAB_P_200803_mean <- cellStats(JUAB_P_200803, mean)
JUAB_P_200804_mean <- cellStats(JUAB_P_200804, mean)
JUAB_P_200805_mean <- cellStats(JUAB_P_200805, mean)
JUAB_P_200806_mean <- cellStats(JUAB_P_200806, mean)
JUAB_P_200807_mean <- cellStats(JUAB_P_200807, mean)
JUAB_P_200808_mean <- cellStats(JUAB_P_200808, mean)
JUAB_P_200809_mean <- cellStats(JUAB_P_200809, mean)
JUAB_P_200810_mean <- cellStats(JUAB_P_200810, mean)
JUAB_P_200811_mean <- cellStats(JUAB_P_200811, mean)
JUAB_P_200812_mean <- cellStats(JUAB_P_200812, mean)

#2009

JUAB_P_200901_mean <- cellStats(JUAB_P_200901, mean)
JUAB_P_200902_mean <- cellStats(JUAB_P_200902, mean)
JUAB_P_200903_mean <- cellStats(JUAB_P_200903, mean)
JUAB_P_200904_mean <- cellStats(JUAB_P_200904, mean)
JUAB_P_200905_mean <- cellStats(JUAB_P_200905, mean)
JUAB_P_200906_mean <- cellStats(JUAB_P_200906, mean)
JUAB_P_200907_mean <- cellStats(JUAB_P_200907, mean)
JUAB_P_200908_mean <- cellStats(JUAB_P_200908, mean)
JUAB_P_200909_mean <- cellStats(JUAB_P_200909, mean)
JUAB_P_200910_mean <- cellStats(JUAB_P_200910, mean)
JUAB_P_200911_mean <- cellStats(JUAB_P_200911, mean)
JUAB_P_200912_mean <- cellStats(JUAB_P_200912, mean)

#2010

JUAB_P_201001_mean <- cellStats(JUAB_P_201001, mean)
JUAB_P_201002_mean <- cellStats(JUAB_P_201002, mean)
JUAB_P_201003_mean <- cellStats(JUAB_P_201003, mean)
JUAB_P_201004_mean <- cellStats(JUAB_P_201004, mean)
JUAB_P_201005_mean <- cellStats(JUAB_P_201005, mean)
JUAB_P_201006_mean <- cellStats(JUAB_P_201006, mean)
JUAB_P_201007_mean <- cellStats(JUAB_P_201007, mean)
JUAB_P_201008_mean <- cellStats(JUAB_P_201008, mean)
JUAB_P_201009_mean <- cellStats(JUAB_P_201009, mean)
JUAB_P_201010_mean <- cellStats(JUAB_P_201010, mean)
JUAB_P_201011_mean <- cellStats(JUAB_P_201011, mean)
JUAB_P_201012_mean <- cellStats(JUAB_P_201012, mean)

#2011

JUAB_P_201101_mean <- cellStats(JUAB_P_201101, mean)
JUAB_P_201102_mean <- cellStats(JUAB_P_201102, mean)
JUAB_P_201103_mean <- cellStats(JUAB_P_201103, mean)
JUAB_P_201104_mean <- cellStats(JUAB_P_201104, mean)
JUAB_P_201105_mean <- cellStats(JUAB_P_201105, mean)
JUAB_P_201106_mean <- cellStats(JUAB_P_201106, mean)
JUAB_P_201107_mean <- cellStats(JUAB_P_201107, mean)
JUAB_P_201108_mean <- cellStats(JUAB_P_201108, mean)
JUAB_P_201109_mean <- cellStats(JUAB_P_201109, mean)
JUAB_P_201110_mean <- cellStats(JUAB_P_201110, mean)
JUAB_P_201111_mean <- cellStats(JUAB_P_201111, mean)
JUAB_P_201112_mean <- cellStats(JUAB_P_201112, mean)

#2012
JUAB_P_201201_mean <- cellStats(JUAB_P_201201, mean)
JUAB_P_201202_mean <- cellStats(JUAB_P_201202, mean)
JUAB_P_201203_mean <- cellStats(JUAB_P_201203, mean)
JUAB_P_201204_mean <- cellStats(JUAB_P_201204, mean)
JUAB_P_201205_mean <- cellStats(JUAB_P_201205, mean)
JUAB_P_201206_mean <- cellStats(JUAB_P_201206, mean)
JUAB_P_201207_mean <- cellStats(JUAB_P_201207, mean)
JUAB_P_201208_mean <- cellStats(JUAB_P_201208, mean)
JUAB_P_201209_mean <- cellStats(JUAB_P_201209, mean)
JUAB_P_201210_mean <- cellStats(JUAB_P_201210, mean)
JUAB_P_201211_mean <- cellStats(JUAB_P_201211, mean)
JUAB_P_201212_mean <- cellStats(JUAB_P_201212, mean)

#2013
JUAB_P_201301_mean <- cellStats(JUAB_P_201301, mean)
JUAB_P_201302_mean <- cellStats(JUAB_P_201302, mean)
JUAB_P_201303_mean <- cellStats(JUAB_P_201303, mean)
JUAB_P_201304_mean <- cellStats(JUAB_P_201304, mean)
JUAB_P_201305_mean <- cellStats(JUAB_P_201305, mean)
JUAB_P_201306_mean <- cellStats(JUAB_P_201306, mean)
JUAB_P_201307_mean <- cellStats(JUAB_P_201307, mean)
JUAB_P_201308_mean <- cellStats(JUAB_P_201308, mean)
JUAB_P_201309_mean <- cellStats(JUAB_P_201309, mean)
JUAB_P_201310_mean <- cellStats(JUAB_P_201310, mean)
JUAB_P_201311_mean <- cellStats(JUAB_P_201311, mean)
JUAB_P_201312_mean <- cellStats(JUAB_P_201312, mean)

#2014
JUAB_P_201401_mean <- cellStats(JUAB_P_201401, mean)
JUAB_P_201402_mean <- cellStats(JUAB_P_201402, mean)
JUAB_P_201403_mean <- cellStats(JUAB_P_201403, mean)
JUAB_P_201404_mean <- cellStats(JUAB_P_201404, mean)
JUAB_P_201405_mean <- cellStats(JUAB_P_201405, mean)
JUAB_P_201406_mean <- cellStats(JUAB_P_201406, mean)
JUAB_P_201407_mean <- cellStats(JUAB_P_201407, mean)
JUAB_P_201408_mean <- cellStats(JUAB_P_201408, mean)
JUAB_P_201409_mean <- cellStats(JUAB_P_201409, mean)
JUAB_P_201410_mean <- cellStats(JUAB_P_201410, mean)
JUAB_P_201411_mean <- cellStats(JUAB_P_201411, mean)
JUAB_P_201412_mean <- cellStats(JUAB_P_201412, mean)

#2015
JUAB_P_201501_mean <- cellStats(JUAB_P_201501, mean)
JUAB_P_201502_mean <- cellStats(JUAB_P_201502, mean)
JUAB_P_201503_mean <- cellStats(JUAB_P_201503, mean)
JUAB_P_201504_mean <- cellStats(JUAB_P_201504, mean)
JUAB_P_201505_mean <- cellStats(JUAB_P_201505, mean)
JUAB_P_201506_mean <- cellStats(JUAB_P_201506, mean)
JUAB_P_201507_mean <- cellStats(JUAB_P_201507, mean)
JUAB_P_201508_mean <- cellStats(JUAB_P_201508, mean)
JUAB_P_201509_mean <- cellStats(JUAB_P_201509, mean)
JUAB_P_201510_mean <- cellStats(JUAB_P_201510, mean)
JUAB_P_201511_mean <- cellStats(JUAB_P_201511, mean)
JUAB_P_201512_mean <- cellStats(JUAB_P_201512, mean)

#2016
JUAB_P_201601_mean <- cellStats(JUAB_P_201601, mean)
JUAB_P_201602_mean <- cellStats(JUAB_P_201602, mean)
JUAB_P_201603_mean <- cellStats(JUAB_P_201603, mean)
JUAB_P_201604_mean <- cellStats(JUAB_P_201604, mean)
JUAB_P_201605_mean <- cellStats(JUAB_P_201605, mean)
JUAB_P_201606_mean <- cellStats(JUAB_P_201606, mean)
JUAB_P_201607_mean <- cellStats(JUAB_P_201607, mean)
JUAB_P_201608_mean <- cellStats(JUAB_P_201608, mean)
JUAB_P_201609_mean <- cellStats(JUAB_P_201609, mean)
JUAB_P_201610_mean <- cellStats(JUAB_P_201610, mean)
JUAB_P_201611_mean <- cellStats(JUAB_P_201611, mean)
JUAB_P_201612_mean <- cellStats(JUAB_P_201612, mean)

#2017
JUAB_P_201701_mean <- cellStats(JUAB_P_201701, mean)
JUAB_P_201702_mean <- cellStats(JUAB_P_201702, mean)
JUAB_P_201703_mean <- cellStats(JUAB_P_201703, mean)
JUAB_P_201704_mean <- cellStats(JUAB_P_201704, mean)
JUAB_P_201705_mean <- cellStats(JUAB_P_201705, mean)
JUAB_P_201706_mean <- cellStats(JUAB_P_201706, mean)
JUAB_P_201707_mean <- cellStats(JUAB_P_201707, mean)
JUAB_P_201708_mean <- cellStats(JUAB_P_201708, mean)
JUAB_P_201709_mean <- cellStats(JUAB_P_201709, mean)
JUAB_P_201710_mean <- cellStats(JUAB_P_201710, mean)
JUAB_P_201711_mean <- cellStats(JUAB_P_201711, mean)
JUAB_P_201712_mean <- cellStats(JUAB_P_201712, mean)

#2018
JUAB_P_201801_mean <- cellStats(JUAB_P_201801, mean)
JUAB_P_201802_mean <- cellStats(JUAB_P_201802, mean)
JUAB_P_201803_mean <- cellStats(JUAB_P_201803, mean)
JUAB_P_201804_mean <- cellStats(JUAB_P_201804, mean)
JUAB_P_201805_mean <- cellStats(JUAB_P_201805, mean)
JUAB_P_201806_mean <- cellStats(JUAB_P_201806, mean)
JUAB_P_201807_mean <- cellStats(JUAB_P_201807, mean)
JUAB_P_201808_mean <- cellStats(JUAB_P_201808, mean)
JUAB_P_201809_mean <- cellStats(JUAB_P_201809, mean)
JUAB_P_201810_mean <- cellStats(JUAB_P_201810, mean)
JUAB_P_201811_mean <- cellStats(JUAB_P_201811, mean)
JUAB_P_201812_mean <- cellStats(JUAB_P_201812, mean)

# KANE

#2000
KANE_P_200001 <- crop(P_200001, KANE) 
KANE_P_200002 <- crop(P_200002, KANE)
KANE_P_200003 <- crop(P_200003, KANE)
KANE_P_200004 <- crop(P_200004, KANE)
KANE_P_200005 <- crop(P_200005, KANE)
KANE_P_200006 <- crop(P_200006, KANE)  
KANE_P_200007 <- crop(P_200007, KANE)  
KANE_P_200008 <- crop(P_200008, KANE)  
KANE_P_200009 <- crop(P_200009, KANE)  
KANE_P_200010 <- crop(P_200010, KANE)  
KANE_P_200011 <- crop(P_200011, KANE)  
KANE_P_200012 <- crop(P_200012, KANE)  
#2001
KANE_P_200101 <- crop(P_200101, KANE) 
KANE_P_200102 <- crop(P_200102, KANE)
KANE_P_200103 <- crop(P_200103, KANE)
KANE_P_200104 <- crop(P_200104, KANE)
KANE_P_200105 <- crop(P_200105, KANE)
KANE_P_200106 <- crop(P_200106, KANE)  
KANE_P_200107 <- crop(P_200107, KANE)  
KANE_P_200108 <- crop(P_200108, KANE)  
KANE_P_200109 <- crop(P_200109, KANE)  
KANE_P_200110 <- crop(P_200110, KANE)  
KANE_P_200111 <- crop(P_200111, KANE)  
KANE_P_200112 <- crop(P_200112, KANE)  

#2002
KANE_P_200201 <- crop(P_200201, KANE) 
KANE_P_200202 <- crop(P_200202, KANE)
KANE_P_200203 <- crop(P_200203, KANE)
KANE_P_200204 <- crop(P_200204, KANE)
KANE_P_200205 <- crop(P_200205, KANE)
KANE_P_200206 <- crop(P_200206, KANE)  
KANE_P_200207 <- crop(P_200207, KANE)  
KANE_P_200208 <- crop(P_200208, KANE)  
KANE_P_200209 <- crop(P_200209, KANE)  
KANE_P_200210 <- crop(P_200210, KANE)  
KANE_P_200211 <- crop(P_200211, KANE)  
KANE_P_200212 <- crop(P_200212, KANE)  
#2003
KANE_P_200301 <- crop(P_200301, KANE) 
KANE_P_200302 <- crop(P_200302, KANE)
KANE_P_200303 <- crop(P_200303, KANE)
KANE_P_200304 <- crop(P_200304, KANE)
KANE_P_200305 <- crop(P_200305, KANE)
KANE_P_200306 <- crop(P_200306, KANE)  
KANE_P_200307 <- crop(P_200307, KANE)  
KANE_P_200308 <- crop(P_200308, KANE)  
KANE_P_200309 <- crop(P_200309, KANE)  
KANE_P_200310 <- crop(P_200310, KANE)  
KANE_P_200311 <- crop(P_200311, KANE)  
KANE_P_200312 <- crop(P_200312, KANE)  
#2004
KANE_P_200401 <- crop(P_200401, KANE) 
KANE_P_200402 <- crop(P_200402, KANE)
KANE_P_200403 <- crop(P_200403, KANE)
KANE_P_200404 <- crop(P_200404, KANE)
KANE_P_200405 <- crop(P_200405, KANE)
KANE_P_200406 <- crop(P_200406, KANE)  
KANE_P_200407 <- crop(P_200407, KANE)  
KANE_P_200408 <- crop(P_200408, KANE)  
KANE_P_200409 <- crop(P_200409, KANE)  
KANE_P_200410 <- crop(P_200410, KANE)  
KANE_P_200411 <- crop(P_200411, KANE)  
KANE_P_200412 <- crop(P_200412, KANE)  
#2005
KANE_P_200501 <- crop(P_200501, KANE) 
KANE_P_200502 <- crop(P_200502, KANE)
KANE_P_200503 <- crop(P_200503, KANE)
KANE_P_200504 <- crop(P_200504, KANE)
KANE_P_200505 <- crop(P_200505, KANE)
KANE_P_200506 <- crop(P_200506, KANE)  
KANE_P_200507 <- crop(P_200507, KANE)  
KANE_P_200508 <- crop(P_200508, KANE)  
KANE_P_200509 <- crop(P_200509, KANE)  
KANE_P_200510 <- crop(P_200510, KANE)  
KANE_P_200511 <- crop(P_200511, KANE)  
KANE_P_200512 <- crop(P_200512, KANE)  
#2006
KANE_P_200601 <- crop(P_200601, KANE) 
KANE_P_200602 <- crop(P_200602, KANE)
KANE_P_200603 <- crop(P_200603, KANE)
KANE_P_200604 <- crop(P_200604, KANE)
KANE_P_200605 <- crop(P_200605, KANE)
KANE_P_200606 <- crop(P_200606, KANE)  
KANE_P_200607 <- crop(P_200607, KANE)  
KANE_P_200608 <- crop(P_200608, KANE)  
KANE_P_200609 <- crop(P_200609, KANE)  
KANE_P_200610 <- crop(P_200610, KANE)  
KANE_P_200611 <- crop(P_200611, KANE)  
KANE_P_200612 <- crop(P_200612, KANE)  
#2007
KANE_P_200701 <- crop(P_200701, KANE) 
KANE_P_200702 <- crop(P_200702, KANE)
KANE_P_200703 <- crop(P_200703, KANE)
KANE_P_200704 <- crop(P_200704, KANE)
KANE_P_200705 <- crop(P_200705, KANE)
KANE_P_200706 <- crop(P_200706, KANE)  
KANE_P_200707 <- crop(P_200707, KANE)  
KANE_P_200708 <- crop(P_200708, KANE)  
KANE_P_200709 <- crop(P_200709, KANE)  
KANE_P_200710 <- crop(P_200710, KANE)  
KANE_P_200711 <- crop(P_200711, KANE)  
KANE_P_200712 <- crop(P_200712, KANE)  
#2008
KANE_P_200801 <- crop(P_200801, KANE) 
KANE_P_200802 <- crop(P_200802, KANE)
KANE_P_200803 <- crop(P_200803, KANE)
KANE_P_200804 <- crop(P_200804, KANE)
KANE_P_200805 <- crop(P_200805, KANE)
KANE_P_200806 <- crop(P_200806, KANE)  
KANE_P_200807 <- crop(P_200807, KANE)  
KANE_P_200808 <- crop(P_200808, KANE)  
KANE_P_200809 <- crop(P_200809, KANE)  
KANE_P_200810 <- crop(P_200810, KANE)  
KANE_P_200811 <- crop(P_200811, KANE)  
KANE_P_200812 <- crop(P_200812, KANE)  
#2009
KANE_P_200901 <- crop(P_200901, KANE) 
KANE_P_200902 <- crop(P_200902, KANE)
KANE_P_200903 <- crop(P_200903, KANE)
KANE_P_200904 <- crop(P_200904, KANE)
KANE_P_200905 <- crop(P_200905, KANE)
KANE_P_200906 <- crop(P_200906, KANE)  
KANE_P_200907 <- crop(P_200907, KANE)  
KANE_P_200908 <- crop(P_200908, KANE)  
KANE_P_200909 <- crop(P_200909, KANE)  
KANE_P_200910 <- crop(P_200910, KANE)  
KANE_P_200911 <- crop(P_200911, KANE)  
KANE_P_200912 <- crop(P_200912, KANE)  
#2010
KANE_P_201001 <- crop(P_201001, KANE) 
KANE_P_201002 <- crop(P_201002, KANE)
KANE_P_201003 <- crop(P_201003, KANE)
KANE_P_201004 <- crop(P_201004, KANE)
KANE_P_201005 <- crop(P_201005, KANE)
KANE_P_201006 <- crop(P_201006, KANE)  
KANE_P_201007 <- crop(P_201007, KANE)  
KANE_P_201008 <- crop(P_201008, KANE)  
KANE_P_201009 <- crop(P_201009, KANE)  
KANE_P_201010 <- crop(P_201010, KANE)  
KANE_P_201011 <- crop(P_201011, KANE)  
KANE_P_201012 <- crop(P_201012, KANE)  
#2011
KANE_P_201101 <- crop(P_201101, KANE) 
KANE_P_201102 <- crop(P_201102, KANE)
KANE_P_201103 <- crop(P_201103, KANE)
KANE_P_201104 <- crop(P_201104, KANE)
KANE_P_201105 <- crop(P_201105, KANE)
KANE_P_201106 <- crop(P_201106, KANE)  
KANE_P_201107 <- crop(P_201107, KANE)  
KANE_P_201108 <- crop(P_201108, KANE)  
KANE_P_201109 <- crop(P_201109, KANE)  
KANE_P_201110 <- crop(P_201110, KANE)  
KANE_P_201111 <- crop(P_201111, KANE)  
KANE_P_201112 <- crop(P_201112, KANE)  
#2012
KANE_P_201201 <- crop(P_201201, KANE) 
KANE_P_201202 <- crop(P_201202, KANE)
KANE_P_201203 <- crop(P_201203, KANE)
KANE_P_201204 <- crop(P_201204, KANE)
KANE_P_201205 <- crop(P_201205, KANE)
KANE_P_201206 <- crop(P_201206, KANE)  
KANE_P_201207 <- crop(P_201207, KANE)  
KANE_P_201208 <- crop(P_201208, KANE)  
KANE_P_201209 <- crop(P_201209, KANE)  
KANE_P_201210 <- crop(P_201210, KANE)  
KANE_P_201211 <- crop(P_201211, KANE)  
KANE_P_201212 <- crop(P_201212, KANE)  
#2013
KANE_P_201301 <- crop(P_201301, KANE) 
KANE_P_201302 <- crop(P_201302, KANE)
KANE_P_201303 <- crop(P_201303, KANE)
KANE_P_201304 <- crop(P_201304, KANE)
KANE_P_201305 <- crop(P_201305, KANE)
KANE_P_201306 <- crop(P_201306, KANE)  
KANE_P_201307 <- crop(P_201307, KANE)  
KANE_P_201308 <- crop(P_201308, KANE)  
KANE_P_201309 <- crop(P_201309, KANE)  
KANE_P_201310 <- crop(P_201310, KANE)  
KANE_P_201311 <- crop(P_201311, KANE)  
KANE_P_201312 <- crop(P_201312, KANE)  
#2014
KANE_P_201401 <- crop(P_201401, KANE) 
KANE_P_201402 <- crop(P_201402, KANE)
KANE_P_201403 <- crop(P_201403, KANE)
KANE_P_201404 <- crop(P_201404, KANE)
KANE_P_201405 <- crop(P_201405, KANE)
KANE_P_201406 <- crop(P_201406, KANE)  
KANE_P_201407 <- crop(P_201407, KANE)  
KANE_P_201408 <- crop(P_201408, KANE)  
KANE_P_201409 <- crop(P_201409, KANE)  
KANE_P_201410 <- crop(P_201410, KANE)  
KANE_P_201411 <- crop(P_201411, KANE)  
KANE_P_201412 <- crop(P_201412, KANE)  
#2015
KANE_P_201501 <- crop(P_201501, KANE) 
KANE_P_201502 <- crop(P_201502, KANE)
KANE_P_201503 <- crop(P_201503, KANE)
KANE_P_201504 <- crop(P_201504, KANE)
KANE_P_201505 <- crop(P_201505, KANE)
KANE_P_201506 <- crop(P_201506, KANE)  
KANE_P_201507 <- crop(P_201507, KANE)  
KANE_P_201508 <- crop(P_201508, KANE)  
KANE_P_201509 <- crop(P_201509, KANE)  
KANE_P_201510 <- crop(P_201510, KANE)  
KANE_P_201511 <- crop(P_201511, KANE)  
KANE_P_201512 <- crop(P_201512, KANE)  
#2016
KANE_P_201601 <- crop(P_201601, KANE) 
KANE_P_201602 <- crop(P_201602, KANE)
KANE_P_201603 <- crop(P_201603, KANE)
KANE_P_201604 <- crop(P_201604, KANE)
KANE_P_201605 <- crop(P_201605, KANE)
KANE_P_201606 <- crop(P_201606, KANE)  
KANE_P_201607 <- crop(P_201607, KANE)  
KANE_P_201608 <- crop(P_201608, KANE)  
KANE_P_201609 <- crop(P_201609, KANE)  
KANE_P_201610 <- crop(P_201610, KANE)  
KANE_P_201611 <- crop(P_201611, KANE)  
KANE_P_201612 <- crop(P_201612, KANE)  
#2017
KANE_P_201701 <- crop(P_201701, KANE) 
KANE_P_201702 <- crop(P_201702, KANE)
KANE_P_201703 <- crop(P_201703, KANE)
KANE_P_201704 <- crop(P_201704, KANE)
KANE_P_201705 <- crop(P_201705, KANE)
KANE_P_201706 <- crop(P_201706, KANE)  
KANE_P_201707 <- crop(P_201707, KANE)  
KANE_P_201708 <- crop(P_201708, KANE)  
KANE_P_201709 <- crop(P_201709, KANE)  
KANE_P_201710 <- crop(P_201710, KANE)  
KANE_P_201711 <- crop(P_201711, KANE)  
KANE_P_201712 <- crop(P_201712, KANE)  

#2018

KANE_P_201801 <- crop(P_201801, KANE) 
KANE_P_201802 <- crop(P_201802, KANE)
KANE_P_201803 <- crop(P_201803, KANE)
KANE_P_201804 <- crop(P_201804, KANE)
KANE_P_201805 <- crop(P_201805, KANE)
KANE_P_201806 <- crop(P_201806, KANE)  
KANE_P_201807 <- crop(P_201807, KANE)  
KANE_P_201808 <- crop(P_201808, KANE)  
KANE_P_201809 <- crop(P_201809, KANE)  
KANE_P_201810 <- crop(P_201810, KANE)  
KANE_P_201811 <- crop(P_201811, KANE)  
KANE_P_201812 <- crop(P_201812, KANE)  


# Mean Monthly Precipitation
#2000
KANE_P_200001_mean <- cellStats(KANE_P_200001, mean)
KANE_P_200002_mean <- cellStats(KANE_P_200002, mean)
KANE_P_200003_mean <- cellStats(KANE_P_200003, mean)
KANE_P_200004_mean <- cellStats(KANE_P_200004, mean)
KANE_P_200005_mean <- cellStats(KANE_P_200005, mean)
KANE_P_200006_mean <- cellStats(KANE_P_200006, mean)
KANE_P_200007_mean <- cellStats(KANE_P_200007, mean)
KANE_P_200008_mean <- cellStats(KANE_P_200008, mean)
KANE_P_200009_mean <- cellStats(KANE_P_200009, mean)
KANE_P_200010_mean <- cellStats(KANE_P_200010, mean)
KANE_P_200011_mean <- cellStats(KANE_P_200011, mean)
KANE_P_200012_mean <- cellStats(KANE_P_200012, mean)
#2001
KANE_P_200101_mean <- cellStats(KANE_P_200101, mean)
KANE_P_200102_mean <- cellStats(KANE_P_200102, mean)
KANE_P_200103_mean <- cellStats(KANE_P_200103, mean)
KANE_P_200104_mean <- cellStats(KANE_P_200104, mean)
KANE_P_200105_mean <- cellStats(KANE_P_200105, mean)
KANE_P_200106_mean <- cellStats(KANE_P_200106, mean)
KANE_P_200107_mean <- cellStats(KANE_P_200107, mean)
KANE_P_200108_mean <- cellStats(KANE_P_200108, mean)
KANE_P_200109_mean <- cellStats(KANE_P_200109, mean)
KANE_P_200110_mean <- cellStats(KANE_P_200110, mean)
KANE_P_200111_mean <- cellStats(KANE_P_200111, mean)
KANE_P_200112_mean <- cellStats(KANE_P_200112, mean)

#2002
KANE_P_200201_mean <- cellStats(KANE_P_200201, mean)
KANE_P_200202_mean <- cellStats(KANE_P_200202, mean)
KANE_P_200203_mean <- cellStats(KANE_P_200203, mean)
KANE_P_200204_mean <- cellStats(KANE_P_200204, mean)
KANE_P_200205_mean <- cellStats(KANE_P_200205, mean)
KANE_P_200206_mean <- cellStats(KANE_P_200206, mean)
KANE_P_200207_mean <- cellStats(KANE_P_200207, mean)
KANE_P_200208_mean <- cellStats(KANE_P_200208, mean)
KANE_P_200209_mean <- cellStats(KANE_P_200209, mean)
KANE_P_200210_mean <- cellStats(KANE_P_200210, mean)
KANE_P_200211_mean <- cellStats(KANE_P_200211, mean)
KANE_P_200212_mean <- cellStats(KANE_P_200212, mean)

#2003
KANE_P_200301_mean <- cellStats(KANE_P_200301, mean)
KANE_P_200302_mean <- cellStats(KANE_P_200302, mean)
KANE_P_200303_mean <- cellStats(KANE_P_200303, mean)
KANE_P_200304_mean <- cellStats(KANE_P_200304, mean)
KANE_P_200305_mean <- cellStats(KANE_P_200305, mean)
KANE_P_200306_mean <- cellStats(KANE_P_200306, mean)
KANE_P_200307_mean <- cellStats(KANE_P_200307, mean)
KANE_P_200308_mean <- cellStats(KANE_P_200308, mean)
KANE_P_200309_mean <- cellStats(KANE_P_200309, mean)
KANE_P_200310_mean <- cellStats(KANE_P_200310, mean)
KANE_P_200311_mean <- cellStats(KANE_P_200311, mean)
KANE_P_200312_mean <- cellStats(KANE_P_200312, mean)

#2004

KANE_P_200401_mean <- cellStats(KANE_P_200401, mean)
KANE_P_200402_mean <- cellStats(KANE_P_200402, mean)
KANE_P_200403_mean <- cellStats(KANE_P_200403, mean)
KANE_P_200404_mean <- cellStats(KANE_P_200404, mean)
KANE_P_200405_mean <- cellStats(KANE_P_200405, mean)
KANE_P_200406_mean <- cellStats(KANE_P_200406, mean)
KANE_P_200407_mean <- cellStats(KANE_P_200407, mean)
KANE_P_200408_mean <- cellStats(KANE_P_200408, mean)
KANE_P_200409_mean <- cellStats(KANE_P_200409, mean)
KANE_P_200410_mean <- cellStats(KANE_P_200410, mean)
KANE_P_200411_mean <- cellStats(KANE_P_200411, mean)
KANE_P_200412_mean <- cellStats(KANE_P_200412, mean)

#2005

KANE_P_200501_mean <- cellStats(KANE_P_200501, mean)
KANE_P_200502_mean <- cellStats(KANE_P_200502, mean)
KANE_P_200503_mean <- cellStats(KANE_P_200503, mean)
KANE_P_200504_mean <- cellStats(KANE_P_200504, mean)
KANE_P_200505_mean <- cellStats(KANE_P_200505, mean)
KANE_P_200506_mean <- cellStats(KANE_P_200506, mean)
KANE_P_200507_mean <- cellStats(KANE_P_200507, mean)
KANE_P_200508_mean <- cellStats(KANE_P_200508, mean)
KANE_P_200509_mean <- cellStats(KANE_P_200509, mean)
KANE_P_200510_mean <- cellStats(KANE_P_200510, mean)
KANE_P_200511_mean <- cellStats(KANE_P_200511, mean)
KANE_P_200512_mean <- cellStats(KANE_P_200512, mean)

#2006

KANE_P_200601_mean <- cellStats(KANE_P_200601, mean)
KANE_P_200602_mean <- cellStats(KANE_P_200602, mean)
KANE_P_200603_mean <- cellStats(KANE_P_200603, mean)
KANE_P_200604_mean <- cellStats(KANE_P_200604, mean)
KANE_P_200605_mean <- cellStats(KANE_P_200605, mean)
KANE_P_200606_mean <- cellStats(KANE_P_200606, mean)
KANE_P_200607_mean <- cellStats(KANE_P_200607, mean)
KANE_P_200608_mean <- cellStats(KANE_P_200608, mean)
KANE_P_200609_mean <- cellStats(KANE_P_200609, mean)
KANE_P_200610_mean <- cellStats(KANE_P_200610, mean)
KANE_P_200611_mean <- cellStats(KANE_P_200611, mean)
KANE_P_200612_mean <- cellStats(KANE_P_200612, mean)

#2007

KANE_P_200701_mean <- cellStats(KANE_P_200701, mean)
KANE_P_200702_mean <- cellStats(KANE_P_200702, mean)
KANE_P_200703_mean <- cellStats(KANE_P_200703, mean)
KANE_P_200704_mean <- cellStats(KANE_P_200704, mean)
KANE_P_200705_mean <- cellStats(KANE_P_200705, mean)
KANE_P_200706_mean <- cellStats(KANE_P_200706, mean)
KANE_P_200707_mean <- cellStats(KANE_P_200707, mean)
KANE_P_200708_mean <- cellStats(KANE_P_200708, mean)
KANE_P_200709_mean <- cellStats(KANE_P_200709, mean)
KANE_P_200710_mean <- cellStats(KANE_P_200710, mean)
KANE_P_200711_mean <- cellStats(KANE_P_200711, mean)
KANE_P_200712_mean <- cellStats(KANE_P_200712, mean)

#2008

KANE_P_200801_mean <- cellStats(KANE_P_200801, mean)
KANE_P_200802_mean <- cellStats(KANE_P_200802, mean)
KANE_P_200803_mean <- cellStats(KANE_P_200803, mean)
KANE_P_200804_mean <- cellStats(KANE_P_200804, mean)
KANE_P_200805_mean <- cellStats(KANE_P_200805, mean)
KANE_P_200806_mean <- cellStats(KANE_P_200806, mean)
KANE_P_200807_mean <- cellStats(KANE_P_200807, mean)
KANE_P_200808_mean <- cellStats(KANE_P_200808, mean)
KANE_P_200809_mean <- cellStats(KANE_P_200809, mean)
KANE_P_200810_mean <- cellStats(KANE_P_200810, mean)
KANE_P_200811_mean <- cellStats(KANE_P_200811, mean)
KANE_P_200812_mean <- cellStats(KANE_P_200812, mean)

#2009

KANE_P_200901_mean <- cellStats(KANE_P_200901, mean)
KANE_P_200902_mean <- cellStats(KANE_P_200902, mean)
KANE_P_200903_mean <- cellStats(KANE_P_200903, mean)
KANE_P_200904_mean <- cellStats(KANE_P_200904, mean)
KANE_P_200905_mean <- cellStats(KANE_P_200905, mean)
KANE_P_200906_mean <- cellStats(KANE_P_200906, mean)
KANE_P_200907_mean <- cellStats(KANE_P_200907, mean)
KANE_P_200908_mean <- cellStats(KANE_P_200908, mean)
KANE_P_200909_mean <- cellStats(KANE_P_200909, mean)
KANE_P_200910_mean <- cellStats(KANE_P_200910, mean)
KANE_P_200911_mean <- cellStats(KANE_P_200911, mean)
KANE_P_200912_mean <- cellStats(KANE_P_200912, mean)

#2010

KANE_P_201001_mean <- cellStats(KANE_P_201001, mean)
KANE_P_201002_mean <- cellStats(KANE_P_201002, mean)
KANE_P_201003_mean <- cellStats(KANE_P_201003, mean)
KANE_P_201004_mean <- cellStats(KANE_P_201004, mean)
KANE_P_201005_mean <- cellStats(KANE_P_201005, mean)
KANE_P_201006_mean <- cellStats(KANE_P_201006, mean)
KANE_P_201007_mean <- cellStats(KANE_P_201007, mean)
KANE_P_201008_mean <- cellStats(KANE_P_201008, mean)
KANE_P_201009_mean <- cellStats(KANE_P_201009, mean)
KANE_P_201010_mean <- cellStats(KANE_P_201010, mean)
KANE_P_201011_mean <- cellStats(KANE_P_201011, mean)
KANE_P_201012_mean <- cellStats(KANE_P_201012, mean)

#2011

KANE_P_201101_mean <- cellStats(KANE_P_201101, mean)
KANE_P_201102_mean <- cellStats(KANE_P_201102, mean)
KANE_P_201103_mean <- cellStats(KANE_P_201103, mean)
KANE_P_201104_mean <- cellStats(KANE_P_201104, mean)
KANE_P_201105_mean <- cellStats(KANE_P_201105, mean)
KANE_P_201106_mean <- cellStats(KANE_P_201106, mean)
KANE_P_201107_mean <- cellStats(KANE_P_201107, mean)
KANE_P_201108_mean <- cellStats(KANE_P_201108, mean)
KANE_P_201109_mean <- cellStats(KANE_P_201109, mean)
KANE_P_201110_mean <- cellStats(KANE_P_201110, mean)
KANE_P_201111_mean <- cellStats(KANE_P_201111, mean)
KANE_P_201112_mean <- cellStats(KANE_P_201112, mean)

#2012
KANE_P_201201_mean <- cellStats(KANE_P_201201, mean)
KANE_P_201202_mean <- cellStats(KANE_P_201202, mean)
KANE_P_201203_mean <- cellStats(KANE_P_201203, mean)
KANE_P_201204_mean <- cellStats(KANE_P_201204, mean)
KANE_P_201205_mean <- cellStats(KANE_P_201205, mean)
KANE_P_201206_mean <- cellStats(KANE_P_201206, mean)
KANE_P_201207_mean <- cellStats(KANE_P_201207, mean)
KANE_P_201208_mean <- cellStats(KANE_P_201208, mean)
KANE_P_201209_mean <- cellStats(KANE_P_201209, mean)
KANE_P_201210_mean <- cellStats(KANE_P_201210, mean)
KANE_P_201211_mean <- cellStats(KANE_P_201211, mean)
KANE_P_201212_mean <- cellStats(KANE_P_201212, mean)

#2013
KANE_P_201301_mean <- cellStats(KANE_P_201301, mean)
KANE_P_201302_mean <- cellStats(KANE_P_201302, mean)
KANE_P_201303_mean <- cellStats(KANE_P_201303, mean)
KANE_P_201304_mean <- cellStats(KANE_P_201304, mean)
KANE_P_201305_mean <- cellStats(KANE_P_201305, mean)
KANE_P_201306_mean <- cellStats(KANE_P_201306, mean)
KANE_P_201307_mean <- cellStats(KANE_P_201307, mean)
KANE_P_201308_mean <- cellStats(KANE_P_201308, mean)
KANE_P_201309_mean <- cellStats(KANE_P_201309, mean)
KANE_P_201310_mean <- cellStats(KANE_P_201310, mean)
KANE_P_201311_mean <- cellStats(KANE_P_201311, mean)
KANE_P_201312_mean <- cellStats(KANE_P_201312, mean)

#2014
KANE_P_201401_mean <- cellStats(KANE_P_201401, mean)
KANE_P_201402_mean <- cellStats(KANE_P_201402, mean)
KANE_P_201403_mean <- cellStats(KANE_P_201403, mean)
KANE_P_201404_mean <- cellStats(KANE_P_201404, mean)
KANE_P_201405_mean <- cellStats(KANE_P_201405, mean)
KANE_P_201406_mean <- cellStats(KANE_P_201406, mean)
KANE_P_201407_mean <- cellStats(KANE_P_201407, mean)
KANE_P_201408_mean <- cellStats(KANE_P_201408, mean)
KANE_P_201409_mean <- cellStats(KANE_P_201409, mean)
KANE_P_201410_mean <- cellStats(KANE_P_201410, mean)
KANE_P_201411_mean <- cellStats(KANE_P_201411, mean)
KANE_P_201412_mean <- cellStats(KANE_P_201412, mean)

#2015
KANE_P_201501_mean <- cellStats(KANE_P_201501, mean)
KANE_P_201502_mean <- cellStats(KANE_P_201502, mean)
KANE_P_201503_mean <- cellStats(KANE_P_201503, mean)
KANE_P_201504_mean <- cellStats(KANE_P_201504, mean)
KANE_P_201505_mean <- cellStats(KANE_P_201505, mean)
KANE_P_201506_mean <- cellStats(KANE_P_201506, mean)
KANE_P_201507_mean <- cellStats(KANE_P_201507, mean)
KANE_P_201508_mean <- cellStats(KANE_P_201508, mean)
KANE_P_201509_mean <- cellStats(KANE_P_201509, mean)
KANE_P_201510_mean <- cellStats(KANE_P_201510, mean)
KANE_P_201511_mean <- cellStats(KANE_P_201511, mean)
KANE_P_201512_mean <- cellStats(KANE_P_201512, mean)

#2016
KANE_P_201601_mean <- cellStats(KANE_P_201601, mean)
KANE_P_201602_mean <- cellStats(KANE_P_201602, mean)
KANE_P_201603_mean <- cellStats(KANE_P_201603, mean)
KANE_P_201604_mean <- cellStats(KANE_P_201604, mean)
KANE_P_201605_mean <- cellStats(KANE_P_201605, mean)
KANE_P_201606_mean <- cellStats(KANE_P_201606, mean)
KANE_P_201607_mean <- cellStats(KANE_P_201607, mean)
KANE_P_201608_mean <- cellStats(KANE_P_201608, mean)
KANE_P_201609_mean <- cellStats(KANE_P_201609, mean)
KANE_P_201610_mean <- cellStats(KANE_P_201610, mean)
KANE_P_201611_mean <- cellStats(KANE_P_201611, mean)
KANE_P_201612_mean <- cellStats(KANE_P_201612, mean)

#2017
KANE_P_201701_mean <- cellStats(KANE_P_201701, mean)
KANE_P_201702_mean <- cellStats(KANE_P_201702, mean)
KANE_P_201703_mean <- cellStats(KANE_P_201703, mean)
KANE_P_201704_mean <- cellStats(KANE_P_201704, mean)
KANE_P_201705_mean <- cellStats(KANE_P_201705, mean)
KANE_P_201706_mean <- cellStats(KANE_P_201706, mean)
KANE_P_201707_mean <- cellStats(KANE_P_201707, mean)
KANE_P_201708_mean <- cellStats(KANE_P_201708, mean)
KANE_P_201709_mean <- cellStats(KANE_P_201709, mean)
KANE_P_201710_mean <- cellStats(KANE_P_201710, mean)
KANE_P_201711_mean <- cellStats(KANE_P_201711, mean)
KANE_P_201712_mean <- cellStats(KANE_P_201712, mean)

#2018
KANE_P_201801_mean <- cellStats(KANE_P_201801, mean)
KANE_P_201802_mean <- cellStats(KANE_P_201802, mean)
KANE_P_201803_mean <- cellStats(KANE_P_201803, mean)
KANE_P_201804_mean <- cellStats(KANE_P_201804, mean)
KANE_P_201805_mean <- cellStats(KANE_P_201805, mean)
KANE_P_201806_mean <- cellStats(KANE_P_201806, mean)
KANE_P_201807_mean <- cellStats(KANE_P_201807, mean)
KANE_P_201808_mean <- cellStats(KANE_P_201808, mean)
KANE_P_201809_mean <- cellStats(KANE_P_201809, mean)
KANE_P_201810_mean <- cellStats(KANE_P_201810, mean)
KANE_P_201811_mean <- cellStats(KANE_P_201811, mean)
KANE_P_201812_mean <- cellStats(KANE_P_201812, mean)

# MORGAN


#2000
MORGAN_P_200001 <- crop(P_200001, MORGAN) 
MORGAN_P_200002 <- crop(P_200002, MORGAN)
MORGAN_P_200003 <- crop(P_200003, MORGAN)
MORGAN_P_200004 <- crop(P_200004, MORGAN)
MORGAN_P_200005 <- crop(P_200005, MORGAN)
MORGAN_P_200006 <- crop(P_200006, MORGAN)  
MORGAN_P_200007 <- crop(P_200007, MORGAN)  
MORGAN_P_200008 <- crop(P_200008, MORGAN)  
MORGAN_P_200009 <- crop(P_200009, MORGAN)  
MORGAN_P_200010 <- crop(P_200010, MORGAN)  
MORGAN_P_200011 <- crop(P_200011, MORGAN)  
MORGAN_P_200012 <- crop(P_200012, MORGAN)  
#2001
MORGAN_P_200101 <- crop(P_200101, MORGAN) 
MORGAN_P_200102 <- crop(P_200102, MORGAN)
MORGAN_P_200103 <- crop(P_200103, MORGAN)
MORGAN_P_200104 <- crop(P_200104, MORGAN)
MORGAN_P_200105 <- crop(P_200105, MORGAN)
MORGAN_P_200106 <- crop(P_200106, MORGAN)  
MORGAN_P_200107 <- crop(P_200107, MORGAN)  
MORGAN_P_200108 <- crop(P_200108, MORGAN)  
MORGAN_P_200109 <- crop(P_200109, MORGAN)  
MORGAN_P_200110 <- crop(P_200110, MORGAN)  
MORGAN_P_200111 <- crop(P_200111, MORGAN)  
MORGAN_P_200112 <- crop(P_200112, MORGAN)  

#2002
MORGAN_P_200201 <- crop(P_200201, MORGAN) 
MORGAN_P_200202 <- crop(P_200202, MORGAN)
MORGAN_P_200203 <- crop(P_200203, MORGAN)
MORGAN_P_200204 <- crop(P_200204, MORGAN)
MORGAN_P_200205 <- crop(P_200205, MORGAN)
MORGAN_P_200206 <- crop(P_200206, MORGAN)  
MORGAN_P_200207 <- crop(P_200207, MORGAN)  
MORGAN_P_200208 <- crop(P_200208, MORGAN)  
MORGAN_P_200209 <- crop(P_200209, MORGAN)  
MORGAN_P_200210 <- crop(P_200210, MORGAN)  
MORGAN_P_200211 <- crop(P_200211, MORGAN)  
MORGAN_P_200212 <- crop(P_200212, MORGAN)  
#2003
MORGAN_P_200301 <- crop(P_200301, MORGAN) 
MORGAN_P_200302 <- crop(P_200302, MORGAN)
MORGAN_P_200303 <- crop(P_200303, MORGAN)
MORGAN_P_200304 <- crop(P_200304, MORGAN)
MORGAN_P_200305 <- crop(P_200305, MORGAN)
MORGAN_P_200306 <- crop(P_200306, MORGAN)  
MORGAN_P_200307 <- crop(P_200307, MORGAN)  
MORGAN_P_200308 <- crop(P_200308, MORGAN)  
MORGAN_P_200309 <- crop(P_200309, MORGAN)  
MORGAN_P_200310 <- crop(P_200310, MORGAN)  
MORGAN_P_200311 <- crop(P_200311, MORGAN)  
MORGAN_P_200312 <- crop(P_200312, MORGAN)  
#2004
MORGAN_P_200401 <- crop(P_200401, MORGAN) 
MORGAN_P_200402 <- crop(P_200402, MORGAN)
MORGAN_P_200403 <- crop(P_200403, MORGAN)
MORGAN_P_200404 <- crop(P_200404, MORGAN)
MORGAN_P_200405 <- crop(P_200405, MORGAN)
MORGAN_P_200406 <- crop(P_200406, MORGAN)  
MORGAN_P_200407 <- crop(P_200407, MORGAN)  
MORGAN_P_200408 <- crop(P_200408, MORGAN)  
MORGAN_P_200409 <- crop(P_200409, MORGAN)  
MORGAN_P_200410 <- crop(P_200410, MORGAN)  
MORGAN_P_200411 <- crop(P_200411, MORGAN)  
MORGAN_P_200412 <- crop(P_200412, MORGAN)  
#2005
MORGAN_P_200501 <- crop(P_200501, MORGAN) 
MORGAN_P_200502 <- crop(P_200502, MORGAN)
MORGAN_P_200503 <- crop(P_200503, MORGAN)
MORGAN_P_200504 <- crop(P_200504, MORGAN)
MORGAN_P_200505 <- crop(P_200505, MORGAN)
MORGAN_P_200506 <- crop(P_200506, MORGAN)  
MORGAN_P_200507 <- crop(P_200507, MORGAN)  
MORGAN_P_200508 <- crop(P_200508, MORGAN)  
MORGAN_P_200509 <- crop(P_200509, MORGAN)  
MORGAN_P_200510 <- crop(P_200510, MORGAN)  
MORGAN_P_200511 <- crop(P_200511, MORGAN)  
MORGAN_P_200512 <- crop(P_200512, MORGAN)  
#2006
MORGAN_P_200601 <- crop(P_200601, MORGAN) 
MORGAN_P_200602 <- crop(P_200602, MORGAN)
MORGAN_P_200603 <- crop(P_200603, MORGAN)
MORGAN_P_200604 <- crop(P_200604, MORGAN)
MORGAN_P_200605 <- crop(P_200605, MORGAN)
MORGAN_P_200606 <- crop(P_200606, MORGAN)  
MORGAN_P_200607 <- crop(P_200607, MORGAN)  
MORGAN_P_200608 <- crop(P_200608, MORGAN)  
MORGAN_P_200609 <- crop(P_200609, MORGAN)  
MORGAN_P_200610 <- crop(P_200610, MORGAN)  
MORGAN_P_200611 <- crop(P_200611, MORGAN)  
MORGAN_P_200612 <- crop(P_200612, MORGAN)  
#2007
MORGAN_P_200701 <- crop(P_200701, MORGAN) 
MORGAN_P_200702 <- crop(P_200702, MORGAN)
MORGAN_P_200703 <- crop(P_200703, MORGAN)
MORGAN_P_200704 <- crop(P_200704, MORGAN)
MORGAN_P_200705 <- crop(P_200705, MORGAN)
MORGAN_P_200706 <- crop(P_200706, MORGAN)  
MORGAN_P_200707 <- crop(P_200707, MORGAN)  
MORGAN_P_200708 <- crop(P_200708, MORGAN)  
MORGAN_P_200709 <- crop(P_200709, MORGAN)  
MORGAN_P_200710 <- crop(P_200710, MORGAN)  
MORGAN_P_200711 <- crop(P_200711, MORGAN)  
MORGAN_P_200712 <- crop(P_200712, MORGAN)  
#2008
MORGAN_P_200801 <- crop(P_200801, MORGAN) 
MORGAN_P_200802 <- crop(P_200802, MORGAN)
MORGAN_P_200803 <- crop(P_200803, MORGAN)
MORGAN_P_200804 <- crop(P_200804, MORGAN)
MORGAN_P_200805 <- crop(P_200805, MORGAN)
MORGAN_P_200806 <- crop(P_200806, MORGAN)  
MORGAN_P_200807 <- crop(P_200807, MORGAN)  
MORGAN_P_200808 <- crop(P_200808, MORGAN)  
MORGAN_P_200809 <- crop(P_200809, MORGAN)  
MORGAN_P_200810 <- crop(P_200810, MORGAN)  
MORGAN_P_200811 <- crop(P_200811, MORGAN)  
MORGAN_P_200812 <- crop(P_200812, MORGAN)  
#2009
MORGAN_P_200901 <- crop(P_200901, MORGAN) 
MORGAN_P_200902 <- crop(P_200902, MORGAN)
MORGAN_P_200903 <- crop(P_200903, MORGAN)
MORGAN_P_200904 <- crop(P_200904, MORGAN)
MORGAN_P_200905 <- crop(P_200905, MORGAN)
MORGAN_P_200906 <- crop(P_200906, MORGAN)  
MORGAN_P_200907 <- crop(P_200907, MORGAN)  
MORGAN_P_200908 <- crop(P_200908, MORGAN)  
MORGAN_P_200909 <- crop(P_200909, MORGAN)  
MORGAN_P_200910 <- crop(P_200910, MORGAN)  
MORGAN_P_200911 <- crop(P_200911, MORGAN)  
MORGAN_P_200912 <- crop(P_200912, MORGAN)  
#2010
MORGAN_P_201001 <- crop(P_201001, MORGAN) 
MORGAN_P_201002 <- crop(P_201002, MORGAN)
MORGAN_P_201003 <- crop(P_201003, MORGAN)
MORGAN_P_201004 <- crop(P_201004, MORGAN)
MORGAN_P_201005 <- crop(P_201005, MORGAN)
MORGAN_P_201006 <- crop(P_201006, MORGAN)  
MORGAN_P_201007 <- crop(P_201007, MORGAN)  
MORGAN_P_201008 <- crop(P_201008, MORGAN)  
MORGAN_P_201009 <- crop(P_201009, MORGAN)  
MORGAN_P_201010 <- crop(P_201010, MORGAN)  
MORGAN_P_201011 <- crop(P_201011, MORGAN)  
MORGAN_P_201012 <- crop(P_201012, MORGAN)  
#2011
MORGAN_P_201101 <- crop(P_201101, MORGAN) 
MORGAN_P_201102 <- crop(P_201102, MORGAN)
MORGAN_P_201103 <- crop(P_201103, MORGAN)
MORGAN_P_201104 <- crop(P_201104, MORGAN)
MORGAN_P_201105 <- crop(P_201105, MORGAN)
MORGAN_P_201106 <- crop(P_201106, MORGAN)  
MORGAN_P_201107 <- crop(P_201107, MORGAN)  
MORGAN_P_201108 <- crop(P_201108, MORGAN)  
MORGAN_P_201109 <- crop(P_201109, MORGAN)  
MORGAN_P_201110 <- crop(P_201110, MORGAN)  
MORGAN_P_201111 <- crop(P_201111, MORGAN)  
MORGAN_P_201112 <- crop(P_201112, MORGAN)  
#2012
MORGAN_P_201201 <- crop(P_201201, MORGAN) 
MORGAN_P_201202 <- crop(P_201202, MORGAN)
MORGAN_P_201203 <- crop(P_201203, MORGAN)
MORGAN_P_201204 <- crop(P_201204, MORGAN)
MORGAN_P_201205 <- crop(P_201205, MORGAN)
MORGAN_P_201206 <- crop(P_201206, MORGAN)  
MORGAN_P_201207 <- crop(P_201207, MORGAN)  
MORGAN_P_201208 <- crop(P_201208, MORGAN)  
MORGAN_P_201209 <- crop(P_201209, MORGAN)  
MORGAN_P_201210 <- crop(P_201210, MORGAN)  
MORGAN_P_201211 <- crop(P_201211, MORGAN)  
MORGAN_P_201212 <- crop(P_201212, MORGAN)  
#2013
MORGAN_P_201301 <- crop(P_201301, MORGAN) 
MORGAN_P_201302 <- crop(P_201302, MORGAN)
MORGAN_P_201303 <- crop(P_201303, MORGAN)
MORGAN_P_201304 <- crop(P_201304, MORGAN)
MORGAN_P_201305 <- crop(P_201305, MORGAN)
MORGAN_P_201306 <- crop(P_201306, MORGAN)  
MORGAN_P_201307 <- crop(P_201307, MORGAN)  
MORGAN_P_201308 <- crop(P_201308, MORGAN)  
MORGAN_P_201309 <- crop(P_201309, MORGAN)  
MORGAN_P_201310 <- crop(P_201310, MORGAN)  
MORGAN_P_201311 <- crop(P_201311, MORGAN)  
MORGAN_P_201312 <- crop(P_201312, MORGAN)  
#2014
MORGAN_P_201401 <- crop(P_201401, MORGAN) 
MORGAN_P_201402 <- crop(P_201402, MORGAN)
MORGAN_P_201403 <- crop(P_201403, MORGAN)
MORGAN_P_201404 <- crop(P_201404, MORGAN)
MORGAN_P_201405 <- crop(P_201405, MORGAN)
MORGAN_P_201406 <- crop(P_201406, MORGAN)  
MORGAN_P_201407 <- crop(P_201407, MORGAN)  
MORGAN_P_201408 <- crop(P_201408, MORGAN)  
MORGAN_P_201409 <- crop(P_201409, MORGAN)  
MORGAN_P_201410 <- crop(P_201410, MORGAN)  
MORGAN_P_201411 <- crop(P_201411, MORGAN)  
MORGAN_P_201412 <- crop(P_201412, MORGAN)  
#2015
MORGAN_P_201501 <- crop(P_201501, MORGAN) 
MORGAN_P_201502 <- crop(P_201502, MORGAN)
MORGAN_P_201503 <- crop(P_201503, MORGAN)
MORGAN_P_201504 <- crop(P_201504, MORGAN)
MORGAN_P_201505 <- crop(P_201505, MORGAN)
MORGAN_P_201506 <- crop(P_201506, MORGAN)  
MORGAN_P_201507 <- crop(P_201507, MORGAN)  
MORGAN_P_201508 <- crop(P_201508, MORGAN)  
MORGAN_P_201509 <- crop(P_201509, MORGAN)  
MORGAN_P_201510 <- crop(P_201510, MORGAN)  
MORGAN_P_201511 <- crop(P_201511, MORGAN)  
MORGAN_P_201512 <- crop(P_201512, MORGAN)  
#2016
MORGAN_P_201601 <- crop(P_201601, MORGAN) 
MORGAN_P_201602 <- crop(P_201602, MORGAN)
MORGAN_P_201603 <- crop(P_201603, MORGAN)
MORGAN_P_201604 <- crop(P_201604, MORGAN)
MORGAN_P_201605 <- crop(P_201605, MORGAN)
MORGAN_P_201606 <- crop(P_201606, MORGAN)  
MORGAN_P_201607 <- crop(P_201607, MORGAN)  
MORGAN_P_201608 <- crop(P_201608, MORGAN)  
MORGAN_P_201609 <- crop(P_201609, MORGAN)  
MORGAN_P_201610 <- crop(P_201610, MORGAN)  
MORGAN_P_201611 <- crop(P_201611, MORGAN)  
MORGAN_P_201612 <- crop(P_201612, MORGAN)  
#2017
MORGAN_P_201701 <- crop(P_201701, MORGAN) 
MORGAN_P_201702 <- crop(P_201702, MORGAN)
MORGAN_P_201703 <- crop(P_201703, MORGAN)
MORGAN_P_201704 <- crop(P_201704, MORGAN)
MORGAN_P_201705 <- crop(P_201705, MORGAN)
MORGAN_P_201706 <- crop(P_201706, MORGAN)  
MORGAN_P_201707 <- crop(P_201707, MORGAN)  
MORGAN_P_201708 <- crop(P_201708, MORGAN)  
MORGAN_P_201709 <- crop(P_201709, MORGAN)  
MORGAN_P_201710 <- crop(P_201710, MORGAN)  
MORGAN_P_201711 <- crop(P_201711, MORGAN)  
MORGAN_P_201712 <- crop(P_201712, MORGAN)  

#2018

MORGAN_P_201801 <- crop(P_201801, MORGAN) 
MORGAN_P_201802 <- crop(P_201802, MORGAN)
MORGAN_P_201803 <- crop(P_201803, MORGAN)
MORGAN_P_201804 <- crop(P_201804, MORGAN)
MORGAN_P_201805 <- crop(P_201805, MORGAN)
MORGAN_P_201806 <- crop(P_201806, MORGAN)  
MORGAN_P_201807 <- crop(P_201807, MORGAN)  
MORGAN_P_201808 <- crop(P_201808, MORGAN)  
MORGAN_P_201809 <- crop(P_201809, MORGAN)  
MORGAN_P_201810 <- crop(P_201810, MORGAN)  
MORGAN_P_201811 <- crop(P_201811, MORGAN)  
MORGAN_P_201812 <- crop(P_201812, MORGAN)  


# Mean Monthly Precipitation
#2000
MORGAN_P_200001_mean <- cellStats(MORGAN_P_200001, mean)
MORGAN_P_200002_mean <- cellStats(MORGAN_P_200002, mean)
MORGAN_P_200003_mean <- cellStats(MORGAN_P_200003, mean)
MORGAN_P_200004_mean <- cellStats(MORGAN_P_200004, mean)
MORGAN_P_200005_mean <- cellStats(MORGAN_P_200005, mean)
MORGAN_P_200006_mean <- cellStats(MORGAN_P_200006, mean)
MORGAN_P_200007_mean <- cellStats(MORGAN_P_200007, mean)
MORGAN_P_200008_mean <- cellStats(MORGAN_P_200008, mean)
MORGAN_P_200009_mean <- cellStats(MORGAN_P_200009, mean)
MORGAN_P_200010_mean <- cellStats(MORGAN_P_200010, mean)
MORGAN_P_200011_mean <- cellStats(MORGAN_P_200011, mean)
MORGAN_P_200012_mean <- cellStats(MORGAN_P_200012, mean)
#2001
MORGAN_P_200101_mean <- cellStats(MORGAN_P_200101, mean)
MORGAN_P_200102_mean <- cellStats(MORGAN_P_200102, mean)
MORGAN_P_200103_mean <- cellStats(MORGAN_P_200103, mean)
MORGAN_P_200104_mean <- cellStats(MORGAN_P_200104, mean)
MORGAN_P_200105_mean <- cellStats(MORGAN_P_200105, mean)
MORGAN_P_200106_mean <- cellStats(MORGAN_P_200106, mean)
MORGAN_P_200107_mean <- cellStats(MORGAN_P_200107, mean)
MORGAN_P_200108_mean <- cellStats(MORGAN_P_200108, mean)
MORGAN_P_200109_mean <- cellStats(MORGAN_P_200109, mean)
MORGAN_P_200110_mean <- cellStats(MORGAN_P_200110, mean)
MORGAN_P_200111_mean <- cellStats(MORGAN_P_200111, mean)
MORGAN_P_200112_mean <- cellStats(MORGAN_P_200112, mean)

#2002
MORGAN_P_200201_mean <- cellStats(MORGAN_P_200201, mean)
MORGAN_P_200202_mean <- cellStats(MORGAN_P_200202, mean)
MORGAN_P_200203_mean <- cellStats(MORGAN_P_200203, mean)
MORGAN_P_200204_mean <- cellStats(MORGAN_P_200204, mean)
MORGAN_P_200205_mean <- cellStats(MORGAN_P_200205, mean)
MORGAN_P_200206_mean <- cellStats(MORGAN_P_200206, mean)
MORGAN_P_200207_mean <- cellStats(MORGAN_P_200207, mean)
MORGAN_P_200208_mean <- cellStats(MORGAN_P_200208, mean)
MORGAN_P_200209_mean <- cellStats(MORGAN_P_200209, mean)
MORGAN_P_200210_mean <- cellStats(MORGAN_P_200210, mean)
MORGAN_P_200211_mean <- cellStats(MORGAN_P_200211, mean)
MORGAN_P_200212_mean <- cellStats(MORGAN_P_200212, mean)

#2003
MORGAN_P_200301_mean <- cellStats(MORGAN_P_200301, mean)
MORGAN_P_200302_mean <- cellStats(MORGAN_P_200302, mean)
MORGAN_P_200303_mean <- cellStats(MORGAN_P_200303, mean)
MORGAN_P_200304_mean <- cellStats(MORGAN_P_200304, mean)
MORGAN_P_200305_mean <- cellStats(MORGAN_P_200305, mean)
MORGAN_P_200306_mean <- cellStats(MORGAN_P_200306, mean)
MORGAN_P_200307_mean <- cellStats(MORGAN_P_200307, mean)
MORGAN_P_200308_mean <- cellStats(MORGAN_P_200308, mean)
MORGAN_P_200309_mean <- cellStats(MORGAN_P_200309, mean)
MORGAN_P_200310_mean <- cellStats(MORGAN_P_200310, mean)
MORGAN_P_200311_mean <- cellStats(MORGAN_P_200311, mean)
MORGAN_P_200312_mean <- cellStats(MORGAN_P_200312, mean)

#2004

MORGAN_P_200401_mean <- cellStats(MORGAN_P_200401, mean)
MORGAN_P_200402_mean <- cellStats(MORGAN_P_200402, mean)
MORGAN_P_200403_mean <- cellStats(MORGAN_P_200403, mean)
MORGAN_P_200404_mean <- cellStats(MORGAN_P_200404, mean)
MORGAN_P_200405_mean <- cellStats(MORGAN_P_200405, mean)
MORGAN_P_200406_mean <- cellStats(MORGAN_P_200406, mean)
MORGAN_P_200407_mean <- cellStats(MORGAN_P_200407, mean)
MORGAN_P_200408_mean <- cellStats(MORGAN_P_200408, mean)
MORGAN_P_200409_mean <- cellStats(MORGAN_P_200409, mean)
MORGAN_P_200410_mean <- cellStats(MORGAN_P_200410, mean)
MORGAN_P_200411_mean <- cellStats(MORGAN_P_200411, mean)
MORGAN_P_200412_mean <- cellStats(MORGAN_P_200412, mean)

#2005

MORGAN_P_200501_mean <- cellStats(MORGAN_P_200501, mean)
MORGAN_P_200502_mean <- cellStats(MORGAN_P_200502, mean)
MORGAN_P_200503_mean <- cellStats(MORGAN_P_200503, mean)
MORGAN_P_200504_mean <- cellStats(MORGAN_P_200504, mean)
MORGAN_P_200505_mean <- cellStats(MORGAN_P_200505, mean)
MORGAN_P_200506_mean <- cellStats(MORGAN_P_200506, mean)
MORGAN_P_200507_mean <- cellStats(MORGAN_P_200507, mean)
MORGAN_P_200508_mean <- cellStats(MORGAN_P_200508, mean)
MORGAN_P_200509_mean <- cellStats(MORGAN_P_200509, mean)
MORGAN_P_200510_mean <- cellStats(MORGAN_P_200510, mean)
MORGAN_P_200511_mean <- cellStats(MORGAN_P_200511, mean)
MORGAN_P_200512_mean <- cellStats(MORGAN_P_200512, mean)

#2006

MORGAN_P_200601_mean <- cellStats(MORGAN_P_200601, mean)
MORGAN_P_200602_mean <- cellStats(MORGAN_P_200602, mean)
MORGAN_P_200603_mean <- cellStats(MORGAN_P_200603, mean)
MORGAN_P_200604_mean <- cellStats(MORGAN_P_200604, mean)
MORGAN_P_200605_mean <- cellStats(MORGAN_P_200605, mean)
MORGAN_P_200606_mean <- cellStats(MORGAN_P_200606, mean)
MORGAN_P_200607_mean <- cellStats(MORGAN_P_200607, mean)
MORGAN_P_200608_mean <- cellStats(MORGAN_P_200608, mean)
MORGAN_P_200609_mean <- cellStats(MORGAN_P_200609, mean)
MORGAN_P_200610_mean <- cellStats(MORGAN_P_200610, mean)
MORGAN_P_200611_mean <- cellStats(MORGAN_P_200611, mean)
MORGAN_P_200612_mean <- cellStats(MORGAN_P_200612, mean)

#2007

MORGAN_P_200701_mean <- cellStats(MORGAN_P_200701, mean)
MORGAN_P_200702_mean <- cellStats(MORGAN_P_200702, mean)
MORGAN_P_200703_mean <- cellStats(MORGAN_P_200703, mean)
MORGAN_P_200704_mean <- cellStats(MORGAN_P_200704, mean)
MORGAN_P_200705_mean <- cellStats(MORGAN_P_200705, mean)
MORGAN_P_200706_mean <- cellStats(MORGAN_P_200706, mean)
MORGAN_P_200707_mean <- cellStats(MORGAN_P_200707, mean)
MORGAN_P_200708_mean <- cellStats(MORGAN_P_200708, mean)
MORGAN_P_200709_mean <- cellStats(MORGAN_P_200709, mean)
MORGAN_P_200710_mean <- cellStats(MORGAN_P_200710, mean)
MORGAN_P_200711_mean <- cellStats(MORGAN_P_200711, mean)
MORGAN_P_200712_mean <- cellStats(MORGAN_P_200712, mean)

#2008

MORGAN_P_200801_mean <- cellStats(MORGAN_P_200801, mean)
MORGAN_P_200802_mean <- cellStats(MORGAN_P_200802, mean)
MORGAN_P_200803_mean <- cellStats(MORGAN_P_200803, mean)
MORGAN_P_200804_mean <- cellStats(MORGAN_P_200804, mean)
MORGAN_P_200805_mean <- cellStats(MORGAN_P_200805, mean)
MORGAN_P_200806_mean <- cellStats(MORGAN_P_200806, mean)
MORGAN_P_200807_mean <- cellStats(MORGAN_P_200807, mean)
MORGAN_P_200808_mean <- cellStats(MORGAN_P_200808, mean)
MORGAN_P_200809_mean <- cellStats(MORGAN_P_200809, mean)
MORGAN_P_200810_mean <- cellStats(MORGAN_P_200810, mean)
MORGAN_P_200811_mean <- cellStats(MORGAN_P_200811, mean)
MORGAN_P_200812_mean <- cellStats(MORGAN_P_200812, mean)

#2009

MORGAN_P_200901_mean <- cellStats(MORGAN_P_200901, mean)
MORGAN_P_200902_mean <- cellStats(MORGAN_P_200902, mean)
MORGAN_P_200903_mean <- cellStats(MORGAN_P_200903, mean)
MORGAN_P_200904_mean <- cellStats(MORGAN_P_200904, mean)
MORGAN_P_200905_mean <- cellStats(MORGAN_P_200905, mean)
MORGAN_P_200906_mean <- cellStats(MORGAN_P_200906, mean)
MORGAN_P_200907_mean <- cellStats(MORGAN_P_200907, mean)
MORGAN_P_200908_mean <- cellStats(MORGAN_P_200908, mean)
MORGAN_P_200909_mean <- cellStats(MORGAN_P_200909, mean)
MORGAN_P_200910_mean <- cellStats(MORGAN_P_200910, mean)
MORGAN_P_200911_mean <- cellStats(MORGAN_P_200911, mean)
MORGAN_P_200912_mean <- cellStats(MORGAN_P_200912, mean)

#2010

MORGAN_P_201001_mean <- cellStats(MORGAN_P_201001, mean)
MORGAN_P_201002_mean <- cellStats(MORGAN_P_201002, mean)
MORGAN_P_201003_mean <- cellStats(MORGAN_P_201003, mean)
MORGAN_P_201004_mean <- cellStats(MORGAN_P_201004, mean)
MORGAN_P_201005_mean <- cellStats(MORGAN_P_201005, mean)
MORGAN_P_201006_mean <- cellStats(MORGAN_P_201006, mean)
MORGAN_P_201007_mean <- cellStats(MORGAN_P_201007, mean)
MORGAN_P_201008_mean <- cellStats(MORGAN_P_201008, mean)
MORGAN_P_201009_mean <- cellStats(MORGAN_P_201009, mean)
MORGAN_P_201010_mean <- cellStats(MORGAN_P_201010, mean)
MORGAN_P_201011_mean <- cellStats(MORGAN_P_201011, mean)
MORGAN_P_201012_mean <- cellStats(MORGAN_P_201012, mean)

#2011

MORGAN_P_201101_mean <- cellStats(MORGAN_P_201101, mean)
MORGAN_P_201102_mean <- cellStats(MORGAN_P_201102, mean)
MORGAN_P_201103_mean <- cellStats(MORGAN_P_201103, mean)
MORGAN_P_201104_mean <- cellStats(MORGAN_P_201104, mean)
MORGAN_P_201105_mean <- cellStats(MORGAN_P_201105, mean)
MORGAN_P_201106_mean <- cellStats(MORGAN_P_201106, mean)
MORGAN_P_201107_mean <- cellStats(MORGAN_P_201107, mean)
MORGAN_P_201108_mean <- cellStats(MORGAN_P_201108, mean)
MORGAN_P_201109_mean <- cellStats(MORGAN_P_201109, mean)
MORGAN_P_201110_mean <- cellStats(MORGAN_P_201110, mean)
MORGAN_P_201111_mean <- cellStats(MORGAN_P_201111, mean)
MORGAN_P_201112_mean <- cellStats(MORGAN_P_201112, mean)

#2012
MORGAN_P_201201_mean <- cellStats(MORGAN_P_201201, mean)
MORGAN_P_201202_mean <- cellStats(MORGAN_P_201202, mean)
MORGAN_P_201203_mean <- cellStats(MORGAN_P_201203, mean)
MORGAN_P_201204_mean <- cellStats(MORGAN_P_201204, mean)
MORGAN_P_201205_mean <- cellStats(MORGAN_P_201205, mean)
MORGAN_P_201206_mean <- cellStats(MORGAN_P_201206, mean)
MORGAN_P_201207_mean <- cellStats(MORGAN_P_201207, mean)
MORGAN_P_201208_mean <- cellStats(MORGAN_P_201208, mean)
MORGAN_P_201209_mean <- cellStats(MORGAN_P_201209, mean)
MORGAN_P_201210_mean <- cellStats(MORGAN_P_201210, mean)
MORGAN_P_201211_mean <- cellStats(MORGAN_P_201211, mean)
MORGAN_P_201212_mean <- cellStats(MORGAN_P_201212, mean)

#2013
MORGAN_P_201301_mean <- cellStats(MORGAN_P_201301, mean)
MORGAN_P_201302_mean <- cellStats(MORGAN_P_201302, mean)
MORGAN_P_201303_mean <- cellStats(MORGAN_P_201303, mean)
MORGAN_P_201304_mean <- cellStats(MORGAN_P_201304, mean)
MORGAN_P_201305_mean <- cellStats(MORGAN_P_201305, mean)
MORGAN_P_201306_mean <- cellStats(MORGAN_P_201306, mean)
MORGAN_P_201307_mean <- cellStats(MORGAN_P_201307, mean)
MORGAN_P_201308_mean <- cellStats(MORGAN_P_201308, mean)
MORGAN_P_201309_mean <- cellStats(MORGAN_P_201309, mean)
MORGAN_P_201310_mean <- cellStats(MORGAN_P_201310, mean)
MORGAN_P_201311_mean <- cellStats(MORGAN_P_201311, mean)
MORGAN_P_201312_mean <- cellStats(MORGAN_P_201312, mean)

#2014
MORGAN_P_201401_mean <- cellStats(MORGAN_P_201401, mean)
MORGAN_P_201402_mean <- cellStats(MORGAN_P_201402, mean)
MORGAN_P_201403_mean <- cellStats(MORGAN_P_201403, mean)
MORGAN_P_201404_mean <- cellStats(MORGAN_P_201404, mean)
MORGAN_P_201405_mean <- cellStats(MORGAN_P_201405, mean)
MORGAN_P_201406_mean <- cellStats(MORGAN_P_201406, mean)
MORGAN_P_201407_mean <- cellStats(MORGAN_P_201407, mean)
MORGAN_P_201408_mean <- cellStats(MORGAN_P_201408, mean)
MORGAN_P_201409_mean <- cellStats(MORGAN_P_201409, mean)
MORGAN_P_201410_mean <- cellStats(MORGAN_P_201410, mean)
MORGAN_P_201411_mean <- cellStats(MORGAN_P_201411, mean)
MORGAN_P_201412_mean <- cellStats(MORGAN_P_201412, mean)

#2015
MORGAN_P_201501_mean <- cellStats(MORGAN_P_201501, mean)
MORGAN_P_201502_mean <- cellStats(MORGAN_P_201502, mean)
MORGAN_P_201503_mean <- cellStats(MORGAN_P_201503, mean)
MORGAN_P_201504_mean <- cellStats(MORGAN_P_201504, mean)
MORGAN_P_201505_mean <- cellStats(MORGAN_P_201505, mean)
MORGAN_P_201506_mean <- cellStats(MORGAN_P_201506, mean)
MORGAN_P_201507_mean <- cellStats(MORGAN_P_201507, mean)
MORGAN_P_201508_mean <- cellStats(MORGAN_P_201508, mean)
MORGAN_P_201509_mean <- cellStats(MORGAN_P_201509, mean)
MORGAN_P_201510_mean <- cellStats(MORGAN_P_201510, mean)
MORGAN_P_201511_mean <- cellStats(MORGAN_P_201511, mean)
MORGAN_P_201512_mean <- cellStats(MORGAN_P_201512, mean)

#2016
MORGAN_P_201601_mean <- cellStats(MORGAN_P_201601, mean)
MORGAN_P_201602_mean <- cellStats(MORGAN_P_201602, mean)
MORGAN_P_201603_mean <- cellStats(MORGAN_P_201603, mean)
MORGAN_P_201604_mean <- cellStats(MORGAN_P_201604, mean)
MORGAN_P_201605_mean <- cellStats(MORGAN_P_201605, mean)
MORGAN_P_201606_mean <- cellStats(MORGAN_P_201606, mean)
MORGAN_P_201607_mean <- cellStats(MORGAN_P_201607, mean)
MORGAN_P_201608_mean <- cellStats(MORGAN_P_201608, mean)
MORGAN_P_201609_mean <- cellStats(MORGAN_P_201609, mean)
MORGAN_P_201610_mean <- cellStats(MORGAN_P_201610, mean)
MORGAN_P_201611_mean <- cellStats(MORGAN_P_201611, mean)
MORGAN_P_201612_mean <- cellStats(MORGAN_P_201612, mean)

#2017
MORGAN_P_201701_mean <- cellStats(MORGAN_P_201701, mean)
MORGAN_P_201702_mean <- cellStats(MORGAN_P_201702, mean)
MORGAN_P_201703_mean <- cellStats(MORGAN_P_201703, mean)
MORGAN_P_201704_mean <- cellStats(MORGAN_P_201704, mean)
MORGAN_P_201705_mean <- cellStats(MORGAN_P_201705, mean)
MORGAN_P_201706_mean <- cellStats(MORGAN_P_201706, mean)
MORGAN_P_201707_mean <- cellStats(MORGAN_P_201707, mean)
MORGAN_P_201708_mean <- cellStats(MORGAN_P_201708, mean)
MORGAN_P_201709_mean <- cellStats(MORGAN_P_201709, mean)
MORGAN_P_201710_mean <- cellStats(MORGAN_P_201710, mean)
MORGAN_P_201711_mean <- cellStats(MORGAN_P_201711, mean)
MORGAN_P_201712_mean <- cellStats(MORGAN_P_201712, mean)

#2018
MORGAN_P_201801_mean <- cellStats(MORGAN_P_201801, mean)
MORGAN_P_201802_mean <- cellStats(MORGAN_P_201802, mean)
MORGAN_P_201803_mean <- cellStats(MORGAN_P_201803, mean)
MORGAN_P_201804_mean <- cellStats(MORGAN_P_201804, mean)
MORGAN_P_201805_mean <- cellStats(MORGAN_P_201805, mean)
MORGAN_P_201806_mean <- cellStats(MORGAN_P_201806, mean)
MORGAN_P_201807_mean <- cellStats(MORGAN_P_201807, mean)
MORGAN_P_201808_mean <- cellStats(MORGAN_P_201808, mean)
MORGAN_P_201809_mean <- cellStats(MORGAN_P_201809, mean)
MORGAN_P_201810_mean <- cellStats(MORGAN_P_201810, mean)
MORGAN_P_201811_mean <- cellStats(MORGAN_P_201811, mean)
MORGAN_P_201812_mean <- cellStats(MORGAN_P_201812, mean)

# MILLARD


#2000
MILLARD_P_200001 <- crop(P_200001, MILLARD) 
MILLARD_P_200002 <- crop(P_200002, MILLARD)
MILLARD_P_200003 <- crop(P_200003, MILLARD)
MILLARD_P_200004 <- crop(P_200004, MILLARD)
MILLARD_P_200005 <- crop(P_200005, MILLARD)
MILLARD_P_200006 <- crop(P_200006, MILLARD)  
MILLARD_P_200007 <- crop(P_200007, MILLARD)  
MILLARD_P_200008 <- crop(P_200008, MILLARD)  
MILLARD_P_200009 <- crop(P_200009, MILLARD)  
MILLARD_P_200010 <- crop(P_200010, MILLARD)  
MILLARD_P_200011 <- crop(P_200011, MILLARD)  
MILLARD_P_200012 <- crop(P_200012, MILLARD)  
#2001
MILLARD_P_200101 <- crop(P_200101, MILLARD) 
MILLARD_P_200102 <- crop(P_200102, MILLARD)
MILLARD_P_200103 <- crop(P_200103, MILLARD)
MILLARD_P_200104 <- crop(P_200104, MILLARD)
MILLARD_P_200105 <- crop(P_200105, MILLARD)
MILLARD_P_200106 <- crop(P_200106, MILLARD)  
MILLARD_P_200107 <- crop(P_200107, MILLARD)  
MILLARD_P_200108 <- crop(P_200108, MILLARD)  
MILLARD_P_200109 <- crop(P_200109, MILLARD)  
MILLARD_P_200110 <- crop(P_200110, MILLARD)  
MILLARD_P_200111 <- crop(P_200111, MILLARD)  
MILLARD_P_200112 <- crop(P_200112, MILLARD)  

#2002
MILLARD_P_200201 <- crop(P_200201, MILLARD) 
MILLARD_P_200202 <- crop(P_200202, MILLARD)
MILLARD_P_200203 <- crop(P_200203, MILLARD)
MILLARD_P_200204 <- crop(P_200204, MILLARD)
MILLARD_P_200205 <- crop(P_200205, MILLARD)
MILLARD_P_200206 <- crop(P_200206, MILLARD)  
MILLARD_P_200207 <- crop(P_200207, MILLARD)  
MILLARD_P_200208 <- crop(P_200208, MILLARD)  
MILLARD_P_200209 <- crop(P_200209, MILLARD)  
MILLARD_P_200210 <- crop(P_200210, MILLARD)  
MILLARD_P_200211 <- crop(P_200211, MILLARD)  
MILLARD_P_200212 <- crop(P_200212, MILLARD)  
#2003
MILLARD_P_200301 <- crop(P_200301, MILLARD) 
MILLARD_P_200302 <- crop(P_200302, MILLARD)
MILLARD_P_200303 <- crop(P_200303, MILLARD)
MILLARD_P_200304 <- crop(P_200304, MILLARD)
MILLARD_P_200305 <- crop(P_200305, MILLARD)
MILLARD_P_200306 <- crop(P_200306, MILLARD)  
MILLARD_P_200307 <- crop(P_200307, MILLARD)  
MILLARD_P_200308 <- crop(P_200308, MILLARD)  
MILLARD_P_200309 <- crop(P_200309, MILLARD)  
MILLARD_P_200310 <- crop(P_200310, MILLARD)  
MILLARD_P_200311 <- crop(P_200311, MILLARD)  
MILLARD_P_200312 <- crop(P_200312, MILLARD)  
#2004
MILLARD_P_200401 <- crop(P_200401, MILLARD) 
MILLARD_P_200402 <- crop(P_200402, MILLARD)
MILLARD_P_200403 <- crop(P_200403, MILLARD)
MILLARD_P_200404 <- crop(P_200404, MILLARD)
MILLARD_P_200405 <- crop(P_200405, MILLARD)
MILLARD_P_200406 <- crop(P_200406, MILLARD)  
MILLARD_P_200407 <- crop(P_200407, MILLARD)  
MILLARD_P_200408 <- crop(P_200408, MILLARD)  
MILLARD_P_200409 <- crop(P_200409, MILLARD)  
MILLARD_P_200410 <- crop(P_200410, MILLARD)  
MILLARD_P_200411 <- crop(P_200411, MILLARD)  
MILLARD_P_200412 <- crop(P_200412, MILLARD)  
#2005
MILLARD_P_200501 <- crop(P_200501, MILLARD) 
MILLARD_P_200502 <- crop(P_200502, MILLARD)
MILLARD_P_200503 <- crop(P_200503, MILLARD)
MILLARD_P_200504 <- crop(P_200504, MILLARD)
MILLARD_P_200505 <- crop(P_200505, MILLARD)
MILLARD_P_200506 <- crop(P_200506, MILLARD)  
MILLARD_P_200507 <- crop(P_200507, MILLARD)  
MILLARD_P_200508 <- crop(P_200508, MILLARD)  
MILLARD_P_200509 <- crop(P_200509, MILLARD)  
MILLARD_P_200510 <- crop(P_200510, MILLARD)  
MILLARD_P_200511 <- crop(P_200511, MILLARD)  
MILLARD_P_200512 <- crop(P_200512, MILLARD)  
#2006
MILLARD_P_200601 <- crop(P_200601, MILLARD) 
MILLARD_P_200602 <- crop(P_200602, MILLARD)
MILLARD_P_200603 <- crop(P_200603, MILLARD)
MILLARD_P_200604 <- crop(P_200604, MILLARD)
MILLARD_P_200605 <- crop(P_200605, MILLARD)
MILLARD_P_200606 <- crop(P_200606, MILLARD)  
MILLARD_P_200607 <- crop(P_200607, MILLARD)  
MILLARD_P_200608 <- crop(P_200608, MILLARD)  
MILLARD_P_200609 <- crop(P_200609, MILLARD)  
MILLARD_P_200610 <- crop(P_200610, MILLARD)  
MILLARD_P_200611 <- crop(P_200611, MILLARD)  
MILLARD_P_200612 <- crop(P_200612, MILLARD)  
#2007
MILLARD_P_200701 <- crop(P_200701, MILLARD) 
MILLARD_P_200702 <- crop(P_200702, MILLARD)
MILLARD_P_200703 <- crop(P_200703, MILLARD)
MILLARD_P_200704 <- crop(P_200704, MILLARD)
MILLARD_P_200705 <- crop(P_200705, MILLARD)
MILLARD_P_200706 <- crop(P_200706, MILLARD)  
MILLARD_P_200707 <- crop(P_200707, MILLARD)  
MILLARD_P_200708 <- crop(P_200708, MILLARD)  
MILLARD_P_200709 <- crop(P_200709, MILLARD)  
MILLARD_P_200710 <- crop(P_200710, MILLARD)  
MILLARD_P_200711 <- crop(P_200711, MILLARD)  
MILLARD_P_200712 <- crop(P_200712, MILLARD)  
#2008
MILLARD_P_200801 <- crop(P_200801, MILLARD) 
MILLARD_P_200802 <- crop(P_200802, MILLARD)
MILLARD_P_200803 <- crop(P_200803, MILLARD)
MILLARD_P_200804 <- crop(P_200804, MILLARD)
MILLARD_P_200805 <- crop(P_200805, MILLARD)
MILLARD_P_200806 <- crop(P_200806, MILLARD)  
MILLARD_P_200807 <- crop(P_200807, MILLARD)  
MILLARD_P_200808 <- crop(P_200808, MILLARD)  
MILLARD_P_200809 <- crop(P_200809, MILLARD)  
MILLARD_P_200810 <- crop(P_200810, MILLARD)  
MILLARD_P_200811 <- crop(P_200811, MILLARD)  
MILLARD_P_200812 <- crop(P_200812, MILLARD)  
#2009
MILLARD_P_200901 <- crop(P_200901, MILLARD) 
MILLARD_P_200902 <- crop(P_200902, MILLARD)
MILLARD_P_200903 <- crop(P_200903, MILLARD)
MILLARD_P_200904 <- crop(P_200904, MILLARD)
MILLARD_P_200905 <- crop(P_200905, MILLARD)
MILLARD_P_200906 <- crop(P_200906, MILLARD)  
MILLARD_P_200907 <- crop(P_200907, MILLARD)  
MILLARD_P_200908 <- crop(P_200908, MILLARD)  
MILLARD_P_200909 <- crop(P_200909, MILLARD)  
MILLARD_P_200910 <- crop(P_200910, MILLARD)  
MILLARD_P_200911 <- crop(P_200911, MILLARD)  
MILLARD_P_200912 <- crop(P_200912, MILLARD)  
#2010
MILLARD_P_201001 <- crop(P_201001, MILLARD) 
MILLARD_P_201002 <- crop(P_201002, MILLARD)
MILLARD_P_201003 <- crop(P_201003, MILLARD)
MILLARD_P_201004 <- crop(P_201004, MILLARD)
MILLARD_P_201005 <- crop(P_201005, MILLARD)
MILLARD_P_201006 <- crop(P_201006, MILLARD)  
MILLARD_P_201007 <- crop(P_201007, MILLARD)  
MILLARD_P_201008 <- crop(P_201008, MILLARD)  
MILLARD_P_201009 <- crop(P_201009, MILLARD)  
MILLARD_P_201010 <- crop(P_201010, MILLARD)  
MILLARD_P_201011 <- crop(P_201011, MILLARD)  
MILLARD_P_201012 <- crop(P_201012, MILLARD)  
#2011
MILLARD_P_201101 <- crop(P_201101, MILLARD) 
MILLARD_P_201102 <- crop(P_201102, MILLARD)
MILLARD_P_201103 <- crop(P_201103, MILLARD)
MILLARD_P_201104 <- crop(P_201104, MILLARD)
MILLARD_P_201105 <- crop(P_201105, MILLARD)
MILLARD_P_201106 <- crop(P_201106, MILLARD)  
MILLARD_P_201107 <- crop(P_201107, MILLARD)  
MILLARD_P_201108 <- crop(P_201108, MILLARD)  
MILLARD_P_201109 <- crop(P_201109, MILLARD)  
MILLARD_P_201110 <- crop(P_201110, MILLARD)  
MILLARD_P_201111 <- crop(P_201111, MILLARD)  
MILLARD_P_201112 <- crop(P_201112, MILLARD)  
#2012
MILLARD_P_201201 <- crop(P_201201, MILLARD) 
MILLARD_P_201202 <- crop(P_201202, MILLARD)
MILLARD_P_201203 <- crop(P_201203, MILLARD)
MILLARD_P_201204 <- crop(P_201204, MILLARD)
MILLARD_P_201205 <- crop(P_201205, MILLARD)
MILLARD_P_201206 <- crop(P_201206, MILLARD)  
MILLARD_P_201207 <- crop(P_201207, MILLARD)  
MILLARD_P_201208 <- crop(P_201208, MILLARD)  
MILLARD_P_201209 <- crop(P_201209, MILLARD)  
MILLARD_P_201210 <- crop(P_201210, MILLARD)  
MILLARD_P_201211 <- crop(P_201211, MILLARD)  
MILLARD_P_201212 <- crop(P_201212, MILLARD)  
#2013
MILLARD_P_201301 <- crop(P_201301, MILLARD) 
MILLARD_P_201302 <- crop(P_201302, MILLARD)
MILLARD_P_201303 <- crop(P_201303, MILLARD)
MILLARD_P_201304 <- crop(P_201304, MILLARD)
MILLARD_P_201305 <- crop(P_201305, MILLARD)
MILLARD_P_201306 <- crop(P_201306, MILLARD)  
MILLARD_P_201307 <- crop(P_201307, MILLARD)  
MILLARD_P_201308 <- crop(P_201308, MILLARD)  
MILLARD_P_201309 <- crop(P_201309, MILLARD)  
MILLARD_P_201310 <- crop(P_201310, MILLARD)  
MILLARD_P_201311 <- crop(P_201311, MILLARD)  
MILLARD_P_201312 <- crop(P_201312, MILLARD)  
#2014
MILLARD_P_201401 <- crop(P_201401, MILLARD) 
MILLARD_P_201402 <- crop(P_201402, MILLARD)
MILLARD_P_201403 <- crop(P_201403, MILLARD)
MILLARD_P_201404 <- crop(P_201404, MILLARD)
MILLARD_P_201405 <- crop(P_201405, MILLARD)
MILLARD_P_201406 <- crop(P_201406, MILLARD)  
MILLARD_P_201407 <- crop(P_201407, MILLARD)  
MILLARD_P_201408 <- crop(P_201408, MILLARD)  
MILLARD_P_201409 <- crop(P_201409, MILLARD)  
MILLARD_P_201410 <- crop(P_201410, MILLARD)  
MILLARD_P_201411 <- crop(P_201411, MILLARD)  
MILLARD_P_201412 <- crop(P_201412, MILLARD)  
#2015
MILLARD_P_201501 <- crop(P_201501, MILLARD) 
MILLARD_P_201502 <- crop(P_201502, MILLARD)
MILLARD_P_201503 <- crop(P_201503, MILLARD)
MILLARD_P_201504 <- crop(P_201504, MILLARD)
MILLARD_P_201505 <- crop(P_201505, MILLARD)
MILLARD_P_201506 <- crop(P_201506, MILLARD)  
MILLARD_P_201507 <- crop(P_201507, MILLARD)  
MILLARD_P_201508 <- crop(P_201508, MILLARD)  
MILLARD_P_201509 <- crop(P_201509, MILLARD)  
MILLARD_P_201510 <- crop(P_201510, MILLARD)  
MILLARD_P_201511 <- crop(P_201511, MILLARD)  
MILLARD_P_201512 <- crop(P_201512, MILLARD)  
#2016
MILLARD_P_201601 <- crop(P_201601, MILLARD) 
MILLARD_P_201602 <- crop(P_201602, MILLARD)
MILLARD_P_201603 <- crop(P_201603, MILLARD)
MILLARD_P_201604 <- crop(P_201604, MILLARD)
MILLARD_P_201605 <- crop(P_201605, MILLARD)
MILLARD_P_201606 <- crop(P_201606, MILLARD)  
MILLARD_P_201607 <- crop(P_201607, MILLARD)  
MILLARD_P_201608 <- crop(P_201608, MILLARD)  
MILLARD_P_201609 <- crop(P_201609, MILLARD)  
MILLARD_P_201610 <- crop(P_201610, MILLARD)  
MILLARD_P_201611 <- crop(P_201611, MILLARD)  
MILLARD_P_201612 <- crop(P_201612, MILLARD)  
#2017
MILLARD_P_201701 <- crop(P_201701, MILLARD) 
MILLARD_P_201702 <- crop(P_201702, MILLARD)
MILLARD_P_201703 <- crop(P_201703, MILLARD)
MILLARD_P_201704 <- crop(P_201704, MILLARD)
MILLARD_P_201705 <- crop(P_201705, MILLARD)
MILLARD_P_201706 <- crop(P_201706, MILLARD)  
MILLARD_P_201707 <- crop(P_201707, MILLARD)  
MILLARD_P_201708 <- crop(P_201708, MILLARD)  
MILLARD_P_201709 <- crop(P_201709, MILLARD)  
MILLARD_P_201710 <- crop(P_201710, MILLARD)  
MILLARD_P_201711 <- crop(P_201711, MILLARD)  
MILLARD_P_201712 <- crop(P_201712, MILLARD)  

#2018

MILLARD_P_201801 <- crop(P_201801, MILLARD) 
MILLARD_P_201802 <- crop(P_201802, MILLARD)
MILLARD_P_201803 <- crop(P_201803, MILLARD)
MILLARD_P_201804 <- crop(P_201804, MILLARD)
MILLARD_P_201805 <- crop(P_201805, MILLARD)
MILLARD_P_201806 <- crop(P_201806, MILLARD)  
MILLARD_P_201807 <- crop(P_201807, MILLARD)  
MILLARD_P_201808 <- crop(P_201808, MILLARD)  
MILLARD_P_201809 <- crop(P_201809, MILLARD)  
MILLARD_P_201810 <- crop(P_201810, MILLARD)  
MILLARD_P_201811 <- crop(P_201811, MILLARD)  
MILLARD_P_201812 <- crop(P_201812, MILLARD)  


# Mean Monthly Precipitation
#2000
MILLARD_P_200001_mean <- cellStats(MILLARD_P_200001, mean)
MILLARD_P_200002_mean <- cellStats(MILLARD_P_200002, mean)
MILLARD_P_200003_mean <- cellStats(MILLARD_P_200003, mean)
MILLARD_P_200004_mean <- cellStats(MILLARD_P_200004, mean)
MILLARD_P_200005_mean <- cellStats(MILLARD_P_200005, mean)
MILLARD_P_200006_mean <- cellStats(MILLARD_P_200006, mean)
MILLARD_P_200007_mean <- cellStats(MILLARD_P_200007, mean)
MILLARD_P_200008_mean <- cellStats(MILLARD_P_200008, mean)
MILLARD_P_200009_mean <- cellStats(MILLARD_P_200009, mean)
MILLARD_P_200010_mean <- cellStats(MILLARD_P_200010, mean)
MILLARD_P_200011_mean <- cellStats(MILLARD_P_200011, mean)
MILLARD_P_200012_mean <- cellStats(MILLARD_P_200012, mean)
#2001
MILLARD_P_200101_mean <- cellStats(MILLARD_P_200101, mean)
MILLARD_P_200102_mean <- cellStats(MILLARD_P_200102, mean)
MILLARD_P_200103_mean <- cellStats(MILLARD_P_200103, mean)
MILLARD_P_200104_mean <- cellStats(MILLARD_P_200104, mean)
MILLARD_P_200105_mean <- cellStats(MILLARD_P_200105, mean)
MILLARD_P_200106_mean <- cellStats(MILLARD_P_200106, mean)
MILLARD_P_200107_mean <- cellStats(MILLARD_P_200107, mean)
MILLARD_P_200108_mean <- cellStats(MILLARD_P_200108, mean)
MILLARD_P_200109_mean <- cellStats(MILLARD_P_200109, mean)
MILLARD_P_200110_mean <- cellStats(MILLARD_P_200110, mean)
MILLARD_P_200111_mean <- cellStats(MILLARD_P_200111, mean)
MILLARD_P_200112_mean <- cellStats(MILLARD_P_200112, mean)

#2002
MILLARD_P_200201_mean <- cellStats(MILLARD_P_200201, mean)
MILLARD_P_200202_mean <- cellStats(MILLARD_P_200202, mean)
MILLARD_P_200203_mean <- cellStats(MILLARD_P_200203, mean)
MILLARD_P_200204_mean <- cellStats(MILLARD_P_200204, mean)
MILLARD_P_200205_mean <- cellStats(MILLARD_P_200205, mean)
MILLARD_P_200206_mean <- cellStats(MILLARD_P_200206, mean)
MILLARD_P_200207_mean <- cellStats(MILLARD_P_200207, mean)
MILLARD_P_200208_mean <- cellStats(MILLARD_P_200208, mean)
MILLARD_P_200209_mean <- cellStats(MILLARD_P_200209, mean)
MILLARD_P_200210_mean <- cellStats(MILLARD_P_200210, mean)
MILLARD_P_200211_mean <- cellStats(MILLARD_P_200211, mean)
MILLARD_P_200212_mean <- cellStats(MILLARD_P_200212, mean)

#2003
MILLARD_P_200301_mean <- cellStats(MILLARD_P_200301, mean)
MILLARD_P_200302_mean <- cellStats(MILLARD_P_200302, mean)
MILLARD_P_200303_mean <- cellStats(MILLARD_P_200303, mean)
MILLARD_P_200304_mean <- cellStats(MILLARD_P_200304, mean)
MILLARD_P_200305_mean <- cellStats(MILLARD_P_200305, mean)
MILLARD_P_200306_mean <- cellStats(MILLARD_P_200306, mean)
MILLARD_P_200307_mean <- cellStats(MILLARD_P_200307, mean)
MILLARD_P_200308_mean <- cellStats(MILLARD_P_200308, mean)
MILLARD_P_200309_mean <- cellStats(MILLARD_P_200309, mean)
MILLARD_P_200310_mean <- cellStats(MILLARD_P_200310, mean)
MILLARD_P_200311_mean <- cellStats(MILLARD_P_200311, mean)
MILLARD_P_200312_mean <- cellStats(MILLARD_P_200312, mean)

#2004

MILLARD_P_200401_mean <- cellStats(MILLARD_P_200401, mean)
MILLARD_P_200402_mean <- cellStats(MILLARD_P_200402, mean)
MILLARD_P_200403_mean <- cellStats(MILLARD_P_200403, mean)
MILLARD_P_200404_mean <- cellStats(MILLARD_P_200404, mean)
MILLARD_P_200405_mean <- cellStats(MILLARD_P_200405, mean)
MILLARD_P_200406_mean <- cellStats(MILLARD_P_200406, mean)
MILLARD_P_200407_mean <- cellStats(MILLARD_P_200407, mean)
MILLARD_P_200408_mean <- cellStats(MILLARD_P_200408, mean)
MILLARD_P_200409_mean <- cellStats(MILLARD_P_200409, mean)
MILLARD_P_200410_mean <- cellStats(MILLARD_P_200410, mean)
MILLARD_P_200411_mean <- cellStats(MILLARD_P_200411, mean)
MILLARD_P_200412_mean <- cellStats(MILLARD_P_200412, mean)

#2005

MILLARD_P_200501_mean <- cellStats(MILLARD_P_200501, mean)
MILLARD_P_200502_mean <- cellStats(MILLARD_P_200502, mean)
MILLARD_P_200503_mean <- cellStats(MILLARD_P_200503, mean)
MILLARD_P_200504_mean <- cellStats(MILLARD_P_200504, mean)
MILLARD_P_200505_mean <- cellStats(MILLARD_P_200505, mean)
MILLARD_P_200506_mean <- cellStats(MILLARD_P_200506, mean)
MILLARD_P_200507_mean <- cellStats(MILLARD_P_200507, mean)
MILLARD_P_200508_mean <- cellStats(MILLARD_P_200508, mean)
MILLARD_P_200509_mean <- cellStats(MILLARD_P_200509, mean)
MILLARD_P_200510_mean <- cellStats(MILLARD_P_200510, mean)
MILLARD_P_200511_mean <- cellStats(MILLARD_P_200511, mean)
MILLARD_P_200512_mean <- cellStats(MILLARD_P_200512, mean)

#2006

MILLARD_P_200601_mean <- cellStats(MILLARD_P_200601, mean)
MILLARD_P_200602_mean <- cellStats(MILLARD_P_200602, mean)
MILLARD_P_200603_mean <- cellStats(MILLARD_P_200603, mean)
MILLARD_P_200604_mean <- cellStats(MILLARD_P_200604, mean)
MILLARD_P_200605_mean <- cellStats(MILLARD_P_200605, mean)
MILLARD_P_200606_mean <- cellStats(MILLARD_P_200606, mean)
MILLARD_P_200607_mean <- cellStats(MILLARD_P_200607, mean)
MILLARD_P_200608_mean <- cellStats(MILLARD_P_200608, mean)
MILLARD_P_200609_mean <- cellStats(MILLARD_P_200609, mean)
MILLARD_P_200610_mean <- cellStats(MILLARD_P_200610, mean)
MILLARD_P_200611_mean <- cellStats(MILLARD_P_200611, mean)
MILLARD_P_200612_mean <- cellStats(MILLARD_P_200612, mean)

#2007

MILLARD_P_200701_mean <- cellStats(MILLARD_P_200701, mean)
MILLARD_P_200702_mean <- cellStats(MILLARD_P_200702, mean)
MILLARD_P_200703_mean <- cellStats(MILLARD_P_200703, mean)
MILLARD_P_200704_mean <- cellStats(MILLARD_P_200704, mean)
MILLARD_P_200705_mean <- cellStats(MILLARD_P_200705, mean)
MILLARD_P_200706_mean <- cellStats(MILLARD_P_200706, mean)
MILLARD_P_200707_mean <- cellStats(MILLARD_P_200707, mean)
MILLARD_P_200708_mean <- cellStats(MILLARD_P_200708, mean)
MILLARD_P_200709_mean <- cellStats(MILLARD_P_200709, mean)
MILLARD_P_200710_mean <- cellStats(MILLARD_P_200710, mean)
MILLARD_P_200711_mean <- cellStats(MILLARD_P_200711, mean)
MILLARD_P_200712_mean <- cellStats(MILLARD_P_200712, mean)

#2008

MILLARD_P_200801_mean <- cellStats(MILLARD_P_200801, mean)
MILLARD_P_200802_mean <- cellStats(MILLARD_P_200802, mean)
MILLARD_P_200803_mean <- cellStats(MILLARD_P_200803, mean)
MILLARD_P_200804_mean <- cellStats(MILLARD_P_200804, mean)
MILLARD_P_200805_mean <- cellStats(MILLARD_P_200805, mean)
MILLARD_P_200806_mean <- cellStats(MILLARD_P_200806, mean)
MILLARD_P_200807_mean <- cellStats(MILLARD_P_200807, mean)
MILLARD_P_200808_mean <- cellStats(MILLARD_P_200808, mean)
MILLARD_P_200809_mean <- cellStats(MILLARD_P_200809, mean)
MILLARD_P_200810_mean <- cellStats(MILLARD_P_200810, mean)
MILLARD_P_200811_mean <- cellStats(MILLARD_P_200811, mean)
MILLARD_P_200812_mean <- cellStats(MILLARD_P_200812, mean)

#2009

MILLARD_P_200901_mean <- cellStats(MILLARD_P_200901, mean)
MILLARD_P_200902_mean <- cellStats(MILLARD_P_200902, mean)
MILLARD_P_200903_mean <- cellStats(MILLARD_P_200903, mean)
MILLARD_P_200904_mean <- cellStats(MILLARD_P_200904, mean)
MILLARD_P_200905_mean <- cellStats(MILLARD_P_200905, mean)
MILLARD_P_200906_mean <- cellStats(MILLARD_P_200906, mean)
MILLARD_P_200907_mean <- cellStats(MILLARD_P_200907, mean)
MILLARD_P_200908_mean <- cellStats(MILLARD_P_200908, mean)
MILLARD_P_200909_mean <- cellStats(MILLARD_P_200909, mean)
MILLARD_P_200910_mean <- cellStats(MILLARD_P_200910, mean)
MILLARD_P_200911_mean <- cellStats(MILLARD_P_200911, mean)
MILLARD_P_200912_mean <- cellStats(MILLARD_P_200912, mean)

#2010

MILLARD_P_201001_mean <- cellStats(MILLARD_P_201001, mean)
MILLARD_P_201002_mean <- cellStats(MILLARD_P_201002, mean)
MILLARD_P_201003_mean <- cellStats(MILLARD_P_201003, mean)
MILLARD_P_201004_mean <- cellStats(MILLARD_P_201004, mean)
MILLARD_P_201005_mean <- cellStats(MILLARD_P_201005, mean)
MILLARD_P_201006_mean <- cellStats(MILLARD_P_201006, mean)
MILLARD_P_201007_mean <- cellStats(MILLARD_P_201007, mean)
MILLARD_P_201008_mean <- cellStats(MILLARD_P_201008, mean)
MILLARD_P_201009_mean <- cellStats(MILLARD_P_201009, mean)
MILLARD_P_201010_mean <- cellStats(MILLARD_P_201010, mean)
MILLARD_P_201011_mean <- cellStats(MILLARD_P_201011, mean)
MILLARD_P_201012_mean <- cellStats(MILLARD_P_201012, mean)

#2011

MILLARD_P_201101_mean <- cellStats(MILLARD_P_201101, mean)
MILLARD_P_201102_mean <- cellStats(MILLARD_P_201102, mean)
MILLARD_P_201103_mean <- cellStats(MILLARD_P_201103, mean)
MILLARD_P_201104_mean <- cellStats(MILLARD_P_201104, mean)
MILLARD_P_201105_mean <- cellStats(MILLARD_P_201105, mean)
MILLARD_P_201106_mean <- cellStats(MILLARD_P_201106, mean)
MILLARD_P_201107_mean <- cellStats(MILLARD_P_201107, mean)
MILLARD_P_201108_mean <- cellStats(MILLARD_P_201108, mean)
MILLARD_P_201109_mean <- cellStats(MILLARD_P_201109, mean)
MILLARD_P_201110_mean <- cellStats(MILLARD_P_201110, mean)
MILLARD_P_201111_mean <- cellStats(MILLARD_P_201111, mean)
MILLARD_P_201112_mean <- cellStats(MILLARD_P_201112, mean)

#2012
MILLARD_P_201201_mean <- cellStats(MILLARD_P_201201, mean)
MILLARD_P_201202_mean <- cellStats(MILLARD_P_201202, mean)
MILLARD_P_201203_mean <- cellStats(MILLARD_P_201203, mean)
MILLARD_P_201204_mean <- cellStats(MILLARD_P_201204, mean)
MILLARD_P_201205_mean <- cellStats(MILLARD_P_201205, mean)
MILLARD_P_201206_mean <- cellStats(MILLARD_P_201206, mean)
MILLARD_P_201207_mean <- cellStats(MILLARD_P_201207, mean)
MILLARD_P_201208_mean <- cellStats(MILLARD_P_201208, mean)
MILLARD_P_201209_mean <- cellStats(MILLARD_P_201209, mean)
MILLARD_P_201210_mean <- cellStats(MILLARD_P_201210, mean)
MILLARD_P_201211_mean <- cellStats(MILLARD_P_201211, mean)
MILLARD_P_201212_mean <- cellStats(MILLARD_P_201212, mean)

#2013
MILLARD_P_201301_mean <- cellStats(MILLARD_P_201301, mean)
MILLARD_P_201302_mean <- cellStats(MILLARD_P_201302, mean)
MILLARD_P_201303_mean <- cellStats(MILLARD_P_201303, mean)
MILLARD_P_201304_mean <- cellStats(MILLARD_P_201304, mean)
MILLARD_P_201305_mean <- cellStats(MILLARD_P_201305, mean)
MILLARD_P_201306_mean <- cellStats(MILLARD_P_201306, mean)
MILLARD_P_201307_mean <- cellStats(MILLARD_P_201307, mean)
MILLARD_P_201308_mean <- cellStats(MILLARD_P_201308, mean)
MILLARD_P_201309_mean <- cellStats(MILLARD_P_201309, mean)
MILLARD_P_201310_mean <- cellStats(MILLARD_P_201310, mean)
MILLARD_P_201311_mean <- cellStats(MILLARD_P_201311, mean)
MILLARD_P_201312_mean <- cellStats(MILLARD_P_201312, mean)

#2014
MILLARD_P_201401_mean <- cellStats(MILLARD_P_201401, mean)
MILLARD_P_201402_mean <- cellStats(MILLARD_P_201402, mean)
MILLARD_P_201403_mean <- cellStats(MILLARD_P_201403, mean)
MILLARD_P_201404_mean <- cellStats(MILLARD_P_201404, mean)
MILLARD_P_201405_mean <- cellStats(MILLARD_P_201405, mean)
MILLARD_P_201406_mean <- cellStats(MILLARD_P_201406, mean)
MILLARD_P_201407_mean <- cellStats(MILLARD_P_201407, mean)
MILLARD_P_201408_mean <- cellStats(MILLARD_P_201408, mean)
MILLARD_P_201409_mean <- cellStats(MILLARD_P_201409, mean)
MILLARD_P_201410_mean <- cellStats(MILLARD_P_201410, mean)
MILLARD_P_201411_mean <- cellStats(MILLARD_P_201411, mean)
MILLARD_P_201412_mean <- cellStats(MILLARD_P_201412, mean)

#2015
MILLARD_P_201501_mean <- cellStats(MILLARD_P_201501, mean)
MILLARD_P_201502_mean <- cellStats(MILLARD_P_201502, mean)
MILLARD_P_201503_mean <- cellStats(MILLARD_P_201503, mean)
MILLARD_P_201504_mean <- cellStats(MILLARD_P_201504, mean)
MILLARD_P_201505_mean <- cellStats(MILLARD_P_201505, mean)
MILLARD_P_201506_mean <- cellStats(MILLARD_P_201506, mean)
MILLARD_P_201507_mean <- cellStats(MILLARD_P_201507, mean)
MILLARD_P_201508_mean <- cellStats(MILLARD_P_201508, mean)
MILLARD_P_201509_mean <- cellStats(MILLARD_P_201509, mean)
MILLARD_P_201510_mean <- cellStats(MILLARD_P_201510, mean)
MILLARD_P_201511_mean <- cellStats(MILLARD_P_201511, mean)
MILLARD_P_201512_mean <- cellStats(MILLARD_P_201512, mean)

#2016
MILLARD_P_201601_mean <- cellStats(MILLARD_P_201601, mean)
MILLARD_P_201602_mean <- cellStats(MILLARD_P_201602, mean)
MILLARD_P_201603_mean <- cellStats(MILLARD_P_201603, mean)
MILLARD_P_201604_mean <- cellStats(MILLARD_P_201604, mean)
MILLARD_P_201605_mean <- cellStats(MILLARD_P_201605, mean)
MILLARD_P_201606_mean <- cellStats(MILLARD_P_201606, mean)
MILLARD_P_201607_mean <- cellStats(MILLARD_P_201607, mean)
MILLARD_P_201608_mean <- cellStats(MILLARD_P_201608, mean)
MILLARD_P_201609_mean <- cellStats(MILLARD_P_201609, mean)
MILLARD_P_201610_mean <- cellStats(MILLARD_P_201610, mean)
MILLARD_P_201611_mean <- cellStats(MILLARD_P_201611, mean)
MILLARD_P_201612_mean <- cellStats(MILLARD_P_201612, mean)

#2017
MILLARD_P_201701_mean <- cellStats(MILLARD_P_201701, mean)
MILLARD_P_201702_mean <- cellStats(MILLARD_P_201702, mean)
MILLARD_P_201703_mean <- cellStats(MILLARD_P_201703, mean)
MILLARD_P_201704_mean <- cellStats(MILLARD_P_201704, mean)
MILLARD_P_201705_mean <- cellStats(MILLARD_P_201705, mean)
MILLARD_P_201706_mean <- cellStats(MILLARD_P_201706, mean)
MILLARD_P_201707_mean <- cellStats(MILLARD_P_201707, mean)
MILLARD_P_201708_mean <- cellStats(MILLARD_P_201708, mean)
MILLARD_P_201709_mean <- cellStats(MILLARD_P_201709, mean)
MILLARD_P_201710_mean <- cellStats(MILLARD_P_201710, mean)
MILLARD_P_201711_mean <- cellStats(MILLARD_P_201711, mean)
MILLARD_P_201712_mean <- cellStats(MILLARD_P_201712, mean)

#2018
MILLARD_P_201801_mean <- cellStats(MILLARD_P_201801, mean)
MILLARD_P_201802_mean <- cellStats(MILLARD_P_201802, mean)
MILLARD_P_201803_mean <- cellStats(MILLARD_P_201803, mean)
MILLARD_P_201804_mean <- cellStats(MILLARD_P_201804, mean)
MILLARD_P_201805_mean <- cellStats(MILLARD_P_201805, mean)
MILLARD_P_201806_mean <- cellStats(MILLARD_P_201806, mean)
MILLARD_P_201807_mean <- cellStats(MILLARD_P_201807, mean)
MILLARD_P_201808_mean <- cellStats(MILLARD_P_201808, mean)
MILLARD_P_201809_mean <- cellStats(MILLARD_P_201809, mean)
MILLARD_P_201810_mean <- cellStats(MILLARD_P_201810, mean)
MILLARD_P_201811_mean <- cellStats(MILLARD_P_201811, mean)
MILLARD_P_201812_mean <- cellStats(MILLARD_P_201812, mean)

# PIUTE


#2000
PIUTE_P_200001 <- crop(P_200001, PIUTE) 
PIUTE_P_200002 <- crop(P_200002, PIUTE)
PIUTE_P_200003 <- crop(P_200003, PIUTE)
PIUTE_P_200004 <- crop(P_200004, PIUTE)
PIUTE_P_200005 <- crop(P_200005, PIUTE)
PIUTE_P_200006 <- crop(P_200006, PIUTE)  
PIUTE_P_200007 <- crop(P_200007, PIUTE)  
PIUTE_P_200008 <- crop(P_200008, PIUTE)  
PIUTE_P_200009 <- crop(P_200009, PIUTE)  
PIUTE_P_200010 <- crop(P_200010, PIUTE)  
PIUTE_P_200011 <- crop(P_200011, PIUTE)  
PIUTE_P_200012 <- crop(P_200012, PIUTE)  
#2001
PIUTE_P_200101 <- crop(P_200101, PIUTE) 
PIUTE_P_200102 <- crop(P_200102, PIUTE)
PIUTE_P_200103 <- crop(P_200103, PIUTE)
PIUTE_P_200104 <- crop(P_200104, PIUTE)
PIUTE_P_200105 <- crop(P_200105, PIUTE)
PIUTE_P_200106 <- crop(P_200106, PIUTE)  
PIUTE_P_200107 <- crop(P_200107, PIUTE)  
PIUTE_P_200108 <- crop(P_200108, PIUTE)  
PIUTE_P_200109 <- crop(P_200109, PIUTE)  
PIUTE_P_200110 <- crop(P_200110, PIUTE)  
PIUTE_P_200111 <- crop(P_200111, PIUTE)  
PIUTE_P_200112 <- crop(P_200112, PIUTE)  

#2002
PIUTE_P_200201 <- crop(P_200201, PIUTE) 
PIUTE_P_200202 <- crop(P_200202, PIUTE)
PIUTE_P_200203 <- crop(P_200203, PIUTE)
PIUTE_P_200204 <- crop(P_200204, PIUTE)
PIUTE_P_200205 <- crop(P_200205, PIUTE)
PIUTE_P_200206 <- crop(P_200206, PIUTE)  
PIUTE_P_200207 <- crop(P_200207, PIUTE)  
PIUTE_P_200208 <- crop(P_200208, PIUTE)  
PIUTE_P_200209 <- crop(P_200209, PIUTE)  
PIUTE_P_200210 <- crop(P_200210, PIUTE)  
PIUTE_P_200211 <- crop(P_200211, PIUTE)  
PIUTE_P_200212 <- crop(P_200212, PIUTE)  
#2003
PIUTE_P_200301 <- crop(P_200301, PIUTE) 
PIUTE_P_200302 <- crop(P_200302, PIUTE)
PIUTE_P_200303 <- crop(P_200303, PIUTE)
PIUTE_P_200304 <- crop(P_200304, PIUTE)
PIUTE_P_200305 <- crop(P_200305, PIUTE)
PIUTE_P_200306 <- crop(P_200306, PIUTE)  
PIUTE_P_200307 <- crop(P_200307, PIUTE)  
PIUTE_P_200308 <- crop(P_200308, PIUTE)  
PIUTE_P_200309 <- crop(P_200309, PIUTE)  
PIUTE_P_200310 <- crop(P_200310, PIUTE)  
PIUTE_P_200311 <- crop(P_200311, PIUTE)  
PIUTE_P_200312 <- crop(P_200312, PIUTE)  
#2004
PIUTE_P_200401 <- crop(P_200401, PIUTE) 
PIUTE_P_200402 <- crop(P_200402, PIUTE)
PIUTE_P_200403 <- crop(P_200403, PIUTE)
PIUTE_P_200404 <- crop(P_200404, PIUTE)
PIUTE_P_200405 <- crop(P_200405, PIUTE)
PIUTE_P_200406 <- crop(P_200406, PIUTE)  
PIUTE_P_200407 <- crop(P_200407, PIUTE)  
PIUTE_P_200408 <- crop(P_200408, PIUTE)  
PIUTE_P_200409 <- crop(P_200409, PIUTE)  
PIUTE_P_200410 <- crop(P_200410, PIUTE)  
PIUTE_P_200411 <- crop(P_200411, PIUTE)  
PIUTE_P_200412 <- crop(P_200412, PIUTE)  
#2005
PIUTE_P_200501 <- crop(P_200501, PIUTE) 
PIUTE_P_200502 <- crop(P_200502, PIUTE)
PIUTE_P_200503 <- crop(P_200503, PIUTE)
PIUTE_P_200504 <- crop(P_200504, PIUTE)
PIUTE_P_200505 <- crop(P_200505, PIUTE)
PIUTE_P_200506 <- crop(P_200506, PIUTE)  
PIUTE_P_200507 <- crop(P_200507, PIUTE)  
PIUTE_P_200508 <- crop(P_200508, PIUTE)  
PIUTE_P_200509 <- crop(P_200509, PIUTE)  
PIUTE_P_200510 <- crop(P_200510, PIUTE)  
PIUTE_P_200511 <- crop(P_200511, PIUTE)  
PIUTE_P_200512 <- crop(P_200512, PIUTE)  
#2006
PIUTE_P_200601 <- crop(P_200601, PIUTE) 
PIUTE_P_200602 <- crop(P_200602, PIUTE)
PIUTE_P_200603 <- crop(P_200603, PIUTE)
PIUTE_P_200604 <- crop(P_200604, PIUTE)
PIUTE_P_200605 <- crop(P_200605, PIUTE)
PIUTE_P_200606 <- crop(P_200606, PIUTE)  
PIUTE_P_200607 <- crop(P_200607, PIUTE)  
PIUTE_P_200608 <- crop(P_200608, PIUTE)  
PIUTE_P_200609 <- crop(P_200609, PIUTE)  
PIUTE_P_200610 <- crop(P_200610, PIUTE)  
PIUTE_P_200611 <- crop(P_200611, PIUTE)  
PIUTE_P_200612 <- crop(P_200612, PIUTE)  
#2007
PIUTE_P_200701 <- crop(P_200701, PIUTE) 
PIUTE_P_200702 <- crop(P_200702, PIUTE)
PIUTE_P_200703 <- crop(P_200703, PIUTE)
PIUTE_P_200704 <- crop(P_200704, PIUTE)
PIUTE_P_200705 <- crop(P_200705, PIUTE)
PIUTE_P_200706 <- crop(P_200706, PIUTE)  
PIUTE_P_200707 <- crop(P_200707, PIUTE)  
PIUTE_P_200708 <- crop(P_200708, PIUTE)  
PIUTE_P_200709 <- crop(P_200709, PIUTE)  
PIUTE_P_200710 <- crop(P_200710, PIUTE)  
PIUTE_P_200711 <- crop(P_200711, PIUTE)  
PIUTE_P_200712 <- crop(P_200712, PIUTE)  
#2008
PIUTE_P_200801 <- crop(P_200801, PIUTE) 
PIUTE_P_200802 <- crop(P_200802, PIUTE)
PIUTE_P_200803 <- crop(P_200803, PIUTE)
PIUTE_P_200804 <- crop(P_200804, PIUTE)
PIUTE_P_200805 <- crop(P_200805, PIUTE)
PIUTE_P_200806 <- crop(P_200806, PIUTE)  
PIUTE_P_200807 <- crop(P_200807, PIUTE)  
PIUTE_P_200808 <- crop(P_200808, PIUTE)  
PIUTE_P_200809 <- crop(P_200809, PIUTE)  
PIUTE_P_200810 <- crop(P_200810, PIUTE)  
PIUTE_P_200811 <- crop(P_200811, PIUTE)  
PIUTE_P_200812 <- crop(P_200812, PIUTE)  
#2009
PIUTE_P_200901 <- crop(P_200901, PIUTE) 
PIUTE_P_200902 <- crop(P_200902, PIUTE)
PIUTE_P_200903 <- crop(P_200903, PIUTE)
PIUTE_P_200904 <- crop(P_200904, PIUTE)
PIUTE_P_200905 <- crop(P_200905, PIUTE)
PIUTE_P_200906 <- crop(P_200906, PIUTE)  
PIUTE_P_200907 <- crop(P_200907, PIUTE)  
PIUTE_P_200908 <- crop(P_200908, PIUTE)  
PIUTE_P_200909 <- crop(P_200909, PIUTE)  
PIUTE_P_200910 <- crop(P_200910, PIUTE)  
PIUTE_P_200911 <- crop(P_200911, PIUTE)  
PIUTE_P_200912 <- crop(P_200912, PIUTE)  
#2010
PIUTE_P_201001 <- crop(P_201001, PIUTE) 
PIUTE_P_201002 <- crop(P_201002, PIUTE)
PIUTE_P_201003 <- crop(P_201003, PIUTE)
PIUTE_P_201004 <- crop(P_201004, PIUTE)
PIUTE_P_201005 <- crop(P_201005, PIUTE)
PIUTE_P_201006 <- crop(P_201006, PIUTE)  
PIUTE_P_201007 <- crop(P_201007, PIUTE)  
PIUTE_P_201008 <- crop(P_201008, PIUTE)  
PIUTE_P_201009 <- crop(P_201009, PIUTE)  
PIUTE_P_201010 <- crop(P_201010, PIUTE)  
PIUTE_P_201011 <- crop(P_201011, PIUTE)  
PIUTE_P_201012 <- crop(P_201012, PIUTE)  
#2011
PIUTE_P_201101 <- crop(P_201101, PIUTE) 
PIUTE_P_201102 <- crop(P_201102, PIUTE)
PIUTE_P_201103 <- crop(P_201103, PIUTE)
PIUTE_P_201104 <- crop(P_201104, PIUTE)
PIUTE_P_201105 <- crop(P_201105, PIUTE)
PIUTE_P_201106 <- crop(P_201106, PIUTE)  
PIUTE_P_201107 <- crop(P_201107, PIUTE)  
PIUTE_P_201108 <- crop(P_201108, PIUTE)  
PIUTE_P_201109 <- crop(P_201109, PIUTE)  
PIUTE_P_201110 <- crop(P_201110, PIUTE)  
PIUTE_P_201111 <- crop(P_201111, PIUTE)  
PIUTE_P_201112 <- crop(P_201112, PIUTE)  
#2012
PIUTE_P_201201 <- crop(P_201201, PIUTE) 
PIUTE_P_201202 <- crop(P_201202, PIUTE)
PIUTE_P_201203 <- crop(P_201203, PIUTE)
PIUTE_P_201204 <- crop(P_201204, PIUTE)
PIUTE_P_201205 <- crop(P_201205, PIUTE)
PIUTE_P_201206 <- crop(P_201206, PIUTE)  
PIUTE_P_201207 <- crop(P_201207, PIUTE)  
PIUTE_P_201208 <- crop(P_201208, PIUTE)  
PIUTE_P_201209 <- crop(P_201209, PIUTE)  
PIUTE_P_201210 <- crop(P_201210, PIUTE)  
PIUTE_P_201211 <- crop(P_201211, PIUTE)  
PIUTE_P_201212 <- crop(P_201212, PIUTE)  
#2013
PIUTE_P_201301 <- crop(P_201301, PIUTE) 
PIUTE_P_201302 <- crop(P_201302, PIUTE)
PIUTE_P_201303 <- crop(P_201303, PIUTE)
PIUTE_P_201304 <- crop(P_201304, PIUTE)
PIUTE_P_201305 <- crop(P_201305, PIUTE)
PIUTE_P_201306 <- crop(P_201306, PIUTE)  
PIUTE_P_201307 <- crop(P_201307, PIUTE)  
PIUTE_P_201308 <- crop(P_201308, PIUTE)  
PIUTE_P_201309 <- crop(P_201309, PIUTE)  
PIUTE_P_201310 <- crop(P_201310, PIUTE)  
PIUTE_P_201311 <- crop(P_201311, PIUTE)  
PIUTE_P_201312 <- crop(P_201312, PIUTE)  
#2014
PIUTE_P_201401 <- crop(P_201401, PIUTE) 
PIUTE_P_201402 <- crop(P_201402, PIUTE)
PIUTE_P_201403 <- crop(P_201403, PIUTE)
PIUTE_P_201404 <- crop(P_201404, PIUTE)
PIUTE_P_201405 <- crop(P_201405, PIUTE)
PIUTE_P_201406 <- crop(P_201406, PIUTE)  
PIUTE_P_201407 <- crop(P_201407, PIUTE)  
PIUTE_P_201408 <- crop(P_201408, PIUTE)  
PIUTE_P_201409 <- crop(P_201409, PIUTE)  
PIUTE_P_201410 <- crop(P_201410, PIUTE)  
PIUTE_P_201411 <- crop(P_201411, PIUTE)  
PIUTE_P_201412 <- crop(P_201412, PIUTE)  
#2015
PIUTE_P_201501 <- crop(P_201501, PIUTE) 
PIUTE_P_201502 <- crop(P_201502, PIUTE)
PIUTE_P_201503 <- crop(P_201503, PIUTE)
PIUTE_P_201504 <- crop(P_201504, PIUTE)
PIUTE_P_201505 <- crop(P_201505, PIUTE)
PIUTE_P_201506 <- crop(P_201506, PIUTE)  
PIUTE_P_201507 <- crop(P_201507, PIUTE)  
PIUTE_P_201508 <- crop(P_201508, PIUTE)  
PIUTE_P_201509 <- crop(P_201509, PIUTE)  
PIUTE_P_201510 <- crop(P_201510, PIUTE)  
PIUTE_P_201511 <- crop(P_201511, PIUTE)  
PIUTE_P_201512 <- crop(P_201512, PIUTE)  
#2016
PIUTE_P_201601 <- crop(P_201601, PIUTE) 
PIUTE_P_201602 <- crop(P_201602, PIUTE)
PIUTE_P_201603 <- crop(P_201603, PIUTE)
PIUTE_P_201604 <- crop(P_201604, PIUTE)
PIUTE_P_201605 <- crop(P_201605, PIUTE)
PIUTE_P_201606 <- crop(P_201606, PIUTE)  
PIUTE_P_201607 <- crop(P_201607, PIUTE)  
PIUTE_P_201608 <- crop(P_201608, PIUTE)  
PIUTE_P_201609 <- crop(P_201609, PIUTE)  
PIUTE_P_201610 <- crop(P_201610, PIUTE)  
PIUTE_P_201611 <- crop(P_201611, PIUTE)  
PIUTE_P_201612 <- crop(P_201612, PIUTE)  
#2017
PIUTE_P_201701 <- crop(P_201701, PIUTE) 
PIUTE_P_201702 <- crop(P_201702, PIUTE)
PIUTE_P_201703 <- crop(P_201703, PIUTE)
PIUTE_P_201704 <- crop(P_201704, PIUTE)
PIUTE_P_201705 <- crop(P_201705, PIUTE)
PIUTE_P_201706 <- crop(P_201706, PIUTE)  
PIUTE_P_201707 <- crop(P_201707, PIUTE)  
PIUTE_P_201708 <- crop(P_201708, PIUTE)  
PIUTE_P_201709 <- crop(P_201709, PIUTE)  
PIUTE_P_201710 <- crop(P_201710, PIUTE)  
PIUTE_P_201711 <- crop(P_201711, PIUTE)  
PIUTE_P_201712 <- crop(P_201712, PIUTE)  

#2018

PIUTE_P_201801 <- crop(P_201801, PIUTE) 
PIUTE_P_201802 <- crop(P_201802, PIUTE)
PIUTE_P_201803 <- crop(P_201803, PIUTE)
PIUTE_P_201804 <- crop(P_201804, PIUTE)
PIUTE_P_201805 <- crop(P_201805, PIUTE)
PIUTE_P_201806 <- crop(P_201806, PIUTE)  
PIUTE_P_201807 <- crop(P_201807, PIUTE)  
PIUTE_P_201808 <- crop(P_201808, PIUTE)  
PIUTE_P_201809 <- crop(P_201809, PIUTE)  
PIUTE_P_201810 <- crop(P_201810, PIUTE)  
PIUTE_P_201811 <- crop(P_201811, PIUTE)  
PIUTE_P_201812 <- crop(P_201812, PIUTE)  


# Mean Monthly Precipitation
#2000
PIUTE_P_200001_mean <- cellStats(PIUTE_P_200001, mean)
PIUTE_P_200002_mean <- cellStats(PIUTE_P_200002, mean)
PIUTE_P_200003_mean <- cellStats(PIUTE_P_200003, mean)
PIUTE_P_200004_mean <- cellStats(PIUTE_P_200004, mean)
PIUTE_P_200005_mean <- cellStats(PIUTE_P_200005, mean)
PIUTE_P_200006_mean <- cellStats(PIUTE_P_200006, mean)
PIUTE_P_200007_mean <- cellStats(PIUTE_P_200007, mean)
PIUTE_P_200008_mean <- cellStats(PIUTE_P_200008, mean)
PIUTE_P_200009_mean <- cellStats(PIUTE_P_200009, mean)
PIUTE_P_200010_mean <- cellStats(PIUTE_P_200010, mean)
PIUTE_P_200011_mean <- cellStats(PIUTE_P_200011, mean)
PIUTE_P_200012_mean <- cellStats(PIUTE_P_200012, mean)
#2001
PIUTE_P_200101_mean <- cellStats(PIUTE_P_200101, mean)
PIUTE_P_200102_mean <- cellStats(PIUTE_P_200102, mean)
PIUTE_P_200103_mean <- cellStats(PIUTE_P_200103, mean)
PIUTE_P_200104_mean <- cellStats(PIUTE_P_200104, mean)
PIUTE_P_200105_mean <- cellStats(PIUTE_P_200105, mean)
PIUTE_P_200106_mean <- cellStats(PIUTE_P_200106, mean)
PIUTE_P_200107_mean <- cellStats(PIUTE_P_200107, mean)
PIUTE_P_200108_mean <- cellStats(PIUTE_P_200108, mean)
PIUTE_P_200109_mean <- cellStats(PIUTE_P_200109, mean)
PIUTE_P_200110_mean <- cellStats(PIUTE_P_200110, mean)
PIUTE_P_200111_mean <- cellStats(PIUTE_P_200111, mean)
PIUTE_P_200112_mean <- cellStats(PIUTE_P_200112, mean)

#2002
PIUTE_P_200201_mean <- cellStats(PIUTE_P_200201, mean)
PIUTE_P_200202_mean <- cellStats(PIUTE_P_200202, mean)
PIUTE_P_200203_mean <- cellStats(PIUTE_P_200203, mean)
PIUTE_P_200204_mean <- cellStats(PIUTE_P_200204, mean)
PIUTE_P_200205_mean <- cellStats(PIUTE_P_200205, mean)
PIUTE_P_200206_mean <- cellStats(PIUTE_P_200206, mean)
PIUTE_P_200207_mean <- cellStats(PIUTE_P_200207, mean)
PIUTE_P_200208_mean <- cellStats(PIUTE_P_200208, mean)
PIUTE_P_200209_mean <- cellStats(PIUTE_P_200209, mean)
PIUTE_P_200210_mean <- cellStats(PIUTE_P_200210, mean)
PIUTE_P_200211_mean <- cellStats(PIUTE_P_200211, mean)
PIUTE_P_200212_mean <- cellStats(PIUTE_P_200212, mean)

#2003
PIUTE_P_200301_mean <- cellStats(PIUTE_P_200301, mean)
PIUTE_P_200302_mean <- cellStats(PIUTE_P_200302, mean)
PIUTE_P_200303_mean <- cellStats(PIUTE_P_200303, mean)
PIUTE_P_200304_mean <- cellStats(PIUTE_P_200304, mean)
PIUTE_P_200305_mean <- cellStats(PIUTE_P_200305, mean)
PIUTE_P_200306_mean <- cellStats(PIUTE_P_200306, mean)
PIUTE_P_200307_mean <- cellStats(PIUTE_P_200307, mean)
PIUTE_P_200308_mean <- cellStats(PIUTE_P_200308, mean)
PIUTE_P_200309_mean <- cellStats(PIUTE_P_200309, mean)
PIUTE_P_200310_mean <- cellStats(PIUTE_P_200310, mean)
PIUTE_P_200311_mean <- cellStats(PIUTE_P_200311, mean)
PIUTE_P_200312_mean <- cellStats(PIUTE_P_200312, mean)

#2004

PIUTE_P_200401_mean <- cellStats(PIUTE_P_200401, mean)
PIUTE_P_200402_mean <- cellStats(PIUTE_P_200402, mean)
PIUTE_P_200403_mean <- cellStats(PIUTE_P_200403, mean)
PIUTE_P_200404_mean <- cellStats(PIUTE_P_200404, mean)
PIUTE_P_200405_mean <- cellStats(PIUTE_P_200405, mean)
PIUTE_P_200406_mean <- cellStats(PIUTE_P_200406, mean)
PIUTE_P_200407_mean <- cellStats(PIUTE_P_200407, mean)
PIUTE_P_200408_mean <- cellStats(PIUTE_P_200408, mean)
PIUTE_P_200409_mean <- cellStats(PIUTE_P_200409, mean)
PIUTE_P_200410_mean <- cellStats(PIUTE_P_200410, mean)
PIUTE_P_200411_mean <- cellStats(PIUTE_P_200411, mean)
PIUTE_P_200412_mean <- cellStats(PIUTE_P_200412, mean)

#2005

PIUTE_P_200501_mean <- cellStats(PIUTE_P_200501, mean)
PIUTE_P_200502_mean <- cellStats(PIUTE_P_200502, mean)
PIUTE_P_200503_mean <- cellStats(PIUTE_P_200503, mean)
PIUTE_P_200504_mean <- cellStats(PIUTE_P_200504, mean)
PIUTE_P_200505_mean <- cellStats(PIUTE_P_200505, mean)
PIUTE_P_200506_mean <- cellStats(PIUTE_P_200506, mean)
PIUTE_P_200507_mean <- cellStats(PIUTE_P_200507, mean)
PIUTE_P_200508_mean <- cellStats(PIUTE_P_200508, mean)
PIUTE_P_200509_mean <- cellStats(PIUTE_P_200509, mean)
PIUTE_P_200510_mean <- cellStats(PIUTE_P_200510, mean)
PIUTE_P_200511_mean <- cellStats(PIUTE_P_200511, mean)
PIUTE_P_200512_mean <- cellStats(PIUTE_P_200512, mean)

#2006

PIUTE_P_200601_mean <- cellStats(PIUTE_P_200601, mean)
PIUTE_P_200602_mean <- cellStats(PIUTE_P_200602, mean)
PIUTE_P_200603_mean <- cellStats(PIUTE_P_200603, mean)
PIUTE_P_200604_mean <- cellStats(PIUTE_P_200604, mean)
PIUTE_P_200605_mean <- cellStats(PIUTE_P_200605, mean)
PIUTE_P_200606_mean <- cellStats(PIUTE_P_200606, mean)
PIUTE_P_200607_mean <- cellStats(PIUTE_P_200607, mean)
PIUTE_P_200608_mean <- cellStats(PIUTE_P_200608, mean)
PIUTE_P_200609_mean <- cellStats(PIUTE_P_200609, mean)
PIUTE_P_200610_mean <- cellStats(PIUTE_P_200610, mean)
PIUTE_P_200611_mean <- cellStats(PIUTE_P_200611, mean)
PIUTE_P_200612_mean <- cellStats(PIUTE_P_200612, mean)

#2007

PIUTE_P_200701_mean <- cellStats(PIUTE_P_200701, mean)
PIUTE_P_200702_mean <- cellStats(PIUTE_P_200702, mean)
PIUTE_P_200703_mean <- cellStats(PIUTE_P_200703, mean)
PIUTE_P_200704_mean <- cellStats(PIUTE_P_200704, mean)
PIUTE_P_200705_mean <- cellStats(PIUTE_P_200705, mean)
PIUTE_P_200706_mean <- cellStats(PIUTE_P_200706, mean)
PIUTE_P_200707_mean <- cellStats(PIUTE_P_200707, mean)
PIUTE_P_200708_mean <- cellStats(PIUTE_P_200708, mean)
PIUTE_P_200709_mean <- cellStats(PIUTE_P_200709, mean)
PIUTE_P_200710_mean <- cellStats(PIUTE_P_200710, mean)
PIUTE_P_200711_mean <- cellStats(PIUTE_P_200711, mean)
PIUTE_P_200712_mean <- cellStats(PIUTE_P_200712, mean)

#2008

PIUTE_P_200801_mean <- cellStats(PIUTE_P_200801, mean)
PIUTE_P_200802_mean <- cellStats(PIUTE_P_200802, mean)
PIUTE_P_200803_mean <- cellStats(PIUTE_P_200803, mean)
PIUTE_P_200804_mean <- cellStats(PIUTE_P_200804, mean)
PIUTE_P_200805_mean <- cellStats(PIUTE_P_200805, mean)
PIUTE_P_200806_mean <- cellStats(PIUTE_P_200806, mean)
PIUTE_P_200807_mean <- cellStats(PIUTE_P_200807, mean)
PIUTE_P_200808_mean <- cellStats(PIUTE_P_200808, mean)
PIUTE_P_200809_mean <- cellStats(PIUTE_P_200809, mean)
PIUTE_P_200810_mean <- cellStats(PIUTE_P_200810, mean)
PIUTE_P_200811_mean <- cellStats(PIUTE_P_200811, mean)
PIUTE_P_200812_mean <- cellStats(PIUTE_P_200812, mean)

#2009

PIUTE_P_200901_mean <- cellStats(PIUTE_P_200901, mean)
PIUTE_P_200902_mean <- cellStats(PIUTE_P_200902, mean)
PIUTE_P_200903_mean <- cellStats(PIUTE_P_200903, mean)
PIUTE_P_200904_mean <- cellStats(PIUTE_P_200904, mean)
PIUTE_P_200905_mean <- cellStats(PIUTE_P_200905, mean)
PIUTE_P_200906_mean <- cellStats(PIUTE_P_200906, mean)
PIUTE_P_200907_mean <- cellStats(PIUTE_P_200907, mean)
PIUTE_P_200908_mean <- cellStats(PIUTE_P_200908, mean)
PIUTE_P_200909_mean <- cellStats(PIUTE_P_200909, mean)
PIUTE_P_200910_mean <- cellStats(PIUTE_P_200910, mean)
PIUTE_P_200911_mean <- cellStats(PIUTE_P_200911, mean)
PIUTE_P_200912_mean <- cellStats(PIUTE_P_200912, mean)

#2010

PIUTE_P_201001_mean <- cellStats(PIUTE_P_201001, mean)
PIUTE_P_201002_mean <- cellStats(PIUTE_P_201002, mean)
PIUTE_P_201003_mean <- cellStats(PIUTE_P_201003, mean)
PIUTE_P_201004_mean <- cellStats(PIUTE_P_201004, mean)
PIUTE_P_201005_mean <- cellStats(PIUTE_P_201005, mean)
PIUTE_P_201006_mean <- cellStats(PIUTE_P_201006, mean)
PIUTE_P_201007_mean <- cellStats(PIUTE_P_201007, mean)
PIUTE_P_201008_mean <- cellStats(PIUTE_P_201008, mean)
PIUTE_P_201009_mean <- cellStats(PIUTE_P_201009, mean)
PIUTE_P_201010_mean <- cellStats(PIUTE_P_201010, mean)
PIUTE_P_201011_mean <- cellStats(PIUTE_P_201011, mean)
PIUTE_P_201012_mean <- cellStats(PIUTE_P_201012, mean)

#2011

PIUTE_P_201101_mean <- cellStats(PIUTE_P_201101, mean)
PIUTE_P_201102_mean <- cellStats(PIUTE_P_201102, mean)
PIUTE_P_201103_mean <- cellStats(PIUTE_P_201103, mean)
PIUTE_P_201104_mean <- cellStats(PIUTE_P_201104, mean)
PIUTE_P_201105_mean <- cellStats(PIUTE_P_201105, mean)
PIUTE_P_201106_mean <- cellStats(PIUTE_P_201106, mean)
PIUTE_P_201107_mean <- cellStats(PIUTE_P_201107, mean)
PIUTE_P_201108_mean <- cellStats(PIUTE_P_201108, mean)
PIUTE_P_201109_mean <- cellStats(PIUTE_P_201109, mean)
PIUTE_P_201110_mean <- cellStats(PIUTE_P_201110, mean)
PIUTE_P_201111_mean <- cellStats(PIUTE_P_201111, mean)
PIUTE_P_201112_mean <- cellStats(PIUTE_P_201112, mean)

#2012
PIUTE_P_201201_mean <- cellStats(PIUTE_P_201201, mean)
PIUTE_P_201202_mean <- cellStats(PIUTE_P_201202, mean)
PIUTE_P_201203_mean <- cellStats(PIUTE_P_201203, mean)
PIUTE_P_201204_mean <- cellStats(PIUTE_P_201204, mean)
PIUTE_P_201205_mean <- cellStats(PIUTE_P_201205, mean)
PIUTE_P_201206_mean <- cellStats(PIUTE_P_201206, mean)
PIUTE_P_201207_mean <- cellStats(PIUTE_P_201207, mean)
PIUTE_P_201208_mean <- cellStats(PIUTE_P_201208, mean)
PIUTE_P_201209_mean <- cellStats(PIUTE_P_201209, mean)
PIUTE_P_201210_mean <- cellStats(PIUTE_P_201210, mean)
PIUTE_P_201211_mean <- cellStats(PIUTE_P_201211, mean)
PIUTE_P_201212_mean <- cellStats(PIUTE_P_201212, mean)

#2013
PIUTE_P_201301_mean <- cellStats(PIUTE_P_201301, mean)
PIUTE_P_201302_mean <- cellStats(PIUTE_P_201302, mean)
PIUTE_P_201303_mean <- cellStats(PIUTE_P_201303, mean)
PIUTE_P_201304_mean <- cellStats(PIUTE_P_201304, mean)
PIUTE_P_201305_mean <- cellStats(PIUTE_P_201305, mean)
PIUTE_P_201306_mean <- cellStats(PIUTE_P_201306, mean)
PIUTE_P_201307_mean <- cellStats(PIUTE_P_201307, mean)
PIUTE_P_201308_mean <- cellStats(PIUTE_P_201308, mean)
PIUTE_P_201309_mean <- cellStats(PIUTE_P_201309, mean)
PIUTE_P_201310_mean <- cellStats(PIUTE_P_201310, mean)
PIUTE_P_201311_mean <- cellStats(PIUTE_P_201311, mean)
PIUTE_P_201312_mean <- cellStats(PIUTE_P_201312, mean)

#2014
PIUTE_P_201401_mean <- cellStats(PIUTE_P_201401, mean)
PIUTE_P_201402_mean <- cellStats(PIUTE_P_201402, mean)
PIUTE_P_201403_mean <- cellStats(PIUTE_P_201403, mean)
PIUTE_P_201404_mean <- cellStats(PIUTE_P_201404, mean)
PIUTE_P_201405_mean <- cellStats(PIUTE_P_201405, mean)
PIUTE_P_201406_mean <- cellStats(PIUTE_P_201406, mean)
PIUTE_P_201407_mean <- cellStats(PIUTE_P_201407, mean)
PIUTE_P_201408_mean <- cellStats(PIUTE_P_201408, mean)
PIUTE_P_201409_mean <- cellStats(PIUTE_P_201409, mean)
PIUTE_P_201410_mean <- cellStats(PIUTE_P_201410, mean)
PIUTE_P_201411_mean <- cellStats(PIUTE_P_201411, mean)
PIUTE_P_201412_mean <- cellStats(PIUTE_P_201412, mean)

#2015
PIUTE_P_201501_mean <- cellStats(PIUTE_P_201501, mean)
PIUTE_P_201502_mean <- cellStats(PIUTE_P_201502, mean)
PIUTE_P_201503_mean <- cellStats(PIUTE_P_201503, mean)
PIUTE_P_201504_mean <- cellStats(PIUTE_P_201504, mean)
PIUTE_P_201505_mean <- cellStats(PIUTE_P_201505, mean)
PIUTE_P_201506_mean <- cellStats(PIUTE_P_201506, mean)
PIUTE_P_201507_mean <- cellStats(PIUTE_P_201507, mean)
PIUTE_P_201508_mean <- cellStats(PIUTE_P_201508, mean)
PIUTE_P_201509_mean <- cellStats(PIUTE_P_201509, mean)
PIUTE_P_201510_mean <- cellStats(PIUTE_P_201510, mean)
PIUTE_P_201511_mean <- cellStats(PIUTE_P_201511, mean)
PIUTE_P_201512_mean <- cellStats(PIUTE_P_201512, mean)

#2016
PIUTE_P_201601_mean <- cellStats(PIUTE_P_201601, mean)
PIUTE_P_201602_mean <- cellStats(PIUTE_P_201602, mean)
PIUTE_P_201603_mean <- cellStats(PIUTE_P_201603, mean)
PIUTE_P_201604_mean <- cellStats(PIUTE_P_201604, mean)
PIUTE_P_201605_mean <- cellStats(PIUTE_P_201605, mean)
PIUTE_P_201606_mean <- cellStats(PIUTE_P_201606, mean)
PIUTE_P_201607_mean <- cellStats(PIUTE_P_201607, mean)
PIUTE_P_201608_mean <- cellStats(PIUTE_P_201608, mean)
PIUTE_P_201609_mean <- cellStats(PIUTE_P_201609, mean)
PIUTE_P_201610_mean <- cellStats(PIUTE_P_201610, mean)
PIUTE_P_201611_mean <- cellStats(PIUTE_P_201611, mean)
PIUTE_P_201612_mean <- cellStats(PIUTE_P_201612, mean)

#2017
PIUTE_P_201701_mean <- cellStats(PIUTE_P_201701, mean)
PIUTE_P_201702_mean <- cellStats(PIUTE_P_201702, mean)
PIUTE_P_201703_mean <- cellStats(PIUTE_P_201703, mean)
PIUTE_P_201704_mean <- cellStats(PIUTE_P_201704, mean)
PIUTE_P_201705_mean <- cellStats(PIUTE_P_201705, mean)
PIUTE_P_201706_mean <- cellStats(PIUTE_P_201706, mean)
PIUTE_P_201707_mean <- cellStats(PIUTE_P_201707, mean)
PIUTE_P_201708_mean <- cellStats(PIUTE_P_201708, mean)
PIUTE_P_201709_mean <- cellStats(PIUTE_P_201709, mean)
PIUTE_P_201710_mean <- cellStats(PIUTE_P_201710, mean)
PIUTE_P_201711_mean <- cellStats(PIUTE_P_201711, mean)
PIUTE_P_201712_mean <- cellStats(PIUTE_P_201712, mean)

#2018
PIUTE_P_201801_mean <- cellStats(PIUTE_P_201801, mean)
PIUTE_P_201802_mean <- cellStats(PIUTE_P_201802, mean)
PIUTE_P_201803_mean <- cellStats(PIUTE_P_201803, mean)
PIUTE_P_201804_mean <- cellStats(PIUTE_P_201804, mean)
PIUTE_P_201805_mean <- cellStats(PIUTE_P_201805, mean)
PIUTE_P_201806_mean <- cellStats(PIUTE_P_201806, mean)
PIUTE_P_201807_mean <- cellStats(PIUTE_P_201807, mean)
PIUTE_P_201808_mean <- cellStats(PIUTE_P_201808, mean)
PIUTE_P_201809_mean <- cellStats(PIUTE_P_201809, mean)
PIUTE_P_201810_mean <- cellStats(PIUTE_P_201810, mean)
PIUTE_P_201811_mean <- cellStats(PIUTE_P_201811, mean)
PIUTE_P_201812_mean <- cellStats(PIUTE_P_201812, mean)

# Rich 


#2000
RICH_P_200001 <- crop(P_200001, RICH) 
RICH_P_200002 <- crop(P_200002, RICH)
RICH_P_200003 <- crop(P_200003, RICH)
RICH_P_200004 <- crop(P_200004, RICH)
RICH_P_200005 <- crop(P_200005, RICH)
RICH_P_200006 <- crop(P_200006, RICH)  
RICH_P_200007 <- crop(P_200007, RICH)  
RICH_P_200008 <- crop(P_200008, RICH)  
RICH_P_200009 <- crop(P_200009, RICH)  
RICH_P_200010 <- crop(P_200010, RICH)  
RICH_P_200011 <- crop(P_200011, RICH)  
RICH_P_200012 <- crop(P_200012, RICH)  
#2001
RICH_P_200101 <- crop(P_200101, RICH) 
RICH_P_200102 <- crop(P_200102, RICH)
RICH_P_200103 <- crop(P_200103, RICH)
RICH_P_200104 <- crop(P_200104, RICH)
RICH_P_200105 <- crop(P_200105, RICH)
RICH_P_200106 <- crop(P_200106, RICH)  
RICH_P_200107 <- crop(P_200107, RICH)  
RICH_P_200108 <- crop(P_200108, RICH)  
RICH_P_200109 <- crop(P_200109, RICH)  
RICH_P_200110 <- crop(P_200110, RICH)  
RICH_P_200111 <- crop(P_200111, RICH)  
RICH_P_200112 <- crop(P_200112, RICH)  

#2002
RICH_P_200201 <- crop(P_200201, RICH) 
RICH_P_200202 <- crop(P_200202, RICH)
RICH_P_200203 <- crop(P_200203, RICH)
RICH_P_200204 <- crop(P_200204, RICH)
RICH_P_200205 <- crop(P_200205, RICH)
RICH_P_200206 <- crop(P_200206, RICH)  
RICH_P_200207 <- crop(P_200207, RICH)  
RICH_P_200208 <- crop(P_200208, RICH)  
RICH_P_200209 <- crop(P_200209, RICH)  
RICH_P_200210 <- crop(P_200210, RICH)  
RICH_P_200211 <- crop(P_200211, RICH)  
RICH_P_200212 <- crop(P_200212, RICH)  
#2003
RICH_P_200301 <- crop(P_200301, RICH) 
RICH_P_200302 <- crop(P_200302, RICH)
RICH_P_200303 <- crop(P_200303, RICH)
RICH_P_200304 <- crop(P_200304, RICH)
RICH_P_200305 <- crop(P_200305, RICH)
RICH_P_200306 <- crop(P_200306, RICH)  
RICH_P_200307 <- crop(P_200307, RICH)  
RICH_P_200308 <- crop(P_200308, RICH)  
RICH_P_200309 <- crop(P_200309, RICH)  
RICH_P_200310 <- crop(P_200310, RICH)  
RICH_P_200311 <- crop(P_200311, RICH)  
RICH_P_200312 <- crop(P_200312, RICH)  
#2004
RICH_P_200401 <- crop(P_200401, RICH) 
RICH_P_200402 <- crop(P_200402, RICH)
RICH_P_200403 <- crop(P_200403, RICH)
RICH_P_200404 <- crop(P_200404, RICH)
RICH_P_200405 <- crop(P_200405, RICH)
RICH_P_200406 <- crop(P_200406, RICH)  
RICH_P_200407 <- crop(P_200407, RICH)  
RICH_P_200408 <- crop(P_200408, RICH)  
RICH_P_200409 <- crop(P_200409, RICH)  
RICH_P_200410 <- crop(P_200410, RICH)  
RICH_P_200411 <- crop(P_200411, RICH)  
RICH_P_200412 <- crop(P_200412, RICH)  
#2005
RICH_P_200501 <- crop(P_200501, RICH) 
RICH_P_200502 <- crop(P_200502, RICH)
RICH_P_200503 <- crop(P_200503, RICH)
RICH_P_200504 <- crop(P_200504, RICH)
RICH_P_200505 <- crop(P_200505, RICH)
RICH_P_200506 <- crop(P_200506, RICH)  
RICH_P_200507 <- crop(P_200507, RICH)  
RICH_P_200508 <- crop(P_200508, RICH)  
RICH_P_200509 <- crop(P_200509, RICH)  
RICH_P_200510 <- crop(P_200510, RICH)  
RICH_P_200511 <- crop(P_200511, RICH)  
RICH_P_200512 <- crop(P_200512, RICH)  
#2006
RICH_P_200601 <- crop(P_200601, RICH) 
RICH_P_200602 <- crop(P_200602, RICH)
RICH_P_200603 <- crop(P_200603, RICH)
RICH_P_200604 <- crop(P_200604, RICH)
RICH_P_200605 <- crop(P_200605, RICH)
RICH_P_200606 <- crop(P_200606, RICH)  
RICH_P_200607 <- crop(P_200607, RICH)  
RICH_P_200608 <- crop(P_200608, RICH)  
RICH_P_200609 <- crop(P_200609, RICH)  
RICH_P_200610 <- crop(P_200610, RICH)  
RICH_P_200611 <- crop(P_200611, RICH)  
RICH_P_200612 <- crop(P_200612, RICH)  
#2007
RICH_P_200701 <- crop(P_200701, RICH) 
RICH_P_200702 <- crop(P_200702, RICH)
RICH_P_200703 <- crop(P_200703, RICH)
RICH_P_200704 <- crop(P_200704, RICH)
RICH_P_200705 <- crop(P_200705, RICH)
RICH_P_200706 <- crop(P_200706, RICH)  
RICH_P_200707 <- crop(P_200707, RICH)  
RICH_P_200708 <- crop(P_200708, RICH)  
RICH_P_200709 <- crop(P_200709, RICH)  
RICH_P_200710 <- crop(P_200710, RICH)  
RICH_P_200711 <- crop(P_200711, RICH)  
RICH_P_200712 <- crop(P_200712, RICH)  
#2008
RICH_P_200801 <- crop(P_200801, RICH) 
RICH_P_200802 <- crop(P_200802, RICH)
RICH_P_200803 <- crop(P_200803, RICH)
RICH_P_200804 <- crop(P_200804, RICH)
RICH_P_200805 <- crop(P_200805, RICH)
RICH_P_200806 <- crop(P_200806, RICH)  
RICH_P_200807 <- crop(P_200807, RICH)  
RICH_P_200808 <- crop(P_200808, RICH)  
RICH_P_200809 <- crop(P_200809, RICH)  
RICH_P_200810 <- crop(P_200810, RICH)  
RICH_P_200811 <- crop(P_200811, RICH)  
RICH_P_200812 <- crop(P_200812, RICH)  
#2009
RICH_P_200901 <- crop(P_200901, RICH) 
RICH_P_200902 <- crop(P_200902, RICH)
RICH_P_200903 <- crop(P_200903, RICH)
RICH_P_200904 <- crop(P_200904, RICH)
RICH_P_200905 <- crop(P_200905, RICH)
RICH_P_200906 <- crop(P_200906, RICH)  
RICH_P_200907 <- crop(P_200907, RICH)  
RICH_P_200908 <- crop(P_200908, RICH)  
RICH_P_200909 <- crop(P_200909, RICH)  
RICH_P_200910 <- crop(P_200910, RICH)  
RICH_P_200911 <- crop(P_200911, RICH)  
RICH_P_200912 <- crop(P_200912, RICH)  
#2010
RICH_P_201001 <- crop(P_201001, RICH) 
RICH_P_201002 <- crop(P_201002, RICH)
RICH_P_201003 <- crop(P_201003, RICH)
RICH_P_201004 <- crop(P_201004, RICH)
RICH_P_201005 <- crop(P_201005, RICH)
RICH_P_201006 <- crop(P_201006, RICH)  
RICH_P_201007 <- crop(P_201007, RICH)  
RICH_P_201008 <- crop(P_201008, RICH)  
RICH_P_201009 <- crop(P_201009, RICH)  
RICH_P_201010 <- crop(P_201010, RICH)  
RICH_P_201011 <- crop(P_201011, RICH)  
RICH_P_201012 <- crop(P_201012, RICH)  
#2011
RICH_P_201101 <- crop(P_201101, RICH) 
RICH_P_201102 <- crop(P_201102, RICH)
RICH_P_201103 <- crop(P_201103, RICH)
RICH_P_201104 <- crop(P_201104, RICH)
RICH_P_201105 <- crop(P_201105, RICH)
RICH_P_201106 <- crop(P_201106, RICH)  
RICH_P_201107 <- crop(P_201107, RICH)  
RICH_P_201108 <- crop(P_201108, RICH)  
RICH_P_201109 <- crop(P_201109, RICH)  
RICH_P_201110 <- crop(P_201110, RICH)  
RICH_P_201111 <- crop(P_201111, RICH)  
RICH_P_201112 <- crop(P_201112, RICH)  
#2012
RICH_P_201201 <- crop(P_201201, RICH) 
RICH_P_201202 <- crop(P_201202, RICH)
RICH_P_201203 <- crop(P_201203, RICH)
RICH_P_201204 <- crop(P_201204, RICH)
RICH_P_201205 <- crop(P_201205, RICH)
RICH_P_201206 <- crop(P_201206, RICH)  
RICH_P_201207 <- crop(P_201207, RICH)  
RICH_P_201208 <- crop(P_201208, RICH)  
RICH_P_201209 <- crop(P_201209, RICH)  
RICH_P_201210 <- crop(P_201210, RICH)  
RICH_P_201211 <- crop(P_201211, RICH)  
RICH_P_201212 <- crop(P_201212, RICH)  
#2013
RICH_P_201301 <- crop(P_201301, RICH) 
RICH_P_201302 <- crop(P_201302, RICH)
RICH_P_201303 <- crop(P_201303, RICH)
RICH_P_201304 <- crop(P_201304, RICH)
RICH_P_201305 <- crop(P_201305, RICH)
RICH_P_201306 <- crop(P_201306, RICH)  
RICH_P_201307 <- crop(P_201307, RICH)  
RICH_P_201308 <- crop(P_201308, RICH)  
RICH_P_201309 <- crop(P_201309, RICH)  
RICH_P_201310 <- crop(P_201310, RICH)  
RICH_P_201311 <- crop(P_201311, RICH)  
RICH_P_201312 <- crop(P_201312, RICH)  
#2014
RICH_P_201401 <- crop(P_201401, RICH) 
RICH_P_201402 <- crop(P_201402, RICH)
RICH_P_201403 <- crop(P_201403, RICH)
RICH_P_201404 <- crop(P_201404, RICH)
RICH_P_201405 <- crop(P_201405, RICH)
RICH_P_201406 <- crop(P_201406, RICH)  
RICH_P_201407 <- crop(P_201407, RICH)  
RICH_P_201408 <- crop(P_201408, RICH)  
RICH_P_201409 <- crop(P_201409, RICH)  
RICH_P_201410 <- crop(P_201410, RICH)  
RICH_P_201411 <- crop(P_201411, RICH)  
RICH_P_201412 <- crop(P_201412, RICH)  
#2015
RICH_P_201501 <- crop(P_201501, RICH) 
RICH_P_201502 <- crop(P_201502, RICH)
RICH_P_201503 <- crop(P_201503, RICH)
RICH_P_201504 <- crop(P_201504, RICH)
RICH_P_201505 <- crop(P_201505, RICH)
RICH_P_201506 <- crop(P_201506, RICH)  
RICH_P_201507 <- crop(P_201507, RICH)  
RICH_P_201508 <- crop(P_201508, RICH)  
RICH_P_201509 <- crop(P_201509, RICH)  
RICH_P_201510 <- crop(P_201510, RICH)  
RICH_P_201511 <- crop(P_201511, RICH)  
RICH_P_201512 <- crop(P_201512, RICH)  
#2016
RICH_P_201601 <- crop(P_201601, RICH) 
RICH_P_201602 <- crop(P_201602, RICH)
RICH_P_201603 <- crop(P_201603, RICH)
RICH_P_201604 <- crop(P_201604, RICH)
RICH_P_201605 <- crop(P_201605, RICH)
RICH_P_201606 <- crop(P_201606, RICH)  
RICH_P_201607 <- crop(P_201607, RICH)  
RICH_P_201608 <- crop(P_201608, RICH)  
RICH_P_201609 <- crop(P_201609, RICH)  
RICH_P_201610 <- crop(P_201610, RICH)  
RICH_P_201611 <- crop(P_201611, RICH)  
RICH_P_201612 <- crop(P_201612, RICH)  
#2017
RICH_P_201701 <- crop(P_201701, RICH) 
RICH_P_201702 <- crop(P_201702, RICH)
RICH_P_201703 <- crop(P_201703, RICH)
RICH_P_201704 <- crop(P_201704, RICH)
RICH_P_201705 <- crop(P_201705, RICH)
RICH_P_201706 <- crop(P_201706, RICH)  
RICH_P_201707 <- crop(P_201707, RICH)  
RICH_P_201708 <- crop(P_201708, RICH)  
RICH_P_201709 <- crop(P_201709, RICH)  
RICH_P_201710 <- crop(P_201710, RICH)  
RICH_P_201711 <- crop(P_201711, RICH)  
RICH_P_201712 <- crop(P_201712, RICH)  

#2018

RICH_P_201801 <- crop(P_201801, RICH) 
RICH_P_201802 <- crop(P_201802, RICH)
RICH_P_201803 <- crop(P_201803, RICH)
RICH_P_201804 <- crop(P_201804, RICH)
RICH_P_201805 <- crop(P_201805, RICH)
RICH_P_201806 <- crop(P_201806, RICH)  
RICH_P_201807 <- crop(P_201807, RICH)  
RICH_P_201808 <- crop(P_201808, RICH)  
RICH_P_201809 <- crop(P_201809, RICH)  
RICH_P_201810 <- crop(P_201810, RICH)  
RICH_P_201811 <- crop(P_201811, RICH)  
RICH_P_201812 <- crop(P_201812, RICH)  


# Mean Monthly Precipitation
#2000
RICH_P_200001_mean <- cellStats(RICH_P_200001, mean)
RICH_P_200002_mean <- cellStats(RICH_P_200002, mean)
RICH_P_200003_mean <- cellStats(RICH_P_200003, mean)
RICH_P_200004_mean <- cellStats(RICH_P_200004, mean)
RICH_P_200005_mean <- cellStats(RICH_P_200005, mean)
RICH_P_200006_mean <- cellStats(RICH_P_200006, mean)
RICH_P_200007_mean <- cellStats(RICH_P_200007, mean)
RICH_P_200008_mean <- cellStats(RICH_P_200008, mean)
RICH_P_200009_mean <- cellStats(RICH_P_200009, mean)
RICH_P_200010_mean <- cellStats(RICH_P_200010, mean)
RICH_P_200011_mean <- cellStats(RICH_P_200011, mean)
RICH_P_200012_mean <- cellStats(RICH_P_200012, mean)
#2001
RICH_P_200101_mean <- cellStats(RICH_P_200101, mean)
RICH_P_200102_mean <- cellStats(RICH_P_200102, mean)
RICH_P_200103_mean <- cellStats(RICH_P_200103, mean)
RICH_P_200104_mean <- cellStats(RICH_P_200104, mean)
RICH_P_200105_mean <- cellStats(RICH_P_200105, mean)
RICH_P_200106_mean <- cellStats(RICH_P_200106, mean)
RICH_P_200107_mean <- cellStats(RICH_P_200107, mean)
RICH_P_200108_mean <- cellStats(RICH_P_200108, mean)
RICH_P_200109_mean <- cellStats(RICH_P_200109, mean)
RICH_P_200110_mean <- cellStats(RICH_P_200110, mean)
RICH_P_200111_mean <- cellStats(RICH_P_200111, mean)
RICH_P_200112_mean <- cellStats(RICH_P_200112, mean)

#2002
RICH_P_200201_mean <- cellStats(RICH_P_200201, mean)
RICH_P_200202_mean <- cellStats(RICH_P_200202, mean)
RICH_P_200203_mean <- cellStats(RICH_P_200203, mean)
RICH_P_200204_mean <- cellStats(RICH_P_200204, mean)
RICH_P_200205_mean <- cellStats(RICH_P_200205, mean)
RICH_P_200206_mean <- cellStats(RICH_P_200206, mean)
RICH_P_200207_mean <- cellStats(RICH_P_200207, mean)
RICH_P_200208_mean <- cellStats(RICH_P_200208, mean)
RICH_P_200209_mean <- cellStats(RICH_P_200209, mean)
RICH_P_200210_mean <- cellStats(RICH_P_200210, mean)
RICH_P_200211_mean <- cellStats(RICH_P_200211, mean)
RICH_P_200212_mean <- cellStats(RICH_P_200212, mean)

#2003
RICH_P_200301_mean <- cellStats(RICH_P_200301, mean)
RICH_P_200302_mean <- cellStats(RICH_P_200302, mean)
RICH_P_200303_mean <- cellStats(RICH_P_200303, mean)
RICH_P_200304_mean <- cellStats(RICH_P_200304, mean)
RICH_P_200305_mean <- cellStats(RICH_P_200305, mean)
RICH_P_200306_mean <- cellStats(RICH_P_200306, mean)
RICH_P_200307_mean <- cellStats(RICH_P_200307, mean)
RICH_P_200308_mean <- cellStats(RICH_P_200308, mean)
RICH_P_200309_mean <- cellStats(RICH_P_200309, mean)
RICH_P_200310_mean <- cellStats(RICH_P_200310, mean)
RICH_P_200311_mean <- cellStats(RICH_P_200311, mean)
RICH_P_200312_mean <- cellStats(RICH_P_200312, mean)

#2004

RICH_P_200401_mean <- cellStats(RICH_P_200401, mean)
RICH_P_200402_mean <- cellStats(RICH_P_200402, mean)
RICH_P_200403_mean <- cellStats(RICH_P_200403, mean)
RICH_P_200404_mean <- cellStats(RICH_P_200404, mean)
RICH_P_200405_mean <- cellStats(RICH_P_200405, mean)
RICH_P_200406_mean <- cellStats(RICH_P_200406, mean)
RICH_P_200407_mean <- cellStats(RICH_P_200407, mean)
RICH_P_200408_mean <- cellStats(RICH_P_200408, mean)
RICH_P_200409_mean <- cellStats(RICH_P_200409, mean)
RICH_P_200410_mean <- cellStats(RICH_P_200410, mean)
RICH_P_200411_mean <- cellStats(RICH_P_200411, mean)
RICH_P_200412_mean <- cellStats(RICH_P_200412, mean)

#2005

RICH_P_200501_mean <- cellStats(RICH_P_200501, mean)
RICH_P_200502_mean <- cellStats(RICH_P_200502, mean)
RICH_P_200503_mean <- cellStats(RICH_P_200503, mean)
RICH_P_200504_mean <- cellStats(RICH_P_200504, mean)
RICH_P_200505_mean <- cellStats(RICH_P_200505, mean)
RICH_P_200506_mean <- cellStats(RICH_P_200506, mean)
RICH_P_200507_mean <- cellStats(RICH_P_200507, mean)
RICH_P_200508_mean <- cellStats(RICH_P_200508, mean)
RICH_P_200509_mean <- cellStats(RICH_P_200509, mean)
RICH_P_200510_mean <- cellStats(RICH_P_200510, mean)
RICH_P_200511_mean <- cellStats(RICH_P_200511, mean)
RICH_P_200512_mean <- cellStats(RICH_P_200512, mean)

#2006

RICH_P_200601_mean <- cellStats(RICH_P_200601, mean)
RICH_P_200602_mean <- cellStats(RICH_P_200602, mean)
RICH_P_200603_mean <- cellStats(RICH_P_200603, mean)
RICH_P_200604_mean <- cellStats(RICH_P_200604, mean)
RICH_P_200605_mean <- cellStats(RICH_P_200605, mean)
RICH_P_200606_mean <- cellStats(RICH_P_200606, mean)
RICH_P_200607_mean <- cellStats(RICH_P_200607, mean)
RICH_P_200608_mean <- cellStats(RICH_P_200608, mean)
RICH_P_200609_mean <- cellStats(RICH_P_200609, mean)
RICH_P_200610_mean <- cellStats(RICH_P_200610, mean)
RICH_P_200611_mean <- cellStats(RICH_P_200611, mean)
RICH_P_200612_mean <- cellStats(RICH_P_200612, mean)

#2007

RICH_P_200701_mean <- cellStats(RICH_P_200701, mean)
RICH_P_200702_mean <- cellStats(RICH_P_200702, mean)
RICH_P_200703_mean <- cellStats(RICH_P_200703, mean)
RICH_P_200704_mean <- cellStats(RICH_P_200704, mean)
RICH_P_200705_mean <- cellStats(RICH_P_200705, mean)
RICH_P_200706_mean <- cellStats(RICH_P_200706, mean)
RICH_P_200707_mean <- cellStats(RICH_P_200707, mean)
RICH_P_200708_mean <- cellStats(RICH_P_200708, mean)
RICH_P_200709_mean <- cellStats(RICH_P_200709, mean)
RICH_P_200710_mean <- cellStats(RICH_P_200710, mean)
RICH_P_200711_mean <- cellStats(RICH_P_200711, mean)
RICH_P_200712_mean <- cellStats(RICH_P_200712, mean)

#2008

RICH_P_200801_mean <- cellStats(RICH_P_200801, mean)
RICH_P_200802_mean <- cellStats(RICH_P_200802, mean)
RICH_P_200803_mean <- cellStats(RICH_P_200803, mean)
RICH_P_200804_mean <- cellStats(RICH_P_200804, mean)
RICH_P_200805_mean <- cellStats(RICH_P_200805, mean)
RICH_P_200806_mean <- cellStats(RICH_P_200806, mean)
RICH_P_200807_mean <- cellStats(RICH_P_200807, mean)
RICH_P_200808_mean <- cellStats(RICH_P_200808, mean)
RICH_P_200809_mean <- cellStats(RICH_P_200809, mean)
RICH_P_200810_mean <- cellStats(RICH_P_200810, mean)
RICH_P_200811_mean <- cellStats(RICH_P_200811, mean)
RICH_P_200812_mean <- cellStats(RICH_P_200812, mean)

#2009

RICH_P_200901_mean <- cellStats(RICH_P_200901, mean)
RICH_P_200902_mean <- cellStats(RICH_P_200902, mean)
RICH_P_200903_mean <- cellStats(RICH_P_200903, mean)
RICH_P_200904_mean <- cellStats(RICH_P_200904, mean)
RICH_P_200905_mean <- cellStats(RICH_P_200905, mean)
RICH_P_200906_mean <- cellStats(RICH_P_200906, mean)
RICH_P_200907_mean <- cellStats(RICH_P_200907, mean)
RICH_P_200908_mean <- cellStats(RICH_P_200908, mean)
RICH_P_200909_mean <- cellStats(RICH_P_200909, mean)
RICH_P_200910_mean <- cellStats(RICH_P_200910, mean)
RICH_P_200911_mean <- cellStats(RICH_P_200911, mean)
RICH_P_200912_mean <- cellStats(RICH_P_200912, mean)

#2010

RICH_P_201001_mean <- cellStats(RICH_P_201001, mean)
RICH_P_201002_mean <- cellStats(RICH_P_201002, mean)
RICH_P_201003_mean <- cellStats(RICH_P_201003, mean)
RICH_P_201004_mean <- cellStats(RICH_P_201004, mean)
RICH_P_201005_mean <- cellStats(RICH_P_201005, mean)
RICH_P_201006_mean <- cellStats(RICH_P_201006, mean)
RICH_P_201007_mean <- cellStats(RICH_P_201007, mean)
RICH_P_201008_mean <- cellStats(RICH_P_201008, mean)
RICH_P_201009_mean <- cellStats(RICH_P_201009, mean)
RICH_P_201010_mean <- cellStats(RICH_P_201010, mean)
RICH_P_201011_mean <- cellStats(RICH_P_201011, mean)
RICH_P_201012_mean <- cellStats(RICH_P_201012, mean)

#2011

RICH_P_201101_mean <- cellStats(RICH_P_201101, mean)
RICH_P_201102_mean <- cellStats(RICH_P_201102, mean)
RICH_P_201103_mean <- cellStats(RICH_P_201103, mean)
RICH_P_201104_mean <- cellStats(RICH_P_201104, mean)
RICH_P_201105_mean <- cellStats(RICH_P_201105, mean)
RICH_P_201106_mean <- cellStats(RICH_P_201106, mean)
RICH_P_201107_mean <- cellStats(RICH_P_201107, mean)
RICH_P_201108_mean <- cellStats(RICH_P_201108, mean)
RICH_P_201109_mean <- cellStats(RICH_P_201109, mean)
RICH_P_201110_mean <- cellStats(RICH_P_201110, mean)
RICH_P_201111_mean <- cellStats(RICH_P_201111, mean)
RICH_P_201112_mean <- cellStats(RICH_P_201112, mean)

#2012
RICH_P_201201_mean <- cellStats(RICH_P_201201, mean)
RICH_P_201202_mean <- cellStats(RICH_P_201202, mean)
RICH_P_201203_mean <- cellStats(RICH_P_201203, mean)
RICH_P_201204_mean <- cellStats(RICH_P_201204, mean)
RICH_P_201205_mean <- cellStats(RICH_P_201205, mean)
RICH_P_201206_mean <- cellStats(RICH_P_201206, mean)
RICH_P_201207_mean <- cellStats(RICH_P_201207, mean)
RICH_P_201208_mean <- cellStats(RICH_P_201208, mean)
RICH_P_201209_mean <- cellStats(RICH_P_201209, mean)
RICH_P_201210_mean <- cellStats(RICH_P_201210, mean)
RICH_P_201211_mean <- cellStats(RICH_P_201211, mean)
RICH_P_201212_mean <- cellStats(RICH_P_201212, mean)

#2013
RICH_P_201301_mean <- cellStats(RICH_P_201301, mean)
RICH_P_201302_mean <- cellStats(RICH_P_201302, mean)
RICH_P_201303_mean <- cellStats(RICH_P_201303, mean)
RICH_P_201304_mean <- cellStats(RICH_P_201304, mean)
RICH_P_201305_mean <- cellStats(RICH_P_201305, mean)
RICH_P_201306_mean <- cellStats(RICH_P_201306, mean)
RICH_P_201307_mean <- cellStats(RICH_P_201307, mean)
RICH_P_201308_mean <- cellStats(RICH_P_201308, mean)
RICH_P_201309_mean <- cellStats(RICH_P_201309, mean)
RICH_P_201310_mean <- cellStats(RICH_P_201310, mean)
RICH_P_201311_mean <- cellStats(RICH_P_201311, mean)
RICH_P_201312_mean <- cellStats(RICH_P_201312, mean)

#2014
RICH_P_201401_mean <- cellStats(RICH_P_201401, mean)
RICH_P_201402_mean <- cellStats(RICH_P_201402, mean)
RICH_P_201403_mean <- cellStats(RICH_P_201403, mean)
RICH_P_201404_mean <- cellStats(RICH_P_201404, mean)
RICH_P_201405_mean <- cellStats(RICH_P_201405, mean)
RICH_P_201406_mean <- cellStats(RICH_P_201406, mean)
RICH_P_201407_mean <- cellStats(RICH_P_201407, mean)
RICH_P_201408_mean <- cellStats(RICH_P_201408, mean)
RICH_P_201409_mean <- cellStats(RICH_P_201409, mean)
RICH_P_201410_mean <- cellStats(RICH_P_201410, mean)
RICH_P_201411_mean <- cellStats(RICH_P_201411, mean)
RICH_P_201412_mean <- cellStats(RICH_P_201412, mean)

#2015
RICH_P_201501_mean <- cellStats(RICH_P_201501, mean)
RICH_P_201502_mean <- cellStats(RICH_P_201502, mean)
RICH_P_201503_mean <- cellStats(RICH_P_201503, mean)
RICH_P_201504_mean <- cellStats(RICH_P_201504, mean)
RICH_P_201505_mean <- cellStats(RICH_P_201505, mean)
RICH_P_201506_mean <- cellStats(RICH_P_201506, mean)
RICH_P_201507_mean <- cellStats(RICH_P_201507, mean)
RICH_P_201508_mean <- cellStats(RICH_P_201508, mean)
RICH_P_201509_mean <- cellStats(RICH_P_201509, mean)
RICH_P_201510_mean <- cellStats(RICH_P_201510, mean)
RICH_P_201511_mean <- cellStats(RICH_P_201511, mean)
RICH_P_201512_mean <- cellStats(RICH_P_201512, mean)

#2016
RICH_P_201601_mean <- cellStats(RICH_P_201601, mean)
RICH_P_201602_mean <- cellStats(RICH_P_201602, mean)
RICH_P_201603_mean <- cellStats(RICH_P_201603, mean)
RICH_P_201604_mean <- cellStats(RICH_P_201604, mean)
RICH_P_201605_mean <- cellStats(RICH_P_201605, mean)
RICH_P_201606_mean <- cellStats(RICH_P_201606, mean)
RICH_P_201607_mean <- cellStats(RICH_P_201607, mean)
RICH_P_201608_mean <- cellStats(RICH_P_201608, mean)
RICH_P_201609_mean <- cellStats(RICH_P_201609, mean)
RICH_P_201610_mean <- cellStats(RICH_P_201610, mean)
RICH_P_201611_mean <- cellStats(RICH_P_201611, mean)
RICH_P_201612_mean <- cellStats(RICH_P_201612, mean)

#2017
RICH_P_201701_mean <- cellStats(RICH_P_201701, mean)
RICH_P_201702_mean <- cellStats(RICH_P_201702, mean)
RICH_P_201703_mean <- cellStats(RICH_P_201703, mean)
RICH_P_201704_mean <- cellStats(RICH_P_201704, mean)
RICH_P_201705_mean <- cellStats(RICH_P_201705, mean)
RICH_P_201706_mean <- cellStats(RICH_P_201706, mean)
RICH_P_201707_mean <- cellStats(RICH_P_201707, mean)
RICH_P_201708_mean <- cellStats(RICH_P_201708, mean)
RICH_P_201709_mean <- cellStats(RICH_P_201709, mean)
RICH_P_201710_mean <- cellStats(RICH_P_201710, mean)
RICH_P_201711_mean <- cellStats(RICH_P_201711, mean)
RICH_P_201712_mean <- cellStats(RICH_P_201712, mean)

#2018
RICH_P_201801_mean <- cellStats(RICH_P_201801, mean)
RICH_P_201802_mean <- cellStats(RICH_P_201802, mean)
RICH_P_201803_mean <- cellStats(RICH_P_201803, mean)
RICH_P_201804_mean <- cellStats(RICH_P_201804, mean)
RICH_P_201805_mean <- cellStats(RICH_P_201805, mean)
RICH_P_201806_mean <- cellStats(RICH_P_201806, mean)
RICH_P_201807_mean <- cellStats(RICH_P_201807, mean)
RICH_P_201808_mean <- cellStats(RICH_P_201808, mean)
RICH_P_201809_mean <- cellStats(RICH_P_201809, mean)
RICH_P_201810_mean <- cellStats(RICH_P_201810, mean)
RICH_P_201811_mean <- cellStats(RICH_P_201811, mean)
RICH_P_201812_mean <- cellStats(RICH_P_201812, mean)

# SALTLAKE

#2000
SALTLAKE_P_200001 <- crop(P_200001, SALTLAKE) 
SALTLAKE_P_200002 <- crop(P_200002, SALTLAKE)
SALTLAKE_P_200003 <- crop(P_200003, SALTLAKE)
SALTLAKE_P_200004 <- crop(P_200004, SALTLAKE)
SALTLAKE_P_200005 <- crop(P_200005, SALTLAKE)
SALTLAKE_P_200006 <- crop(P_200006, SALTLAKE)  
SALTLAKE_P_200007 <- crop(P_200007, SALTLAKE)  
SALTLAKE_P_200008 <- crop(P_200008, SALTLAKE)  
SALTLAKE_P_200009 <- crop(P_200009, SALTLAKE)  
SALTLAKE_P_200010 <- crop(P_200010, SALTLAKE)  
SALTLAKE_P_200011 <- crop(P_200011, SALTLAKE)  
SALTLAKE_P_200012 <- crop(P_200012, SALTLAKE)  
#2001
SALTLAKE_P_200101 <- crop(P_200101, SALTLAKE) 
SALTLAKE_P_200102 <- crop(P_200102, SALTLAKE)
SALTLAKE_P_200103 <- crop(P_200103, SALTLAKE)
SALTLAKE_P_200104 <- crop(P_200104, SALTLAKE)
SALTLAKE_P_200105 <- crop(P_200105, SALTLAKE)
SALTLAKE_P_200106 <- crop(P_200106, SALTLAKE)  
SALTLAKE_P_200107 <- crop(P_200107, SALTLAKE)  
SALTLAKE_P_200108 <- crop(P_200108, SALTLAKE)  
SALTLAKE_P_200109 <- crop(P_200109, SALTLAKE)  
SALTLAKE_P_200110 <- crop(P_200110, SALTLAKE)  
SALTLAKE_P_200111 <- crop(P_200111, SALTLAKE)  
SALTLAKE_P_200112 <- crop(P_200112, SALTLAKE)  

#2002
SALTLAKE_P_200201 <- crop(P_200201, SALTLAKE) 
SALTLAKE_P_200202 <- crop(P_200202, SALTLAKE)
SALTLAKE_P_200203 <- crop(P_200203, SALTLAKE)
SALTLAKE_P_200204 <- crop(P_200204, SALTLAKE)
SALTLAKE_P_200205 <- crop(P_200205, SALTLAKE)
SALTLAKE_P_200206 <- crop(P_200206, SALTLAKE)  
SALTLAKE_P_200207 <- crop(P_200207, SALTLAKE)  
SALTLAKE_P_200208 <- crop(P_200208, SALTLAKE)  
SALTLAKE_P_200209 <- crop(P_200209, SALTLAKE)  
SALTLAKE_P_200210 <- crop(P_200210, SALTLAKE)  
SALTLAKE_P_200211 <- crop(P_200211, SALTLAKE)  
SALTLAKE_P_200212 <- crop(P_200212, SALTLAKE)  
#2003
SALTLAKE_P_200301 <- crop(P_200301, SALTLAKE) 
SALTLAKE_P_200302 <- crop(P_200302, SALTLAKE)
SALTLAKE_P_200303 <- crop(P_200303, SALTLAKE)
SALTLAKE_P_200304 <- crop(P_200304, SALTLAKE)
SALTLAKE_P_200305 <- crop(P_200305, SALTLAKE)
SALTLAKE_P_200306 <- crop(P_200306, SALTLAKE)  
SALTLAKE_P_200307 <- crop(P_200307, SALTLAKE)  
SALTLAKE_P_200308 <- crop(P_200308, SALTLAKE)  
SALTLAKE_P_200309 <- crop(P_200309, SALTLAKE)  
SALTLAKE_P_200310 <- crop(P_200310, SALTLAKE)  
SALTLAKE_P_200311 <- crop(P_200311, SALTLAKE)  
SALTLAKE_P_200312 <- crop(P_200312, SALTLAKE)  
#2004
SALTLAKE_P_200401 <- crop(P_200401, SALTLAKE) 
SALTLAKE_P_200402 <- crop(P_200402, SALTLAKE)
SALTLAKE_P_200403 <- crop(P_200403, SALTLAKE)
SALTLAKE_P_200404 <- crop(P_200404, SALTLAKE)
SALTLAKE_P_200405 <- crop(P_200405, SALTLAKE)
SALTLAKE_P_200406 <- crop(P_200406, SALTLAKE)  
SALTLAKE_P_200407 <- crop(P_200407, SALTLAKE)  
SALTLAKE_P_200408 <- crop(P_200408, SALTLAKE)  
SALTLAKE_P_200409 <- crop(P_200409, SALTLAKE)  
SALTLAKE_P_200410 <- crop(P_200410, SALTLAKE)  
SALTLAKE_P_200411 <- crop(P_200411, SALTLAKE)  
SALTLAKE_P_200412 <- crop(P_200412, SALTLAKE)  
#2005
SALTLAKE_P_200501 <- crop(P_200501, SALTLAKE) 
SALTLAKE_P_200502 <- crop(P_200502, SALTLAKE)
SALTLAKE_P_200503 <- crop(P_200503, SALTLAKE)
SALTLAKE_P_200504 <- crop(P_200504, SALTLAKE)
SALTLAKE_P_200505 <- crop(P_200505, SALTLAKE)
SALTLAKE_P_200506 <- crop(P_200506, SALTLAKE)  
SALTLAKE_P_200507 <- crop(P_200507, SALTLAKE)  
SALTLAKE_P_200508 <- crop(P_200508, SALTLAKE)  
SALTLAKE_P_200509 <- crop(P_200509, SALTLAKE)  
SALTLAKE_P_200510 <- crop(P_200510, SALTLAKE)  
SALTLAKE_P_200511 <- crop(P_200511, SALTLAKE)  
SALTLAKE_P_200512 <- crop(P_200512, SALTLAKE)  
#2006
SALTLAKE_P_200601 <- crop(P_200601, SALTLAKE) 
SALTLAKE_P_200602 <- crop(P_200602, SALTLAKE)
SALTLAKE_P_200603 <- crop(P_200603, SALTLAKE)
SALTLAKE_P_200604 <- crop(P_200604, SALTLAKE)
SALTLAKE_P_200605 <- crop(P_200605, SALTLAKE)
SALTLAKE_P_200606 <- crop(P_200606, SALTLAKE)  
SALTLAKE_P_200607 <- crop(P_200607, SALTLAKE)  
SALTLAKE_P_200608 <- crop(P_200608, SALTLAKE)  
SALTLAKE_P_200609 <- crop(P_200609, SALTLAKE)  
SALTLAKE_P_200610 <- crop(P_200610, SALTLAKE)  
SALTLAKE_P_200611 <- crop(P_200611, SALTLAKE)  
SALTLAKE_P_200612 <- crop(P_200612, SALTLAKE)  
#2007
SALTLAKE_P_200701 <- crop(P_200701, SALTLAKE) 
SALTLAKE_P_200702 <- crop(P_200702, SALTLAKE)
SALTLAKE_P_200703 <- crop(P_200703, SALTLAKE)
SALTLAKE_P_200704 <- crop(P_200704, SALTLAKE)
SALTLAKE_P_200705 <- crop(P_200705, SALTLAKE)
SALTLAKE_P_200706 <- crop(P_200706, SALTLAKE)  
SALTLAKE_P_200707 <- crop(P_200707, SALTLAKE)  
SALTLAKE_P_200708 <- crop(P_200708, SALTLAKE)  
SALTLAKE_P_200709 <- crop(P_200709, SALTLAKE)  
SALTLAKE_P_200710 <- crop(P_200710, SALTLAKE)  
SALTLAKE_P_200711 <- crop(P_200711, SALTLAKE)  
SALTLAKE_P_200712 <- crop(P_200712, SALTLAKE)  
#2008
SALTLAKE_P_200801 <- crop(P_200801, SALTLAKE) 
SALTLAKE_P_200802 <- crop(P_200802, SALTLAKE)
SALTLAKE_P_200803 <- crop(P_200803, SALTLAKE)
SALTLAKE_P_200804 <- crop(P_200804, SALTLAKE)
SALTLAKE_P_200805 <- crop(P_200805, SALTLAKE)
SALTLAKE_P_200806 <- crop(P_200806, SALTLAKE)  
SALTLAKE_P_200807 <- crop(P_200807, SALTLAKE)  
SALTLAKE_P_200808 <- crop(P_200808, SALTLAKE)  
SALTLAKE_P_200809 <- crop(P_200809, SALTLAKE)  
SALTLAKE_P_200810 <- crop(P_200810, SALTLAKE)  
SALTLAKE_P_200811 <- crop(P_200811, SALTLAKE)  
SALTLAKE_P_200812 <- crop(P_200812, SALTLAKE)  
#2009
SALTLAKE_P_200901 <- crop(P_200901, SALTLAKE) 
SALTLAKE_P_200902 <- crop(P_200902, SALTLAKE)
SALTLAKE_P_200903 <- crop(P_200903, SALTLAKE)
SALTLAKE_P_200904 <- crop(P_200904, SALTLAKE)
SALTLAKE_P_200905 <- crop(P_200905, SALTLAKE)
SALTLAKE_P_200906 <- crop(P_200906, SALTLAKE)  
SALTLAKE_P_200907 <- crop(P_200907, SALTLAKE)  
SALTLAKE_P_200908 <- crop(P_200908, SALTLAKE)  
SALTLAKE_P_200909 <- crop(P_200909, SALTLAKE)  
SALTLAKE_P_200910 <- crop(P_200910, SALTLAKE)  
SALTLAKE_P_200911 <- crop(P_200911, SALTLAKE)  
SALTLAKE_P_200912 <- crop(P_200912, SALTLAKE)  
#2010
SALTLAKE_P_201001 <- crop(P_201001, SALTLAKE) 
SALTLAKE_P_201002 <- crop(P_201002, SALTLAKE)
SALTLAKE_P_201003 <- crop(P_201003, SALTLAKE)
SALTLAKE_P_201004 <- crop(P_201004, SALTLAKE)
SALTLAKE_P_201005 <- crop(P_201005, SALTLAKE)
SALTLAKE_P_201006 <- crop(P_201006, SALTLAKE)  
SALTLAKE_P_201007 <- crop(P_201007, SALTLAKE)  
SALTLAKE_P_201008 <- crop(P_201008, SALTLAKE)  
SALTLAKE_P_201009 <- crop(P_201009, SALTLAKE)  
SALTLAKE_P_201010 <- crop(P_201010, SALTLAKE)  
SALTLAKE_P_201011 <- crop(P_201011, SALTLAKE)  
SALTLAKE_P_201012 <- crop(P_201012, SALTLAKE)  
#2011
SALTLAKE_P_201101 <- crop(P_201101, SALTLAKE) 
SALTLAKE_P_201102 <- crop(P_201102, SALTLAKE)
SALTLAKE_P_201103 <- crop(P_201103, SALTLAKE)
SALTLAKE_P_201104 <- crop(P_201104, SALTLAKE)
SALTLAKE_P_201105 <- crop(P_201105, SALTLAKE)
SALTLAKE_P_201106 <- crop(P_201106, SALTLAKE)  
SALTLAKE_P_201107 <- crop(P_201107, SALTLAKE)  
SALTLAKE_P_201108 <- crop(P_201108, SALTLAKE)  
SALTLAKE_P_201109 <- crop(P_201109, SALTLAKE)  
SALTLAKE_P_201110 <- crop(P_201110, SALTLAKE)  
SALTLAKE_P_201111 <- crop(P_201111, SALTLAKE)  
SALTLAKE_P_201112 <- crop(P_201112, SALTLAKE)  
#2012
SALTLAKE_P_201201 <- crop(P_201201, SALTLAKE) 
SALTLAKE_P_201202 <- crop(P_201202, SALTLAKE)
SALTLAKE_P_201203 <- crop(P_201203, SALTLAKE)
SALTLAKE_P_201204 <- crop(P_201204, SALTLAKE)
SALTLAKE_P_201205 <- crop(P_201205, SALTLAKE)
SALTLAKE_P_201206 <- crop(P_201206, SALTLAKE)  
SALTLAKE_P_201207 <- crop(P_201207, SALTLAKE)  
SALTLAKE_P_201208 <- crop(P_201208, SALTLAKE)  
SALTLAKE_P_201209 <- crop(P_201209, SALTLAKE)  
SALTLAKE_P_201210 <- crop(P_201210, SALTLAKE)  
SALTLAKE_P_201211 <- crop(P_201211, SALTLAKE)  
SALTLAKE_P_201212 <- crop(P_201212, SALTLAKE)  
#2013
SALTLAKE_P_201301 <- crop(P_201301, SALTLAKE) 
SALTLAKE_P_201302 <- crop(P_201302, SALTLAKE)
SALTLAKE_P_201303 <- crop(P_201303, SALTLAKE)
SALTLAKE_P_201304 <- crop(P_201304, SALTLAKE)
SALTLAKE_P_201305 <- crop(P_201305, SALTLAKE)
SALTLAKE_P_201306 <- crop(P_201306, SALTLAKE)  
SALTLAKE_P_201307 <- crop(P_201307, SALTLAKE)  
SALTLAKE_P_201308 <- crop(P_201308, SALTLAKE)  
SALTLAKE_P_201309 <- crop(P_201309, SALTLAKE)  
SALTLAKE_P_201310 <- crop(P_201310, SALTLAKE)  
SALTLAKE_P_201311 <- crop(P_201311, SALTLAKE)  
SALTLAKE_P_201312 <- crop(P_201312, SALTLAKE)  
#2014
SALTLAKE_P_201401 <- crop(P_201401, SALTLAKE) 
SALTLAKE_P_201402 <- crop(P_201402, SALTLAKE)
SALTLAKE_P_201403 <- crop(P_201403, SALTLAKE)
SALTLAKE_P_201404 <- crop(P_201404, SALTLAKE)
SALTLAKE_P_201405 <- crop(P_201405, SALTLAKE)
SALTLAKE_P_201406 <- crop(P_201406, SALTLAKE)  
SALTLAKE_P_201407 <- crop(P_201407, SALTLAKE)  
SALTLAKE_P_201408 <- crop(P_201408, SALTLAKE)  
SALTLAKE_P_201409 <- crop(P_201409, SALTLAKE)  
SALTLAKE_P_201410 <- crop(P_201410, SALTLAKE)  
SALTLAKE_P_201411 <- crop(P_201411, SALTLAKE)  
SALTLAKE_P_201412 <- crop(P_201412, SALTLAKE)  
#2015
SALTLAKE_P_201501 <- crop(P_201501, SALTLAKE) 
SALTLAKE_P_201502 <- crop(P_201502, SALTLAKE)
SALTLAKE_P_201503 <- crop(P_201503, SALTLAKE)
SALTLAKE_P_201504 <- crop(P_201504, SALTLAKE)
SALTLAKE_P_201505 <- crop(P_201505, SALTLAKE)
SALTLAKE_P_201506 <- crop(P_201506, SALTLAKE)  
SALTLAKE_P_201507 <- crop(P_201507, SALTLAKE)  
SALTLAKE_P_201508 <- crop(P_201508, SALTLAKE)  
SALTLAKE_P_201509 <- crop(P_201509, SALTLAKE)  
SALTLAKE_P_201510 <- crop(P_201510, SALTLAKE)  
SALTLAKE_P_201511 <- crop(P_201511, SALTLAKE)  
SALTLAKE_P_201512 <- crop(P_201512, SALTLAKE)  
#2016
SALTLAKE_P_201601 <- crop(P_201601, SALTLAKE) 
SALTLAKE_P_201602 <- crop(P_201602, SALTLAKE)
SALTLAKE_P_201603 <- crop(P_201603, SALTLAKE)
SALTLAKE_P_201604 <- crop(P_201604, SALTLAKE)
SALTLAKE_P_201605 <- crop(P_201605, SALTLAKE)
SALTLAKE_P_201606 <- crop(P_201606, SALTLAKE)  
SALTLAKE_P_201607 <- crop(P_201607, SALTLAKE)  
SALTLAKE_P_201608 <- crop(P_201608, SALTLAKE)  
SALTLAKE_P_201609 <- crop(P_201609, SALTLAKE)  
SALTLAKE_P_201610 <- crop(P_201610, SALTLAKE)  
SALTLAKE_P_201611 <- crop(P_201611, SALTLAKE)  
SALTLAKE_P_201612 <- crop(P_201612, SALTLAKE)  
#2017
SALTLAKE_P_201701 <- crop(P_201701, SALTLAKE) 
SALTLAKE_P_201702 <- crop(P_201702, SALTLAKE)
SALTLAKE_P_201703 <- crop(P_201703, SALTLAKE)
SALTLAKE_P_201704 <- crop(P_201704, SALTLAKE)
SALTLAKE_P_201705 <- crop(P_201705, SALTLAKE)
SALTLAKE_P_201706 <- crop(P_201706, SALTLAKE)  
SALTLAKE_P_201707 <- crop(P_201707, SALTLAKE)  
SALTLAKE_P_201708 <- crop(P_201708, SALTLAKE)  
SALTLAKE_P_201709 <- crop(P_201709, SALTLAKE)  
SALTLAKE_P_201710 <- crop(P_201710, SALTLAKE)  
SALTLAKE_P_201711 <- crop(P_201711, SALTLAKE)  
SALTLAKE_P_201712 <- crop(P_201712, SALTLAKE)  

#2018

SALTLAKE_P_201801 <- crop(P_201801, SALTLAKE) 
SALTLAKE_P_201802 <- crop(P_201802, SALTLAKE)
SALTLAKE_P_201803 <- crop(P_201803, SALTLAKE)
SALTLAKE_P_201804 <- crop(P_201804, SALTLAKE)
SALTLAKE_P_201805 <- crop(P_201805, SALTLAKE)
SALTLAKE_P_201806 <- crop(P_201806, SALTLAKE)  
SALTLAKE_P_201807 <- crop(P_201807, SALTLAKE)  
SALTLAKE_P_201808 <- crop(P_201808, SALTLAKE)  
SALTLAKE_P_201809 <- crop(P_201809, SALTLAKE)  
SALTLAKE_P_201810 <- crop(P_201810, SALTLAKE)  
SALTLAKE_P_201811 <- crop(P_201811, SALTLAKE)  
SALTLAKE_P_201812 <- crop(P_201812, SALTLAKE)  


# Mean Monthly Precipitation
#2000
SALTLAKE_P_200001_mean <- cellStats(SALTLAKE_P_200001, mean)
SALTLAKE_P_200002_mean <- cellStats(SALTLAKE_P_200002, mean)
SALTLAKE_P_200003_mean <- cellStats(SALTLAKE_P_200003, mean)
SALTLAKE_P_200004_mean <- cellStats(SALTLAKE_P_200004, mean)
SALTLAKE_P_200005_mean <- cellStats(SALTLAKE_P_200005, mean)
SALTLAKE_P_200006_mean <- cellStats(SALTLAKE_P_200006, mean)
SALTLAKE_P_200007_mean <- cellStats(SALTLAKE_P_200007, mean)
SALTLAKE_P_200008_mean <- cellStats(SALTLAKE_P_200008, mean)
SALTLAKE_P_200009_mean <- cellStats(SALTLAKE_P_200009, mean)
SALTLAKE_P_200010_mean <- cellStats(SALTLAKE_P_200010, mean)
SALTLAKE_P_200011_mean <- cellStats(SALTLAKE_P_200011, mean)
SALTLAKE_P_200012_mean <- cellStats(SALTLAKE_P_200012, mean)
#2001
SALTLAKE_P_200101_mean <- cellStats(SALTLAKE_P_200101, mean)
SALTLAKE_P_200102_mean <- cellStats(SALTLAKE_P_200102, mean)
SALTLAKE_P_200103_mean <- cellStats(SALTLAKE_P_200103, mean)
SALTLAKE_P_200104_mean <- cellStats(SALTLAKE_P_200104, mean)
SALTLAKE_P_200105_mean <- cellStats(SALTLAKE_P_200105, mean)
SALTLAKE_P_200106_mean <- cellStats(SALTLAKE_P_200106, mean)
SALTLAKE_P_200107_mean <- cellStats(SALTLAKE_P_200107, mean)
SALTLAKE_P_200108_mean <- cellStats(SALTLAKE_P_200108, mean)
SALTLAKE_P_200109_mean <- cellStats(SALTLAKE_P_200109, mean)
SALTLAKE_P_200110_mean <- cellStats(SALTLAKE_P_200110, mean)
SALTLAKE_P_200111_mean <- cellStats(SALTLAKE_P_200111, mean)
SALTLAKE_P_200112_mean <- cellStats(SALTLAKE_P_200112, mean)

#2002
SALTLAKE_P_200201_mean <- cellStats(SALTLAKE_P_200201, mean)
SALTLAKE_P_200202_mean <- cellStats(SALTLAKE_P_200202, mean)
SALTLAKE_P_200203_mean <- cellStats(SALTLAKE_P_200203, mean)
SALTLAKE_P_200204_mean <- cellStats(SALTLAKE_P_200204, mean)
SALTLAKE_P_200205_mean <- cellStats(SALTLAKE_P_200205, mean)
SALTLAKE_P_200206_mean <- cellStats(SALTLAKE_P_200206, mean)
SALTLAKE_P_200207_mean <- cellStats(SALTLAKE_P_200207, mean)
SALTLAKE_P_200208_mean <- cellStats(SALTLAKE_P_200208, mean)
SALTLAKE_P_200209_mean <- cellStats(SALTLAKE_P_200209, mean)
SALTLAKE_P_200210_mean <- cellStats(SALTLAKE_P_200210, mean)
SALTLAKE_P_200211_mean <- cellStats(SALTLAKE_P_200211, mean)
SALTLAKE_P_200212_mean <- cellStats(SALTLAKE_P_200212, mean)

#2003
SALTLAKE_P_200301_mean <- cellStats(SALTLAKE_P_200301, mean)
SALTLAKE_P_200302_mean <- cellStats(SALTLAKE_P_200302, mean)
SALTLAKE_P_200303_mean <- cellStats(SALTLAKE_P_200303, mean)
SALTLAKE_P_200304_mean <- cellStats(SALTLAKE_P_200304, mean)
SALTLAKE_P_200305_mean <- cellStats(SALTLAKE_P_200305, mean)
SALTLAKE_P_200306_mean <- cellStats(SALTLAKE_P_200306, mean)
SALTLAKE_P_200307_mean <- cellStats(SALTLAKE_P_200307, mean)
SALTLAKE_P_200308_mean <- cellStats(SALTLAKE_P_200308, mean)
SALTLAKE_P_200309_mean <- cellStats(SALTLAKE_P_200309, mean)
SALTLAKE_P_200310_mean <- cellStats(SALTLAKE_P_200310, mean)
SALTLAKE_P_200311_mean <- cellStats(SALTLAKE_P_200311, mean)
SALTLAKE_P_200312_mean <- cellStats(SALTLAKE_P_200312, mean)

#2004

SALTLAKE_P_200401_mean <- cellStats(SALTLAKE_P_200401, mean)
SALTLAKE_P_200402_mean <- cellStats(SALTLAKE_P_200402, mean)
SALTLAKE_P_200403_mean <- cellStats(SALTLAKE_P_200403, mean)
SALTLAKE_P_200404_mean <- cellStats(SALTLAKE_P_200404, mean)
SALTLAKE_P_200405_mean <- cellStats(SALTLAKE_P_200405, mean)
SALTLAKE_P_200406_mean <- cellStats(SALTLAKE_P_200406, mean)
SALTLAKE_P_200407_mean <- cellStats(SALTLAKE_P_200407, mean)
SALTLAKE_P_200408_mean <- cellStats(SALTLAKE_P_200408, mean)
SALTLAKE_P_200409_mean <- cellStats(SALTLAKE_P_200409, mean)
SALTLAKE_P_200410_mean <- cellStats(SALTLAKE_P_200410, mean)
SALTLAKE_P_200411_mean <- cellStats(SALTLAKE_P_200411, mean)
SALTLAKE_P_200412_mean <- cellStats(SALTLAKE_P_200412, mean)

#2005

SALTLAKE_P_200501_mean <- cellStats(SALTLAKE_P_200501, mean)
SALTLAKE_P_200502_mean <- cellStats(SALTLAKE_P_200502, mean)
SALTLAKE_P_200503_mean <- cellStats(SALTLAKE_P_200503, mean)
SALTLAKE_P_200504_mean <- cellStats(SALTLAKE_P_200504, mean)
SALTLAKE_P_200505_mean <- cellStats(SALTLAKE_P_200505, mean)
SALTLAKE_P_200506_mean <- cellStats(SALTLAKE_P_200506, mean)
SALTLAKE_P_200507_mean <- cellStats(SALTLAKE_P_200507, mean)
SALTLAKE_P_200508_mean <- cellStats(SALTLAKE_P_200508, mean)
SALTLAKE_P_200509_mean <- cellStats(SALTLAKE_P_200509, mean)
SALTLAKE_P_200510_mean <- cellStats(SALTLAKE_P_200510, mean)
SALTLAKE_P_200511_mean <- cellStats(SALTLAKE_P_200511, mean)
SALTLAKE_P_200512_mean <- cellStats(SALTLAKE_P_200512, mean)

#2006

SALTLAKE_P_200601_mean <- cellStats(SALTLAKE_P_200601, mean)
SALTLAKE_P_200602_mean <- cellStats(SALTLAKE_P_200602, mean)
SALTLAKE_P_200603_mean <- cellStats(SALTLAKE_P_200603, mean)
SALTLAKE_P_200604_mean <- cellStats(SALTLAKE_P_200604, mean)
SALTLAKE_P_200605_mean <- cellStats(SALTLAKE_P_200605, mean)
SALTLAKE_P_200606_mean <- cellStats(SALTLAKE_P_200606, mean)
SALTLAKE_P_200607_mean <- cellStats(SALTLAKE_P_200607, mean)
SALTLAKE_P_200608_mean <- cellStats(SALTLAKE_P_200608, mean)
SALTLAKE_P_200609_mean <- cellStats(SALTLAKE_P_200609, mean)
SALTLAKE_P_200610_mean <- cellStats(SALTLAKE_P_200610, mean)
SALTLAKE_P_200611_mean <- cellStats(SALTLAKE_P_200611, mean)
SALTLAKE_P_200612_mean <- cellStats(SALTLAKE_P_200612, mean)

#2007

SALTLAKE_P_200701_mean <- cellStats(SALTLAKE_P_200701, mean)
SALTLAKE_P_200702_mean <- cellStats(SALTLAKE_P_200702, mean)
SALTLAKE_P_200703_mean <- cellStats(SALTLAKE_P_200703, mean)
SALTLAKE_P_200704_mean <- cellStats(SALTLAKE_P_200704, mean)
SALTLAKE_P_200705_mean <- cellStats(SALTLAKE_P_200705, mean)
SALTLAKE_P_200706_mean <- cellStats(SALTLAKE_P_200706, mean)
SALTLAKE_P_200707_mean <- cellStats(SALTLAKE_P_200707, mean)
SALTLAKE_P_200708_mean <- cellStats(SALTLAKE_P_200708, mean)
SALTLAKE_P_200709_mean <- cellStats(SALTLAKE_P_200709, mean)
SALTLAKE_P_200710_mean <- cellStats(SALTLAKE_P_200710, mean)
SALTLAKE_P_200711_mean <- cellStats(SALTLAKE_P_200711, mean)
SALTLAKE_P_200712_mean <- cellStats(SALTLAKE_P_200712, mean)

#2008

SALTLAKE_P_200801_mean <- cellStats(SALTLAKE_P_200801, mean)
SALTLAKE_P_200802_mean <- cellStats(SALTLAKE_P_200802, mean)
SALTLAKE_P_200803_mean <- cellStats(SALTLAKE_P_200803, mean)
SALTLAKE_P_200804_mean <- cellStats(SALTLAKE_P_200804, mean)
SALTLAKE_P_200805_mean <- cellStats(SALTLAKE_P_200805, mean)
SALTLAKE_P_200806_mean <- cellStats(SALTLAKE_P_200806, mean)
SALTLAKE_P_200807_mean <- cellStats(SALTLAKE_P_200807, mean)
SALTLAKE_P_200808_mean <- cellStats(SALTLAKE_P_200808, mean)
SALTLAKE_P_200809_mean <- cellStats(SALTLAKE_P_200809, mean)
SALTLAKE_P_200810_mean <- cellStats(SALTLAKE_P_200810, mean)
SALTLAKE_P_200811_mean <- cellStats(SALTLAKE_P_200811, mean)
SALTLAKE_P_200812_mean <- cellStats(SALTLAKE_P_200812, mean)

#2009

SALTLAKE_P_200901_mean <- cellStats(SALTLAKE_P_200901, mean)
SALTLAKE_P_200902_mean <- cellStats(SALTLAKE_P_200902, mean)
SALTLAKE_P_200903_mean <- cellStats(SALTLAKE_P_200903, mean)
SALTLAKE_P_200904_mean <- cellStats(SALTLAKE_P_200904, mean)
SALTLAKE_P_200905_mean <- cellStats(SALTLAKE_P_200905, mean)
SALTLAKE_P_200906_mean <- cellStats(SALTLAKE_P_200906, mean)
SALTLAKE_P_200907_mean <- cellStats(SALTLAKE_P_200907, mean)
SALTLAKE_P_200908_mean <- cellStats(SALTLAKE_P_200908, mean)
SALTLAKE_P_200909_mean <- cellStats(SALTLAKE_P_200909, mean)
SALTLAKE_P_200910_mean <- cellStats(SALTLAKE_P_200910, mean)
SALTLAKE_P_200911_mean <- cellStats(SALTLAKE_P_200911, mean)
SALTLAKE_P_200912_mean <- cellStats(SALTLAKE_P_200912, mean)

#2010

SALTLAKE_P_201001_mean <- cellStats(SALTLAKE_P_201001, mean)
SALTLAKE_P_201002_mean <- cellStats(SALTLAKE_P_201002, mean)
SALTLAKE_P_201003_mean <- cellStats(SALTLAKE_P_201003, mean)
SALTLAKE_P_201004_mean <- cellStats(SALTLAKE_P_201004, mean)
SALTLAKE_P_201005_mean <- cellStats(SALTLAKE_P_201005, mean)
SALTLAKE_P_201006_mean <- cellStats(SALTLAKE_P_201006, mean)
SALTLAKE_P_201007_mean <- cellStats(SALTLAKE_P_201007, mean)
SALTLAKE_P_201008_mean <- cellStats(SALTLAKE_P_201008, mean)
SALTLAKE_P_201009_mean <- cellStats(SALTLAKE_P_201009, mean)
SALTLAKE_P_201010_mean <- cellStats(SALTLAKE_P_201010, mean)
SALTLAKE_P_201011_mean <- cellStats(SALTLAKE_P_201011, mean)
SALTLAKE_P_201012_mean <- cellStats(SALTLAKE_P_201012, mean)

#2011

SALTLAKE_P_201101_mean <- cellStats(SALTLAKE_P_201101, mean)
SALTLAKE_P_201102_mean <- cellStats(SALTLAKE_P_201102, mean)
SALTLAKE_P_201103_mean <- cellStats(SALTLAKE_P_201103, mean)
SALTLAKE_P_201104_mean <- cellStats(SALTLAKE_P_201104, mean)
SALTLAKE_P_201105_mean <- cellStats(SALTLAKE_P_201105, mean)
SALTLAKE_P_201106_mean <- cellStats(SALTLAKE_P_201106, mean)
SALTLAKE_P_201107_mean <- cellStats(SALTLAKE_P_201107, mean)
SALTLAKE_P_201108_mean <- cellStats(SALTLAKE_P_201108, mean)
SALTLAKE_P_201109_mean <- cellStats(SALTLAKE_P_201109, mean)
SALTLAKE_P_201110_mean <- cellStats(SALTLAKE_P_201110, mean)
SALTLAKE_P_201111_mean <- cellStats(SALTLAKE_P_201111, mean)
SALTLAKE_P_201112_mean <- cellStats(SALTLAKE_P_201112, mean)

#2012
SALTLAKE_P_201201_mean <- cellStats(SALTLAKE_P_201201, mean)
SALTLAKE_P_201202_mean <- cellStats(SALTLAKE_P_201202, mean)
SALTLAKE_P_201203_mean <- cellStats(SALTLAKE_P_201203, mean)
SALTLAKE_P_201204_mean <- cellStats(SALTLAKE_P_201204, mean)
SALTLAKE_P_201205_mean <- cellStats(SALTLAKE_P_201205, mean)
SALTLAKE_P_201206_mean <- cellStats(SALTLAKE_P_201206, mean)
SALTLAKE_P_201207_mean <- cellStats(SALTLAKE_P_201207, mean)
SALTLAKE_P_201208_mean <- cellStats(SALTLAKE_P_201208, mean)
SALTLAKE_P_201209_mean <- cellStats(SALTLAKE_P_201209, mean)
SALTLAKE_P_201210_mean <- cellStats(SALTLAKE_P_201210, mean)
SALTLAKE_P_201211_mean <- cellStats(SALTLAKE_P_201211, mean)
SALTLAKE_P_201212_mean <- cellStats(SALTLAKE_P_201212, mean)

#2013
SALTLAKE_P_201301_mean <- cellStats(SALTLAKE_P_201301, mean)
SALTLAKE_P_201302_mean <- cellStats(SALTLAKE_P_201302, mean)
SALTLAKE_P_201303_mean <- cellStats(SALTLAKE_P_201303, mean)
SALTLAKE_P_201304_mean <- cellStats(SALTLAKE_P_201304, mean)
SALTLAKE_P_201305_mean <- cellStats(SALTLAKE_P_201305, mean)
SALTLAKE_P_201306_mean <- cellStats(SALTLAKE_P_201306, mean)
SALTLAKE_P_201307_mean <- cellStats(SALTLAKE_P_201307, mean)
SALTLAKE_P_201308_mean <- cellStats(SALTLAKE_P_201308, mean)
SALTLAKE_P_201309_mean <- cellStats(SALTLAKE_P_201309, mean)
SALTLAKE_P_201310_mean <- cellStats(SALTLAKE_P_201310, mean)
SALTLAKE_P_201311_mean <- cellStats(SALTLAKE_P_201311, mean)
SALTLAKE_P_201312_mean <- cellStats(SALTLAKE_P_201312, mean)

#2014
SALTLAKE_P_201401_mean <- cellStats(SALTLAKE_P_201401, mean)
SALTLAKE_P_201402_mean <- cellStats(SALTLAKE_P_201402, mean)
SALTLAKE_P_201403_mean <- cellStats(SALTLAKE_P_201403, mean)
SALTLAKE_P_201404_mean <- cellStats(SALTLAKE_P_201404, mean)
SALTLAKE_P_201405_mean <- cellStats(SALTLAKE_P_201405, mean)
SALTLAKE_P_201406_mean <- cellStats(SALTLAKE_P_201406, mean)
SALTLAKE_P_201407_mean <- cellStats(SALTLAKE_P_201407, mean)
SALTLAKE_P_201408_mean <- cellStats(SALTLAKE_P_201408, mean)
SALTLAKE_P_201409_mean <- cellStats(SALTLAKE_P_201409, mean)
SALTLAKE_P_201410_mean <- cellStats(SALTLAKE_P_201410, mean)
SALTLAKE_P_201411_mean <- cellStats(SALTLAKE_P_201411, mean)
SALTLAKE_P_201412_mean <- cellStats(SALTLAKE_P_201412, mean)

#2015
SALTLAKE_P_201501_mean <- cellStats(SALTLAKE_P_201501, mean)
SALTLAKE_P_201502_mean <- cellStats(SALTLAKE_P_201502, mean)
SALTLAKE_P_201503_mean <- cellStats(SALTLAKE_P_201503, mean)
SALTLAKE_P_201504_mean <- cellStats(SALTLAKE_P_201504, mean)
SALTLAKE_P_201505_mean <- cellStats(SALTLAKE_P_201505, mean)
SALTLAKE_P_201506_mean <- cellStats(SALTLAKE_P_201506, mean)
SALTLAKE_P_201507_mean <- cellStats(SALTLAKE_P_201507, mean)
SALTLAKE_P_201508_mean <- cellStats(SALTLAKE_P_201508, mean)
SALTLAKE_P_201509_mean <- cellStats(SALTLAKE_P_201509, mean)
SALTLAKE_P_201510_mean <- cellStats(SALTLAKE_P_201510, mean)
SALTLAKE_P_201511_mean <- cellStats(SALTLAKE_P_201511, mean)
SALTLAKE_P_201512_mean <- cellStats(SALTLAKE_P_201512, mean)

#2016
SALTLAKE_P_201601_mean <- cellStats(SALTLAKE_P_201601, mean)
SALTLAKE_P_201602_mean <- cellStats(SALTLAKE_P_201602, mean)
SALTLAKE_P_201603_mean <- cellStats(SALTLAKE_P_201603, mean)
SALTLAKE_P_201604_mean <- cellStats(SALTLAKE_P_201604, mean)
SALTLAKE_P_201605_mean <- cellStats(SALTLAKE_P_201605, mean)
SALTLAKE_P_201606_mean <- cellStats(SALTLAKE_P_201606, mean)
SALTLAKE_P_201607_mean <- cellStats(SALTLAKE_P_201607, mean)
SALTLAKE_P_201608_mean <- cellStats(SALTLAKE_P_201608, mean)
SALTLAKE_P_201609_mean <- cellStats(SALTLAKE_P_201609, mean)
SALTLAKE_P_201610_mean <- cellStats(SALTLAKE_P_201610, mean)
SALTLAKE_P_201611_mean <- cellStats(SALTLAKE_P_201611, mean)
SALTLAKE_P_201612_mean <- cellStats(SALTLAKE_P_201612, mean)

#2017
SALTLAKE_P_201701_mean <- cellStats(SALTLAKE_P_201701, mean)
SALTLAKE_P_201702_mean <- cellStats(SALTLAKE_P_201702, mean)
SALTLAKE_P_201703_mean <- cellStats(SALTLAKE_P_201703, mean)
SALTLAKE_P_201704_mean <- cellStats(SALTLAKE_P_201704, mean)
SALTLAKE_P_201705_mean <- cellStats(SALTLAKE_P_201705, mean)
SALTLAKE_P_201706_mean <- cellStats(SALTLAKE_P_201706, mean)
SALTLAKE_P_201707_mean <- cellStats(SALTLAKE_P_201707, mean)
SALTLAKE_P_201708_mean <- cellStats(SALTLAKE_P_201708, mean)
SALTLAKE_P_201709_mean <- cellStats(SALTLAKE_P_201709, mean)
SALTLAKE_P_201710_mean <- cellStats(SALTLAKE_P_201710, mean)
SALTLAKE_P_201711_mean <- cellStats(SALTLAKE_P_201711, mean)
SALTLAKE_P_201712_mean <- cellStats(SALTLAKE_P_201712, mean)

#2018
SALTLAKE_P_201801_mean <- cellStats(SALTLAKE_P_201801, mean)
SALTLAKE_P_201802_mean <- cellStats(SALTLAKE_P_201802, mean)
SALTLAKE_P_201803_mean <- cellStats(SALTLAKE_P_201803, mean)
SALTLAKE_P_201804_mean <- cellStats(SALTLAKE_P_201804, mean)
SALTLAKE_P_201805_mean <- cellStats(SALTLAKE_P_201805, mean)
SALTLAKE_P_201806_mean <- cellStats(SALTLAKE_P_201806, mean)
SALTLAKE_P_201807_mean <- cellStats(SALTLAKE_P_201807, mean)
SALTLAKE_P_201808_mean <- cellStats(SALTLAKE_P_201808, mean)
SALTLAKE_P_201809_mean <- cellStats(SALTLAKE_P_201809, mean)
SALTLAKE_P_201810_mean <- cellStats(SALTLAKE_P_201810, mean)
SALTLAKE_P_201811_mean <- cellStats(SALTLAKE_P_201811, mean)
SALTLAKE_P_201812_mean <- cellStats(SALTLAKE_P_201812, mean)

# SEVIER


#2000
SEVIER_P_200001 <- crop(P_200001, SEVIER) 
SEVIER_P_200002 <- crop(P_200002, SEVIER)
SEVIER_P_200003 <- crop(P_200003, SEVIER)
SEVIER_P_200004 <- crop(P_200004, SEVIER)
SEVIER_P_200005 <- crop(P_200005, SEVIER)
SEVIER_P_200006 <- crop(P_200006, SEVIER)  
SEVIER_P_200007 <- crop(P_200007, SEVIER)  
SEVIER_P_200008 <- crop(P_200008, SEVIER)  
SEVIER_P_200009 <- crop(P_200009, SEVIER)  
SEVIER_P_200010 <- crop(P_200010, SEVIER)  
SEVIER_P_200011 <- crop(P_200011, SEVIER)  
SEVIER_P_200012 <- crop(P_200012, SEVIER)  
#2001
SEVIER_P_200101 <- crop(P_200101, SEVIER) 
SEVIER_P_200102 <- crop(P_200102, SEVIER)
SEVIER_P_200103 <- crop(P_200103, SEVIER)
SEVIER_P_200104 <- crop(P_200104, SEVIER)
SEVIER_P_200105 <- crop(P_200105, SEVIER)
SEVIER_P_200106 <- crop(P_200106, SEVIER)  
SEVIER_P_200107 <- crop(P_200107, SEVIER)  
SEVIER_P_200108 <- crop(P_200108, SEVIER)  
SEVIER_P_200109 <- crop(P_200109, SEVIER)  
SEVIER_P_200110 <- crop(P_200110, SEVIER)  
SEVIER_P_200111 <- crop(P_200111, SEVIER)  
SEVIER_P_200112 <- crop(P_200112, SEVIER)  

#2002
SEVIER_P_200201 <- crop(P_200201, SEVIER) 
SEVIER_P_200202 <- crop(P_200202, SEVIER)
SEVIER_P_200203 <- crop(P_200203, SEVIER)
SEVIER_P_200204 <- crop(P_200204, SEVIER)
SEVIER_P_200205 <- crop(P_200205, SEVIER)
SEVIER_P_200206 <- crop(P_200206, SEVIER)  
SEVIER_P_200207 <- crop(P_200207, SEVIER)  
SEVIER_P_200208 <- crop(P_200208, SEVIER)  
SEVIER_P_200209 <- crop(P_200209, SEVIER)  
SEVIER_P_200210 <- crop(P_200210, SEVIER)  
SEVIER_P_200211 <- crop(P_200211, SEVIER)  
SEVIER_P_200212 <- crop(P_200212, SEVIER)  
#2003
SEVIER_P_200301 <- crop(P_200301, SEVIER) 
SEVIER_P_200302 <- crop(P_200302, SEVIER)
SEVIER_P_200303 <- crop(P_200303, SEVIER)
SEVIER_P_200304 <- crop(P_200304, SEVIER)
SEVIER_P_200305 <- crop(P_200305, SEVIER)
SEVIER_P_200306 <- crop(P_200306, SEVIER)  
SEVIER_P_200307 <- crop(P_200307, SEVIER)  
SEVIER_P_200308 <- crop(P_200308, SEVIER)  
SEVIER_P_200309 <- crop(P_200309, SEVIER)  
SEVIER_P_200310 <- crop(P_200310, SEVIER)  
SEVIER_P_200311 <- crop(P_200311, SEVIER)  
SEVIER_P_200312 <- crop(P_200312, SEVIER)  
#2004
SEVIER_P_200401 <- crop(P_200401, SEVIER) 
SEVIER_P_200402 <- crop(P_200402, SEVIER)
SEVIER_P_200403 <- crop(P_200403, SEVIER)
SEVIER_P_200404 <- crop(P_200404, SEVIER)
SEVIER_P_200405 <- crop(P_200405, SEVIER)
SEVIER_P_200406 <- crop(P_200406, SEVIER)  
SEVIER_P_200407 <- crop(P_200407, SEVIER)  
SEVIER_P_200408 <- crop(P_200408, SEVIER)  
SEVIER_P_200409 <- crop(P_200409, SEVIER)  
SEVIER_P_200410 <- crop(P_200410, SEVIER)  
SEVIER_P_200411 <- crop(P_200411, SEVIER)  
SEVIER_P_200412 <- crop(P_200412, SEVIER)  
#2005
SEVIER_P_200501 <- crop(P_200501, SEVIER) 
SEVIER_P_200502 <- crop(P_200502, SEVIER)
SEVIER_P_200503 <- crop(P_200503, SEVIER)
SEVIER_P_200504 <- crop(P_200504, SEVIER)
SEVIER_P_200505 <- crop(P_200505, SEVIER)
SEVIER_P_200506 <- crop(P_200506, SEVIER)  
SEVIER_P_200507 <- crop(P_200507, SEVIER)  
SEVIER_P_200508 <- crop(P_200508, SEVIER)  
SEVIER_P_200509 <- crop(P_200509, SEVIER)  
SEVIER_P_200510 <- crop(P_200510, SEVIER)  
SEVIER_P_200511 <- crop(P_200511, SEVIER)  
SEVIER_P_200512 <- crop(P_200512, SEVIER)  
#2006
SEVIER_P_200601 <- crop(P_200601, SEVIER) 
SEVIER_P_200602 <- crop(P_200602, SEVIER)
SEVIER_P_200603 <- crop(P_200603, SEVIER)
SEVIER_P_200604 <- crop(P_200604, SEVIER)
SEVIER_P_200605 <- crop(P_200605, SEVIER)
SEVIER_P_200606 <- crop(P_200606, SEVIER)  
SEVIER_P_200607 <- crop(P_200607, SEVIER)  
SEVIER_P_200608 <- crop(P_200608, SEVIER)  
SEVIER_P_200609 <- crop(P_200609, SEVIER)  
SEVIER_P_200610 <- crop(P_200610, SEVIER)  
SEVIER_P_200611 <- crop(P_200611, SEVIER)  
SEVIER_P_200612 <- crop(P_200612, SEVIER)  
#2007
SEVIER_P_200701 <- crop(P_200701, SEVIER) 
SEVIER_P_200702 <- crop(P_200702, SEVIER)
SEVIER_P_200703 <- crop(P_200703, SEVIER)
SEVIER_P_200704 <- crop(P_200704, SEVIER)
SEVIER_P_200705 <- crop(P_200705, SEVIER)
SEVIER_P_200706 <- crop(P_200706, SEVIER)  
SEVIER_P_200707 <- crop(P_200707, SEVIER)  
SEVIER_P_200708 <- crop(P_200708, SEVIER)  
SEVIER_P_200709 <- crop(P_200709, SEVIER)  
SEVIER_P_200710 <- crop(P_200710, SEVIER)  
SEVIER_P_200711 <- crop(P_200711, SEVIER)  
SEVIER_P_200712 <- crop(P_200712, SEVIER)  
#2008
SEVIER_P_200801 <- crop(P_200801, SEVIER) 
SEVIER_P_200802 <- crop(P_200802, SEVIER)
SEVIER_P_200803 <- crop(P_200803, SEVIER)
SEVIER_P_200804 <- crop(P_200804, SEVIER)
SEVIER_P_200805 <- crop(P_200805, SEVIER)
SEVIER_P_200806 <- crop(P_200806, SEVIER)  
SEVIER_P_200807 <- crop(P_200807, SEVIER)  
SEVIER_P_200808 <- crop(P_200808, SEVIER)  
SEVIER_P_200809 <- crop(P_200809, SEVIER)  
SEVIER_P_200810 <- crop(P_200810, SEVIER)  
SEVIER_P_200811 <- crop(P_200811, SEVIER)  
SEVIER_P_200812 <- crop(P_200812, SEVIER)  
#2009
SEVIER_P_200901 <- crop(P_200901, SEVIER) 
SEVIER_P_200902 <- crop(P_200902, SEVIER)
SEVIER_P_200903 <- crop(P_200903, SEVIER)
SEVIER_P_200904 <- crop(P_200904, SEVIER)
SEVIER_P_200905 <- crop(P_200905, SEVIER)
SEVIER_P_200906 <- crop(P_200906, SEVIER)  
SEVIER_P_200907 <- crop(P_200907, SEVIER)  
SEVIER_P_200908 <- crop(P_200908, SEVIER)  
SEVIER_P_200909 <- crop(P_200909, SEVIER)  
SEVIER_P_200910 <- crop(P_200910, SEVIER)  
SEVIER_P_200911 <- crop(P_200911, SEVIER)  
SEVIER_P_200912 <- crop(P_200912, SEVIER)  
#2010
SEVIER_P_201001 <- crop(P_201001, SEVIER) 
SEVIER_P_201002 <- crop(P_201002, SEVIER)
SEVIER_P_201003 <- crop(P_201003, SEVIER)
SEVIER_P_201004 <- crop(P_201004, SEVIER)
SEVIER_P_201005 <- crop(P_201005, SEVIER)
SEVIER_P_201006 <- crop(P_201006, SEVIER)  
SEVIER_P_201007 <- crop(P_201007, SEVIER)  
SEVIER_P_201008 <- crop(P_201008, SEVIER)  
SEVIER_P_201009 <- crop(P_201009, SEVIER)  
SEVIER_P_201010 <- crop(P_201010, SEVIER)  
SEVIER_P_201011 <- crop(P_201011, SEVIER)  
SEVIER_P_201012 <- crop(P_201012, SEVIER)  
#2011
SEVIER_P_201101 <- crop(P_201101, SEVIER) 
SEVIER_P_201102 <- crop(P_201102, SEVIER)
SEVIER_P_201103 <- crop(P_201103, SEVIER)
SEVIER_P_201104 <- crop(P_201104, SEVIER)
SEVIER_P_201105 <- crop(P_201105, SEVIER)
SEVIER_P_201106 <- crop(P_201106, SEVIER)  
SEVIER_P_201107 <- crop(P_201107, SEVIER)  
SEVIER_P_201108 <- crop(P_201108, SEVIER)  
SEVIER_P_201109 <- crop(P_201109, SEVIER)  
SEVIER_P_201110 <- crop(P_201110, SEVIER)  
SEVIER_P_201111 <- crop(P_201111, SEVIER)  
SEVIER_P_201112 <- crop(P_201112, SEVIER)  
#2012
SEVIER_P_201201 <- crop(P_201201, SEVIER) 
SEVIER_P_201202 <- crop(P_201202, SEVIER)
SEVIER_P_201203 <- crop(P_201203, SEVIER)
SEVIER_P_201204 <- crop(P_201204, SEVIER)
SEVIER_P_201205 <- crop(P_201205, SEVIER)
SEVIER_P_201206 <- crop(P_201206, SEVIER)  
SEVIER_P_201207 <- crop(P_201207, SEVIER)  
SEVIER_P_201208 <- crop(P_201208, SEVIER)  
SEVIER_P_201209 <- crop(P_201209, SEVIER)  
SEVIER_P_201210 <- crop(P_201210, SEVIER)  
SEVIER_P_201211 <- crop(P_201211, SEVIER)  
SEVIER_P_201212 <- crop(P_201212, SEVIER)  
#2013
SEVIER_P_201301 <- crop(P_201301, SEVIER) 
SEVIER_P_201302 <- crop(P_201302, SEVIER)
SEVIER_P_201303 <- crop(P_201303, SEVIER)
SEVIER_P_201304 <- crop(P_201304, SEVIER)
SEVIER_P_201305 <- crop(P_201305, SEVIER)
SEVIER_P_201306 <- crop(P_201306, SEVIER)  
SEVIER_P_201307 <- crop(P_201307, SEVIER)  
SEVIER_P_201308 <- crop(P_201308, SEVIER)  
SEVIER_P_201309 <- crop(P_201309, SEVIER)  
SEVIER_P_201310 <- crop(P_201310, SEVIER)  
SEVIER_P_201311 <- crop(P_201311, SEVIER)  
SEVIER_P_201312 <- crop(P_201312, SEVIER)  
#2014
SEVIER_P_201401 <- crop(P_201401, SEVIER) 
SEVIER_P_201402 <- crop(P_201402, SEVIER)
SEVIER_P_201403 <- crop(P_201403, SEVIER)
SEVIER_P_201404 <- crop(P_201404, SEVIER)
SEVIER_P_201405 <- crop(P_201405, SEVIER)
SEVIER_P_201406 <- crop(P_201406, SEVIER)  
SEVIER_P_201407 <- crop(P_201407, SEVIER)  
SEVIER_P_201408 <- crop(P_201408, SEVIER)  
SEVIER_P_201409 <- crop(P_201409, SEVIER)  
SEVIER_P_201410 <- crop(P_201410, SEVIER)  
SEVIER_P_201411 <- crop(P_201411, SEVIER)  
SEVIER_P_201412 <- crop(P_201412, SEVIER)  
#2015
SEVIER_P_201501 <- crop(P_201501, SEVIER) 
SEVIER_P_201502 <- crop(P_201502, SEVIER)
SEVIER_P_201503 <- crop(P_201503, SEVIER)
SEVIER_P_201504 <- crop(P_201504, SEVIER)
SEVIER_P_201505 <- crop(P_201505, SEVIER)
SEVIER_P_201506 <- crop(P_201506, SEVIER)  
SEVIER_P_201507 <- crop(P_201507, SEVIER)  
SEVIER_P_201508 <- crop(P_201508, SEVIER)  
SEVIER_P_201509 <- crop(P_201509, SEVIER)  
SEVIER_P_201510 <- crop(P_201510, SEVIER)  
SEVIER_P_201511 <- crop(P_201511, SEVIER)  
SEVIER_P_201512 <- crop(P_201512, SEVIER)  
#2016
SEVIER_P_201601 <- crop(P_201601, SEVIER) 
SEVIER_P_201602 <- crop(P_201602, SEVIER)
SEVIER_P_201603 <- crop(P_201603, SEVIER)
SEVIER_P_201604 <- crop(P_201604, SEVIER)
SEVIER_P_201605 <- crop(P_201605, SEVIER)
SEVIER_P_201606 <- crop(P_201606, SEVIER)  
SEVIER_P_201607 <- crop(P_201607, SEVIER)  
SEVIER_P_201608 <- crop(P_201608, SEVIER)  
SEVIER_P_201609 <- crop(P_201609, SEVIER)  
SEVIER_P_201610 <- crop(P_201610, SEVIER)  
SEVIER_P_201611 <- crop(P_201611, SEVIER)  
SEVIER_P_201612 <- crop(P_201612, SEVIER)  
#2017
SEVIER_P_201701 <- crop(P_201701, SEVIER) 
SEVIER_P_201702 <- crop(P_201702, SEVIER)
SEVIER_P_201703 <- crop(P_201703, SEVIER)
SEVIER_P_201704 <- crop(P_201704, SEVIER)
SEVIER_P_201705 <- crop(P_201705, SEVIER)
SEVIER_P_201706 <- crop(P_201706, SEVIER)  
SEVIER_P_201707 <- crop(P_201707, SEVIER)  
SEVIER_P_201708 <- crop(P_201708, SEVIER)  
SEVIER_P_201709 <- crop(P_201709, SEVIER)  
SEVIER_P_201710 <- crop(P_201710, SEVIER)  
SEVIER_P_201711 <- crop(P_201711, SEVIER)  
SEVIER_P_201712 <- crop(P_201712, SEVIER)  

#2018

SEVIER_P_201801 <- crop(P_201801, SEVIER) 
SEVIER_P_201802 <- crop(P_201802, SEVIER)
SEVIER_P_201803 <- crop(P_201803, SEVIER)
SEVIER_P_201804 <- crop(P_201804, SEVIER)
SEVIER_P_201805 <- crop(P_201805, SEVIER)
SEVIER_P_201806 <- crop(P_201806, SEVIER)  
SEVIER_P_201807 <- crop(P_201807, SEVIER)  
SEVIER_P_201808 <- crop(P_201808, SEVIER)  
SEVIER_P_201809 <- crop(P_201809, SEVIER)  
SEVIER_P_201810 <- crop(P_201810, SEVIER)  
SEVIER_P_201811 <- crop(P_201811, SEVIER)  
SEVIER_P_201812 <- crop(P_201812, SEVIER)  


# Mean Monthly Precipitation
#2000
SEVIER_P_200001_mean <- cellStats(SEVIER_P_200001, mean)
SEVIER_P_200002_mean <- cellStats(SEVIER_P_200002, mean)
SEVIER_P_200003_mean <- cellStats(SEVIER_P_200003, mean)
SEVIER_P_200004_mean <- cellStats(SEVIER_P_200004, mean)
SEVIER_P_200005_mean <- cellStats(SEVIER_P_200005, mean)
SEVIER_P_200006_mean <- cellStats(SEVIER_P_200006, mean)
SEVIER_P_200007_mean <- cellStats(SEVIER_P_200007, mean)
SEVIER_P_200008_mean <- cellStats(SEVIER_P_200008, mean)
SEVIER_P_200009_mean <- cellStats(SEVIER_P_200009, mean)
SEVIER_P_200010_mean <- cellStats(SEVIER_P_200010, mean)
SEVIER_P_200011_mean <- cellStats(SEVIER_P_200011, mean)
SEVIER_P_200012_mean <- cellStats(SEVIER_P_200012, mean)
#2001
SEVIER_P_200101_mean <- cellStats(SEVIER_P_200101, mean)
SEVIER_P_200102_mean <- cellStats(SEVIER_P_200102, mean)
SEVIER_P_200103_mean <- cellStats(SEVIER_P_200103, mean)
SEVIER_P_200104_mean <- cellStats(SEVIER_P_200104, mean)
SEVIER_P_200105_mean <- cellStats(SEVIER_P_200105, mean)
SEVIER_P_200106_mean <- cellStats(SEVIER_P_200106, mean)
SEVIER_P_200107_mean <- cellStats(SEVIER_P_200107, mean)
SEVIER_P_200108_mean <- cellStats(SEVIER_P_200108, mean)
SEVIER_P_200109_mean <- cellStats(SEVIER_P_200109, mean)
SEVIER_P_200110_mean <- cellStats(SEVIER_P_200110, mean)
SEVIER_P_200111_mean <- cellStats(SEVIER_P_200111, mean)
SEVIER_P_200112_mean <- cellStats(SEVIER_P_200112, mean)

#2002
SEVIER_P_200201_mean <- cellStats(SEVIER_P_200201, mean)
SEVIER_P_200202_mean <- cellStats(SEVIER_P_200202, mean)
SEVIER_P_200203_mean <- cellStats(SEVIER_P_200203, mean)
SEVIER_P_200204_mean <- cellStats(SEVIER_P_200204, mean)
SEVIER_P_200205_mean <- cellStats(SEVIER_P_200205, mean)
SEVIER_P_200206_mean <- cellStats(SEVIER_P_200206, mean)
SEVIER_P_200207_mean <- cellStats(SEVIER_P_200207, mean)
SEVIER_P_200208_mean <- cellStats(SEVIER_P_200208, mean)
SEVIER_P_200209_mean <- cellStats(SEVIER_P_200209, mean)
SEVIER_P_200210_mean <- cellStats(SEVIER_P_200210, mean)
SEVIER_P_200211_mean <- cellStats(SEVIER_P_200211, mean)
SEVIER_P_200212_mean <- cellStats(SEVIER_P_200212, mean)

#2003
SEVIER_P_200301_mean <- cellStats(SEVIER_P_200301, mean)
SEVIER_P_200302_mean <- cellStats(SEVIER_P_200302, mean)
SEVIER_P_200303_mean <- cellStats(SEVIER_P_200303, mean)
SEVIER_P_200304_mean <- cellStats(SEVIER_P_200304, mean)
SEVIER_P_200305_mean <- cellStats(SEVIER_P_200305, mean)
SEVIER_P_200306_mean <- cellStats(SEVIER_P_200306, mean)
SEVIER_P_200307_mean <- cellStats(SEVIER_P_200307, mean)
SEVIER_P_200308_mean <- cellStats(SEVIER_P_200308, mean)
SEVIER_P_200309_mean <- cellStats(SEVIER_P_200309, mean)
SEVIER_P_200310_mean <- cellStats(SEVIER_P_200310, mean)
SEVIER_P_200311_mean <- cellStats(SEVIER_P_200311, mean)
SEVIER_P_200312_mean <- cellStats(SEVIER_P_200312, mean)

#2004

SEVIER_P_200401_mean <- cellStats(SEVIER_P_200401, mean)
SEVIER_P_200402_mean <- cellStats(SEVIER_P_200402, mean)
SEVIER_P_200403_mean <- cellStats(SEVIER_P_200403, mean)
SEVIER_P_200404_mean <- cellStats(SEVIER_P_200404, mean)
SEVIER_P_200405_mean <- cellStats(SEVIER_P_200405, mean)
SEVIER_P_200406_mean <- cellStats(SEVIER_P_200406, mean)
SEVIER_P_200407_mean <- cellStats(SEVIER_P_200407, mean)
SEVIER_P_200408_mean <- cellStats(SEVIER_P_200408, mean)
SEVIER_P_200409_mean <- cellStats(SEVIER_P_200409, mean)
SEVIER_P_200410_mean <- cellStats(SEVIER_P_200410, mean)
SEVIER_P_200411_mean <- cellStats(SEVIER_P_200411, mean)
SEVIER_P_200412_mean <- cellStats(SEVIER_P_200412, mean)

#2005

SEVIER_P_200501_mean <- cellStats(SEVIER_P_200501, mean)
SEVIER_P_200502_mean <- cellStats(SEVIER_P_200502, mean)
SEVIER_P_200503_mean <- cellStats(SEVIER_P_200503, mean)
SEVIER_P_200504_mean <- cellStats(SEVIER_P_200504, mean)
SEVIER_P_200505_mean <- cellStats(SEVIER_P_200505, mean)
SEVIER_P_200506_mean <- cellStats(SEVIER_P_200506, mean)
SEVIER_P_200507_mean <- cellStats(SEVIER_P_200507, mean)
SEVIER_P_200508_mean <- cellStats(SEVIER_P_200508, mean)
SEVIER_P_200509_mean <- cellStats(SEVIER_P_200509, mean)
SEVIER_P_200510_mean <- cellStats(SEVIER_P_200510, mean)
SEVIER_P_200511_mean <- cellStats(SEVIER_P_200511, mean)
SEVIER_P_200512_mean <- cellStats(SEVIER_P_200512, mean)

#2006

SEVIER_P_200601_mean <- cellStats(SEVIER_P_200601, mean)
SEVIER_P_200602_mean <- cellStats(SEVIER_P_200602, mean)
SEVIER_P_200603_mean <- cellStats(SEVIER_P_200603, mean)
SEVIER_P_200604_mean <- cellStats(SEVIER_P_200604, mean)
SEVIER_P_200605_mean <- cellStats(SEVIER_P_200605, mean)
SEVIER_P_200606_mean <- cellStats(SEVIER_P_200606, mean)
SEVIER_P_200607_mean <- cellStats(SEVIER_P_200607, mean)
SEVIER_P_200608_mean <- cellStats(SEVIER_P_200608, mean)
SEVIER_P_200609_mean <- cellStats(SEVIER_P_200609, mean)
SEVIER_P_200610_mean <- cellStats(SEVIER_P_200610, mean)
SEVIER_P_200611_mean <- cellStats(SEVIER_P_200611, mean)
SEVIER_P_200612_mean <- cellStats(SEVIER_P_200612, mean)

#2007

SEVIER_P_200701_mean <- cellStats(SEVIER_P_200701, mean)
SEVIER_P_200702_mean <- cellStats(SEVIER_P_200702, mean)
SEVIER_P_200703_mean <- cellStats(SEVIER_P_200703, mean)
SEVIER_P_200704_mean <- cellStats(SEVIER_P_200704, mean)
SEVIER_P_200705_mean <- cellStats(SEVIER_P_200705, mean)
SEVIER_P_200706_mean <- cellStats(SEVIER_P_200706, mean)
SEVIER_P_200707_mean <- cellStats(SEVIER_P_200707, mean)
SEVIER_P_200708_mean <- cellStats(SEVIER_P_200708, mean)
SEVIER_P_200709_mean <- cellStats(SEVIER_P_200709, mean)
SEVIER_P_200710_mean <- cellStats(SEVIER_P_200710, mean)
SEVIER_P_200711_mean <- cellStats(SEVIER_P_200711, mean)
SEVIER_P_200712_mean <- cellStats(SEVIER_P_200712, mean)

#2008

SEVIER_P_200801_mean <- cellStats(SEVIER_P_200801, mean)
SEVIER_P_200802_mean <- cellStats(SEVIER_P_200802, mean)
SEVIER_P_200803_mean <- cellStats(SEVIER_P_200803, mean)
SEVIER_P_200804_mean <- cellStats(SEVIER_P_200804, mean)
SEVIER_P_200805_mean <- cellStats(SEVIER_P_200805, mean)
SEVIER_P_200806_mean <- cellStats(SEVIER_P_200806, mean)
SEVIER_P_200807_mean <- cellStats(SEVIER_P_200807, mean)
SEVIER_P_200808_mean <- cellStats(SEVIER_P_200808, mean)
SEVIER_P_200809_mean <- cellStats(SEVIER_P_200809, mean)
SEVIER_P_200810_mean <- cellStats(SEVIER_P_200810, mean)
SEVIER_P_200811_mean <- cellStats(SEVIER_P_200811, mean)
SEVIER_P_200812_mean <- cellStats(SEVIER_P_200812, mean)

#2009

SEVIER_P_200901_mean <- cellStats(SEVIER_P_200901, mean)
SEVIER_P_200902_mean <- cellStats(SEVIER_P_200902, mean)
SEVIER_P_200903_mean <- cellStats(SEVIER_P_200903, mean)
SEVIER_P_200904_mean <- cellStats(SEVIER_P_200904, mean)
SEVIER_P_200905_mean <- cellStats(SEVIER_P_200905, mean)
SEVIER_P_200906_mean <- cellStats(SEVIER_P_200906, mean)
SEVIER_P_200907_mean <- cellStats(SEVIER_P_200907, mean)
SEVIER_P_200908_mean <- cellStats(SEVIER_P_200908, mean)
SEVIER_P_200909_mean <- cellStats(SEVIER_P_200909, mean)
SEVIER_P_200910_mean <- cellStats(SEVIER_P_200910, mean)
SEVIER_P_200911_mean <- cellStats(SEVIER_P_200911, mean)
SEVIER_P_200912_mean <- cellStats(SEVIER_P_200912, mean)

#2010

SEVIER_P_201001_mean <- cellStats(SEVIER_P_201001, mean)
SEVIER_P_201002_mean <- cellStats(SEVIER_P_201002, mean)
SEVIER_P_201003_mean <- cellStats(SEVIER_P_201003, mean)
SEVIER_P_201004_mean <- cellStats(SEVIER_P_201004, mean)
SEVIER_P_201005_mean <- cellStats(SEVIER_P_201005, mean)
SEVIER_P_201006_mean <- cellStats(SEVIER_P_201006, mean)
SEVIER_P_201007_mean <- cellStats(SEVIER_P_201007, mean)
SEVIER_P_201008_mean <- cellStats(SEVIER_P_201008, mean)
SEVIER_P_201009_mean <- cellStats(SEVIER_P_201009, mean)
SEVIER_P_201010_mean <- cellStats(SEVIER_P_201010, mean)
SEVIER_P_201011_mean <- cellStats(SEVIER_P_201011, mean)
SEVIER_P_201012_mean <- cellStats(SEVIER_P_201012, mean)

#2011

SEVIER_P_201101_mean <- cellStats(SEVIER_P_201101, mean)
SEVIER_P_201102_mean <- cellStats(SEVIER_P_201102, mean)
SEVIER_P_201103_mean <- cellStats(SEVIER_P_201103, mean)
SEVIER_P_201104_mean <- cellStats(SEVIER_P_201104, mean)
SEVIER_P_201105_mean <- cellStats(SEVIER_P_201105, mean)
SEVIER_P_201106_mean <- cellStats(SEVIER_P_201106, mean)
SEVIER_P_201107_mean <- cellStats(SEVIER_P_201107, mean)
SEVIER_P_201108_mean <- cellStats(SEVIER_P_201108, mean)
SEVIER_P_201109_mean <- cellStats(SEVIER_P_201109, mean)
SEVIER_P_201110_mean <- cellStats(SEVIER_P_201110, mean)
SEVIER_P_201111_mean <- cellStats(SEVIER_P_201111, mean)
SEVIER_P_201112_mean <- cellStats(SEVIER_P_201112, mean)

#2012
SEVIER_P_201201_mean <- cellStats(SEVIER_P_201201, mean)
SEVIER_P_201202_mean <- cellStats(SEVIER_P_201202, mean)
SEVIER_P_201203_mean <- cellStats(SEVIER_P_201203, mean)
SEVIER_P_201204_mean <- cellStats(SEVIER_P_201204, mean)
SEVIER_P_201205_mean <- cellStats(SEVIER_P_201205, mean)
SEVIER_P_201206_mean <- cellStats(SEVIER_P_201206, mean)
SEVIER_P_201207_mean <- cellStats(SEVIER_P_201207, mean)
SEVIER_P_201208_mean <- cellStats(SEVIER_P_201208, mean)
SEVIER_P_201209_mean <- cellStats(SEVIER_P_201209, mean)
SEVIER_P_201210_mean <- cellStats(SEVIER_P_201210, mean)
SEVIER_P_201211_mean <- cellStats(SEVIER_P_201211, mean)
SEVIER_P_201212_mean <- cellStats(SEVIER_P_201212, mean)

#2013
SEVIER_P_201301_mean <- cellStats(SEVIER_P_201301, mean)
SEVIER_P_201302_mean <- cellStats(SEVIER_P_201302, mean)
SEVIER_P_201303_mean <- cellStats(SEVIER_P_201303, mean)
SEVIER_P_201304_mean <- cellStats(SEVIER_P_201304, mean)
SEVIER_P_201305_mean <- cellStats(SEVIER_P_201305, mean)
SEVIER_P_201306_mean <- cellStats(SEVIER_P_201306, mean)
SEVIER_P_201307_mean <- cellStats(SEVIER_P_201307, mean)
SEVIER_P_201308_mean <- cellStats(SEVIER_P_201308, mean)
SEVIER_P_201309_mean <- cellStats(SEVIER_P_201309, mean)
SEVIER_P_201310_mean <- cellStats(SEVIER_P_201310, mean)
SEVIER_P_201311_mean <- cellStats(SEVIER_P_201311, mean)
SEVIER_P_201312_mean <- cellStats(SEVIER_P_201312, mean)

#2014
SEVIER_P_201401_mean <- cellStats(SEVIER_P_201401, mean)
SEVIER_P_201402_mean <- cellStats(SEVIER_P_201402, mean)
SEVIER_P_201403_mean <- cellStats(SEVIER_P_201403, mean)
SEVIER_P_201404_mean <- cellStats(SEVIER_P_201404, mean)
SEVIER_P_201405_mean <- cellStats(SEVIER_P_201405, mean)
SEVIER_P_201406_mean <- cellStats(SEVIER_P_201406, mean)
SEVIER_P_201407_mean <- cellStats(SEVIER_P_201407, mean)
SEVIER_P_201408_mean <- cellStats(SEVIER_P_201408, mean)
SEVIER_P_201409_mean <- cellStats(SEVIER_P_201409, mean)
SEVIER_P_201410_mean <- cellStats(SEVIER_P_201410, mean)
SEVIER_P_201411_mean <- cellStats(SEVIER_P_201411, mean)
SEVIER_P_201412_mean <- cellStats(SEVIER_P_201412, mean)

#2015
SEVIER_P_201501_mean <- cellStats(SEVIER_P_201501, mean)
SEVIER_P_201502_mean <- cellStats(SEVIER_P_201502, mean)
SEVIER_P_201503_mean <- cellStats(SEVIER_P_201503, mean)
SEVIER_P_201504_mean <- cellStats(SEVIER_P_201504, mean)
SEVIER_P_201505_mean <- cellStats(SEVIER_P_201505, mean)
SEVIER_P_201506_mean <- cellStats(SEVIER_P_201506, mean)
SEVIER_P_201507_mean <- cellStats(SEVIER_P_201507, mean)
SEVIER_P_201508_mean <- cellStats(SEVIER_P_201508, mean)
SEVIER_P_201509_mean <- cellStats(SEVIER_P_201509, mean)
SEVIER_P_201510_mean <- cellStats(SEVIER_P_201510, mean)
SEVIER_P_201511_mean <- cellStats(SEVIER_P_201511, mean)
SEVIER_P_201512_mean <- cellStats(SEVIER_P_201512, mean)

#2016
SEVIER_P_201601_mean <- cellStats(SEVIER_P_201601, mean)
SEVIER_P_201602_mean <- cellStats(SEVIER_P_201602, mean)
SEVIER_P_201603_mean <- cellStats(SEVIER_P_201603, mean)
SEVIER_P_201604_mean <- cellStats(SEVIER_P_201604, mean)
SEVIER_P_201605_mean <- cellStats(SEVIER_P_201605, mean)
SEVIER_P_201606_mean <- cellStats(SEVIER_P_201606, mean)
SEVIER_P_201607_mean <- cellStats(SEVIER_P_201607, mean)
SEVIER_P_201608_mean <- cellStats(SEVIER_P_201608, mean)
SEVIER_P_201609_mean <- cellStats(SEVIER_P_201609, mean)
SEVIER_P_201610_mean <- cellStats(SEVIER_P_201610, mean)
SEVIER_P_201611_mean <- cellStats(SEVIER_P_201611, mean)
SEVIER_P_201612_mean <- cellStats(SEVIER_P_201612, mean)

#2017
SEVIER_P_201701_mean <- cellStats(SEVIER_P_201701, mean)
SEVIER_P_201702_mean <- cellStats(SEVIER_P_201702, mean)
SEVIER_P_201703_mean <- cellStats(SEVIER_P_201703, mean)
SEVIER_P_201704_mean <- cellStats(SEVIER_P_201704, mean)
SEVIER_P_201705_mean <- cellStats(SEVIER_P_201705, mean)
SEVIER_P_201706_mean <- cellStats(SEVIER_P_201706, mean)
SEVIER_P_201707_mean <- cellStats(SEVIER_P_201707, mean)
SEVIER_P_201708_mean <- cellStats(SEVIER_P_201708, mean)
SEVIER_P_201709_mean <- cellStats(SEVIER_P_201709, mean)
SEVIER_P_201710_mean <- cellStats(SEVIER_P_201710, mean)
SEVIER_P_201711_mean <- cellStats(SEVIER_P_201711, mean)
SEVIER_P_201712_mean <- cellStats(SEVIER_P_201712, mean)

#2018
SEVIER_P_201801_mean <- cellStats(SEVIER_P_201801, mean)
SEVIER_P_201802_mean <- cellStats(SEVIER_P_201802, mean)
SEVIER_P_201803_mean <- cellStats(SEVIER_P_201803, mean)
SEVIER_P_201804_mean <- cellStats(SEVIER_P_201804, mean)
SEVIER_P_201805_mean <- cellStats(SEVIER_P_201805, mean)
SEVIER_P_201806_mean <- cellStats(SEVIER_P_201806, mean)
SEVIER_P_201807_mean <- cellStats(SEVIER_P_201807, mean)
SEVIER_P_201808_mean <- cellStats(SEVIER_P_201808, mean)
SEVIER_P_201809_mean <- cellStats(SEVIER_P_201809, mean)
SEVIER_P_201810_mean <- cellStats(SEVIER_P_201810, mean)
SEVIER_P_201811_mean <- cellStats(SEVIER_P_201811, mean)
SEVIER_P_201812_mean <- cellStats(SEVIER_P_201812, mean)

# SUMMIT

#2000
SUMMIT_P_200001 <- crop(P_200001, SUMMIT) 
SUMMIT_P_200002 <- crop(P_200002, SUMMIT)
SUMMIT_P_200003 <- crop(P_200003, SUMMIT)
SUMMIT_P_200004 <- crop(P_200004, SUMMIT)
SUMMIT_P_200005 <- crop(P_200005, SUMMIT)
SUMMIT_P_200006 <- crop(P_200006, SUMMIT)  
SUMMIT_P_200007 <- crop(P_200007, SUMMIT)  
SUMMIT_P_200008 <- crop(P_200008, SUMMIT)  
SUMMIT_P_200009 <- crop(P_200009, SUMMIT)  
SUMMIT_P_200010 <- crop(P_200010, SUMMIT)  
SUMMIT_P_200011 <- crop(P_200011, SUMMIT)  
SUMMIT_P_200012 <- crop(P_200012, SUMMIT)  
#2001
SUMMIT_P_200101 <- crop(P_200101, SUMMIT) 
SUMMIT_P_200102 <- crop(P_200102, SUMMIT)
SUMMIT_P_200103 <- crop(P_200103, SUMMIT)
SUMMIT_P_200104 <- crop(P_200104, SUMMIT)
SUMMIT_P_200105 <- crop(P_200105, SUMMIT)
SUMMIT_P_200106 <- crop(P_200106, SUMMIT)  
SUMMIT_P_200107 <- crop(P_200107, SUMMIT)  
SUMMIT_P_200108 <- crop(P_200108, SUMMIT)  
SUMMIT_P_200109 <- crop(P_200109, SUMMIT)  
SUMMIT_P_200110 <- crop(P_200110, SUMMIT)  
SUMMIT_P_200111 <- crop(P_200111, SUMMIT)  
SUMMIT_P_200112 <- crop(P_200112, SUMMIT)  

#2002
SUMMIT_P_200201 <- crop(P_200201, SUMMIT) 
SUMMIT_P_200202 <- crop(P_200202, SUMMIT)
SUMMIT_P_200203 <- crop(P_200203, SUMMIT)
SUMMIT_P_200204 <- crop(P_200204, SUMMIT)
SUMMIT_P_200205 <- crop(P_200205, SUMMIT)
SUMMIT_P_200206 <- crop(P_200206, SUMMIT)  
SUMMIT_P_200207 <- crop(P_200207, SUMMIT)  
SUMMIT_P_200208 <- crop(P_200208, SUMMIT)  
SUMMIT_P_200209 <- crop(P_200209, SUMMIT)  
SUMMIT_P_200210 <- crop(P_200210, SUMMIT)  
SUMMIT_P_200211 <- crop(P_200211, SUMMIT)  
SUMMIT_P_200212 <- crop(P_200212, SUMMIT)  
#2003
SUMMIT_P_200301 <- crop(P_200301, SUMMIT) 
SUMMIT_P_200302 <- crop(P_200302, SUMMIT)
SUMMIT_P_200303 <- crop(P_200303, SUMMIT)
SUMMIT_P_200304 <- crop(P_200304, SUMMIT)
SUMMIT_P_200305 <- crop(P_200305, SUMMIT)
SUMMIT_P_200306 <- crop(P_200306, SUMMIT)  
SUMMIT_P_200307 <- crop(P_200307, SUMMIT)  
SUMMIT_P_200308 <- crop(P_200308, SUMMIT)  
SUMMIT_P_200309 <- crop(P_200309, SUMMIT)  
SUMMIT_P_200310 <- crop(P_200310, SUMMIT)  
SUMMIT_P_200311 <- crop(P_200311, SUMMIT)  
SUMMIT_P_200312 <- crop(P_200312, SUMMIT)  
#2004
SUMMIT_P_200401 <- crop(P_200401, SUMMIT) 
SUMMIT_P_200402 <- crop(P_200402, SUMMIT)
SUMMIT_P_200403 <- crop(P_200403, SUMMIT)
SUMMIT_P_200404 <- crop(P_200404, SUMMIT)
SUMMIT_P_200405 <- crop(P_200405, SUMMIT)
SUMMIT_P_200406 <- crop(P_200406, SUMMIT)  
SUMMIT_P_200407 <- crop(P_200407, SUMMIT)  
SUMMIT_P_200408 <- crop(P_200408, SUMMIT)  
SUMMIT_P_200409 <- crop(P_200409, SUMMIT)  
SUMMIT_P_200410 <- crop(P_200410, SUMMIT)  
SUMMIT_P_200411 <- crop(P_200411, SUMMIT)  
SUMMIT_P_200412 <- crop(P_200412, SUMMIT)  
#2005
SUMMIT_P_200501 <- crop(P_200501, SUMMIT) 
SUMMIT_P_200502 <- crop(P_200502, SUMMIT)
SUMMIT_P_200503 <- crop(P_200503, SUMMIT)
SUMMIT_P_200504 <- crop(P_200504, SUMMIT)
SUMMIT_P_200505 <- crop(P_200505, SUMMIT)
SUMMIT_P_200506 <- crop(P_200506, SUMMIT)  
SUMMIT_P_200507 <- crop(P_200507, SUMMIT)  
SUMMIT_P_200508 <- crop(P_200508, SUMMIT)  
SUMMIT_P_200509 <- crop(P_200509, SUMMIT)  
SUMMIT_P_200510 <- crop(P_200510, SUMMIT)  
SUMMIT_P_200511 <- crop(P_200511, SUMMIT)  
SUMMIT_P_200512 <- crop(P_200512, SUMMIT)  
#2006
SUMMIT_P_200601 <- crop(P_200601, SUMMIT) 
SUMMIT_P_200602 <- crop(P_200602, SUMMIT)
SUMMIT_P_200603 <- crop(P_200603, SUMMIT)
SUMMIT_P_200604 <- crop(P_200604, SUMMIT)
SUMMIT_P_200605 <- crop(P_200605, SUMMIT)
SUMMIT_P_200606 <- crop(P_200606, SUMMIT)  
SUMMIT_P_200607 <- crop(P_200607, SUMMIT)  
SUMMIT_P_200608 <- crop(P_200608, SUMMIT)  
SUMMIT_P_200609 <- crop(P_200609, SUMMIT)  
SUMMIT_P_200610 <- crop(P_200610, SUMMIT)  
SUMMIT_P_200611 <- crop(P_200611, SUMMIT)  
SUMMIT_P_200612 <- crop(P_200612, SUMMIT)  
#2007
SUMMIT_P_200701 <- crop(P_200701, SUMMIT) 
SUMMIT_P_200702 <- crop(P_200702, SUMMIT)
SUMMIT_P_200703 <- crop(P_200703, SUMMIT)
SUMMIT_P_200704 <- crop(P_200704, SUMMIT)
SUMMIT_P_200705 <- crop(P_200705, SUMMIT)
SUMMIT_P_200706 <- crop(P_200706, SUMMIT)  
SUMMIT_P_200707 <- crop(P_200707, SUMMIT)  
SUMMIT_P_200708 <- crop(P_200708, SUMMIT)  
SUMMIT_P_200709 <- crop(P_200709, SUMMIT)  
SUMMIT_P_200710 <- crop(P_200710, SUMMIT)  
SUMMIT_P_200711 <- crop(P_200711, SUMMIT)  
SUMMIT_P_200712 <- crop(P_200712, SUMMIT)  
#2008
SUMMIT_P_200801 <- crop(P_200801, SUMMIT) 
SUMMIT_P_200802 <- crop(P_200802, SUMMIT)
SUMMIT_P_200803 <- crop(P_200803, SUMMIT)
SUMMIT_P_200804 <- crop(P_200804, SUMMIT)
SUMMIT_P_200805 <- crop(P_200805, SUMMIT)
SUMMIT_P_200806 <- crop(P_200806, SUMMIT)  
SUMMIT_P_200807 <- crop(P_200807, SUMMIT)  
SUMMIT_P_200808 <- crop(P_200808, SUMMIT)  
SUMMIT_P_200809 <- crop(P_200809, SUMMIT)  
SUMMIT_P_200810 <- crop(P_200810, SUMMIT)  
SUMMIT_P_200811 <- crop(P_200811, SUMMIT)  
SUMMIT_P_200812 <- crop(P_200812, SUMMIT)  
#2009
SUMMIT_P_200901 <- crop(P_200901, SUMMIT) 
SUMMIT_P_200902 <- crop(P_200902, SUMMIT)
SUMMIT_P_200903 <- crop(P_200903, SUMMIT)
SUMMIT_P_200904 <- crop(P_200904, SUMMIT)
SUMMIT_P_200905 <- crop(P_200905, SUMMIT)
SUMMIT_P_200906 <- crop(P_200906, SUMMIT)  
SUMMIT_P_200907 <- crop(P_200907, SUMMIT)  
SUMMIT_P_200908 <- crop(P_200908, SUMMIT)  
SUMMIT_P_200909 <- crop(P_200909, SUMMIT)  
SUMMIT_P_200910 <- crop(P_200910, SUMMIT)  
SUMMIT_P_200911 <- crop(P_200911, SUMMIT)  
SUMMIT_P_200912 <- crop(P_200912, SUMMIT)  
#2010
SUMMIT_P_201001 <- crop(P_201001, SUMMIT) 
SUMMIT_P_201002 <- crop(P_201002, SUMMIT)
SUMMIT_P_201003 <- crop(P_201003, SUMMIT)
SUMMIT_P_201004 <- crop(P_201004, SUMMIT)
SUMMIT_P_201005 <- crop(P_201005, SUMMIT)
SUMMIT_P_201006 <- crop(P_201006, SUMMIT)  
SUMMIT_P_201007 <- crop(P_201007, SUMMIT)  
SUMMIT_P_201008 <- crop(P_201008, SUMMIT)  
SUMMIT_P_201009 <- crop(P_201009, SUMMIT)  
SUMMIT_P_201010 <- crop(P_201010, SUMMIT)  
SUMMIT_P_201011 <- crop(P_201011, SUMMIT)  
SUMMIT_P_201012 <- crop(P_201012, SUMMIT)  
#2011
SUMMIT_P_201101 <- crop(P_201101, SUMMIT) 
SUMMIT_P_201102 <- crop(P_201102, SUMMIT)
SUMMIT_P_201103 <- crop(P_201103, SUMMIT)
SUMMIT_P_201104 <- crop(P_201104, SUMMIT)
SUMMIT_P_201105 <- crop(P_201105, SUMMIT)
SUMMIT_P_201106 <- crop(P_201106, SUMMIT)  
SUMMIT_P_201107 <- crop(P_201107, SUMMIT)  
SUMMIT_P_201108 <- crop(P_201108, SUMMIT)  
SUMMIT_P_201109 <- crop(P_201109, SUMMIT)  
SUMMIT_P_201110 <- crop(P_201110, SUMMIT)  
SUMMIT_P_201111 <- crop(P_201111, SUMMIT)  
SUMMIT_P_201112 <- crop(P_201112, SUMMIT)  
#2012
SUMMIT_P_201201 <- crop(P_201201, SUMMIT) 
SUMMIT_P_201202 <- crop(P_201202, SUMMIT)
SUMMIT_P_201203 <- crop(P_201203, SUMMIT)
SUMMIT_P_201204 <- crop(P_201204, SUMMIT)
SUMMIT_P_201205 <- crop(P_201205, SUMMIT)
SUMMIT_P_201206 <- crop(P_201206, SUMMIT)  
SUMMIT_P_201207 <- crop(P_201207, SUMMIT)  
SUMMIT_P_201208 <- crop(P_201208, SUMMIT)  
SUMMIT_P_201209 <- crop(P_201209, SUMMIT)  
SUMMIT_P_201210 <- crop(P_201210, SUMMIT)  
SUMMIT_P_201211 <- crop(P_201211, SUMMIT)  
SUMMIT_P_201212 <- crop(P_201212, SUMMIT)  
#2013
SUMMIT_P_201301 <- crop(P_201301, SUMMIT) 
SUMMIT_P_201302 <- crop(P_201302, SUMMIT)
SUMMIT_P_201303 <- crop(P_201303, SUMMIT)
SUMMIT_P_201304 <- crop(P_201304, SUMMIT)
SUMMIT_P_201305 <- crop(P_201305, SUMMIT)
SUMMIT_P_201306 <- crop(P_201306, SUMMIT)  
SUMMIT_P_201307 <- crop(P_201307, SUMMIT)  
SUMMIT_P_201308 <- crop(P_201308, SUMMIT)  
SUMMIT_P_201309 <- crop(P_201309, SUMMIT)  
SUMMIT_P_201310 <- crop(P_201310, SUMMIT)  
SUMMIT_P_201311 <- crop(P_201311, SUMMIT)  
SUMMIT_P_201312 <- crop(P_201312, SUMMIT)  
#2014
SUMMIT_P_201401 <- crop(P_201401, SUMMIT) 
SUMMIT_P_201402 <- crop(P_201402, SUMMIT)
SUMMIT_P_201403 <- crop(P_201403, SUMMIT)
SUMMIT_P_201404 <- crop(P_201404, SUMMIT)
SUMMIT_P_201405 <- crop(P_201405, SUMMIT)
SUMMIT_P_201406 <- crop(P_201406, SUMMIT)  
SUMMIT_P_201407 <- crop(P_201407, SUMMIT)  
SUMMIT_P_201408 <- crop(P_201408, SUMMIT)  
SUMMIT_P_201409 <- crop(P_201409, SUMMIT)  
SUMMIT_P_201410 <- crop(P_201410, SUMMIT)  
SUMMIT_P_201411 <- crop(P_201411, SUMMIT)  
SUMMIT_P_201412 <- crop(P_201412, SUMMIT)  
#2015
SUMMIT_P_201501 <- crop(P_201501, SUMMIT) 
SUMMIT_P_201502 <- crop(P_201502, SUMMIT)
SUMMIT_P_201503 <- crop(P_201503, SUMMIT)
SUMMIT_P_201504 <- crop(P_201504, SUMMIT)
SUMMIT_P_201505 <- crop(P_201505, SUMMIT)
SUMMIT_P_201506 <- crop(P_201506, SUMMIT)  
SUMMIT_P_201507 <- crop(P_201507, SUMMIT)  
SUMMIT_P_201508 <- crop(P_201508, SUMMIT)  
SUMMIT_P_201509 <- crop(P_201509, SUMMIT)  
SUMMIT_P_201510 <- crop(P_201510, SUMMIT)  
SUMMIT_P_201511 <- crop(P_201511, SUMMIT)  
SUMMIT_P_201512 <- crop(P_201512, SUMMIT)  
#2016
SUMMIT_P_201601 <- crop(P_201601, SUMMIT) 
SUMMIT_P_201602 <- crop(P_201602, SUMMIT)
SUMMIT_P_201603 <- crop(P_201603, SUMMIT)
SUMMIT_P_201604 <- crop(P_201604, SUMMIT)
SUMMIT_P_201605 <- crop(P_201605, SUMMIT)
SUMMIT_P_201606 <- crop(P_201606, SUMMIT)  
SUMMIT_P_201607 <- crop(P_201607, SUMMIT)  
SUMMIT_P_201608 <- crop(P_201608, SUMMIT)  
SUMMIT_P_201609 <- crop(P_201609, SUMMIT)  
SUMMIT_P_201610 <- crop(P_201610, SUMMIT)  
SUMMIT_P_201611 <- crop(P_201611, SUMMIT)  
SUMMIT_P_201612 <- crop(P_201612, SUMMIT)  
#2017
SUMMIT_P_201701 <- crop(P_201701, SUMMIT) 
SUMMIT_P_201702 <- crop(P_201702, SUMMIT)
SUMMIT_P_201703 <- crop(P_201703, SUMMIT)
SUMMIT_P_201704 <- crop(P_201704, SUMMIT)
SUMMIT_P_201705 <- crop(P_201705, SUMMIT)
SUMMIT_P_201706 <- crop(P_201706, SUMMIT)  
SUMMIT_P_201707 <- crop(P_201707, SUMMIT)  
SUMMIT_P_201708 <- crop(P_201708, SUMMIT)  
SUMMIT_P_201709 <- crop(P_201709, SUMMIT)  
SUMMIT_P_201710 <- crop(P_201710, SUMMIT)  
SUMMIT_P_201711 <- crop(P_201711, SUMMIT)  
SUMMIT_P_201712 <- crop(P_201712, SUMMIT)  

#2018

SUMMIT_P_201801 <- crop(P_201801, SUMMIT) 
SUMMIT_P_201802 <- crop(P_201802, SUMMIT)
SUMMIT_P_201803 <- crop(P_201803, SUMMIT)
SUMMIT_P_201804 <- crop(P_201804, SUMMIT)
SUMMIT_P_201805 <- crop(P_201805, SUMMIT)
SUMMIT_P_201806 <- crop(P_201806, SUMMIT)  
SUMMIT_P_201807 <- crop(P_201807, SUMMIT)  
SUMMIT_P_201808 <- crop(P_201808, SUMMIT)  
SUMMIT_P_201809 <- crop(P_201809, SUMMIT)  
SUMMIT_P_201810 <- crop(P_201810, SUMMIT)  
SUMMIT_P_201811 <- crop(P_201811, SUMMIT)  
SUMMIT_P_201812 <- crop(P_201812, SUMMIT)  


# Mean Monthly Precipitation
#2000
SUMMIT_P_200001_mean <- cellStats(SUMMIT_P_200001, mean)
SUMMIT_P_200002_mean <- cellStats(SUMMIT_P_200002, mean)
SUMMIT_P_200003_mean <- cellStats(SUMMIT_P_200003, mean)
SUMMIT_P_200004_mean <- cellStats(SUMMIT_P_200004, mean)
SUMMIT_P_200005_mean <- cellStats(SUMMIT_P_200005, mean)
SUMMIT_P_200006_mean <- cellStats(SUMMIT_P_200006, mean)
SUMMIT_P_200007_mean <- cellStats(SUMMIT_P_200007, mean)
SUMMIT_P_200008_mean <- cellStats(SUMMIT_P_200008, mean)
SUMMIT_P_200009_mean <- cellStats(SUMMIT_P_200009, mean)
SUMMIT_P_200010_mean <- cellStats(SUMMIT_P_200010, mean)
SUMMIT_P_200011_mean <- cellStats(SUMMIT_P_200011, mean)
SUMMIT_P_200012_mean <- cellStats(SUMMIT_P_200012, mean)
#2001
SUMMIT_P_200101_mean <- cellStats(SUMMIT_P_200101, mean)
SUMMIT_P_200102_mean <- cellStats(SUMMIT_P_200102, mean)
SUMMIT_P_200103_mean <- cellStats(SUMMIT_P_200103, mean)
SUMMIT_P_200104_mean <- cellStats(SUMMIT_P_200104, mean)
SUMMIT_P_200105_mean <- cellStats(SUMMIT_P_200105, mean)
SUMMIT_P_200106_mean <- cellStats(SUMMIT_P_200106, mean)
SUMMIT_P_200107_mean <- cellStats(SUMMIT_P_200107, mean)
SUMMIT_P_200108_mean <- cellStats(SUMMIT_P_200108, mean)
SUMMIT_P_200109_mean <- cellStats(SUMMIT_P_200109, mean)
SUMMIT_P_200110_mean <- cellStats(SUMMIT_P_200110, mean)
SUMMIT_P_200111_mean <- cellStats(SUMMIT_P_200111, mean)
SUMMIT_P_200112_mean <- cellStats(SUMMIT_P_200112, mean)

#2002
SUMMIT_P_200201_mean <- cellStats(SUMMIT_P_200201, mean)
SUMMIT_P_200202_mean <- cellStats(SUMMIT_P_200202, mean)
SUMMIT_P_200203_mean <- cellStats(SUMMIT_P_200203, mean)
SUMMIT_P_200204_mean <- cellStats(SUMMIT_P_200204, mean)
SUMMIT_P_200205_mean <- cellStats(SUMMIT_P_200205, mean)
SUMMIT_P_200206_mean <- cellStats(SUMMIT_P_200206, mean)
SUMMIT_P_200207_mean <- cellStats(SUMMIT_P_200207, mean)
SUMMIT_P_200208_mean <- cellStats(SUMMIT_P_200208, mean)
SUMMIT_P_200209_mean <- cellStats(SUMMIT_P_200209, mean)
SUMMIT_P_200210_mean <- cellStats(SUMMIT_P_200210, mean)
SUMMIT_P_200211_mean <- cellStats(SUMMIT_P_200211, mean)
SUMMIT_P_200212_mean <- cellStats(SUMMIT_P_200212, mean)

#2003
SUMMIT_P_200301_mean <- cellStats(SUMMIT_P_200301, mean)
SUMMIT_P_200302_mean <- cellStats(SUMMIT_P_200302, mean)
SUMMIT_P_200303_mean <- cellStats(SUMMIT_P_200303, mean)
SUMMIT_P_200304_mean <- cellStats(SUMMIT_P_200304, mean)
SUMMIT_P_200305_mean <- cellStats(SUMMIT_P_200305, mean)
SUMMIT_P_200306_mean <- cellStats(SUMMIT_P_200306, mean)
SUMMIT_P_200307_mean <- cellStats(SUMMIT_P_200307, mean)
SUMMIT_P_200308_mean <- cellStats(SUMMIT_P_200308, mean)
SUMMIT_P_200309_mean <- cellStats(SUMMIT_P_200309, mean)
SUMMIT_P_200310_mean <- cellStats(SUMMIT_P_200310, mean)
SUMMIT_P_200311_mean <- cellStats(SUMMIT_P_200311, mean)
SUMMIT_P_200312_mean <- cellStats(SUMMIT_P_200312, mean)

#2004

SUMMIT_P_200401_mean <- cellStats(SUMMIT_P_200401, mean)
SUMMIT_P_200402_mean <- cellStats(SUMMIT_P_200402, mean)
SUMMIT_P_200403_mean <- cellStats(SUMMIT_P_200403, mean)
SUMMIT_P_200404_mean <- cellStats(SUMMIT_P_200404, mean)
SUMMIT_P_200405_mean <- cellStats(SUMMIT_P_200405, mean)
SUMMIT_P_200406_mean <- cellStats(SUMMIT_P_200406, mean)
SUMMIT_P_200407_mean <- cellStats(SUMMIT_P_200407, mean)
SUMMIT_P_200408_mean <- cellStats(SUMMIT_P_200408, mean)
SUMMIT_P_200409_mean <- cellStats(SUMMIT_P_200409, mean)
SUMMIT_P_200410_mean <- cellStats(SUMMIT_P_200410, mean)
SUMMIT_P_200411_mean <- cellStats(SUMMIT_P_200411, mean)
SUMMIT_P_200412_mean <- cellStats(SUMMIT_P_200412, mean)

#2005

SUMMIT_P_200501_mean <- cellStats(SUMMIT_P_200501, mean)
SUMMIT_P_200502_mean <- cellStats(SUMMIT_P_200502, mean)
SUMMIT_P_200503_mean <- cellStats(SUMMIT_P_200503, mean)
SUMMIT_P_200504_mean <- cellStats(SUMMIT_P_200504, mean)
SUMMIT_P_200505_mean <- cellStats(SUMMIT_P_200505, mean)
SUMMIT_P_200506_mean <- cellStats(SUMMIT_P_200506, mean)
SUMMIT_P_200507_mean <- cellStats(SUMMIT_P_200507, mean)
SUMMIT_P_200508_mean <- cellStats(SUMMIT_P_200508, mean)
SUMMIT_P_200509_mean <- cellStats(SUMMIT_P_200509, mean)
SUMMIT_P_200510_mean <- cellStats(SUMMIT_P_200510, mean)
SUMMIT_P_200511_mean <- cellStats(SUMMIT_P_200511, mean)
SUMMIT_P_200512_mean <- cellStats(SUMMIT_P_200512, mean)

#2006

SUMMIT_P_200601_mean <- cellStats(SUMMIT_P_200601, mean)
SUMMIT_P_200602_mean <- cellStats(SUMMIT_P_200602, mean)
SUMMIT_P_200603_mean <- cellStats(SUMMIT_P_200603, mean)
SUMMIT_P_200604_mean <- cellStats(SUMMIT_P_200604, mean)
SUMMIT_P_200605_mean <- cellStats(SUMMIT_P_200605, mean)
SUMMIT_P_200606_mean <- cellStats(SUMMIT_P_200606, mean)
SUMMIT_P_200607_mean <- cellStats(SUMMIT_P_200607, mean)
SUMMIT_P_200608_mean <- cellStats(SUMMIT_P_200608, mean)
SUMMIT_P_200609_mean <- cellStats(SUMMIT_P_200609, mean)
SUMMIT_P_200610_mean <- cellStats(SUMMIT_P_200610, mean)
SUMMIT_P_200611_mean <- cellStats(SUMMIT_P_200611, mean)
SUMMIT_P_200612_mean <- cellStats(SUMMIT_P_200612, mean)

#2007

SUMMIT_P_200701_mean <- cellStats(SUMMIT_P_200701, mean)
SUMMIT_P_200702_mean <- cellStats(SUMMIT_P_200702, mean)
SUMMIT_P_200703_mean <- cellStats(SUMMIT_P_200703, mean)
SUMMIT_P_200704_mean <- cellStats(SUMMIT_P_200704, mean)
SUMMIT_P_200705_mean <- cellStats(SUMMIT_P_200705, mean)
SUMMIT_P_200706_mean <- cellStats(SUMMIT_P_200706, mean)
SUMMIT_P_200707_mean <- cellStats(SUMMIT_P_200707, mean)
SUMMIT_P_200708_mean <- cellStats(SUMMIT_P_200708, mean)
SUMMIT_P_200709_mean <- cellStats(SUMMIT_P_200709, mean)
SUMMIT_P_200710_mean <- cellStats(SUMMIT_P_200710, mean)
SUMMIT_P_200711_mean <- cellStats(SUMMIT_P_200711, mean)
SUMMIT_P_200712_mean <- cellStats(SUMMIT_P_200712, mean)

#2008

SUMMIT_P_200801_mean <- cellStats(SUMMIT_P_200801, mean)
SUMMIT_P_200802_mean <- cellStats(SUMMIT_P_200802, mean)
SUMMIT_P_200803_mean <- cellStats(SUMMIT_P_200803, mean)
SUMMIT_P_200804_mean <- cellStats(SUMMIT_P_200804, mean)
SUMMIT_P_200805_mean <- cellStats(SUMMIT_P_200805, mean)
SUMMIT_P_200806_mean <- cellStats(SUMMIT_P_200806, mean)
SUMMIT_P_200807_mean <- cellStats(SUMMIT_P_200807, mean)
SUMMIT_P_200808_mean <- cellStats(SUMMIT_P_200808, mean)
SUMMIT_P_200809_mean <- cellStats(SUMMIT_P_200809, mean)
SUMMIT_P_200810_mean <- cellStats(SUMMIT_P_200810, mean)
SUMMIT_P_200811_mean <- cellStats(SUMMIT_P_200811, mean)
SUMMIT_P_200812_mean <- cellStats(SUMMIT_P_200812, mean)

#2009

SUMMIT_P_200901_mean <- cellStats(SUMMIT_P_200901, mean)
SUMMIT_P_200902_mean <- cellStats(SUMMIT_P_200902, mean)
SUMMIT_P_200903_mean <- cellStats(SUMMIT_P_200903, mean)
SUMMIT_P_200904_mean <- cellStats(SUMMIT_P_200904, mean)
SUMMIT_P_200905_mean <- cellStats(SUMMIT_P_200905, mean)
SUMMIT_P_200906_mean <- cellStats(SUMMIT_P_200906, mean)
SUMMIT_P_200907_mean <- cellStats(SUMMIT_P_200907, mean)
SUMMIT_P_200908_mean <- cellStats(SUMMIT_P_200908, mean)
SUMMIT_P_200909_mean <- cellStats(SUMMIT_P_200909, mean)
SUMMIT_P_200910_mean <- cellStats(SUMMIT_P_200910, mean)
SUMMIT_P_200911_mean <- cellStats(SUMMIT_P_200911, mean)
SUMMIT_P_200912_mean <- cellStats(SUMMIT_P_200912, mean)

#2010

SUMMIT_P_201001_mean <- cellStats(SUMMIT_P_201001, mean)
SUMMIT_P_201002_mean <- cellStats(SUMMIT_P_201002, mean)
SUMMIT_P_201003_mean <- cellStats(SUMMIT_P_201003, mean)
SUMMIT_P_201004_mean <- cellStats(SUMMIT_P_201004, mean)
SUMMIT_P_201005_mean <- cellStats(SUMMIT_P_201005, mean)
SUMMIT_P_201006_mean <- cellStats(SUMMIT_P_201006, mean)
SUMMIT_P_201007_mean <- cellStats(SUMMIT_P_201007, mean)
SUMMIT_P_201008_mean <- cellStats(SUMMIT_P_201008, mean)
SUMMIT_P_201009_mean <- cellStats(SUMMIT_P_201009, mean)
SUMMIT_P_201010_mean <- cellStats(SUMMIT_P_201010, mean)
SUMMIT_P_201011_mean <- cellStats(SUMMIT_P_201011, mean)
SUMMIT_P_201012_mean <- cellStats(SUMMIT_P_201012, mean)

#2011

SUMMIT_P_201101_mean <- cellStats(SUMMIT_P_201101, mean)
SUMMIT_P_201102_mean <- cellStats(SUMMIT_P_201102, mean)
SUMMIT_P_201103_mean <- cellStats(SUMMIT_P_201103, mean)
SUMMIT_P_201104_mean <- cellStats(SUMMIT_P_201104, mean)
SUMMIT_P_201105_mean <- cellStats(SUMMIT_P_201105, mean)
SUMMIT_P_201106_mean <- cellStats(SUMMIT_P_201106, mean)
SUMMIT_P_201107_mean <- cellStats(SUMMIT_P_201107, mean)
SUMMIT_P_201108_mean <- cellStats(SUMMIT_P_201108, mean)
SUMMIT_P_201109_mean <- cellStats(SUMMIT_P_201109, mean)
SUMMIT_P_201110_mean <- cellStats(SUMMIT_P_201110, mean)
SUMMIT_P_201111_mean <- cellStats(SUMMIT_P_201111, mean)
SUMMIT_P_201112_mean <- cellStats(SUMMIT_P_201112, mean)

#2012
SUMMIT_P_201201_mean <- cellStats(SUMMIT_P_201201, mean)
SUMMIT_P_201202_mean <- cellStats(SUMMIT_P_201202, mean)
SUMMIT_P_201203_mean <- cellStats(SUMMIT_P_201203, mean)
SUMMIT_P_201204_mean <- cellStats(SUMMIT_P_201204, mean)
SUMMIT_P_201205_mean <- cellStats(SUMMIT_P_201205, mean)
SUMMIT_P_201206_mean <- cellStats(SUMMIT_P_201206, mean)
SUMMIT_P_201207_mean <- cellStats(SUMMIT_P_201207, mean)
SUMMIT_P_201208_mean <- cellStats(SUMMIT_P_201208, mean)
SUMMIT_P_201209_mean <- cellStats(SUMMIT_P_201209, mean)
SUMMIT_P_201210_mean <- cellStats(SUMMIT_P_201210, mean)
SUMMIT_P_201211_mean <- cellStats(SUMMIT_P_201211, mean)
SUMMIT_P_201212_mean <- cellStats(SUMMIT_P_201212, mean)

#2013
SUMMIT_P_201301_mean <- cellStats(SUMMIT_P_201301, mean)
SUMMIT_P_201302_mean <- cellStats(SUMMIT_P_201302, mean)
SUMMIT_P_201303_mean <- cellStats(SUMMIT_P_201303, mean)
SUMMIT_P_201304_mean <- cellStats(SUMMIT_P_201304, mean)
SUMMIT_P_201305_mean <- cellStats(SUMMIT_P_201305, mean)
SUMMIT_P_201306_mean <- cellStats(SUMMIT_P_201306, mean)
SUMMIT_P_201307_mean <- cellStats(SUMMIT_P_201307, mean)
SUMMIT_P_201308_mean <- cellStats(SUMMIT_P_201308, mean)
SUMMIT_P_201309_mean <- cellStats(SUMMIT_P_201309, mean)
SUMMIT_P_201310_mean <- cellStats(SUMMIT_P_201310, mean)
SUMMIT_P_201311_mean <- cellStats(SUMMIT_P_201311, mean)
SUMMIT_P_201312_mean <- cellStats(SUMMIT_P_201312, mean)

#2014
SUMMIT_P_201401_mean <- cellStats(SUMMIT_P_201401, mean)
SUMMIT_P_201402_mean <- cellStats(SUMMIT_P_201402, mean)
SUMMIT_P_201403_mean <- cellStats(SUMMIT_P_201403, mean)
SUMMIT_P_201404_mean <- cellStats(SUMMIT_P_201404, mean)
SUMMIT_P_201405_mean <- cellStats(SUMMIT_P_201405, mean)
SUMMIT_P_201406_mean <- cellStats(SUMMIT_P_201406, mean)
SUMMIT_P_201407_mean <- cellStats(SUMMIT_P_201407, mean)
SUMMIT_P_201408_mean <- cellStats(SUMMIT_P_201408, mean)
SUMMIT_P_201409_mean <- cellStats(SUMMIT_P_201409, mean)
SUMMIT_P_201410_mean <- cellStats(SUMMIT_P_201410, mean)
SUMMIT_P_201411_mean <- cellStats(SUMMIT_P_201411, mean)
SUMMIT_P_201412_mean <- cellStats(SUMMIT_P_201412, mean)

#2015
SUMMIT_P_201501_mean <- cellStats(SUMMIT_P_201501, mean)
SUMMIT_P_201502_mean <- cellStats(SUMMIT_P_201502, mean)
SUMMIT_P_201503_mean <- cellStats(SUMMIT_P_201503, mean)
SUMMIT_P_201504_mean <- cellStats(SUMMIT_P_201504, mean)
SUMMIT_P_201505_mean <- cellStats(SUMMIT_P_201505, mean)
SUMMIT_P_201506_mean <- cellStats(SUMMIT_P_201506, mean)
SUMMIT_P_201507_mean <- cellStats(SUMMIT_P_201507, mean)
SUMMIT_P_201508_mean <- cellStats(SUMMIT_P_201508, mean)
SUMMIT_P_201509_mean <- cellStats(SUMMIT_P_201509, mean)
SUMMIT_P_201510_mean <- cellStats(SUMMIT_P_201510, mean)
SUMMIT_P_201511_mean <- cellStats(SUMMIT_P_201511, mean)
SUMMIT_P_201512_mean <- cellStats(SUMMIT_P_201512, mean)

#2016
SUMMIT_P_201601_mean <- cellStats(SUMMIT_P_201601, mean)
SUMMIT_P_201602_mean <- cellStats(SUMMIT_P_201602, mean)
SUMMIT_P_201603_mean <- cellStats(SUMMIT_P_201603, mean)
SUMMIT_P_201604_mean <- cellStats(SUMMIT_P_201604, mean)
SUMMIT_P_201605_mean <- cellStats(SUMMIT_P_201605, mean)
SUMMIT_P_201606_mean <- cellStats(SUMMIT_P_201606, mean)
SUMMIT_P_201607_mean <- cellStats(SUMMIT_P_201607, mean)
SUMMIT_P_201608_mean <- cellStats(SUMMIT_P_201608, mean)
SUMMIT_P_201609_mean <- cellStats(SUMMIT_P_201609, mean)
SUMMIT_P_201610_mean <- cellStats(SUMMIT_P_201610, mean)
SUMMIT_P_201611_mean <- cellStats(SUMMIT_P_201611, mean)
SUMMIT_P_201612_mean <- cellStats(SUMMIT_P_201612, mean)

#2017
SUMMIT_P_201701_mean <- cellStats(SUMMIT_P_201701, mean)
SUMMIT_P_201702_mean <- cellStats(SUMMIT_P_201702, mean)
SUMMIT_P_201703_mean <- cellStats(SUMMIT_P_201703, mean)
SUMMIT_P_201704_mean <- cellStats(SUMMIT_P_201704, mean)
SUMMIT_P_201705_mean <- cellStats(SUMMIT_P_201705, mean)
SUMMIT_P_201706_mean <- cellStats(SUMMIT_P_201706, mean)
SUMMIT_P_201707_mean <- cellStats(SUMMIT_P_201707, mean)
SUMMIT_P_201708_mean <- cellStats(SUMMIT_P_201708, mean)
SUMMIT_P_201709_mean <- cellStats(SUMMIT_P_201709, mean)
SUMMIT_P_201710_mean <- cellStats(SUMMIT_P_201710, mean)
SUMMIT_P_201711_mean <- cellStats(SUMMIT_P_201711, mean)
SUMMIT_P_201712_mean <- cellStats(SUMMIT_P_201712, mean)

#2018
SUMMIT_P_201801_mean <- cellStats(SUMMIT_P_201801, mean)
SUMMIT_P_201802_mean <- cellStats(SUMMIT_P_201802, mean)
SUMMIT_P_201803_mean <- cellStats(SUMMIT_P_201803, mean)
SUMMIT_P_201804_mean <- cellStats(SUMMIT_P_201804, mean)
SUMMIT_P_201805_mean <- cellStats(SUMMIT_P_201805, mean)
SUMMIT_P_201806_mean <- cellStats(SUMMIT_P_201806, mean)
SUMMIT_P_201807_mean <- cellStats(SUMMIT_P_201807, mean)
SUMMIT_P_201808_mean <- cellStats(SUMMIT_P_201808, mean)
SUMMIT_P_201809_mean <- cellStats(SUMMIT_P_201809, mean)
SUMMIT_P_201810_mean <- cellStats(SUMMIT_P_201810, mean)
SUMMIT_P_201811_mean <- cellStats(SUMMIT_P_201811, mean)
SUMMIT_P_201812_mean <- cellStats(SUMMIT_P_201812, mean)

# SAN JUAN

#2000
SAN_JUAN_P_200001 <- crop(P_200001, SAN_JUAN) 
SAN_JUAN_P_200002 <- crop(P_200002, SAN_JUAN)
SAN_JUAN_P_200003 <- crop(P_200003, SAN_JUAN)
SAN_JUAN_P_200004 <- crop(P_200004, SAN_JUAN)
SAN_JUAN_P_200005 <- crop(P_200005, SAN_JUAN)
SAN_JUAN_P_200006 <- crop(P_200006, SAN_JUAN)  
SAN_JUAN_P_200007 <- crop(P_200007, SAN_JUAN)  
SAN_JUAN_P_200008 <- crop(P_200008, SAN_JUAN)  
SAN_JUAN_P_200009 <- crop(P_200009, SAN_JUAN)  
SAN_JUAN_P_200010 <- crop(P_200010, SAN_JUAN)  
SAN_JUAN_P_200011 <- crop(P_200011, SAN_JUAN)  
SAN_JUAN_P_200012 <- crop(P_200012, SAN_JUAN)  
#2001
SAN_JUAN_P_200101 <- crop(P_200101, SAN_JUAN) 
SAN_JUAN_P_200102 <- crop(P_200102, SAN_JUAN)
SAN_JUAN_P_200103 <- crop(P_200103, SAN_JUAN)
SAN_JUAN_P_200104 <- crop(P_200104, SAN_JUAN)
SAN_JUAN_P_200105 <- crop(P_200105, SAN_JUAN)
SAN_JUAN_P_200106 <- crop(P_200106, SAN_JUAN)  
SAN_JUAN_P_200107 <- crop(P_200107, SAN_JUAN)  
SAN_JUAN_P_200108 <- crop(P_200108, SAN_JUAN)  
SAN_JUAN_P_200109 <- crop(P_200109, SAN_JUAN)  
SAN_JUAN_P_200110 <- crop(P_200110, SAN_JUAN)  
SAN_JUAN_P_200111 <- crop(P_200111, SAN_JUAN)  
SAN_JUAN_P_200112 <- crop(P_200112, SAN_JUAN)  

#2002
SAN_JUAN_P_200201 <- crop(P_200201, SAN_JUAN) 
SAN_JUAN_P_200202 <- crop(P_200202, SAN_JUAN)
SAN_JUAN_P_200203 <- crop(P_200203, SAN_JUAN)
SAN_JUAN_P_200204 <- crop(P_200204, SAN_JUAN)
SAN_JUAN_P_200205 <- crop(P_200205, SAN_JUAN)
SAN_JUAN_P_200206 <- crop(P_200206, SAN_JUAN)  
SAN_JUAN_P_200207 <- crop(P_200207, SAN_JUAN)  
SAN_JUAN_P_200208 <- crop(P_200208, SAN_JUAN)  
SAN_JUAN_P_200209 <- crop(P_200209, SAN_JUAN)  
SAN_JUAN_P_200210 <- crop(P_200210, SAN_JUAN)  
SAN_JUAN_P_200211 <- crop(P_200211, SAN_JUAN)  
SAN_JUAN_P_200212 <- crop(P_200212, SAN_JUAN)  
#2003
SAN_JUAN_P_200301 <- crop(P_200301, SAN_JUAN) 
SAN_JUAN_P_200302 <- crop(P_200302, SAN_JUAN)
SAN_JUAN_P_200303 <- crop(P_200303, SAN_JUAN)
SAN_JUAN_P_200304 <- crop(P_200304, SAN_JUAN)
SAN_JUAN_P_200305 <- crop(P_200305, SAN_JUAN)
SAN_JUAN_P_200306 <- crop(P_200306, SAN_JUAN)  
SAN_JUAN_P_200307 <- crop(P_200307, SAN_JUAN)  
SAN_JUAN_P_200308 <- crop(P_200308, SAN_JUAN)  
SAN_JUAN_P_200309 <- crop(P_200309, SAN_JUAN)  
SAN_JUAN_P_200310 <- crop(P_200310, SAN_JUAN)  
SAN_JUAN_P_200311 <- crop(P_200311, SAN_JUAN)  
SAN_JUAN_P_200312 <- crop(P_200312, SAN_JUAN)  
#2004
SAN_JUAN_P_200401 <- crop(P_200401, SAN_JUAN) 
SAN_JUAN_P_200402 <- crop(P_200402, SAN_JUAN)
SAN_JUAN_P_200403 <- crop(P_200403, SAN_JUAN)
SAN_JUAN_P_200404 <- crop(P_200404, SAN_JUAN)
SAN_JUAN_P_200405 <- crop(P_200405, SAN_JUAN)
SAN_JUAN_P_200406 <- crop(P_200406, SAN_JUAN)  
SAN_JUAN_P_200407 <- crop(P_200407, SAN_JUAN)  
SAN_JUAN_P_200408 <- crop(P_200408, SAN_JUAN)  
SAN_JUAN_P_200409 <- crop(P_200409, SAN_JUAN)  
SAN_JUAN_P_200410 <- crop(P_200410, SAN_JUAN)  
SAN_JUAN_P_200411 <- crop(P_200411, SAN_JUAN)  
SAN_JUAN_P_200412 <- crop(P_200412, SAN_JUAN)  
#2005
SAN_JUAN_P_200501 <- crop(P_200501, SAN_JUAN) 
SAN_JUAN_P_200502 <- crop(P_200502, SAN_JUAN)
SAN_JUAN_P_200503 <- crop(P_200503, SAN_JUAN)
SAN_JUAN_P_200504 <- crop(P_200504, SAN_JUAN)
SAN_JUAN_P_200505 <- crop(P_200505, SAN_JUAN)
SAN_JUAN_P_200506 <- crop(P_200506, SAN_JUAN)  
SAN_JUAN_P_200507 <- crop(P_200507, SAN_JUAN)  
SAN_JUAN_P_200508 <- crop(P_200508, SAN_JUAN)  
SAN_JUAN_P_200509 <- crop(P_200509, SAN_JUAN)  
SAN_JUAN_P_200510 <- crop(P_200510, SAN_JUAN)  
SAN_JUAN_P_200511 <- crop(P_200511, SAN_JUAN)  
SAN_JUAN_P_200512 <- crop(P_200512, SAN_JUAN)  
#2006
SAN_JUAN_P_200601 <- crop(P_200601, SAN_JUAN) 
SAN_JUAN_P_200602 <- crop(P_200602, SAN_JUAN)
SAN_JUAN_P_200603 <- crop(P_200603, SAN_JUAN)
SAN_JUAN_P_200604 <- crop(P_200604, SAN_JUAN)
SAN_JUAN_P_200605 <- crop(P_200605, SAN_JUAN)
SAN_JUAN_P_200606 <- crop(P_200606, SAN_JUAN)  
SAN_JUAN_P_200607 <- crop(P_200607, SAN_JUAN)  
SAN_JUAN_P_200608 <- crop(P_200608, SAN_JUAN)  
SAN_JUAN_P_200609 <- crop(P_200609, SAN_JUAN)  
SAN_JUAN_P_200610 <- crop(P_200610, SAN_JUAN)  
SAN_JUAN_P_200611 <- crop(P_200611, SAN_JUAN)  
SAN_JUAN_P_200612 <- crop(P_200612, SAN_JUAN)  
#2007
SAN_JUAN_P_200701 <- crop(P_200701, SAN_JUAN) 
SAN_JUAN_P_200702 <- crop(P_200702, SAN_JUAN)
SAN_JUAN_P_200703 <- crop(P_200703, SAN_JUAN)
SAN_JUAN_P_200704 <- crop(P_200704, SAN_JUAN)
SAN_JUAN_P_200705 <- crop(P_200705, SAN_JUAN)
SAN_JUAN_P_200706 <- crop(P_200706, SAN_JUAN)  
SAN_JUAN_P_200707 <- crop(P_200707, SAN_JUAN)  
SAN_JUAN_P_200708 <- crop(P_200708, SAN_JUAN)  
SAN_JUAN_P_200709 <- crop(P_200709, SAN_JUAN)  
SAN_JUAN_P_200710 <- crop(P_200710, SAN_JUAN)  
SAN_JUAN_P_200711 <- crop(P_200711, SAN_JUAN)  
SAN_JUAN_P_200712 <- crop(P_200712, SAN_JUAN)  
#2008
SAN_JUAN_P_200801 <- crop(P_200801, SAN_JUAN) 
SAN_JUAN_P_200802 <- crop(P_200802, SAN_JUAN)
SAN_JUAN_P_200803 <- crop(P_200803, SAN_JUAN)
SAN_JUAN_P_200804 <- crop(P_200804, SAN_JUAN)
SAN_JUAN_P_200805 <- crop(P_200805, SAN_JUAN)
SAN_JUAN_P_200806 <- crop(P_200806, SAN_JUAN)  
SAN_JUAN_P_200807 <- crop(P_200807, SAN_JUAN)  
SAN_JUAN_P_200808 <- crop(P_200808, SAN_JUAN)  
SAN_JUAN_P_200809 <- crop(P_200809, SAN_JUAN)  
SAN_JUAN_P_200810 <- crop(P_200810, SAN_JUAN)  
SAN_JUAN_P_200811 <- crop(P_200811, SAN_JUAN)  
SAN_JUAN_P_200812 <- crop(P_200812, SAN_JUAN)  
#2009
SAN_JUAN_P_200901 <- crop(P_200901, SAN_JUAN) 
SAN_JUAN_P_200902 <- crop(P_200902, SAN_JUAN)
SAN_JUAN_P_200903 <- crop(P_200903, SAN_JUAN)
SAN_JUAN_P_200904 <- crop(P_200904, SAN_JUAN)
SAN_JUAN_P_200905 <- crop(P_200905, SAN_JUAN)
SAN_JUAN_P_200906 <- crop(P_200906, SAN_JUAN)  
SAN_JUAN_P_200907 <- crop(P_200907, SAN_JUAN)  
SAN_JUAN_P_200908 <- crop(P_200908, SAN_JUAN)  
SAN_JUAN_P_200909 <- crop(P_200909, SAN_JUAN)  
SAN_JUAN_P_200910 <- crop(P_200910, SAN_JUAN)  
SAN_JUAN_P_200911 <- crop(P_200911, SAN_JUAN)  
SAN_JUAN_P_200912 <- crop(P_200912, SAN_JUAN)  
#2010
SAN_JUAN_P_201001 <- crop(P_201001, SAN_JUAN) 
SAN_JUAN_P_201002 <- crop(P_201002, SAN_JUAN)
SAN_JUAN_P_201003 <- crop(P_201003, SAN_JUAN)
SAN_JUAN_P_201004 <- crop(P_201004, SAN_JUAN)
SAN_JUAN_P_201005 <- crop(P_201005, SAN_JUAN)
SAN_JUAN_P_201006 <- crop(P_201006, SAN_JUAN)  
SAN_JUAN_P_201007 <- crop(P_201007, SAN_JUAN)  
SAN_JUAN_P_201008 <- crop(P_201008, SAN_JUAN)  
SAN_JUAN_P_201009 <- crop(P_201009, SAN_JUAN)  
SAN_JUAN_P_201010 <- crop(P_201010, SAN_JUAN)  
SAN_JUAN_P_201011 <- crop(P_201011, SAN_JUAN)  
SAN_JUAN_P_201012 <- crop(P_201012, SAN_JUAN)  
#2011
SAN_JUAN_P_201101 <- crop(P_201101, SAN_JUAN) 
SAN_JUAN_P_201102 <- crop(P_201102, SAN_JUAN)
SAN_JUAN_P_201103 <- crop(P_201103, SAN_JUAN)
SAN_JUAN_P_201104 <- crop(P_201104, SAN_JUAN)
SAN_JUAN_P_201105 <- crop(P_201105, SAN_JUAN)
SAN_JUAN_P_201106 <- crop(P_201106, SAN_JUAN)  
SAN_JUAN_P_201107 <- crop(P_201107, SAN_JUAN)  
SAN_JUAN_P_201108 <- crop(P_201108, SAN_JUAN)  
SAN_JUAN_P_201109 <- crop(P_201109, SAN_JUAN)  
SAN_JUAN_P_201110 <- crop(P_201110, SAN_JUAN)  
SAN_JUAN_P_201111 <- crop(P_201111, SAN_JUAN)  
SAN_JUAN_P_201112 <- crop(P_201112, SAN_JUAN)  
#2012
SAN_JUAN_P_201201 <- crop(P_201201, SAN_JUAN) 
SAN_JUAN_P_201202 <- crop(P_201202, SAN_JUAN)
SAN_JUAN_P_201203 <- crop(P_201203, SAN_JUAN)
SAN_JUAN_P_201204 <- crop(P_201204, SAN_JUAN)
SAN_JUAN_P_201205 <- crop(P_201205, SAN_JUAN)
SAN_JUAN_P_201206 <- crop(P_201206, SAN_JUAN)  
SAN_JUAN_P_201207 <- crop(P_201207, SAN_JUAN)  
SAN_JUAN_P_201208 <- crop(P_201208, SAN_JUAN)  
SAN_JUAN_P_201209 <- crop(P_201209, SAN_JUAN)  
SAN_JUAN_P_201210 <- crop(P_201210, SAN_JUAN)  
SAN_JUAN_P_201211 <- crop(P_201211, SAN_JUAN)  
SAN_JUAN_P_201212 <- crop(P_201212, SAN_JUAN)  
#2013
SAN_JUAN_P_201301 <- crop(P_201301, SAN_JUAN) 
SAN_JUAN_P_201302 <- crop(P_201302, SAN_JUAN)
SAN_JUAN_P_201303 <- crop(P_201303, SAN_JUAN)
SAN_JUAN_P_201304 <- crop(P_201304, SAN_JUAN)
SAN_JUAN_P_201305 <- crop(P_201305, SAN_JUAN)
SAN_JUAN_P_201306 <- crop(P_201306, SAN_JUAN)  
SAN_JUAN_P_201307 <- crop(P_201307, SAN_JUAN)  
SAN_JUAN_P_201308 <- crop(P_201308, SAN_JUAN)  
SAN_JUAN_P_201309 <- crop(P_201309, SAN_JUAN)  
SAN_JUAN_P_201310 <- crop(P_201310, SAN_JUAN)  
SAN_JUAN_P_201311 <- crop(P_201311, SAN_JUAN)  
SAN_JUAN_P_201312 <- crop(P_201312, SAN_JUAN)  
#2014
SAN_JUAN_P_201401 <- crop(P_201401, SAN_JUAN) 
SAN_JUAN_P_201402 <- crop(P_201402, SAN_JUAN)
SAN_JUAN_P_201403 <- crop(P_201403, SAN_JUAN)
SAN_JUAN_P_201404 <- crop(P_201404, SAN_JUAN)
SAN_JUAN_P_201405 <- crop(P_201405, SAN_JUAN)
SAN_JUAN_P_201406 <- crop(P_201406, SAN_JUAN)  
SAN_JUAN_P_201407 <- crop(P_201407, SAN_JUAN)  
SAN_JUAN_P_201408 <- crop(P_201408, SAN_JUAN)  
SAN_JUAN_P_201409 <- crop(P_201409, SAN_JUAN)  
SAN_JUAN_P_201410 <- crop(P_201410, SAN_JUAN)  
SAN_JUAN_P_201411 <- crop(P_201411, SAN_JUAN)  
SAN_JUAN_P_201412 <- crop(P_201412, SAN_JUAN)  
#2015
SAN_JUAN_P_201501 <- crop(P_201501, SAN_JUAN) 
SAN_JUAN_P_201502 <- crop(P_201502, SAN_JUAN)
SAN_JUAN_P_201503 <- crop(P_201503, SAN_JUAN)
SAN_JUAN_P_201504 <- crop(P_201504, SAN_JUAN)
SAN_JUAN_P_201505 <- crop(P_201505, SAN_JUAN)
SAN_JUAN_P_201506 <- crop(P_201506, SAN_JUAN)  
SAN_JUAN_P_201507 <- crop(P_201507, SAN_JUAN)  
SAN_JUAN_P_201508 <- crop(P_201508, SAN_JUAN)  
SAN_JUAN_P_201509 <- crop(P_201509, SAN_JUAN)  
SAN_JUAN_P_201510 <- crop(P_201510, SAN_JUAN)  
SAN_JUAN_P_201511 <- crop(P_201511, SAN_JUAN)  
SAN_JUAN_P_201512 <- crop(P_201512, SAN_JUAN)  
#2016
SAN_JUAN_P_201601 <- crop(P_201601, SAN_JUAN) 
SAN_JUAN_P_201602 <- crop(P_201602, SAN_JUAN)
SAN_JUAN_P_201603 <- crop(P_201603, SAN_JUAN)
SAN_JUAN_P_201604 <- crop(P_201604, SAN_JUAN)
SAN_JUAN_P_201605 <- crop(P_201605, SAN_JUAN)
SAN_JUAN_P_201606 <- crop(P_201606, SAN_JUAN)  
SAN_JUAN_P_201607 <- crop(P_201607, SAN_JUAN)  
SAN_JUAN_P_201608 <- crop(P_201608, SAN_JUAN)  
SAN_JUAN_P_201609 <- crop(P_201609, SAN_JUAN)  
SAN_JUAN_P_201610 <- crop(P_201610, SAN_JUAN)  
SAN_JUAN_P_201611 <- crop(P_201611, SAN_JUAN)  
SAN_JUAN_P_201612 <- crop(P_201612, SAN_JUAN)  
#2017
SAN_JUAN_P_201701 <- crop(P_201701, SAN_JUAN) 
SAN_JUAN_P_201702 <- crop(P_201702, SAN_JUAN)
SAN_JUAN_P_201703 <- crop(P_201703, SAN_JUAN)
SAN_JUAN_P_201704 <- crop(P_201704, SAN_JUAN)
SAN_JUAN_P_201705 <- crop(P_201705, SAN_JUAN)
SAN_JUAN_P_201706 <- crop(P_201706, SAN_JUAN)  
SAN_JUAN_P_201707 <- crop(P_201707, SAN_JUAN)  
SAN_JUAN_P_201708 <- crop(P_201708, SAN_JUAN)  
SAN_JUAN_P_201709 <- crop(P_201709, SAN_JUAN)  
SAN_JUAN_P_201710 <- crop(P_201710, SAN_JUAN)  
SAN_JUAN_P_201711 <- crop(P_201711, SAN_JUAN)  
SAN_JUAN_P_201712 <- crop(P_201712, SAN_JUAN)  

#2018

SAN_JUAN_P_201801 <- crop(P_201801, SAN_JUAN) 
SAN_JUAN_P_201802 <- crop(P_201802, SAN_JUAN)
SAN_JUAN_P_201803 <- crop(P_201803, SAN_JUAN)
SAN_JUAN_P_201804 <- crop(P_201804, SAN_JUAN)
SAN_JUAN_P_201805 <- crop(P_201805, SAN_JUAN)
SAN_JUAN_P_201806 <- crop(P_201806, SAN_JUAN)  
SAN_JUAN_P_201807 <- crop(P_201807, SAN_JUAN)  
SAN_JUAN_P_201808 <- crop(P_201808, SAN_JUAN)  
SAN_JUAN_P_201809 <- crop(P_201809, SAN_JUAN)  
SAN_JUAN_P_201810 <- crop(P_201810, SAN_JUAN)  
SAN_JUAN_P_201811 <- crop(P_201811, SAN_JUAN)  
SAN_JUAN_P_201812 <- crop(P_201812, SAN_JUAN)  


# Mean Monthly Precipitation
#2000
SAN_JUAN_P_200001_mean <- cellStats(SAN_JUAN_P_200001, mean)
SAN_JUAN_P_200002_mean <- cellStats(SAN_JUAN_P_200002, mean)
SAN_JUAN_P_200003_mean <- cellStats(SAN_JUAN_P_200003, mean)
SAN_JUAN_P_200004_mean <- cellStats(SAN_JUAN_P_200004, mean)
SAN_JUAN_P_200005_mean <- cellStats(SAN_JUAN_P_200005, mean)
SAN_JUAN_P_200006_mean <- cellStats(SAN_JUAN_P_200006, mean)
SAN_JUAN_P_200007_mean <- cellStats(SAN_JUAN_P_200007, mean)
SAN_JUAN_P_200008_mean <- cellStats(SAN_JUAN_P_200008, mean)
SAN_JUAN_P_200009_mean <- cellStats(SAN_JUAN_P_200009, mean)
SAN_JUAN_P_200010_mean <- cellStats(SAN_JUAN_P_200010, mean)
SAN_JUAN_P_200011_mean <- cellStats(SAN_JUAN_P_200011, mean)
SAN_JUAN_P_200012_mean <- cellStats(SAN_JUAN_P_200012, mean)
#2001
SAN_JUAN_P_200101_mean <- cellStats(SAN_JUAN_P_200101, mean)
SAN_JUAN_P_200102_mean <- cellStats(SAN_JUAN_P_200102, mean)
SAN_JUAN_P_200103_mean <- cellStats(SAN_JUAN_P_200103, mean)
SAN_JUAN_P_200104_mean <- cellStats(SAN_JUAN_P_200104, mean)
SAN_JUAN_P_200105_mean <- cellStats(SAN_JUAN_P_200105, mean)
SAN_JUAN_P_200106_mean <- cellStats(SAN_JUAN_P_200106, mean)
SAN_JUAN_P_200107_mean <- cellStats(SAN_JUAN_P_200107, mean)
SAN_JUAN_P_200108_mean <- cellStats(SAN_JUAN_P_200108, mean)
SAN_JUAN_P_200109_mean <- cellStats(SAN_JUAN_P_200109, mean)
SAN_JUAN_P_200110_mean <- cellStats(SAN_JUAN_P_200110, mean)
SAN_JUAN_P_200111_mean <- cellStats(SAN_JUAN_P_200111, mean)
SAN_JUAN_P_200112_mean <- cellStats(SAN_JUAN_P_200112, mean)

#2002
SAN_JUAN_P_200201_mean <- cellStats(SAN_JUAN_P_200201, mean)
SAN_JUAN_P_200202_mean <- cellStats(SAN_JUAN_P_200202, mean)
SAN_JUAN_P_200203_mean <- cellStats(SAN_JUAN_P_200203, mean)
SAN_JUAN_P_200204_mean <- cellStats(SAN_JUAN_P_200204, mean)
SAN_JUAN_P_200205_mean <- cellStats(SAN_JUAN_P_200205, mean)
SAN_JUAN_P_200206_mean <- cellStats(SAN_JUAN_P_200206, mean)
SAN_JUAN_P_200207_mean <- cellStats(SAN_JUAN_P_200207, mean)
SAN_JUAN_P_200208_mean <- cellStats(SAN_JUAN_P_200208, mean)
SAN_JUAN_P_200209_mean <- cellStats(SAN_JUAN_P_200209, mean)
SAN_JUAN_P_200210_mean <- cellStats(SAN_JUAN_P_200210, mean)
SAN_JUAN_P_200211_mean <- cellStats(SAN_JUAN_P_200211, mean)
SAN_JUAN_P_200212_mean <- cellStats(SAN_JUAN_P_200212, mean)

#2003
SAN_JUAN_P_200301_mean <- cellStats(SAN_JUAN_P_200301, mean)
SAN_JUAN_P_200302_mean <- cellStats(SAN_JUAN_P_200302, mean)
SAN_JUAN_P_200303_mean <- cellStats(SAN_JUAN_P_200303, mean)
SAN_JUAN_P_200304_mean <- cellStats(SAN_JUAN_P_200304, mean)
SAN_JUAN_P_200305_mean <- cellStats(SAN_JUAN_P_200305, mean)
SAN_JUAN_P_200306_mean <- cellStats(SAN_JUAN_P_200306, mean)
SAN_JUAN_P_200307_mean <- cellStats(SAN_JUAN_P_200307, mean)
SAN_JUAN_P_200308_mean <- cellStats(SAN_JUAN_P_200308, mean)
SAN_JUAN_P_200309_mean <- cellStats(SAN_JUAN_P_200309, mean)
SAN_JUAN_P_200310_mean <- cellStats(SAN_JUAN_P_200310, mean)
SAN_JUAN_P_200311_mean <- cellStats(SAN_JUAN_P_200311, mean)
SAN_JUAN_P_200312_mean <- cellStats(SAN_JUAN_P_200312, mean)

#2004

SAN_JUAN_P_200401_mean <- cellStats(SAN_JUAN_P_200401, mean)
SAN_JUAN_P_200402_mean <- cellStats(SAN_JUAN_P_200402, mean)
SAN_JUAN_P_200403_mean <- cellStats(SAN_JUAN_P_200403, mean)
SAN_JUAN_P_200404_mean <- cellStats(SAN_JUAN_P_200404, mean)
SAN_JUAN_P_200405_mean <- cellStats(SAN_JUAN_P_200405, mean)
SAN_JUAN_P_200406_mean <- cellStats(SAN_JUAN_P_200406, mean)
SAN_JUAN_P_200407_mean <- cellStats(SAN_JUAN_P_200407, mean)
SAN_JUAN_P_200408_mean <- cellStats(SAN_JUAN_P_200408, mean)
SAN_JUAN_P_200409_mean <- cellStats(SAN_JUAN_P_200409, mean)
SAN_JUAN_P_200410_mean <- cellStats(SAN_JUAN_P_200410, mean)
SAN_JUAN_P_200411_mean <- cellStats(SAN_JUAN_P_200411, mean)
SAN_JUAN_P_200412_mean <- cellStats(SAN_JUAN_P_200412, mean)

#2005

SAN_JUAN_P_200501_mean <- cellStats(SAN_JUAN_P_200501, mean)
SAN_JUAN_P_200502_mean <- cellStats(SAN_JUAN_P_200502, mean)
SAN_JUAN_P_200503_mean <- cellStats(SAN_JUAN_P_200503, mean)
SAN_JUAN_P_200504_mean <- cellStats(SAN_JUAN_P_200504, mean)
SAN_JUAN_P_200505_mean <- cellStats(SAN_JUAN_P_200505, mean)
SAN_JUAN_P_200506_mean <- cellStats(SAN_JUAN_P_200506, mean)
SAN_JUAN_P_200507_mean <- cellStats(SAN_JUAN_P_200507, mean)
SAN_JUAN_P_200508_mean <- cellStats(SAN_JUAN_P_200508, mean)
SAN_JUAN_P_200509_mean <- cellStats(SAN_JUAN_P_200509, mean)
SAN_JUAN_P_200510_mean <- cellStats(SAN_JUAN_P_200510, mean)
SAN_JUAN_P_200511_mean <- cellStats(SAN_JUAN_P_200511, mean)
SAN_JUAN_P_200512_mean <- cellStats(SAN_JUAN_P_200512, mean)

#2006

SAN_JUAN_P_200601_mean <- cellStats(SAN_JUAN_P_200601, mean)
SAN_JUAN_P_200602_mean <- cellStats(SAN_JUAN_P_200602, mean)
SAN_JUAN_P_200603_mean <- cellStats(SAN_JUAN_P_200603, mean)
SAN_JUAN_P_200604_mean <- cellStats(SAN_JUAN_P_200604, mean)
SAN_JUAN_P_200605_mean <- cellStats(SAN_JUAN_P_200605, mean)
SAN_JUAN_P_200606_mean <- cellStats(SAN_JUAN_P_200606, mean)
SAN_JUAN_P_200607_mean <- cellStats(SAN_JUAN_P_200607, mean)
SAN_JUAN_P_200608_mean <- cellStats(SAN_JUAN_P_200608, mean)
SAN_JUAN_P_200609_mean <- cellStats(SAN_JUAN_P_200609, mean)
SAN_JUAN_P_200610_mean <- cellStats(SAN_JUAN_P_200610, mean)
SAN_JUAN_P_200611_mean <- cellStats(SAN_JUAN_P_200611, mean)
SAN_JUAN_P_200612_mean <- cellStats(SAN_JUAN_P_200612, mean)

#2007

SAN_JUAN_P_200701_mean <- cellStats(SAN_JUAN_P_200701, mean)
SAN_JUAN_P_200702_mean <- cellStats(SAN_JUAN_P_200702, mean)
SAN_JUAN_P_200703_mean <- cellStats(SAN_JUAN_P_200703, mean)
SAN_JUAN_P_200704_mean <- cellStats(SAN_JUAN_P_200704, mean)
SAN_JUAN_P_200705_mean <- cellStats(SAN_JUAN_P_200705, mean)
SAN_JUAN_P_200706_mean <- cellStats(SAN_JUAN_P_200706, mean)
SAN_JUAN_P_200707_mean <- cellStats(SAN_JUAN_P_200707, mean)
SAN_JUAN_P_200708_mean <- cellStats(SAN_JUAN_P_200708, mean)
SAN_JUAN_P_200709_mean <- cellStats(SAN_JUAN_P_200709, mean)
SAN_JUAN_P_200710_mean <- cellStats(SAN_JUAN_P_200710, mean)
SAN_JUAN_P_200711_mean <- cellStats(SAN_JUAN_P_200711, mean)
SAN_JUAN_P_200712_mean <- cellStats(SAN_JUAN_P_200712, mean)

#2008

SAN_JUAN_P_200801_mean <- cellStats(SAN_JUAN_P_200801, mean)
SAN_JUAN_P_200802_mean <- cellStats(SAN_JUAN_P_200802, mean)
SAN_JUAN_P_200803_mean <- cellStats(SAN_JUAN_P_200803, mean)
SAN_JUAN_P_200804_mean <- cellStats(SAN_JUAN_P_200804, mean)
SAN_JUAN_P_200805_mean <- cellStats(SAN_JUAN_P_200805, mean)
SAN_JUAN_P_200806_mean <- cellStats(SAN_JUAN_P_200806, mean)
SAN_JUAN_P_200807_mean <- cellStats(SAN_JUAN_P_200807, mean)
SAN_JUAN_P_200808_mean <- cellStats(SAN_JUAN_P_200808, mean)
SAN_JUAN_P_200809_mean <- cellStats(SAN_JUAN_P_200809, mean)
SAN_JUAN_P_200810_mean <- cellStats(SAN_JUAN_P_200810, mean)
SAN_JUAN_P_200811_mean <- cellStats(SAN_JUAN_P_200811, mean)
SAN_JUAN_P_200812_mean <- cellStats(SAN_JUAN_P_200812, mean)

#2009

SAN_JUAN_P_200901_mean <- cellStats(SAN_JUAN_P_200901, mean)
SAN_JUAN_P_200902_mean <- cellStats(SAN_JUAN_P_200902, mean)
SAN_JUAN_P_200903_mean <- cellStats(SAN_JUAN_P_200903, mean)
SAN_JUAN_P_200904_mean <- cellStats(SAN_JUAN_P_200904, mean)
SAN_JUAN_P_200905_mean <- cellStats(SAN_JUAN_P_200905, mean)
SAN_JUAN_P_200906_mean <- cellStats(SAN_JUAN_P_200906, mean)
SAN_JUAN_P_200907_mean <- cellStats(SAN_JUAN_P_200907, mean)
SAN_JUAN_P_200908_mean <- cellStats(SAN_JUAN_P_200908, mean)
SAN_JUAN_P_200909_mean <- cellStats(SAN_JUAN_P_200909, mean)
SAN_JUAN_P_200910_mean <- cellStats(SAN_JUAN_P_200910, mean)
SAN_JUAN_P_200911_mean <- cellStats(SAN_JUAN_P_200911, mean)
SAN_JUAN_P_200912_mean <- cellStats(SAN_JUAN_P_200912, mean)

#2010

SAN_JUAN_P_201001_mean <- cellStats(SAN_JUAN_P_201001, mean)
SAN_JUAN_P_201002_mean <- cellStats(SAN_JUAN_P_201002, mean)
SAN_JUAN_P_201003_mean <- cellStats(SAN_JUAN_P_201003, mean)
SAN_JUAN_P_201004_mean <- cellStats(SAN_JUAN_P_201004, mean)
SAN_JUAN_P_201005_mean <- cellStats(SAN_JUAN_P_201005, mean)
SAN_JUAN_P_201006_mean <- cellStats(SAN_JUAN_P_201006, mean)
SAN_JUAN_P_201007_mean <- cellStats(SAN_JUAN_P_201007, mean)
SAN_JUAN_P_201008_mean <- cellStats(SAN_JUAN_P_201008, mean)
SAN_JUAN_P_201009_mean <- cellStats(SAN_JUAN_P_201009, mean)
SAN_JUAN_P_201010_mean <- cellStats(SAN_JUAN_P_201010, mean)
SAN_JUAN_P_201011_mean <- cellStats(SAN_JUAN_P_201011, mean)
SAN_JUAN_P_201012_mean <- cellStats(SAN_JUAN_P_201012, mean)

#2011

SAN_JUAN_P_201101_mean <- cellStats(SAN_JUAN_P_201101, mean)
SAN_JUAN_P_201102_mean <- cellStats(SAN_JUAN_P_201102, mean)
SAN_JUAN_P_201103_mean <- cellStats(SAN_JUAN_P_201103, mean)
SAN_JUAN_P_201104_mean <- cellStats(SAN_JUAN_P_201104, mean)
SAN_JUAN_P_201105_mean <- cellStats(SAN_JUAN_P_201105, mean)
SAN_JUAN_P_201106_mean <- cellStats(SAN_JUAN_P_201106, mean)
SAN_JUAN_P_201107_mean <- cellStats(SAN_JUAN_P_201107, mean)
SAN_JUAN_P_201108_mean <- cellStats(SAN_JUAN_P_201108, mean)
SAN_JUAN_P_201109_mean <- cellStats(SAN_JUAN_P_201109, mean)
SAN_JUAN_P_201110_mean <- cellStats(SAN_JUAN_P_201110, mean)
SAN_JUAN_P_201111_mean <- cellStats(SAN_JUAN_P_201111, mean)
SAN_JUAN_P_201112_mean <- cellStats(SAN_JUAN_P_201112, mean)

#2012
SAN_JUAN_P_201201_mean <- cellStats(SAN_JUAN_P_201201, mean)
SAN_JUAN_P_201202_mean <- cellStats(SAN_JUAN_P_201202, mean)
SAN_JUAN_P_201203_mean <- cellStats(SAN_JUAN_P_201203, mean)
SAN_JUAN_P_201204_mean <- cellStats(SAN_JUAN_P_201204, mean)
SAN_JUAN_P_201205_mean <- cellStats(SAN_JUAN_P_201205, mean)
SAN_JUAN_P_201206_mean <- cellStats(SAN_JUAN_P_201206, mean)
SAN_JUAN_P_201207_mean <- cellStats(SAN_JUAN_P_201207, mean)
SAN_JUAN_P_201208_mean <- cellStats(SAN_JUAN_P_201208, mean)
SAN_JUAN_P_201209_mean <- cellStats(SAN_JUAN_P_201209, mean)
SAN_JUAN_P_201210_mean <- cellStats(SAN_JUAN_P_201210, mean)
SAN_JUAN_P_201211_mean <- cellStats(SAN_JUAN_P_201211, mean)
SAN_JUAN_P_201212_mean <- cellStats(SAN_JUAN_P_201212, mean)

#2013
SAN_JUAN_P_201301_mean <- cellStats(SAN_JUAN_P_201301, mean)
SAN_JUAN_P_201302_mean <- cellStats(SAN_JUAN_P_201302, mean)
SAN_JUAN_P_201303_mean <- cellStats(SAN_JUAN_P_201303, mean)
SAN_JUAN_P_201304_mean <- cellStats(SAN_JUAN_P_201304, mean)
SAN_JUAN_P_201305_mean <- cellStats(SAN_JUAN_P_201305, mean)
SAN_JUAN_P_201306_mean <- cellStats(SAN_JUAN_P_201306, mean)
SAN_JUAN_P_201307_mean <- cellStats(SAN_JUAN_P_201307, mean)
SAN_JUAN_P_201308_mean <- cellStats(SAN_JUAN_P_201308, mean)
SAN_JUAN_P_201309_mean <- cellStats(SAN_JUAN_P_201309, mean)
SAN_JUAN_P_201310_mean <- cellStats(SAN_JUAN_P_201310, mean)
SAN_JUAN_P_201311_mean <- cellStats(SAN_JUAN_P_201311, mean)
SAN_JUAN_P_201312_mean <- cellStats(SAN_JUAN_P_201312, mean)

#2014
SAN_JUAN_P_201401_mean <- cellStats(SAN_JUAN_P_201401, mean)
SAN_JUAN_P_201402_mean <- cellStats(SAN_JUAN_P_201402, mean)
SAN_JUAN_P_201403_mean <- cellStats(SAN_JUAN_P_201403, mean)
SAN_JUAN_P_201404_mean <- cellStats(SAN_JUAN_P_201404, mean)
SAN_JUAN_P_201405_mean <- cellStats(SAN_JUAN_P_201405, mean)
SAN_JUAN_P_201406_mean <- cellStats(SAN_JUAN_P_201406, mean)
SAN_JUAN_P_201407_mean <- cellStats(SAN_JUAN_P_201407, mean)
SAN_JUAN_P_201408_mean <- cellStats(SAN_JUAN_P_201408, mean)
SAN_JUAN_P_201409_mean <- cellStats(SAN_JUAN_P_201409, mean)
SAN_JUAN_P_201410_mean <- cellStats(SAN_JUAN_P_201410, mean)
SAN_JUAN_P_201411_mean <- cellStats(SAN_JUAN_P_201411, mean)
SAN_JUAN_P_201412_mean <- cellStats(SAN_JUAN_P_201412, mean)

#2015
SAN_JUAN_P_201501_mean <- cellStats(SAN_JUAN_P_201501, mean)
SAN_JUAN_P_201502_mean <- cellStats(SAN_JUAN_P_201502, mean)
SAN_JUAN_P_201503_mean <- cellStats(SAN_JUAN_P_201503, mean)
SAN_JUAN_P_201504_mean <- cellStats(SAN_JUAN_P_201504, mean)
SAN_JUAN_P_201505_mean <- cellStats(SAN_JUAN_P_201505, mean)
SAN_JUAN_P_201506_mean <- cellStats(SAN_JUAN_P_201506, mean)
SAN_JUAN_P_201507_mean <- cellStats(SAN_JUAN_P_201507, mean)
SAN_JUAN_P_201508_mean <- cellStats(SAN_JUAN_P_201508, mean)
SAN_JUAN_P_201509_mean <- cellStats(SAN_JUAN_P_201509, mean)
SAN_JUAN_P_201510_mean <- cellStats(SAN_JUAN_P_201510, mean)
SAN_JUAN_P_201511_mean <- cellStats(SAN_JUAN_P_201511, mean)
SAN_JUAN_P_201512_mean <- cellStats(SAN_JUAN_P_201512, mean)

#2016
SAN_JUAN_P_201601_mean <- cellStats(SAN_JUAN_P_201601, mean)
SAN_JUAN_P_201602_mean <- cellStats(SAN_JUAN_P_201602, mean)
SAN_JUAN_P_201603_mean <- cellStats(SAN_JUAN_P_201603, mean)
SAN_JUAN_P_201604_mean <- cellStats(SAN_JUAN_P_201604, mean)
SAN_JUAN_P_201605_mean <- cellStats(SAN_JUAN_P_201605, mean)
SAN_JUAN_P_201606_mean <- cellStats(SAN_JUAN_P_201606, mean)
SAN_JUAN_P_201607_mean <- cellStats(SAN_JUAN_P_201607, mean)
SAN_JUAN_P_201608_mean <- cellStats(SAN_JUAN_P_201608, mean)
SAN_JUAN_P_201609_mean <- cellStats(SAN_JUAN_P_201609, mean)
SAN_JUAN_P_201610_mean <- cellStats(SAN_JUAN_P_201610, mean)
SAN_JUAN_P_201611_mean <- cellStats(SAN_JUAN_P_201611, mean)
SAN_JUAN_P_201612_mean <- cellStats(SAN_JUAN_P_201612, mean)

#2017
SAN_JUAN_P_201701_mean <- cellStats(SAN_JUAN_P_201701, mean)
SAN_JUAN_P_201702_mean <- cellStats(SAN_JUAN_P_201702, mean)
SAN_JUAN_P_201703_mean <- cellStats(SAN_JUAN_P_201703, mean)
SAN_JUAN_P_201704_mean <- cellStats(SAN_JUAN_P_201704, mean)
SAN_JUAN_P_201705_mean <- cellStats(SAN_JUAN_P_201705, mean)
SAN_JUAN_P_201706_mean <- cellStats(SAN_JUAN_P_201706, mean)
SAN_JUAN_P_201707_mean <- cellStats(SAN_JUAN_P_201707, mean)
SAN_JUAN_P_201708_mean <- cellStats(SAN_JUAN_P_201708, mean)
SAN_JUAN_P_201709_mean <- cellStats(SAN_JUAN_P_201709, mean)
SAN_JUAN_P_201710_mean <- cellStats(SAN_JUAN_P_201710, mean)
SAN_JUAN_P_201711_mean <- cellStats(SAN_JUAN_P_201711, mean)
SAN_JUAN_P_201712_mean <- cellStats(SAN_JUAN_P_201712, mean)

#2018
SAN_JUAN_P_201801_mean <- cellStats(SAN_JUAN_P_201801, mean)
SAN_JUAN_P_201802_mean <- cellStats(SAN_JUAN_P_201802, mean)
SAN_JUAN_P_201803_mean <- cellStats(SAN_JUAN_P_201803, mean)
SAN_JUAN_P_201804_mean <- cellStats(SAN_JUAN_P_201804, mean)
SAN_JUAN_P_201805_mean <- cellStats(SAN_JUAN_P_201805, mean)
SAN_JUAN_P_201806_mean <- cellStats(SAN_JUAN_P_201806, mean)
SAN_JUAN_P_201807_mean <- cellStats(SAN_JUAN_P_201807, mean)
SAN_JUAN_P_201808_mean <- cellStats(SAN_JUAN_P_201808, mean)
SAN_JUAN_P_201809_mean <- cellStats(SAN_JUAN_P_201809, mean)
SAN_JUAN_P_201810_mean <- cellStats(SAN_JUAN_P_201810, mean)
SAN_JUAN_P_201811_mean <- cellStats(SAN_JUAN_P_201811, mean)
SAN_JUAN_P_201812_mean <- cellStats(SAN_JUAN_P_201812, mean)

# SANPETE

#2000
SANPETE_P_200001 <- crop(P_200001, SANPETE) 
SANPETE_P_200002 <- crop(P_200002, SANPETE)
SANPETE_P_200003 <- crop(P_200003, SANPETE)
SANPETE_P_200004 <- crop(P_200004, SANPETE)
SANPETE_P_200005 <- crop(P_200005, SANPETE)
SANPETE_P_200006 <- crop(P_200006, SANPETE)  
SANPETE_P_200007 <- crop(P_200007, SANPETE)  
SANPETE_P_200008 <- crop(P_200008, SANPETE)  
SANPETE_P_200009 <- crop(P_200009, SANPETE)  
SANPETE_P_200010 <- crop(P_200010, SANPETE)  
SANPETE_P_200011 <- crop(P_200011, SANPETE)  
SANPETE_P_200012 <- crop(P_200012, SANPETE)  
#2001
SANPETE_P_200101 <- crop(P_200101, SANPETE) 
SANPETE_P_200102 <- crop(P_200102, SANPETE)
SANPETE_P_200103 <- crop(P_200103, SANPETE)
SANPETE_P_200104 <- crop(P_200104, SANPETE)
SANPETE_P_200105 <- crop(P_200105, SANPETE)
SANPETE_P_200106 <- crop(P_200106, SANPETE)  
SANPETE_P_200107 <- crop(P_200107, SANPETE)  
SANPETE_P_200108 <- crop(P_200108, SANPETE)  
SANPETE_P_200109 <- crop(P_200109, SANPETE)  
SANPETE_P_200110 <- crop(P_200110, SANPETE)  
SANPETE_P_200111 <- crop(P_200111, SANPETE)  
SANPETE_P_200112 <- crop(P_200112, SANPETE)  

#2002
SANPETE_P_200201 <- crop(P_200201, SANPETE) 
SANPETE_P_200202 <- crop(P_200202, SANPETE)
SANPETE_P_200203 <- crop(P_200203, SANPETE)
SANPETE_P_200204 <- crop(P_200204, SANPETE)
SANPETE_P_200205 <- crop(P_200205, SANPETE)
SANPETE_P_200206 <- crop(P_200206, SANPETE)  
SANPETE_P_200207 <- crop(P_200207, SANPETE)  
SANPETE_P_200208 <- crop(P_200208, SANPETE)  
SANPETE_P_200209 <- crop(P_200209, SANPETE)  
SANPETE_P_200210 <- crop(P_200210, SANPETE)  
SANPETE_P_200211 <- crop(P_200211, SANPETE)  
SANPETE_P_200212 <- crop(P_200212, SANPETE)  
#2003
SANPETE_P_200301 <- crop(P_200301, SANPETE) 
SANPETE_P_200302 <- crop(P_200302, SANPETE)
SANPETE_P_200303 <- crop(P_200303, SANPETE)
SANPETE_P_200304 <- crop(P_200304, SANPETE)
SANPETE_P_200305 <- crop(P_200305, SANPETE)
SANPETE_P_200306 <- crop(P_200306, SANPETE)  
SANPETE_P_200307 <- crop(P_200307, SANPETE)  
SANPETE_P_200308 <- crop(P_200308, SANPETE)  
SANPETE_P_200309 <- crop(P_200309, SANPETE)  
SANPETE_P_200310 <- crop(P_200310, SANPETE)  
SANPETE_P_200311 <- crop(P_200311, SANPETE)  
SANPETE_P_200312 <- crop(P_200312, SANPETE)  
#2004
SANPETE_P_200401 <- crop(P_200401, SANPETE) 
SANPETE_P_200402 <- crop(P_200402, SANPETE)
SANPETE_P_200403 <- crop(P_200403, SANPETE)
SANPETE_P_200404 <- crop(P_200404, SANPETE)
SANPETE_P_200405 <- crop(P_200405, SANPETE)
SANPETE_P_200406 <- crop(P_200406, SANPETE)  
SANPETE_P_200407 <- crop(P_200407, SANPETE)  
SANPETE_P_200408 <- crop(P_200408, SANPETE)  
SANPETE_P_200409 <- crop(P_200409, SANPETE)  
SANPETE_P_200410 <- crop(P_200410, SANPETE)  
SANPETE_P_200411 <- crop(P_200411, SANPETE)  
SANPETE_P_200412 <- crop(P_200412, SANPETE)  
#2005
SANPETE_P_200501 <- crop(P_200501, SANPETE) 
SANPETE_P_200502 <- crop(P_200502, SANPETE)
SANPETE_P_200503 <- crop(P_200503, SANPETE)
SANPETE_P_200504 <- crop(P_200504, SANPETE)
SANPETE_P_200505 <- crop(P_200505, SANPETE)
SANPETE_P_200506 <- crop(P_200506, SANPETE)  
SANPETE_P_200507 <- crop(P_200507, SANPETE)  
SANPETE_P_200508 <- crop(P_200508, SANPETE)  
SANPETE_P_200509 <- crop(P_200509, SANPETE)  
SANPETE_P_200510 <- crop(P_200510, SANPETE)  
SANPETE_P_200511 <- crop(P_200511, SANPETE)  
SANPETE_P_200512 <- crop(P_200512, SANPETE)  
#2006
SANPETE_P_200601 <- crop(P_200601, SANPETE) 
SANPETE_P_200602 <- crop(P_200602, SANPETE)
SANPETE_P_200603 <- crop(P_200603, SANPETE)
SANPETE_P_200604 <- crop(P_200604, SANPETE)
SANPETE_P_200605 <- crop(P_200605, SANPETE)
SANPETE_P_200606 <- crop(P_200606, SANPETE)  
SANPETE_P_200607 <- crop(P_200607, SANPETE)  
SANPETE_P_200608 <- crop(P_200608, SANPETE)  
SANPETE_P_200609 <- crop(P_200609, SANPETE)  
SANPETE_P_200610 <- crop(P_200610, SANPETE)  
SANPETE_P_200611 <- crop(P_200611, SANPETE)  
SANPETE_P_200612 <- crop(P_200612, SANPETE)  
#2007
SANPETE_P_200701 <- crop(P_200701, SANPETE) 
SANPETE_P_200702 <- crop(P_200702, SANPETE)
SANPETE_P_200703 <- crop(P_200703, SANPETE)
SANPETE_P_200704 <- crop(P_200704, SANPETE)
SANPETE_P_200705 <- crop(P_200705, SANPETE)
SANPETE_P_200706 <- crop(P_200706, SANPETE)  
SANPETE_P_200707 <- crop(P_200707, SANPETE)  
SANPETE_P_200708 <- crop(P_200708, SANPETE)  
SANPETE_P_200709 <- crop(P_200709, SANPETE)  
SANPETE_P_200710 <- crop(P_200710, SANPETE)  
SANPETE_P_200711 <- crop(P_200711, SANPETE)  
SANPETE_P_200712 <- crop(P_200712, SANPETE)  
#2008
SANPETE_P_200801 <- crop(P_200801, SANPETE) 
SANPETE_P_200802 <- crop(P_200802, SANPETE)
SANPETE_P_200803 <- crop(P_200803, SANPETE)
SANPETE_P_200804 <- crop(P_200804, SANPETE)
SANPETE_P_200805 <- crop(P_200805, SANPETE)
SANPETE_P_200806 <- crop(P_200806, SANPETE)  
SANPETE_P_200807 <- crop(P_200807, SANPETE)  
SANPETE_P_200808 <- crop(P_200808, SANPETE)  
SANPETE_P_200809 <- crop(P_200809, SANPETE)  
SANPETE_P_200810 <- crop(P_200810, SANPETE)  
SANPETE_P_200811 <- crop(P_200811, SANPETE)  
SANPETE_P_200812 <- crop(P_200812, SANPETE)  
#2009
SANPETE_P_200901 <- crop(P_200901, SANPETE) 
SANPETE_P_200902 <- crop(P_200902, SANPETE)
SANPETE_P_200903 <- crop(P_200903, SANPETE)
SANPETE_P_200904 <- crop(P_200904, SANPETE)
SANPETE_P_200905 <- crop(P_200905, SANPETE)
SANPETE_P_200906 <- crop(P_200906, SANPETE)  
SANPETE_P_200907 <- crop(P_200907, SANPETE)  
SANPETE_P_200908 <- crop(P_200908, SANPETE)  
SANPETE_P_200909 <- crop(P_200909, SANPETE)  
SANPETE_P_200910 <- crop(P_200910, SANPETE)  
SANPETE_P_200911 <- crop(P_200911, SANPETE)  
SANPETE_P_200912 <- crop(P_200912, SANPETE)  
#2010
SANPETE_P_201001 <- crop(P_201001, SANPETE) 
SANPETE_P_201002 <- crop(P_201002, SANPETE)
SANPETE_P_201003 <- crop(P_201003, SANPETE)
SANPETE_P_201004 <- crop(P_201004, SANPETE)
SANPETE_P_201005 <- crop(P_201005, SANPETE)
SANPETE_P_201006 <- crop(P_201006, SANPETE)  
SANPETE_P_201007 <- crop(P_201007, SANPETE)  
SANPETE_P_201008 <- crop(P_201008, SANPETE)  
SANPETE_P_201009 <- crop(P_201009, SANPETE)  
SANPETE_P_201010 <- crop(P_201010, SANPETE)  
SANPETE_P_201011 <- crop(P_201011, SANPETE)  
SANPETE_P_201012 <- crop(P_201012, SANPETE)  
#2011
SANPETE_P_201101 <- crop(P_201101, SANPETE) 
SANPETE_P_201102 <- crop(P_201102, SANPETE)
SANPETE_P_201103 <- crop(P_201103, SANPETE)
SANPETE_P_201104 <- crop(P_201104, SANPETE)
SANPETE_P_201105 <- crop(P_201105, SANPETE)
SANPETE_P_201106 <- crop(P_201106, SANPETE)  
SANPETE_P_201107 <- crop(P_201107, SANPETE)  
SANPETE_P_201108 <- crop(P_201108, SANPETE)  
SANPETE_P_201109 <- crop(P_201109, SANPETE)  
SANPETE_P_201110 <- crop(P_201110, SANPETE)  
SANPETE_P_201111 <- crop(P_201111, SANPETE)  
SANPETE_P_201112 <- crop(P_201112, SANPETE)  
#2012
SANPETE_P_201201 <- crop(P_201201, SANPETE) 
SANPETE_P_201202 <- crop(P_201202, SANPETE)
SANPETE_P_201203 <- crop(P_201203, SANPETE)
SANPETE_P_201204 <- crop(P_201204, SANPETE)
SANPETE_P_201205 <- crop(P_201205, SANPETE)
SANPETE_P_201206 <- crop(P_201206, SANPETE)  
SANPETE_P_201207 <- crop(P_201207, SANPETE)  
SANPETE_P_201208 <- crop(P_201208, SANPETE)  
SANPETE_P_201209 <- crop(P_201209, SANPETE)  
SANPETE_P_201210 <- crop(P_201210, SANPETE)  
SANPETE_P_201211 <- crop(P_201211, SANPETE)  
SANPETE_P_201212 <- crop(P_201212, SANPETE)  
#2013
SANPETE_P_201301 <- crop(P_201301, SANPETE) 
SANPETE_P_201302 <- crop(P_201302, SANPETE)
SANPETE_P_201303 <- crop(P_201303, SANPETE)
SANPETE_P_201304 <- crop(P_201304, SANPETE)
SANPETE_P_201305 <- crop(P_201305, SANPETE)
SANPETE_P_201306 <- crop(P_201306, SANPETE)  
SANPETE_P_201307 <- crop(P_201307, SANPETE)  
SANPETE_P_201308 <- crop(P_201308, SANPETE)  
SANPETE_P_201309 <- crop(P_201309, SANPETE)  
SANPETE_P_201310 <- crop(P_201310, SANPETE)  
SANPETE_P_201311 <- crop(P_201311, SANPETE)  
SANPETE_P_201312 <- crop(P_201312, SANPETE)  
#2014
SANPETE_P_201401 <- crop(P_201401, SANPETE) 
SANPETE_P_201402 <- crop(P_201402, SANPETE)
SANPETE_P_201403 <- crop(P_201403, SANPETE)
SANPETE_P_201404 <- crop(P_201404, SANPETE)
SANPETE_P_201405 <- crop(P_201405, SANPETE)
SANPETE_P_201406 <- crop(P_201406, SANPETE)  
SANPETE_P_201407 <- crop(P_201407, SANPETE)  
SANPETE_P_201408 <- crop(P_201408, SANPETE)  
SANPETE_P_201409 <- crop(P_201409, SANPETE)  
SANPETE_P_201410 <- crop(P_201410, SANPETE)  
SANPETE_P_201411 <- crop(P_201411, SANPETE)  
SANPETE_P_201412 <- crop(P_201412, SANPETE)  
#2015
SANPETE_P_201501 <- crop(P_201501, SANPETE) 
SANPETE_P_201502 <- crop(P_201502, SANPETE)
SANPETE_P_201503 <- crop(P_201503, SANPETE)
SANPETE_P_201504 <- crop(P_201504, SANPETE)
SANPETE_P_201505 <- crop(P_201505, SANPETE)
SANPETE_P_201506 <- crop(P_201506, SANPETE)  
SANPETE_P_201507 <- crop(P_201507, SANPETE)  
SANPETE_P_201508 <- crop(P_201508, SANPETE)  
SANPETE_P_201509 <- crop(P_201509, SANPETE)  
SANPETE_P_201510 <- crop(P_201510, SANPETE)  
SANPETE_P_201511 <- crop(P_201511, SANPETE)  
SANPETE_P_201512 <- crop(P_201512, SANPETE)  
#2016
SANPETE_P_201601 <- crop(P_201601, SANPETE) 
SANPETE_P_201602 <- crop(P_201602, SANPETE)
SANPETE_P_201603 <- crop(P_201603, SANPETE)
SANPETE_P_201604 <- crop(P_201604, SANPETE)
SANPETE_P_201605 <- crop(P_201605, SANPETE)
SANPETE_P_201606 <- crop(P_201606, SANPETE)  
SANPETE_P_201607 <- crop(P_201607, SANPETE)  
SANPETE_P_201608 <- crop(P_201608, SANPETE)  
SANPETE_P_201609 <- crop(P_201609, SANPETE)  
SANPETE_P_201610 <- crop(P_201610, SANPETE)  
SANPETE_P_201611 <- crop(P_201611, SANPETE)  
SANPETE_P_201612 <- crop(P_201612, SANPETE)  
#2017
SANPETE_P_201701 <- crop(P_201701, SANPETE) 
SANPETE_P_201702 <- crop(P_201702, SANPETE)
SANPETE_P_201703 <- crop(P_201703, SANPETE)
SANPETE_P_201704 <- crop(P_201704, SANPETE)
SANPETE_P_201705 <- crop(P_201705, SANPETE)
SANPETE_P_201706 <- crop(P_201706, SANPETE)  
SANPETE_P_201707 <- crop(P_201707, SANPETE)  
SANPETE_P_201708 <- crop(P_201708, SANPETE)  
SANPETE_P_201709 <- crop(P_201709, SANPETE)  
SANPETE_P_201710 <- crop(P_201710, SANPETE)  
SANPETE_P_201711 <- crop(P_201711, SANPETE)  
SANPETE_P_201712 <- crop(P_201712, SANPETE)  

#2018

SANPETE_P_201801 <- crop(P_201801, SANPETE) 
SANPETE_P_201802 <- crop(P_201802, SANPETE)
SANPETE_P_201803 <- crop(P_201803, SANPETE)
SANPETE_P_201804 <- crop(P_201804, SANPETE)
SANPETE_P_201805 <- crop(P_201805, SANPETE)
SANPETE_P_201806 <- crop(P_201806, SANPETE)  
SANPETE_P_201807 <- crop(P_201807, SANPETE)  
SANPETE_P_201808 <- crop(P_201808, SANPETE)  
SANPETE_P_201809 <- crop(P_201809, SANPETE)  
SANPETE_P_201810 <- crop(P_201810, SANPETE)  
SANPETE_P_201811 <- crop(P_201811, SANPETE)  
SANPETE_P_201812 <- crop(P_201812, SANPETE)  


# Mean Monthly Precipitation
#2000
SANPETE_P_200001_mean <- cellStats(SANPETE_P_200001, mean)
SANPETE_P_200002_mean <- cellStats(SANPETE_P_200002, mean)
SANPETE_P_200003_mean <- cellStats(SANPETE_P_200003, mean)
SANPETE_P_200004_mean <- cellStats(SANPETE_P_200004, mean)
SANPETE_P_200005_mean <- cellStats(SANPETE_P_200005, mean)
SANPETE_P_200006_mean <- cellStats(SANPETE_P_200006, mean)
SANPETE_P_200007_mean <- cellStats(SANPETE_P_200007, mean)
SANPETE_P_200008_mean <- cellStats(SANPETE_P_200008, mean)
SANPETE_P_200009_mean <- cellStats(SANPETE_P_200009, mean)
SANPETE_P_200010_mean <- cellStats(SANPETE_P_200010, mean)
SANPETE_P_200011_mean <- cellStats(SANPETE_P_200011, mean)
SANPETE_P_200012_mean <- cellStats(SANPETE_P_200012, mean)
#2001
SANPETE_P_200101_mean <- cellStats(SANPETE_P_200101, mean)
SANPETE_P_200102_mean <- cellStats(SANPETE_P_200102, mean)
SANPETE_P_200103_mean <- cellStats(SANPETE_P_200103, mean)
SANPETE_P_200104_mean <- cellStats(SANPETE_P_200104, mean)
SANPETE_P_200105_mean <- cellStats(SANPETE_P_200105, mean)
SANPETE_P_200106_mean <- cellStats(SANPETE_P_200106, mean)
SANPETE_P_200107_mean <- cellStats(SANPETE_P_200107, mean)
SANPETE_P_200108_mean <- cellStats(SANPETE_P_200108, mean)
SANPETE_P_200109_mean <- cellStats(SANPETE_P_200109, mean)
SANPETE_P_200110_mean <- cellStats(SANPETE_P_200110, mean)
SANPETE_P_200111_mean <- cellStats(SANPETE_P_200111, mean)
SANPETE_P_200112_mean <- cellStats(SANPETE_P_200112, mean)

#2002
SANPETE_P_200201_mean <- cellStats(SANPETE_P_200201, mean)
SANPETE_P_200202_mean <- cellStats(SANPETE_P_200202, mean)
SANPETE_P_200203_mean <- cellStats(SANPETE_P_200203, mean)
SANPETE_P_200204_mean <- cellStats(SANPETE_P_200204, mean)
SANPETE_P_200205_mean <- cellStats(SANPETE_P_200205, mean)
SANPETE_P_200206_mean <- cellStats(SANPETE_P_200206, mean)
SANPETE_P_200207_mean <- cellStats(SANPETE_P_200207, mean)
SANPETE_P_200208_mean <- cellStats(SANPETE_P_200208, mean)
SANPETE_P_200209_mean <- cellStats(SANPETE_P_200209, mean)
SANPETE_P_200210_mean <- cellStats(SANPETE_P_200210, mean)
SANPETE_P_200211_mean <- cellStats(SANPETE_P_200211, mean)
SANPETE_P_200212_mean <- cellStats(SANPETE_P_200212, mean)

#2003
SANPETE_P_200301_mean <- cellStats(SANPETE_P_200301, mean)
SANPETE_P_200302_mean <- cellStats(SANPETE_P_200302, mean)
SANPETE_P_200303_mean <- cellStats(SANPETE_P_200303, mean)
SANPETE_P_200304_mean <- cellStats(SANPETE_P_200304, mean)
SANPETE_P_200305_mean <- cellStats(SANPETE_P_200305, mean)
SANPETE_P_200306_mean <- cellStats(SANPETE_P_200306, mean)
SANPETE_P_200307_mean <- cellStats(SANPETE_P_200307, mean)
SANPETE_P_200308_mean <- cellStats(SANPETE_P_200308, mean)
SANPETE_P_200309_mean <- cellStats(SANPETE_P_200309, mean)
SANPETE_P_200310_mean <- cellStats(SANPETE_P_200310, mean)
SANPETE_P_200311_mean <- cellStats(SANPETE_P_200311, mean)
SANPETE_P_200312_mean <- cellStats(SANPETE_P_200312, mean)

#2004

SANPETE_P_200401_mean <- cellStats(SANPETE_P_200401, mean)
SANPETE_P_200402_mean <- cellStats(SANPETE_P_200402, mean)
SANPETE_P_200403_mean <- cellStats(SANPETE_P_200403, mean)
SANPETE_P_200404_mean <- cellStats(SANPETE_P_200404, mean)
SANPETE_P_200405_mean <- cellStats(SANPETE_P_200405, mean)
SANPETE_P_200406_mean <- cellStats(SANPETE_P_200406, mean)
SANPETE_P_200407_mean <- cellStats(SANPETE_P_200407, mean)
SANPETE_P_200408_mean <- cellStats(SANPETE_P_200408, mean)
SANPETE_P_200409_mean <- cellStats(SANPETE_P_200409, mean)
SANPETE_P_200410_mean <- cellStats(SANPETE_P_200410, mean)
SANPETE_P_200411_mean <- cellStats(SANPETE_P_200411, mean)
SANPETE_P_200412_mean <- cellStats(SANPETE_P_200412, mean)

#2005

SANPETE_P_200501_mean <- cellStats(SANPETE_P_200501, mean)
SANPETE_P_200502_mean <- cellStats(SANPETE_P_200502, mean)
SANPETE_P_200503_mean <- cellStats(SANPETE_P_200503, mean)
SANPETE_P_200504_mean <- cellStats(SANPETE_P_200504, mean)
SANPETE_P_200505_mean <- cellStats(SANPETE_P_200505, mean)
SANPETE_P_200506_mean <- cellStats(SANPETE_P_200506, mean)
SANPETE_P_200507_mean <- cellStats(SANPETE_P_200507, mean)
SANPETE_P_200508_mean <- cellStats(SANPETE_P_200508, mean)
SANPETE_P_200509_mean <- cellStats(SANPETE_P_200509, mean)
SANPETE_P_200510_mean <- cellStats(SANPETE_P_200510, mean)
SANPETE_P_200511_mean <- cellStats(SANPETE_P_200511, mean)
SANPETE_P_200512_mean <- cellStats(SANPETE_P_200512, mean)

#2006

SANPETE_P_200601_mean <- cellStats(SANPETE_P_200601, mean)
SANPETE_P_200602_mean <- cellStats(SANPETE_P_200602, mean)
SANPETE_P_200603_mean <- cellStats(SANPETE_P_200603, mean)
SANPETE_P_200604_mean <- cellStats(SANPETE_P_200604, mean)
SANPETE_P_200605_mean <- cellStats(SANPETE_P_200605, mean)
SANPETE_P_200606_mean <- cellStats(SANPETE_P_200606, mean)
SANPETE_P_200607_mean <- cellStats(SANPETE_P_200607, mean)
SANPETE_P_200608_mean <- cellStats(SANPETE_P_200608, mean)
SANPETE_P_200609_mean <- cellStats(SANPETE_P_200609, mean)
SANPETE_P_200610_mean <- cellStats(SANPETE_P_200610, mean)
SANPETE_P_200611_mean <- cellStats(SANPETE_P_200611, mean)
SANPETE_P_200612_mean <- cellStats(SANPETE_P_200612, mean)

#2007

SANPETE_P_200701_mean <- cellStats(SANPETE_P_200701, mean)
SANPETE_P_200702_mean <- cellStats(SANPETE_P_200702, mean)
SANPETE_P_200703_mean <- cellStats(SANPETE_P_200703, mean)
SANPETE_P_200704_mean <- cellStats(SANPETE_P_200704, mean)
SANPETE_P_200705_mean <- cellStats(SANPETE_P_200705, mean)
SANPETE_P_200706_mean <- cellStats(SANPETE_P_200706, mean)
SANPETE_P_200707_mean <- cellStats(SANPETE_P_200707, mean)
SANPETE_P_200708_mean <- cellStats(SANPETE_P_200708, mean)
SANPETE_P_200709_mean <- cellStats(SANPETE_P_200709, mean)
SANPETE_P_200710_mean <- cellStats(SANPETE_P_200710, mean)
SANPETE_P_200711_mean <- cellStats(SANPETE_P_200711, mean)
SANPETE_P_200712_mean <- cellStats(SANPETE_P_200712, mean)

#2008

SANPETE_P_200801_mean <- cellStats(SANPETE_P_200801, mean)
SANPETE_P_200802_mean <- cellStats(SANPETE_P_200802, mean)
SANPETE_P_200803_mean <- cellStats(SANPETE_P_200803, mean)
SANPETE_P_200804_mean <- cellStats(SANPETE_P_200804, mean)
SANPETE_P_200805_mean <- cellStats(SANPETE_P_200805, mean)
SANPETE_P_200806_mean <- cellStats(SANPETE_P_200806, mean)
SANPETE_P_200807_mean <- cellStats(SANPETE_P_200807, mean)
SANPETE_P_200808_mean <- cellStats(SANPETE_P_200808, mean)
SANPETE_P_200809_mean <- cellStats(SANPETE_P_200809, mean)
SANPETE_P_200810_mean <- cellStats(SANPETE_P_200810, mean)
SANPETE_P_200811_mean <- cellStats(SANPETE_P_200811, mean)
SANPETE_P_200812_mean <- cellStats(SANPETE_P_200812, mean)

#2009

SANPETE_P_200901_mean <- cellStats(SANPETE_P_200901, mean)
SANPETE_P_200902_mean <- cellStats(SANPETE_P_200902, mean)
SANPETE_P_200903_mean <- cellStats(SANPETE_P_200903, mean)
SANPETE_P_200904_mean <- cellStats(SANPETE_P_200904, mean)
SANPETE_P_200905_mean <- cellStats(SANPETE_P_200905, mean)
SANPETE_P_200906_mean <- cellStats(SANPETE_P_200906, mean)
SANPETE_P_200907_mean <- cellStats(SANPETE_P_200907, mean)
SANPETE_P_200908_mean <- cellStats(SANPETE_P_200908, mean)
SANPETE_P_200909_mean <- cellStats(SANPETE_P_200909, mean)
SANPETE_P_200910_mean <- cellStats(SANPETE_P_200910, mean)
SANPETE_P_200911_mean <- cellStats(SANPETE_P_200911, mean)
SANPETE_P_200912_mean <- cellStats(SANPETE_P_200912, mean)

#2010

SANPETE_P_201001_mean <- cellStats(SANPETE_P_201001, mean)
SANPETE_P_201002_mean <- cellStats(SANPETE_P_201002, mean)
SANPETE_P_201003_mean <- cellStats(SANPETE_P_201003, mean)
SANPETE_P_201004_mean <- cellStats(SANPETE_P_201004, mean)
SANPETE_P_201005_mean <- cellStats(SANPETE_P_201005, mean)
SANPETE_P_201006_mean <- cellStats(SANPETE_P_201006, mean)
SANPETE_P_201007_mean <- cellStats(SANPETE_P_201007, mean)
SANPETE_P_201008_mean <- cellStats(SANPETE_P_201008, mean)
SANPETE_P_201009_mean <- cellStats(SANPETE_P_201009, mean)
SANPETE_P_201010_mean <- cellStats(SANPETE_P_201010, mean)
SANPETE_P_201011_mean <- cellStats(SANPETE_P_201011, mean)
SANPETE_P_201012_mean <- cellStats(SANPETE_P_201012, mean)

#2011

SANPETE_P_201101_mean <- cellStats(SANPETE_P_201101, mean)
SANPETE_P_201102_mean <- cellStats(SANPETE_P_201102, mean)
SANPETE_P_201103_mean <- cellStats(SANPETE_P_201103, mean)
SANPETE_P_201104_mean <- cellStats(SANPETE_P_201104, mean)
SANPETE_P_201105_mean <- cellStats(SANPETE_P_201105, mean)
SANPETE_P_201106_mean <- cellStats(SANPETE_P_201106, mean)
SANPETE_P_201107_mean <- cellStats(SANPETE_P_201107, mean)
SANPETE_P_201108_mean <- cellStats(SANPETE_P_201108, mean)
SANPETE_P_201109_mean <- cellStats(SANPETE_P_201109, mean)
SANPETE_P_201110_mean <- cellStats(SANPETE_P_201110, mean)
SANPETE_P_201111_mean <- cellStats(SANPETE_P_201111, mean)
SANPETE_P_201112_mean <- cellStats(SANPETE_P_201112, mean)

#2012
SANPETE_P_201201_mean <- cellStats(SANPETE_P_201201, mean)
SANPETE_P_201202_mean <- cellStats(SANPETE_P_201202, mean)
SANPETE_P_201203_mean <- cellStats(SANPETE_P_201203, mean)
SANPETE_P_201204_mean <- cellStats(SANPETE_P_201204, mean)
SANPETE_P_201205_mean <- cellStats(SANPETE_P_201205, mean)
SANPETE_P_201206_mean <- cellStats(SANPETE_P_201206, mean)
SANPETE_P_201207_mean <- cellStats(SANPETE_P_201207, mean)
SANPETE_P_201208_mean <- cellStats(SANPETE_P_201208, mean)
SANPETE_P_201209_mean <- cellStats(SANPETE_P_201209, mean)
SANPETE_P_201210_mean <- cellStats(SANPETE_P_201210, mean)
SANPETE_P_201211_mean <- cellStats(SANPETE_P_201211, mean)
SANPETE_P_201212_mean <- cellStats(SANPETE_P_201212, mean)

#2013
SANPETE_P_201301_mean <- cellStats(SANPETE_P_201301, mean)
SANPETE_P_201302_mean <- cellStats(SANPETE_P_201302, mean)
SANPETE_P_201303_mean <- cellStats(SANPETE_P_201303, mean)
SANPETE_P_201304_mean <- cellStats(SANPETE_P_201304, mean)
SANPETE_P_201305_mean <- cellStats(SANPETE_P_201305, mean)
SANPETE_P_201306_mean <- cellStats(SANPETE_P_201306, mean)
SANPETE_P_201307_mean <- cellStats(SANPETE_P_201307, mean)
SANPETE_P_201308_mean <- cellStats(SANPETE_P_201308, mean)
SANPETE_P_201309_mean <- cellStats(SANPETE_P_201309, mean)
SANPETE_P_201310_mean <- cellStats(SANPETE_P_201310, mean)
SANPETE_P_201311_mean <- cellStats(SANPETE_P_201311, mean)
SANPETE_P_201312_mean <- cellStats(SANPETE_P_201312, mean)

#2014
SANPETE_P_201401_mean <- cellStats(SANPETE_P_201401, mean)
SANPETE_P_201402_mean <- cellStats(SANPETE_P_201402, mean)
SANPETE_P_201403_mean <- cellStats(SANPETE_P_201403, mean)
SANPETE_P_201404_mean <- cellStats(SANPETE_P_201404, mean)
SANPETE_P_201405_mean <- cellStats(SANPETE_P_201405, mean)
SANPETE_P_201406_mean <- cellStats(SANPETE_P_201406, mean)
SANPETE_P_201407_mean <- cellStats(SANPETE_P_201407, mean)
SANPETE_P_201408_mean <- cellStats(SANPETE_P_201408, mean)
SANPETE_P_201409_mean <- cellStats(SANPETE_P_201409, mean)
SANPETE_P_201410_mean <- cellStats(SANPETE_P_201410, mean)
SANPETE_P_201411_mean <- cellStats(SANPETE_P_201411, mean)
SANPETE_P_201412_mean <- cellStats(SANPETE_P_201412, mean)

#2015
SANPETE_P_201501_mean <- cellStats(SANPETE_P_201501, mean)
SANPETE_P_201502_mean <- cellStats(SANPETE_P_201502, mean)
SANPETE_P_201503_mean <- cellStats(SANPETE_P_201503, mean)
SANPETE_P_201504_mean <- cellStats(SANPETE_P_201504, mean)
SANPETE_P_201505_mean <- cellStats(SANPETE_P_201505, mean)
SANPETE_P_201506_mean <- cellStats(SANPETE_P_201506, mean)
SANPETE_P_201507_mean <- cellStats(SANPETE_P_201507, mean)
SANPETE_P_201508_mean <- cellStats(SANPETE_P_201508, mean)
SANPETE_P_201509_mean <- cellStats(SANPETE_P_201509, mean)
SANPETE_P_201510_mean <- cellStats(SANPETE_P_201510, mean)
SANPETE_P_201511_mean <- cellStats(SANPETE_P_201511, mean)
SANPETE_P_201512_mean <- cellStats(SANPETE_P_201512, mean)

#2016
SANPETE_P_201601_mean <- cellStats(SANPETE_P_201601, mean)
SANPETE_P_201602_mean <- cellStats(SANPETE_P_201602, mean)
SANPETE_P_201603_mean <- cellStats(SANPETE_P_201603, mean)
SANPETE_P_201604_mean <- cellStats(SANPETE_P_201604, mean)
SANPETE_P_201605_mean <- cellStats(SANPETE_P_201605, mean)
SANPETE_P_201606_mean <- cellStats(SANPETE_P_201606, mean)
SANPETE_P_201607_mean <- cellStats(SANPETE_P_201607, mean)
SANPETE_P_201608_mean <- cellStats(SANPETE_P_201608, mean)
SANPETE_P_201609_mean <- cellStats(SANPETE_P_201609, mean)
SANPETE_P_201610_mean <- cellStats(SANPETE_P_201610, mean)
SANPETE_P_201611_mean <- cellStats(SANPETE_P_201611, mean)
SANPETE_P_201612_mean <- cellStats(SANPETE_P_201612, mean)

#2017
SANPETE_P_201701_mean <- cellStats(SANPETE_P_201701, mean)
SANPETE_P_201702_mean <- cellStats(SANPETE_P_201702, mean)
SANPETE_P_201703_mean <- cellStats(SANPETE_P_201703, mean)
SANPETE_P_201704_mean <- cellStats(SANPETE_P_201704, mean)
SANPETE_P_201705_mean <- cellStats(SANPETE_P_201705, mean)
SANPETE_P_201706_mean <- cellStats(SANPETE_P_201706, mean)
SANPETE_P_201707_mean <- cellStats(SANPETE_P_201707, mean)
SANPETE_P_201708_mean <- cellStats(SANPETE_P_201708, mean)
SANPETE_P_201709_mean <- cellStats(SANPETE_P_201709, mean)
SANPETE_P_201710_mean <- cellStats(SANPETE_P_201710, mean)
SANPETE_P_201711_mean <- cellStats(SANPETE_P_201711, mean)
SANPETE_P_201712_mean <- cellStats(SANPETE_P_201712, mean)

#2018
SANPETE_P_201801_mean <- cellStats(SANPETE_P_201801, mean)
SANPETE_P_201802_mean <- cellStats(SANPETE_P_201802, mean)
SANPETE_P_201803_mean <- cellStats(SANPETE_P_201803, mean)
SANPETE_P_201804_mean <- cellStats(SANPETE_P_201804, mean)
SANPETE_P_201805_mean <- cellStats(SANPETE_P_201805, mean)
SANPETE_P_201806_mean <- cellStats(SANPETE_P_201806, mean)
SANPETE_P_201807_mean <- cellStats(SANPETE_P_201807, mean)
SANPETE_P_201808_mean <- cellStats(SANPETE_P_201808, mean)
SANPETE_P_201809_mean <- cellStats(SANPETE_P_201809, mean)
SANPETE_P_201810_mean <- cellStats(SANPETE_P_201810, mean)
SANPETE_P_201811_mean <- cellStats(SANPETE_P_201811, mean)
SANPETE_P_201812_mean <- cellStats(SANPETE_P_201812, mean)

# TOOELE


#2000
TOOELE_P_200001 <- crop(P_200001, TOOELE) 
TOOELE_P_200002 <- crop(P_200002, TOOELE)
TOOELE_P_200003 <- crop(P_200003, TOOELE)
TOOELE_P_200004 <- crop(P_200004, TOOELE)
TOOELE_P_200005 <- crop(P_200005, TOOELE)
TOOELE_P_200006 <- crop(P_200006, TOOELE)  
TOOELE_P_200007 <- crop(P_200007, TOOELE)  
TOOELE_P_200008 <- crop(P_200008, TOOELE)  
TOOELE_P_200009 <- crop(P_200009, TOOELE)  
TOOELE_P_200010 <- crop(P_200010, TOOELE)  
TOOELE_P_200011 <- crop(P_200011, TOOELE)  
TOOELE_P_200012 <- crop(P_200012, TOOELE)  
#2001
TOOELE_P_200101 <- crop(P_200101, TOOELE) 
TOOELE_P_200102 <- crop(P_200102, TOOELE)
TOOELE_P_200103 <- crop(P_200103, TOOELE)
TOOELE_P_200104 <- crop(P_200104, TOOELE)
TOOELE_P_200105 <- crop(P_200105, TOOELE)
TOOELE_P_200106 <- crop(P_200106, TOOELE)  
TOOELE_P_200107 <- crop(P_200107, TOOELE)  
TOOELE_P_200108 <- crop(P_200108, TOOELE)  
TOOELE_P_200109 <- crop(P_200109, TOOELE)  
TOOELE_P_200110 <- crop(P_200110, TOOELE)  
TOOELE_P_200111 <- crop(P_200111, TOOELE)  
TOOELE_P_200112 <- crop(P_200112, TOOELE)  

#2002
TOOELE_P_200201 <- crop(P_200201, TOOELE) 
TOOELE_P_200202 <- crop(P_200202, TOOELE)
TOOELE_P_200203 <- crop(P_200203, TOOELE)
TOOELE_P_200204 <- crop(P_200204, TOOELE)
TOOELE_P_200205 <- crop(P_200205, TOOELE)
TOOELE_P_200206 <- crop(P_200206, TOOELE)  
TOOELE_P_200207 <- crop(P_200207, TOOELE)  
TOOELE_P_200208 <- crop(P_200208, TOOELE)  
TOOELE_P_200209 <- crop(P_200209, TOOELE)  
TOOELE_P_200210 <- crop(P_200210, TOOELE)  
TOOELE_P_200211 <- crop(P_200211, TOOELE)  
TOOELE_P_200212 <- crop(P_200212, TOOELE)  
#2003
TOOELE_P_200301 <- crop(P_200301, TOOELE) 
TOOELE_P_200302 <- crop(P_200302, TOOELE)
TOOELE_P_200303 <- crop(P_200303, TOOELE)
TOOELE_P_200304 <- crop(P_200304, TOOELE)
TOOELE_P_200305 <- crop(P_200305, TOOELE)
TOOELE_P_200306 <- crop(P_200306, TOOELE)  
TOOELE_P_200307 <- crop(P_200307, TOOELE)  
TOOELE_P_200308 <- crop(P_200308, TOOELE)  
TOOELE_P_200309 <- crop(P_200309, TOOELE)  
TOOELE_P_200310 <- crop(P_200310, TOOELE)  
TOOELE_P_200311 <- crop(P_200311, TOOELE)  
TOOELE_P_200312 <- crop(P_200312, TOOELE)  
#2004
TOOELE_P_200401 <- crop(P_200401, TOOELE) 
TOOELE_P_200402 <- crop(P_200402, TOOELE)
TOOELE_P_200403 <- crop(P_200403, TOOELE)
TOOELE_P_200404 <- crop(P_200404, TOOELE)
TOOELE_P_200405 <- crop(P_200405, TOOELE)
TOOELE_P_200406 <- crop(P_200406, TOOELE)  
TOOELE_P_200407 <- crop(P_200407, TOOELE)  
TOOELE_P_200408 <- crop(P_200408, TOOELE)  
TOOELE_P_200409 <- crop(P_200409, TOOELE)  
TOOELE_P_200410 <- crop(P_200410, TOOELE)  
TOOELE_P_200411 <- crop(P_200411, TOOELE)  
TOOELE_P_200412 <- crop(P_200412, TOOELE)  
#2005
TOOELE_P_200501 <- crop(P_200501, TOOELE) 
TOOELE_P_200502 <- crop(P_200502, TOOELE)
TOOELE_P_200503 <- crop(P_200503, TOOELE)
TOOELE_P_200504 <- crop(P_200504, TOOELE)
TOOELE_P_200505 <- crop(P_200505, TOOELE)
TOOELE_P_200506 <- crop(P_200506, TOOELE)  
TOOELE_P_200507 <- crop(P_200507, TOOELE)  
TOOELE_P_200508 <- crop(P_200508, TOOELE)  
TOOELE_P_200509 <- crop(P_200509, TOOELE)  
TOOELE_P_200510 <- crop(P_200510, TOOELE)  
TOOELE_P_200511 <- crop(P_200511, TOOELE)  
TOOELE_P_200512 <- crop(P_200512, TOOELE)  
#2006
TOOELE_P_200601 <- crop(P_200601, TOOELE) 
TOOELE_P_200602 <- crop(P_200602, TOOELE)
TOOELE_P_200603 <- crop(P_200603, TOOELE)
TOOELE_P_200604 <- crop(P_200604, TOOELE)
TOOELE_P_200605 <- crop(P_200605, TOOELE)
TOOELE_P_200606 <- crop(P_200606, TOOELE)  
TOOELE_P_200607 <- crop(P_200607, TOOELE)  
TOOELE_P_200608 <- crop(P_200608, TOOELE)  
TOOELE_P_200609 <- crop(P_200609, TOOELE)  
TOOELE_P_200610 <- crop(P_200610, TOOELE)  
TOOELE_P_200611 <- crop(P_200611, TOOELE)  
TOOELE_P_200612 <- crop(P_200612, TOOELE)  
#2007
TOOELE_P_200701 <- crop(P_200701, TOOELE) 
TOOELE_P_200702 <- crop(P_200702, TOOELE)
TOOELE_P_200703 <- crop(P_200703, TOOELE)
TOOELE_P_200704 <- crop(P_200704, TOOELE)
TOOELE_P_200705 <- crop(P_200705, TOOELE)
TOOELE_P_200706 <- crop(P_200706, TOOELE)  
TOOELE_P_200707 <- crop(P_200707, TOOELE)  
TOOELE_P_200708 <- crop(P_200708, TOOELE)  
TOOELE_P_200709 <- crop(P_200709, TOOELE)  
TOOELE_P_200710 <- crop(P_200710, TOOELE)  
TOOELE_P_200711 <- crop(P_200711, TOOELE)  
TOOELE_P_200712 <- crop(P_200712, TOOELE)  
#2008
TOOELE_P_200801 <- crop(P_200801, TOOELE) 
TOOELE_P_200802 <- crop(P_200802, TOOELE)
TOOELE_P_200803 <- crop(P_200803, TOOELE)
TOOELE_P_200804 <- crop(P_200804, TOOELE)
TOOELE_P_200805 <- crop(P_200805, TOOELE)
TOOELE_P_200806 <- crop(P_200806, TOOELE)  
TOOELE_P_200807 <- crop(P_200807, TOOELE)  
TOOELE_P_200808 <- crop(P_200808, TOOELE)  
TOOELE_P_200809 <- crop(P_200809, TOOELE)  
TOOELE_P_200810 <- crop(P_200810, TOOELE)  
TOOELE_P_200811 <- crop(P_200811, TOOELE)  
TOOELE_P_200812 <- crop(P_200812, TOOELE)  
#2009
TOOELE_P_200901 <- crop(P_200901, TOOELE) 
TOOELE_P_200902 <- crop(P_200902, TOOELE)
TOOELE_P_200903 <- crop(P_200903, TOOELE)
TOOELE_P_200904 <- crop(P_200904, TOOELE)
TOOELE_P_200905 <- crop(P_200905, TOOELE)
TOOELE_P_200906 <- crop(P_200906, TOOELE)  
TOOELE_P_200907 <- crop(P_200907, TOOELE)  
TOOELE_P_200908 <- crop(P_200908, TOOELE)  
TOOELE_P_200909 <- crop(P_200909, TOOELE)  
TOOELE_P_200910 <- crop(P_200910, TOOELE)  
TOOELE_P_200911 <- crop(P_200911, TOOELE)  
TOOELE_P_200912 <- crop(P_200912, TOOELE)  
#2010
TOOELE_P_201001 <- crop(P_201001, TOOELE) 
TOOELE_P_201002 <- crop(P_201002, TOOELE)
TOOELE_P_201003 <- crop(P_201003, TOOELE)
TOOELE_P_201004 <- crop(P_201004, TOOELE)
TOOELE_P_201005 <- crop(P_201005, TOOELE)
TOOELE_P_201006 <- crop(P_201006, TOOELE)  
TOOELE_P_201007 <- crop(P_201007, TOOELE)  
TOOELE_P_201008 <- crop(P_201008, TOOELE)  
TOOELE_P_201009 <- crop(P_201009, TOOELE)  
TOOELE_P_201010 <- crop(P_201010, TOOELE)  
TOOELE_P_201011 <- crop(P_201011, TOOELE)  
TOOELE_P_201012 <- crop(P_201012, TOOELE)  
#2011
TOOELE_P_201101 <- crop(P_201101, TOOELE) 
TOOELE_P_201102 <- crop(P_201102, TOOELE)
TOOELE_P_201103 <- crop(P_201103, TOOELE)
TOOELE_P_201104 <- crop(P_201104, TOOELE)
TOOELE_P_201105 <- crop(P_201105, TOOELE)
TOOELE_P_201106 <- crop(P_201106, TOOELE)  
TOOELE_P_201107 <- crop(P_201107, TOOELE)  
TOOELE_P_201108 <- crop(P_201108, TOOELE)  
TOOELE_P_201109 <- crop(P_201109, TOOELE)  
TOOELE_P_201110 <- crop(P_201110, TOOELE)  
TOOELE_P_201111 <- crop(P_201111, TOOELE)  
TOOELE_P_201112 <- crop(P_201112, TOOELE)  
#2012
TOOELE_P_201201 <- crop(P_201201, TOOELE) 
TOOELE_P_201202 <- crop(P_201202, TOOELE)
TOOELE_P_201203 <- crop(P_201203, TOOELE)
TOOELE_P_201204 <- crop(P_201204, TOOELE)
TOOELE_P_201205 <- crop(P_201205, TOOELE)
TOOELE_P_201206 <- crop(P_201206, TOOELE)  
TOOELE_P_201207 <- crop(P_201207, TOOELE)  
TOOELE_P_201208 <- crop(P_201208, TOOELE)  
TOOELE_P_201209 <- crop(P_201209, TOOELE)  
TOOELE_P_201210 <- crop(P_201210, TOOELE)  
TOOELE_P_201211 <- crop(P_201211, TOOELE)  
TOOELE_P_201212 <- crop(P_201212, TOOELE)  
#2013
TOOELE_P_201301 <- crop(P_201301, TOOELE) 
TOOELE_P_201302 <- crop(P_201302, TOOELE)
TOOELE_P_201303 <- crop(P_201303, TOOELE)
TOOELE_P_201304 <- crop(P_201304, TOOELE)
TOOELE_P_201305 <- crop(P_201305, TOOELE)
TOOELE_P_201306 <- crop(P_201306, TOOELE)  
TOOELE_P_201307 <- crop(P_201307, TOOELE)  
TOOELE_P_201308 <- crop(P_201308, TOOELE)  
TOOELE_P_201309 <- crop(P_201309, TOOELE)  
TOOELE_P_201310 <- crop(P_201310, TOOELE)  
TOOELE_P_201311 <- crop(P_201311, TOOELE)  
TOOELE_P_201312 <- crop(P_201312, TOOELE)  
#2014
TOOELE_P_201401 <- crop(P_201401, TOOELE) 
TOOELE_P_201402 <- crop(P_201402, TOOELE)
TOOELE_P_201403 <- crop(P_201403, TOOELE)
TOOELE_P_201404 <- crop(P_201404, TOOELE)
TOOELE_P_201405 <- crop(P_201405, TOOELE)
TOOELE_P_201406 <- crop(P_201406, TOOELE)  
TOOELE_P_201407 <- crop(P_201407, TOOELE)  
TOOELE_P_201408 <- crop(P_201408, TOOELE)  
TOOELE_P_201409 <- crop(P_201409, TOOELE)  
TOOELE_P_201410 <- crop(P_201410, TOOELE)  
TOOELE_P_201411 <- crop(P_201411, TOOELE)  
TOOELE_P_201412 <- crop(P_201412, TOOELE)  
#2015
TOOELE_P_201501 <- crop(P_201501, TOOELE) 
TOOELE_P_201502 <- crop(P_201502, TOOELE)
TOOELE_P_201503 <- crop(P_201503, TOOELE)
TOOELE_P_201504 <- crop(P_201504, TOOELE)
TOOELE_P_201505 <- crop(P_201505, TOOELE)
TOOELE_P_201506 <- crop(P_201506, TOOELE)  
TOOELE_P_201507 <- crop(P_201507, TOOELE)  
TOOELE_P_201508 <- crop(P_201508, TOOELE)  
TOOELE_P_201509 <- crop(P_201509, TOOELE)  
TOOELE_P_201510 <- crop(P_201510, TOOELE)  
TOOELE_P_201511 <- crop(P_201511, TOOELE)  
TOOELE_P_201512 <- crop(P_201512, TOOELE)  
#2016
TOOELE_P_201601 <- crop(P_201601, TOOELE) 
TOOELE_P_201602 <- crop(P_201602, TOOELE)
TOOELE_P_201603 <- crop(P_201603, TOOELE)
TOOELE_P_201604 <- crop(P_201604, TOOELE)
TOOELE_P_201605 <- crop(P_201605, TOOELE)
TOOELE_P_201606 <- crop(P_201606, TOOELE)  
TOOELE_P_201607 <- crop(P_201607, TOOELE)  
TOOELE_P_201608 <- crop(P_201608, TOOELE)  
TOOELE_P_201609 <- crop(P_201609, TOOELE)  
TOOELE_P_201610 <- crop(P_201610, TOOELE)  
TOOELE_P_201611 <- crop(P_201611, TOOELE)  
TOOELE_P_201612 <- crop(P_201612, TOOELE)  
#2017
TOOELE_P_201701 <- crop(P_201701, TOOELE) 
TOOELE_P_201702 <- crop(P_201702, TOOELE)
TOOELE_P_201703 <- crop(P_201703, TOOELE)
TOOELE_P_201704 <- crop(P_201704, TOOELE)
TOOELE_P_201705 <- crop(P_201705, TOOELE)
TOOELE_P_201706 <- crop(P_201706, TOOELE)  
TOOELE_P_201707 <- crop(P_201707, TOOELE)  
TOOELE_P_201708 <- crop(P_201708, TOOELE)  
TOOELE_P_201709 <- crop(P_201709, TOOELE)  
TOOELE_P_201710 <- crop(P_201710, TOOELE)  
TOOELE_P_201711 <- crop(P_201711, TOOELE)  
TOOELE_P_201712 <- crop(P_201712, TOOELE)  

#2018

TOOELE_P_201801 <- crop(P_201801, TOOELE) 
TOOELE_P_201802 <- crop(P_201802, TOOELE)
TOOELE_P_201803 <- crop(P_201803, TOOELE)
TOOELE_P_201804 <- crop(P_201804, TOOELE)
TOOELE_P_201805 <- crop(P_201805, TOOELE)
TOOELE_P_201806 <- crop(P_201806, TOOELE)  
TOOELE_P_201807 <- crop(P_201807, TOOELE)  
TOOELE_P_201808 <- crop(P_201808, TOOELE)  
TOOELE_P_201809 <- crop(P_201809, TOOELE)  
TOOELE_P_201810 <- crop(P_201810, TOOELE)  
TOOELE_P_201811 <- crop(P_201811, TOOELE)  
TOOELE_P_201812 <- crop(P_201812, TOOELE)  


# Mean Monthly Precipitation
#2000
TOOELE_P_200001_mean <- cellStats(TOOELE_P_200001, mean)
TOOELE_P_200002_mean <- cellStats(TOOELE_P_200002, mean)
TOOELE_P_200003_mean <- cellStats(TOOELE_P_200003, mean)
TOOELE_P_200004_mean <- cellStats(TOOELE_P_200004, mean)
TOOELE_P_200005_mean <- cellStats(TOOELE_P_200005, mean)
TOOELE_P_200006_mean <- cellStats(TOOELE_P_200006, mean)
TOOELE_P_200007_mean <- cellStats(TOOELE_P_200007, mean)
TOOELE_P_200008_mean <- cellStats(TOOELE_P_200008, mean)
TOOELE_P_200009_mean <- cellStats(TOOELE_P_200009, mean)
TOOELE_P_200010_mean <- cellStats(TOOELE_P_200010, mean)
TOOELE_P_200011_mean <- cellStats(TOOELE_P_200011, mean)
TOOELE_P_200012_mean <- cellStats(TOOELE_P_200012, mean)
#2001
TOOELE_P_200101_mean <- cellStats(TOOELE_P_200101, mean)
TOOELE_P_200102_mean <- cellStats(TOOELE_P_200102, mean)
TOOELE_P_200103_mean <- cellStats(TOOELE_P_200103, mean)
TOOELE_P_200104_mean <- cellStats(TOOELE_P_200104, mean)
TOOELE_P_200105_mean <- cellStats(TOOELE_P_200105, mean)
TOOELE_P_200106_mean <- cellStats(TOOELE_P_200106, mean)
TOOELE_P_200107_mean <- cellStats(TOOELE_P_200107, mean)
TOOELE_P_200108_mean <- cellStats(TOOELE_P_200108, mean)
TOOELE_P_200109_mean <- cellStats(TOOELE_P_200109, mean)
TOOELE_P_200110_mean <- cellStats(TOOELE_P_200110, mean)
TOOELE_P_200111_mean <- cellStats(TOOELE_P_200111, mean)
TOOELE_P_200112_mean <- cellStats(TOOELE_P_200112, mean)

#2002
TOOELE_P_200201_mean <- cellStats(TOOELE_P_200201, mean)
TOOELE_P_200202_mean <- cellStats(TOOELE_P_200202, mean)
TOOELE_P_200203_mean <- cellStats(TOOELE_P_200203, mean)
TOOELE_P_200204_mean <- cellStats(TOOELE_P_200204, mean)
TOOELE_P_200205_mean <- cellStats(TOOELE_P_200205, mean)
TOOELE_P_200206_mean <- cellStats(TOOELE_P_200206, mean)
TOOELE_P_200207_mean <- cellStats(TOOELE_P_200207, mean)
TOOELE_P_200208_mean <- cellStats(TOOELE_P_200208, mean)
TOOELE_P_200209_mean <- cellStats(TOOELE_P_200209, mean)
TOOELE_P_200210_mean <- cellStats(TOOELE_P_200210, mean)
TOOELE_P_200211_mean <- cellStats(TOOELE_P_200211, mean)
TOOELE_P_200212_mean <- cellStats(TOOELE_P_200212, mean)

#2003
TOOELE_P_200301_mean <- cellStats(TOOELE_P_200301, mean)
TOOELE_P_200302_mean <- cellStats(TOOELE_P_200302, mean)
TOOELE_P_200303_mean <- cellStats(TOOELE_P_200303, mean)
TOOELE_P_200304_mean <- cellStats(TOOELE_P_200304, mean)
TOOELE_P_200305_mean <- cellStats(TOOELE_P_200305, mean)
TOOELE_P_200306_mean <- cellStats(TOOELE_P_200306, mean)
TOOELE_P_200307_mean <- cellStats(TOOELE_P_200307, mean)
TOOELE_P_200308_mean <- cellStats(TOOELE_P_200308, mean)
TOOELE_P_200309_mean <- cellStats(TOOELE_P_200309, mean)
TOOELE_P_200310_mean <- cellStats(TOOELE_P_200310, mean)
TOOELE_P_200311_mean <- cellStats(TOOELE_P_200311, mean)
TOOELE_P_200312_mean <- cellStats(TOOELE_P_200312, mean)

#2004

TOOELE_P_200401_mean <- cellStats(TOOELE_P_200401, mean)
TOOELE_P_200402_mean <- cellStats(TOOELE_P_200402, mean)
TOOELE_P_200403_mean <- cellStats(TOOELE_P_200403, mean)
TOOELE_P_200404_mean <- cellStats(TOOELE_P_200404, mean)
TOOELE_P_200405_mean <- cellStats(TOOELE_P_200405, mean)
TOOELE_P_200406_mean <- cellStats(TOOELE_P_200406, mean)
TOOELE_P_200407_mean <- cellStats(TOOELE_P_200407, mean)
TOOELE_P_200408_mean <- cellStats(TOOELE_P_200408, mean)
TOOELE_P_200409_mean <- cellStats(TOOELE_P_200409, mean)
TOOELE_P_200410_mean <- cellStats(TOOELE_P_200410, mean)
TOOELE_P_200411_mean <- cellStats(TOOELE_P_200411, mean)
TOOELE_P_200412_mean <- cellStats(TOOELE_P_200412, mean)

#2005

TOOELE_P_200501_mean <- cellStats(TOOELE_P_200501, mean)
TOOELE_P_200502_mean <- cellStats(TOOELE_P_200502, mean)
TOOELE_P_200503_mean <- cellStats(TOOELE_P_200503, mean)
TOOELE_P_200504_mean <- cellStats(TOOELE_P_200504, mean)
TOOELE_P_200505_mean <- cellStats(TOOELE_P_200505, mean)
TOOELE_P_200506_mean <- cellStats(TOOELE_P_200506, mean)
TOOELE_P_200507_mean <- cellStats(TOOELE_P_200507, mean)
TOOELE_P_200508_mean <- cellStats(TOOELE_P_200508, mean)
TOOELE_P_200509_mean <- cellStats(TOOELE_P_200509, mean)
TOOELE_P_200510_mean <- cellStats(TOOELE_P_200510, mean)
TOOELE_P_200511_mean <- cellStats(TOOELE_P_200511, mean)
TOOELE_P_200512_mean <- cellStats(TOOELE_P_200512, mean)

#2006

TOOELE_P_200601_mean <- cellStats(TOOELE_P_200601, mean)
TOOELE_P_200602_mean <- cellStats(TOOELE_P_200602, mean)
TOOELE_P_200603_mean <- cellStats(TOOELE_P_200603, mean)
TOOELE_P_200604_mean <- cellStats(TOOELE_P_200604, mean)
TOOELE_P_200605_mean <- cellStats(TOOELE_P_200605, mean)
TOOELE_P_200606_mean <- cellStats(TOOELE_P_200606, mean)
TOOELE_P_200607_mean <- cellStats(TOOELE_P_200607, mean)
TOOELE_P_200608_mean <- cellStats(TOOELE_P_200608, mean)
TOOELE_P_200609_mean <- cellStats(TOOELE_P_200609, mean)
TOOELE_P_200610_mean <- cellStats(TOOELE_P_200610, mean)
TOOELE_P_200611_mean <- cellStats(TOOELE_P_200611, mean)
TOOELE_P_200612_mean <- cellStats(TOOELE_P_200612, mean)

#2007

TOOELE_P_200701_mean <- cellStats(TOOELE_P_200701, mean)
TOOELE_P_200702_mean <- cellStats(TOOELE_P_200702, mean)
TOOELE_P_200703_mean <- cellStats(TOOELE_P_200703, mean)
TOOELE_P_200704_mean <- cellStats(TOOELE_P_200704, mean)
TOOELE_P_200705_mean <- cellStats(TOOELE_P_200705, mean)
TOOELE_P_200706_mean <- cellStats(TOOELE_P_200706, mean)
TOOELE_P_200707_mean <- cellStats(TOOELE_P_200707, mean)
TOOELE_P_200708_mean <- cellStats(TOOELE_P_200708, mean)
TOOELE_P_200709_mean <- cellStats(TOOELE_P_200709, mean)
TOOELE_P_200710_mean <- cellStats(TOOELE_P_200710, mean)
TOOELE_P_200711_mean <- cellStats(TOOELE_P_200711, mean)
TOOELE_P_200712_mean <- cellStats(TOOELE_P_200712, mean)

#2008

TOOELE_P_200801_mean <- cellStats(TOOELE_P_200801, mean)
TOOELE_P_200802_mean <- cellStats(TOOELE_P_200802, mean)
TOOELE_P_200803_mean <- cellStats(TOOELE_P_200803, mean)
TOOELE_P_200804_mean <- cellStats(TOOELE_P_200804, mean)
TOOELE_P_200805_mean <- cellStats(TOOELE_P_200805, mean)
TOOELE_P_200806_mean <- cellStats(TOOELE_P_200806, mean)
TOOELE_P_200807_mean <- cellStats(TOOELE_P_200807, mean)
TOOELE_P_200808_mean <- cellStats(TOOELE_P_200808, mean)
TOOELE_P_200809_mean <- cellStats(TOOELE_P_200809, mean)
TOOELE_P_200810_mean <- cellStats(TOOELE_P_200810, mean)
TOOELE_P_200811_mean <- cellStats(TOOELE_P_200811, mean)
TOOELE_P_200812_mean <- cellStats(TOOELE_P_200812, mean)

#2009

TOOELE_P_200901_mean <- cellStats(TOOELE_P_200901, mean)
TOOELE_P_200902_mean <- cellStats(TOOELE_P_200902, mean)
TOOELE_P_200903_mean <- cellStats(TOOELE_P_200903, mean)
TOOELE_P_200904_mean <- cellStats(TOOELE_P_200904, mean)
TOOELE_P_200905_mean <- cellStats(TOOELE_P_200905, mean)
TOOELE_P_200906_mean <- cellStats(TOOELE_P_200906, mean)
TOOELE_P_200907_mean <- cellStats(TOOELE_P_200907, mean)
TOOELE_P_200908_mean <- cellStats(TOOELE_P_200908, mean)
TOOELE_P_200909_mean <- cellStats(TOOELE_P_200909, mean)
TOOELE_P_200910_mean <- cellStats(TOOELE_P_200910, mean)
TOOELE_P_200911_mean <- cellStats(TOOELE_P_200911, mean)
TOOELE_P_200912_mean <- cellStats(TOOELE_P_200912, mean)

#2010

TOOELE_P_201001_mean <- cellStats(TOOELE_P_201001, mean)
TOOELE_P_201002_mean <- cellStats(TOOELE_P_201002, mean)
TOOELE_P_201003_mean <- cellStats(TOOELE_P_201003, mean)
TOOELE_P_201004_mean <- cellStats(TOOELE_P_201004, mean)
TOOELE_P_201005_mean <- cellStats(TOOELE_P_201005, mean)
TOOELE_P_201006_mean <- cellStats(TOOELE_P_201006, mean)
TOOELE_P_201007_mean <- cellStats(TOOELE_P_201007, mean)
TOOELE_P_201008_mean <- cellStats(TOOELE_P_201008, mean)
TOOELE_P_201009_mean <- cellStats(TOOELE_P_201009, mean)
TOOELE_P_201010_mean <- cellStats(TOOELE_P_201010, mean)
TOOELE_P_201011_mean <- cellStats(TOOELE_P_201011, mean)
TOOELE_P_201012_mean <- cellStats(TOOELE_P_201012, mean)

#2011

TOOELE_P_201101_mean <- cellStats(TOOELE_P_201101, mean)
TOOELE_P_201102_mean <- cellStats(TOOELE_P_201102, mean)
TOOELE_P_201103_mean <- cellStats(TOOELE_P_201103, mean)
TOOELE_P_201104_mean <- cellStats(TOOELE_P_201104, mean)
TOOELE_P_201105_mean <- cellStats(TOOELE_P_201105, mean)
TOOELE_P_201106_mean <- cellStats(TOOELE_P_201106, mean)
TOOELE_P_201107_mean <- cellStats(TOOELE_P_201107, mean)
TOOELE_P_201108_mean <- cellStats(TOOELE_P_201108, mean)
TOOELE_P_201109_mean <- cellStats(TOOELE_P_201109, mean)
TOOELE_P_201110_mean <- cellStats(TOOELE_P_201110, mean)
TOOELE_P_201111_mean <- cellStats(TOOELE_P_201111, mean)
TOOELE_P_201112_mean <- cellStats(TOOELE_P_201112, mean)

#2012
TOOELE_P_201201_mean <- cellStats(TOOELE_P_201201, mean)
TOOELE_P_201202_mean <- cellStats(TOOELE_P_201202, mean)
TOOELE_P_201203_mean <- cellStats(TOOELE_P_201203, mean)
TOOELE_P_201204_mean <- cellStats(TOOELE_P_201204, mean)
TOOELE_P_201205_mean <- cellStats(TOOELE_P_201205, mean)
TOOELE_P_201206_mean <- cellStats(TOOELE_P_201206, mean)
TOOELE_P_201207_mean <- cellStats(TOOELE_P_201207, mean)
TOOELE_P_201208_mean <- cellStats(TOOELE_P_201208, mean)
TOOELE_P_201209_mean <- cellStats(TOOELE_P_201209, mean)
TOOELE_P_201210_mean <- cellStats(TOOELE_P_201210, mean)
TOOELE_P_201211_mean <- cellStats(TOOELE_P_201211, mean)
TOOELE_P_201212_mean <- cellStats(TOOELE_P_201212, mean)

#2013
TOOELE_P_201301_mean <- cellStats(TOOELE_P_201301, mean)
TOOELE_P_201302_mean <- cellStats(TOOELE_P_201302, mean)
TOOELE_P_201303_mean <- cellStats(TOOELE_P_201303, mean)
TOOELE_P_201304_mean <- cellStats(TOOELE_P_201304, mean)
TOOELE_P_201305_mean <- cellStats(TOOELE_P_201305, mean)
TOOELE_P_201306_mean <- cellStats(TOOELE_P_201306, mean)
TOOELE_P_201307_mean <- cellStats(TOOELE_P_201307, mean)
TOOELE_P_201308_mean <- cellStats(TOOELE_P_201308, mean)
TOOELE_P_201309_mean <- cellStats(TOOELE_P_201309, mean)
TOOELE_P_201310_mean <- cellStats(TOOELE_P_201310, mean)
TOOELE_P_201311_mean <- cellStats(TOOELE_P_201311, mean)
TOOELE_P_201312_mean <- cellStats(TOOELE_P_201312, mean)

#2014
TOOELE_P_201401_mean <- cellStats(TOOELE_P_201401, mean)
TOOELE_P_201402_mean <- cellStats(TOOELE_P_201402, mean)
TOOELE_P_201403_mean <- cellStats(TOOELE_P_201403, mean)
TOOELE_P_201404_mean <- cellStats(TOOELE_P_201404, mean)
TOOELE_P_201405_mean <- cellStats(TOOELE_P_201405, mean)
TOOELE_P_201406_mean <- cellStats(TOOELE_P_201406, mean)
TOOELE_P_201407_mean <- cellStats(TOOELE_P_201407, mean)
TOOELE_P_201408_mean <- cellStats(TOOELE_P_201408, mean)
TOOELE_P_201409_mean <- cellStats(TOOELE_P_201409, mean)
TOOELE_P_201410_mean <- cellStats(TOOELE_P_201410, mean)
TOOELE_P_201411_mean <- cellStats(TOOELE_P_201411, mean)
TOOELE_P_201412_mean <- cellStats(TOOELE_P_201412, mean)

#2015
TOOELE_P_201501_mean <- cellStats(TOOELE_P_201501, mean)
TOOELE_P_201502_mean <- cellStats(TOOELE_P_201502, mean)
TOOELE_P_201503_mean <- cellStats(TOOELE_P_201503, mean)
TOOELE_P_201504_mean <- cellStats(TOOELE_P_201504, mean)
TOOELE_P_201505_mean <- cellStats(TOOELE_P_201505, mean)
TOOELE_P_201506_mean <- cellStats(TOOELE_P_201506, mean)
TOOELE_P_201507_mean <- cellStats(TOOELE_P_201507, mean)
TOOELE_P_201508_mean <- cellStats(TOOELE_P_201508, mean)
TOOELE_P_201509_mean <- cellStats(TOOELE_P_201509, mean)
TOOELE_P_201510_mean <- cellStats(TOOELE_P_201510, mean)
TOOELE_P_201511_mean <- cellStats(TOOELE_P_201511, mean)
TOOELE_P_201512_mean <- cellStats(TOOELE_P_201512, mean)

#2016
TOOELE_P_201601_mean <- cellStats(TOOELE_P_201601, mean)
TOOELE_P_201602_mean <- cellStats(TOOELE_P_201602, mean)
TOOELE_P_201603_mean <- cellStats(TOOELE_P_201603, mean)
TOOELE_P_201604_mean <- cellStats(TOOELE_P_201604, mean)
TOOELE_P_201605_mean <- cellStats(TOOELE_P_201605, mean)
TOOELE_P_201606_mean <- cellStats(TOOELE_P_201606, mean)
TOOELE_P_201607_mean <- cellStats(TOOELE_P_201607, mean)
TOOELE_P_201608_mean <- cellStats(TOOELE_P_201608, mean)
TOOELE_P_201609_mean <- cellStats(TOOELE_P_201609, mean)
TOOELE_P_201610_mean <- cellStats(TOOELE_P_201610, mean)
TOOELE_P_201611_mean <- cellStats(TOOELE_P_201611, mean)
TOOELE_P_201612_mean <- cellStats(TOOELE_P_201612, mean)

#2017
TOOELE_P_201701_mean <- cellStats(TOOELE_P_201701, mean)
TOOELE_P_201702_mean <- cellStats(TOOELE_P_201702, mean)
TOOELE_P_201703_mean <- cellStats(TOOELE_P_201703, mean)
TOOELE_P_201704_mean <- cellStats(TOOELE_P_201704, mean)
TOOELE_P_201705_mean <- cellStats(TOOELE_P_201705, mean)
TOOELE_P_201706_mean <- cellStats(TOOELE_P_201706, mean)
TOOELE_P_201707_mean <- cellStats(TOOELE_P_201707, mean)
TOOELE_P_201708_mean <- cellStats(TOOELE_P_201708, mean)
TOOELE_P_201709_mean <- cellStats(TOOELE_P_201709, mean)
TOOELE_P_201710_mean <- cellStats(TOOELE_P_201710, mean)
TOOELE_P_201711_mean <- cellStats(TOOELE_P_201711, mean)
TOOELE_P_201712_mean <- cellStats(TOOELE_P_201712, mean)

#2018
TOOELE_P_201801_mean <- cellStats(TOOELE_P_201801, mean)
TOOELE_P_201802_mean <- cellStats(TOOELE_P_201802, mean)
TOOELE_P_201803_mean <- cellStats(TOOELE_P_201803, mean)
TOOELE_P_201804_mean <- cellStats(TOOELE_P_201804, mean)
TOOELE_P_201805_mean <- cellStats(TOOELE_P_201805, mean)
TOOELE_P_201806_mean <- cellStats(TOOELE_P_201806, mean)
TOOELE_P_201807_mean <- cellStats(TOOELE_P_201807, mean)
TOOELE_P_201808_mean <- cellStats(TOOELE_P_201808, mean)
TOOELE_P_201809_mean <- cellStats(TOOELE_P_201809, mean)
TOOELE_P_201810_mean <- cellStats(TOOELE_P_201810, mean)
TOOELE_P_201811_mean <- cellStats(TOOELE_P_201811, mean)
TOOELE_P_201812_mean <- cellStats(TOOELE_P_201812, mean)

# Utah


#2000
UTAH_P_200001 <- crop(P_200001, UTAH) 
UTAH_P_200002 <- crop(P_200002, UTAH)
UTAH_P_200003 <- crop(P_200003, UTAH)
UTAH_P_200004 <- crop(P_200004, UTAH)
UTAH_P_200005 <- crop(P_200005, UTAH)
UTAH_P_200006 <- crop(P_200006, UTAH)  
UTAH_P_200007 <- crop(P_200007, UTAH)  
UTAH_P_200008 <- crop(P_200008, UTAH)  
UTAH_P_200009 <- crop(P_200009, UTAH)  
UTAH_P_200010 <- crop(P_200010, UTAH)  
UTAH_P_200011 <- crop(P_200011, UTAH)  
UTAH_P_200012 <- crop(P_200012, UTAH)  
#2001
UTAH_P_200101 <- crop(P_200101, UTAH) 
UTAH_P_200102 <- crop(P_200102, UTAH)
UTAH_P_200103 <- crop(P_200103, UTAH)
UTAH_P_200104 <- crop(P_200104, UTAH)
UTAH_P_200105 <- crop(P_200105, UTAH)
UTAH_P_200106 <- crop(P_200106, UTAH)  
UTAH_P_200107 <- crop(P_200107, UTAH)  
UTAH_P_200108 <- crop(P_200108, UTAH)  
UTAH_P_200109 <- crop(P_200109, UTAH)  
UTAH_P_200110 <- crop(P_200110, UTAH)  
UTAH_P_200111 <- crop(P_200111, UTAH)  
UTAH_P_200112 <- crop(P_200112, UTAH)  

#2002
UTAH_P_200201 <- crop(P_200201, UTAH) 
UTAH_P_200202 <- crop(P_200202, UTAH)
UTAH_P_200203 <- crop(P_200203, UTAH)
UTAH_P_200204 <- crop(P_200204, UTAH)
UTAH_P_200205 <- crop(P_200205, UTAH)
UTAH_P_200206 <- crop(P_200206, UTAH)  
UTAH_P_200207 <- crop(P_200207, UTAH)  
UTAH_P_200208 <- crop(P_200208, UTAH)  
UTAH_P_200209 <- crop(P_200209, UTAH)  
UTAH_P_200210 <- crop(P_200210, UTAH)  
UTAH_P_200211 <- crop(P_200211, UTAH)  
UTAH_P_200212 <- crop(P_200212, UTAH)  
#2003
UTAH_P_200301 <- crop(P_200301, UTAH) 
UTAH_P_200302 <- crop(P_200302, UTAH)
UTAH_P_200303 <- crop(P_200303, UTAH)
UTAH_P_200304 <- crop(P_200304, UTAH)
UTAH_P_200305 <- crop(P_200305, UTAH)
UTAH_P_200306 <- crop(P_200306, UTAH)  
UTAH_P_200307 <- crop(P_200307, UTAH)  
UTAH_P_200308 <- crop(P_200308, UTAH)  
UTAH_P_200309 <- crop(P_200309, UTAH)  
UTAH_P_200310 <- crop(P_200310, UTAH)  
UTAH_P_200311 <- crop(P_200311, UTAH)  
UTAH_P_200312 <- crop(P_200312, UTAH)  
#2004
UTAH_P_200401 <- crop(P_200401, UTAH) 
UTAH_P_200402 <- crop(P_200402, UTAH)
UTAH_P_200403 <- crop(P_200403, UTAH)
UTAH_P_200404 <- crop(P_200404, UTAH)
UTAH_P_200405 <- crop(P_200405, UTAH)
UTAH_P_200406 <- crop(P_200406, UTAH)  
UTAH_P_200407 <- crop(P_200407, UTAH)  
UTAH_P_200408 <- crop(P_200408, UTAH)  
UTAH_P_200409 <- crop(P_200409, UTAH)  
UTAH_P_200410 <- crop(P_200410, UTAH)  
UTAH_P_200411 <- crop(P_200411, UTAH)  
UTAH_P_200412 <- crop(P_200412, UTAH)  
#2005
UTAH_P_200501 <- crop(P_200501, UTAH) 
UTAH_P_200502 <- crop(P_200502, UTAH)
UTAH_P_200503 <- crop(P_200503, UTAH)
UTAH_P_200504 <- crop(P_200504, UTAH)
UTAH_P_200505 <- crop(P_200505, UTAH)
UTAH_P_200506 <- crop(P_200506, UTAH)  
UTAH_P_200507 <- crop(P_200507, UTAH)  
UTAH_P_200508 <- crop(P_200508, UTAH)  
UTAH_P_200509 <- crop(P_200509, UTAH)  
UTAH_P_200510 <- crop(P_200510, UTAH)  
UTAH_P_200511 <- crop(P_200511, UTAH)  
UTAH_P_200512 <- crop(P_200512, UTAH)  
#2006
UTAH_P_200601 <- crop(P_200601, UTAH) 
UTAH_P_200602 <- crop(P_200602, UTAH)
UTAH_P_200603 <- crop(P_200603, UTAH)
UTAH_P_200604 <- crop(P_200604, UTAH)
UTAH_P_200605 <- crop(P_200605, UTAH)
UTAH_P_200606 <- crop(P_200606, UTAH)  
UTAH_P_200607 <- crop(P_200607, UTAH)  
UTAH_P_200608 <- crop(P_200608, UTAH)  
UTAH_P_200609 <- crop(P_200609, UTAH)  
UTAH_P_200610 <- crop(P_200610, UTAH)  
UTAH_P_200611 <- crop(P_200611, UTAH)  
UTAH_P_200612 <- crop(P_200612, UTAH)  
#2007
UTAH_P_200701 <- crop(P_200701, UTAH) 
UTAH_P_200702 <- crop(P_200702, UTAH)
UTAH_P_200703 <- crop(P_200703, UTAH)
UTAH_P_200704 <- crop(P_200704, UTAH)
UTAH_P_200705 <- crop(P_200705, UTAH)
UTAH_P_200706 <- crop(P_200706, UTAH)  
UTAH_P_200707 <- crop(P_200707, UTAH)  
UTAH_P_200708 <- crop(P_200708, UTAH)  
UTAH_P_200709 <- crop(P_200709, UTAH)  
UTAH_P_200710 <- crop(P_200710, UTAH)  
UTAH_P_200711 <- crop(P_200711, UTAH)  
UTAH_P_200712 <- crop(P_200712, UTAH)  
#2008
UTAH_P_200801 <- crop(P_200801, UTAH) 
UTAH_P_200802 <- crop(P_200802, UTAH)
UTAH_P_200803 <- crop(P_200803, UTAH)
UTAH_P_200804 <- crop(P_200804, UTAH)
UTAH_P_200805 <- crop(P_200805, UTAH)
UTAH_P_200806 <- crop(P_200806, UTAH)  
UTAH_P_200807 <- crop(P_200807, UTAH)  
UTAH_P_200808 <- crop(P_200808, UTAH)  
UTAH_P_200809 <- crop(P_200809, UTAH)  
UTAH_P_200810 <- crop(P_200810, UTAH)  
UTAH_P_200811 <- crop(P_200811, UTAH)  
UTAH_P_200812 <- crop(P_200812, UTAH)  
#2009
UTAH_P_200901 <- crop(P_200901, UTAH) 
UTAH_P_200902 <- crop(P_200902, UTAH)
UTAH_P_200903 <- crop(P_200903, UTAH)
UTAH_P_200904 <- crop(P_200904, UTAH)
UTAH_P_200905 <- crop(P_200905, UTAH)
UTAH_P_200906 <- crop(P_200906, UTAH)  
UTAH_P_200907 <- crop(P_200907, UTAH)  
UTAH_P_200908 <- crop(P_200908, UTAH)  
UTAH_P_200909 <- crop(P_200909, UTAH)  
UTAH_P_200910 <- crop(P_200910, UTAH)  
UTAH_P_200911 <- crop(P_200911, UTAH)  
UTAH_P_200912 <- crop(P_200912, UTAH)  
#2010
UTAH_P_201001 <- crop(P_201001, UTAH) 
UTAH_P_201002 <- crop(P_201002, UTAH)
UTAH_P_201003 <- crop(P_201003, UTAH)
UTAH_P_201004 <- crop(P_201004, UTAH)
UTAH_P_201005 <- crop(P_201005, UTAH)
UTAH_P_201006 <- crop(P_201006, UTAH)  
UTAH_P_201007 <- crop(P_201007, UTAH)  
UTAH_P_201008 <- crop(P_201008, UTAH)  
UTAH_P_201009 <- crop(P_201009, UTAH)  
UTAH_P_201010 <- crop(P_201010, UTAH)  
UTAH_P_201011 <- crop(P_201011, UTAH)  
UTAH_P_201012 <- crop(P_201012, UTAH)  
#2011
UTAH_P_201101 <- crop(P_201101, UTAH) 
UTAH_P_201102 <- crop(P_201102, UTAH)
UTAH_P_201103 <- crop(P_201103, UTAH)
UTAH_P_201104 <- crop(P_201104, UTAH)
UTAH_P_201105 <- crop(P_201105, UTAH)
UTAH_P_201106 <- crop(P_201106, UTAH)  
UTAH_P_201107 <- crop(P_201107, UTAH)  
UTAH_P_201108 <- crop(P_201108, UTAH)  
UTAH_P_201109 <- crop(P_201109, UTAH)  
UTAH_P_201110 <- crop(P_201110, UTAH)  
UTAH_P_201111 <- crop(P_201111, UTAH)  
UTAH_P_201112 <- crop(P_201112, UTAH)  
#2012
UTAH_P_201201 <- crop(P_201201, UTAH) 
UTAH_P_201202 <- crop(P_201202, UTAH)
UTAH_P_201203 <- crop(P_201203, UTAH)
UTAH_P_201204 <- crop(P_201204, UTAH)
UTAH_P_201205 <- crop(P_201205, UTAH)
UTAH_P_201206 <- crop(P_201206, UTAH)  
UTAH_P_201207 <- crop(P_201207, UTAH)  
UTAH_P_201208 <- crop(P_201208, UTAH)  
UTAH_P_201209 <- crop(P_201209, UTAH)  
UTAH_P_201210 <- crop(P_201210, UTAH)  
UTAH_P_201211 <- crop(P_201211, UTAH)  
UTAH_P_201212 <- crop(P_201212, UTAH)  
#2013
UTAH_P_201301 <- crop(P_201301, UTAH) 
UTAH_P_201302 <- crop(P_201302, UTAH)
UTAH_P_201303 <- crop(P_201303, UTAH)
UTAH_P_201304 <- crop(P_201304, UTAH)
UTAH_P_201305 <- crop(P_201305, UTAH)
UTAH_P_201306 <- crop(P_201306, UTAH)  
UTAH_P_201307 <- crop(P_201307, UTAH)  
UTAH_P_201308 <- crop(P_201308, UTAH)  
UTAH_P_201309 <- crop(P_201309, UTAH)  
UTAH_P_201310 <- crop(P_201310, UTAH)  
UTAH_P_201311 <- crop(P_201311, UTAH)  
UTAH_P_201312 <- crop(P_201312, UTAH)  
#2014
UTAH_P_201401 <- crop(P_201401, UTAH) 
UTAH_P_201402 <- crop(P_201402, UTAH)
UTAH_P_201403 <- crop(P_201403, UTAH)
UTAH_P_201404 <- crop(P_201404, UTAH)
UTAH_P_201405 <- crop(P_201405, UTAH)
UTAH_P_201406 <- crop(P_201406, UTAH)  
UTAH_P_201407 <- crop(P_201407, UTAH)  
UTAH_P_201408 <- crop(P_201408, UTAH)  
UTAH_P_201409 <- crop(P_201409, UTAH)  
UTAH_P_201410 <- crop(P_201410, UTAH)  
UTAH_P_201411 <- crop(P_201411, UTAH)  
UTAH_P_201412 <- crop(P_201412, UTAH)  
#2015
UTAH_P_201501 <- crop(P_201501, UTAH) 
UTAH_P_201502 <- crop(P_201502, UTAH)
UTAH_P_201503 <- crop(P_201503, UTAH)
UTAH_P_201504 <- crop(P_201504, UTAH)
UTAH_P_201505 <- crop(P_201505, UTAH)
UTAH_P_201506 <- crop(P_201506, UTAH)  
UTAH_P_201507 <- crop(P_201507, UTAH)  
UTAH_P_201508 <- crop(P_201508, UTAH)  
UTAH_P_201509 <- crop(P_201509, UTAH)  
UTAH_P_201510 <- crop(P_201510, UTAH)  
UTAH_P_201511 <- crop(P_201511, UTAH)  
UTAH_P_201512 <- crop(P_201512, UTAH)  
#2016
UTAH_P_201601 <- crop(P_201601, UTAH) 
UTAH_P_201602 <- crop(P_201602, UTAH)
UTAH_P_201603 <- crop(P_201603, UTAH)
UTAH_P_201604 <- crop(P_201604, UTAH)
UTAH_P_201605 <- crop(P_201605, UTAH)
UTAH_P_201606 <- crop(P_201606, UTAH)  
UTAH_P_201607 <- crop(P_201607, UTAH)  
UTAH_P_201608 <- crop(P_201608, UTAH)  
UTAH_P_201609 <- crop(P_201609, UTAH)  
UTAH_P_201610 <- crop(P_201610, UTAH)  
UTAH_P_201611 <- crop(P_201611, UTAH)  
UTAH_P_201612 <- crop(P_201612, UTAH)  
#2017
UTAH_P_201701 <- crop(P_201701, UTAH) 
UTAH_P_201702 <- crop(P_201702, UTAH)
UTAH_P_201703 <- crop(P_201703, UTAH)
UTAH_P_201704 <- crop(P_201704, UTAH)
UTAH_P_201705 <- crop(P_201705, UTAH)
UTAH_P_201706 <- crop(P_201706, UTAH)  
UTAH_P_201707 <- crop(P_201707, UTAH)  
UTAH_P_201708 <- crop(P_201708, UTAH)  
UTAH_P_201709 <- crop(P_201709, UTAH)  
UTAH_P_201710 <- crop(P_201710, UTAH)  
UTAH_P_201711 <- crop(P_201711, UTAH)  
UTAH_P_201712 <- crop(P_201712, UTAH)  

#2018

UTAH_P_201801 <- crop(P_201801, UTAH) 
UTAH_P_201802 <- crop(P_201802, UTAH)
UTAH_P_201803 <- crop(P_201803, UTAH)
UTAH_P_201804 <- crop(P_201804, UTAH)
UTAH_P_201805 <- crop(P_201805, UTAH)
UTAH_P_201806 <- crop(P_201806, UTAH)  
UTAH_P_201807 <- crop(P_201807, UTAH)  
UTAH_P_201808 <- crop(P_201808, UTAH)  
UTAH_P_201809 <- crop(P_201809, UTAH)  
UTAH_P_201810 <- crop(P_201810, UTAH)  
UTAH_P_201811 <- crop(P_201811, UTAH)  
UTAH_P_201812 <- crop(P_201812, UTAH)  


# Mean Monthly Precipitation
#2000
UTAH_P_200001_mean <- cellStats(UTAH_P_200001, mean)
UTAH_P_200002_mean <- cellStats(UTAH_P_200002, mean)
UTAH_P_200003_mean <- cellStats(UTAH_P_200003, mean)
UTAH_P_200004_mean <- cellStats(UTAH_P_200004, mean)
UTAH_P_200005_mean <- cellStats(UTAH_P_200005, mean)
UTAH_P_200006_mean <- cellStats(UTAH_P_200006, mean)
UTAH_P_200007_mean <- cellStats(UTAH_P_200007, mean)
UTAH_P_200008_mean <- cellStats(UTAH_P_200008, mean)
UTAH_P_200009_mean <- cellStats(UTAH_P_200009, mean)
UTAH_P_200010_mean <- cellStats(UTAH_P_200010, mean)
UTAH_P_200011_mean <- cellStats(UTAH_P_200011, mean)
UTAH_P_200012_mean <- cellStats(UTAH_P_200012, mean)
#2001
UTAH_P_200101_mean <- cellStats(UTAH_P_200101, mean)
UTAH_P_200102_mean <- cellStats(UTAH_P_200102, mean)
UTAH_P_200103_mean <- cellStats(UTAH_P_200103, mean)
UTAH_P_200104_mean <- cellStats(UTAH_P_200104, mean)
UTAH_P_200105_mean <- cellStats(UTAH_P_200105, mean)
UTAH_P_200106_mean <- cellStats(UTAH_P_200106, mean)
UTAH_P_200107_mean <- cellStats(UTAH_P_200107, mean)
UTAH_P_200108_mean <- cellStats(UTAH_P_200108, mean)
UTAH_P_200109_mean <- cellStats(UTAH_P_200109, mean)
UTAH_P_200110_mean <- cellStats(UTAH_P_200110, mean)
UTAH_P_200111_mean <- cellStats(UTAH_P_200111, mean)
UTAH_P_200112_mean <- cellStats(UTAH_P_200112, mean)

#2002
UTAH_P_200201_mean <- cellStats(UTAH_P_200201, mean)
UTAH_P_200202_mean <- cellStats(UTAH_P_200202, mean)
UTAH_P_200203_mean <- cellStats(UTAH_P_200203, mean)
UTAH_P_200204_mean <- cellStats(UTAH_P_200204, mean)
UTAH_P_200205_mean <- cellStats(UTAH_P_200205, mean)
UTAH_P_200206_mean <- cellStats(UTAH_P_200206, mean)
UTAH_P_200207_mean <- cellStats(UTAH_P_200207, mean)
UTAH_P_200208_mean <- cellStats(UTAH_P_200208, mean)
UTAH_P_200209_mean <- cellStats(UTAH_P_200209, mean)
UTAH_P_200210_mean <- cellStats(UTAH_P_200210, mean)
UTAH_P_200211_mean <- cellStats(UTAH_P_200211, mean)
UTAH_P_200212_mean <- cellStats(UTAH_P_200212, mean)

#2003
UTAH_P_200301_mean <- cellStats(UTAH_P_200301, mean)
UTAH_P_200302_mean <- cellStats(UTAH_P_200302, mean)
UTAH_P_200303_mean <- cellStats(UTAH_P_200303, mean)
UTAH_P_200304_mean <- cellStats(UTAH_P_200304, mean)
UTAH_P_200305_mean <- cellStats(UTAH_P_200305, mean)
UTAH_P_200306_mean <- cellStats(UTAH_P_200306, mean)
UTAH_P_200307_mean <- cellStats(UTAH_P_200307, mean)
UTAH_P_200308_mean <- cellStats(UTAH_P_200308, mean)
UTAH_P_200309_mean <- cellStats(UTAH_P_200309, mean)
UTAH_P_200310_mean <- cellStats(UTAH_P_200310, mean)
UTAH_P_200311_mean <- cellStats(UTAH_P_200311, mean)
UTAH_P_200312_mean <- cellStats(UTAH_P_200312, mean)

#2004

UTAH_P_200401_mean <- cellStats(UTAH_P_200401, mean)
UTAH_P_200402_mean <- cellStats(UTAH_P_200402, mean)
UTAH_P_200403_mean <- cellStats(UTAH_P_200403, mean)
UTAH_P_200404_mean <- cellStats(UTAH_P_200404, mean)
UTAH_P_200405_mean <- cellStats(UTAH_P_200405, mean)
UTAH_P_200406_mean <- cellStats(UTAH_P_200406, mean)
UTAH_P_200407_mean <- cellStats(UTAH_P_200407, mean)
UTAH_P_200408_mean <- cellStats(UTAH_P_200408, mean)
UTAH_P_200409_mean <- cellStats(UTAH_P_200409, mean)
UTAH_P_200410_mean <- cellStats(UTAH_P_200410, mean)
UTAH_P_200411_mean <- cellStats(UTAH_P_200411, mean)
UTAH_P_200412_mean <- cellStats(UTAH_P_200412, mean)

#2005

UTAH_P_200501_mean <- cellStats(UTAH_P_200501, mean)
UTAH_P_200502_mean <- cellStats(UTAH_P_200502, mean)
UTAH_P_200503_mean <- cellStats(UTAH_P_200503, mean)
UTAH_P_200504_mean <- cellStats(UTAH_P_200504, mean)
UTAH_P_200505_mean <- cellStats(UTAH_P_200505, mean)
UTAH_P_200506_mean <- cellStats(UTAH_P_200506, mean)
UTAH_P_200507_mean <- cellStats(UTAH_P_200507, mean)
UTAH_P_200508_mean <- cellStats(UTAH_P_200508, mean)
UTAH_P_200509_mean <- cellStats(UTAH_P_200509, mean)
UTAH_P_200510_mean <- cellStats(UTAH_P_200510, mean)
UTAH_P_200511_mean <- cellStats(UTAH_P_200511, mean)
UTAH_P_200512_mean <- cellStats(UTAH_P_200512, mean)

#2006

UTAH_P_200601_mean <- cellStats(UTAH_P_200601, mean)
UTAH_P_200602_mean <- cellStats(UTAH_P_200602, mean)
UTAH_P_200603_mean <- cellStats(UTAH_P_200603, mean)
UTAH_P_200604_mean <- cellStats(UTAH_P_200604, mean)
UTAH_P_200605_mean <- cellStats(UTAH_P_200605, mean)
UTAH_P_200606_mean <- cellStats(UTAH_P_200606, mean)
UTAH_P_200607_mean <- cellStats(UTAH_P_200607, mean)
UTAH_P_200608_mean <- cellStats(UTAH_P_200608, mean)
UTAH_P_200609_mean <- cellStats(UTAH_P_200609, mean)
UTAH_P_200610_mean <- cellStats(UTAH_P_200610, mean)
UTAH_P_200611_mean <- cellStats(UTAH_P_200611, mean)
UTAH_P_200612_mean <- cellStats(UTAH_P_200612, mean)

#2007

UTAH_P_200701_mean <- cellStats(UTAH_P_200701, mean)
UTAH_P_200702_mean <- cellStats(UTAH_P_200702, mean)
UTAH_P_200703_mean <- cellStats(UTAH_P_200703, mean)
UTAH_P_200704_mean <- cellStats(UTAH_P_200704, mean)
UTAH_P_200705_mean <- cellStats(UTAH_P_200705, mean)
UTAH_P_200706_mean <- cellStats(UTAH_P_200706, mean)
UTAH_P_200707_mean <- cellStats(UTAH_P_200707, mean)
UTAH_P_200708_mean <- cellStats(UTAH_P_200708, mean)
UTAH_P_200709_mean <- cellStats(UTAH_P_200709, mean)
UTAH_P_200710_mean <- cellStats(UTAH_P_200710, mean)
UTAH_P_200711_mean <- cellStats(UTAH_P_200711, mean)
UTAH_P_200712_mean <- cellStats(UTAH_P_200712, mean)

#2008

UTAH_P_200801_mean <- cellStats(UTAH_P_200801, mean)
UTAH_P_200802_mean <- cellStats(UTAH_P_200802, mean)
UTAH_P_200803_mean <- cellStats(UTAH_P_200803, mean)
UTAH_P_200804_mean <- cellStats(UTAH_P_200804, mean)
UTAH_P_200805_mean <- cellStats(UTAH_P_200805, mean)
UTAH_P_200806_mean <- cellStats(UTAH_P_200806, mean)
UTAH_P_200807_mean <- cellStats(UTAH_P_200807, mean)
UTAH_P_200808_mean <- cellStats(UTAH_P_200808, mean)
UTAH_P_200809_mean <- cellStats(UTAH_P_200809, mean)
UTAH_P_200810_mean <- cellStats(UTAH_P_200810, mean)
UTAH_P_200811_mean <- cellStats(UTAH_P_200811, mean)
UTAH_P_200812_mean <- cellStats(UTAH_P_200812, mean)

#2009

UTAH_P_200901_mean <- cellStats(UTAH_P_200901, mean)
UTAH_P_200902_mean <- cellStats(UTAH_P_200902, mean)
UTAH_P_200903_mean <- cellStats(UTAH_P_200903, mean)
UTAH_P_200904_mean <- cellStats(UTAH_P_200904, mean)
UTAH_P_200905_mean <- cellStats(UTAH_P_200905, mean)
UTAH_P_200906_mean <- cellStats(UTAH_P_200906, mean)
UTAH_P_200907_mean <- cellStats(UTAH_P_200907, mean)
UTAH_P_200908_mean <- cellStats(UTAH_P_200908, mean)
UTAH_P_200909_mean <- cellStats(UTAH_P_200909, mean)
UTAH_P_200910_mean <- cellStats(UTAH_P_200910, mean)
UTAH_P_200911_mean <- cellStats(UTAH_P_200911, mean)
UTAH_P_200912_mean <- cellStats(UTAH_P_200912, mean)

#2010

UTAH_P_201001_mean <- cellStats(UTAH_P_201001, mean)
UTAH_P_201002_mean <- cellStats(UTAH_P_201002, mean)
UTAH_P_201003_mean <- cellStats(UTAH_P_201003, mean)
UTAH_P_201004_mean <- cellStats(UTAH_P_201004, mean)
UTAH_P_201005_mean <- cellStats(UTAH_P_201005, mean)
UTAH_P_201006_mean <- cellStats(UTAH_P_201006, mean)
UTAH_P_201007_mean <- cellStats(UTAH_P_201007, mean)
UTAH_P_201008_mean <- cellStats(UTAH_P_201008, mean)
UTAH_P_201009_mean <- cellStats(UTAH_P_201009, mean)
UTAH_P_201010_mean <- cellStats(UTAH_P_201010, mean)
UTAH_P_201011_mean <- cellStats(UTAH_P_201011, mean)
UTAH_P_201012_mean <- cellStats(UTAH_P_201012, mean)

#2011

UTAH_P_201101_mean <- cellStats(UTAH_P_201101, mean)
UTAH_P_201102_mean <- cellStats(UTAH_P_201102, mean)
UTAH_P_201103_mean <- cellStats(UTAH_P_201103, mean)
UTAH_P_201104_mean <- cellStats(UTAH_P_201104, mean)
UTAH_P_201105_mean <- cellStats(UTAH_P_201105, mean)
UTAH_P_201106_mean <- cellStats(UTAH_P_201106, mean)
UTAH_P_201107_mean <- cellStats(UTAH_P_201107, mean)
UTAH_P_201108_mean <- cellStats(UTAH_P_201108, mean)
UTAH_P_201109_mean <- cellStats(UTAH_P_201109, mean)
UTAH_P_201110_mean <- cellStats(UTAH_P_201110, mean)
UTAH_P_201111_mean <- cellStats(UTAH_P_201111, mean)
UTAH_P_201112_mean <- cellStats(UTAH_P_201112, mean)

#2012
UTAH_P_201201_mean <- cellStats(UTAH_P_201201, mean)
UTAH_P_201202_mean <- cellStats(UTAH_P_201202, mean)
UTAH_P_201203_mean <- cellStats(UTAH_P_201203, mean)
UTAH_P_201204_mean <- cellStats(UTAH_P_201204, mean)
UTAH_P_201205_mean <- cellStats(UTAH_P_201205, mean)
UTAH_P_201206_mean <- cellStats(UTAH_P_201206, mean)
UTAH_P_201207_mean <- cellStats(UTAH_P_201207, mean)
UTAH_P_201208_mean <- cellStats(UTAH_P_201208, mean)
UTAH_P_201209_mean <- cellStats(UTAH_P_201209, mean)
UTAH_P_201210_mean <- cellStats(UTAH_P_201210, mean)
UTAH_P_201211_mean <- cellStats(UTAH_P_201211, mean)
UTAH_P_201212_mean <- cellStats(UTAH_P_201212, mean)

#2013
UTAH_P_201301_mean <- cellStats(UTAH_P_201301, mean)
UTAH_P_201302_mean <- cellStats(UTAH_P_201302, mean)
UTAH_P_201303_mean <- cellStats(UTAH_P_201303, mean)
UTAH_P_201304_mean <- cellStats(UTAH_P_201304, mean)
UTAH_P_201305_mean <- cellStats(UTAH_P_201305, mean)
UTAH_P_201306_mean <- cellStats(UTAH_P_201306, mean)
UTAH_P_201307_mean <- cellStats(UTAH_P_201307, mean)
UTAH_P_201308_mean <- cellStats(UTAH_P_201308, mean)
UTAH_P_201309_mean <- cellStats(UTAH_P_201309, mean)
UTAH_P_201310_mean <- cellStats(UTAH_P_201310, mean)
UTAH_P_201311_mean <- cellStats(UTAH_P_201311, mean)
UTAH_P_201312_mean <- cellStats(UTAH_P_201312, mean)

#2014
UTAH_P_201401_mean <- cellStats(UTAH_P_201401, mean)
UTAH_P_201402_mean <- cellStats(UTAH_P_201402, mean)
UTAH_P_201403_mean <- cellStats(UTAH_P_201403, mean)
UTAH_P_201404_mean <- cellStats(UTAH_P_201404, mean)
UTAH_P_201405_mean <- cellStats(UTAH_P_201405, mean)
UTAH_P_201406_mean <- cellStats(UTAH_P_201406, mean)
UTAH_P_201407_mean <- cellStats(UTAH_P_201407, mean)
UTAH_P_201408_mean <- cellStats(UTAH_P_201408, mean)
UTAH_P_201409_mean <- cellStats(UTAH_P_201409, mean)
UTAH_P_201410_mean <- cellStats(UTAH_P_201410, mean)
UTAH_P_201411_mean <- cellStats(UTAH_P_201411, mean)
UTAH_P_201412_mean <- cellStats(UTAH_P_201412, mean)

#2015
UTAH_P_201501_mean <- cellStats(UTAH_P_201501, mean)
UTAH_P_201502_mean <- cellStats(UTAH_P_201502, mean)
UTAH_P_201503_mean <- cellStats(UTAH_P_201503, mean)
UTAH_P_201504_mean <- cellStats(UTAH_P_201504, mean)
UTAH_P_201505_mean <- cellStats(UTAH_P_201505, mean)
UTAH_P_201506_mean <- cellStats(UTAH_P_201506, mean)
UTAH_P_201507_mean <- cellStats(UTAH_P_201507, mean)
UTAH_P_201508_mean <- cellStats(UTAH_P_201508, mean)
UTAH_P_201509_mean <- cellStats(UTAH_P_201509, mean)
UTAH_P_201510_mean <- cellStats(UTAH_P_201510, mean)
UTAH_P_201511_mean <- cellStats(UTAH_P_201511, mean)
UTAH_P_201512_mean <- cellStats(UTAH_P_201512, mean)

#2016
UTAH_P_201601_mean <- cellStats(UTAH_P_201601, mean)
UTAH_P_201602_mean <- cellStats(UTAH_P_201602, mean)
UTAH_P_201603_mean <- cellStats(UTAH_P_201603, mean)
UTAH_P_201604_mean <- cellStats(UTAH_P_201604, mean)
UTAH_P_201605_mean <- cellStats(UTAH_P_201605, mean)
UTAH_P_201606_mean <- cellStats(UTAH_P_201606, mean)
UTAH_P_201607_mean <- cellStats(UTAH_P_201607, mean)
UTAH_P_201608_mean <- cellStats(UTAH_P_201608, mean)
UTAH_P_201609_mean <- cellStats(UTAH_P_201609, mean)
UTAH_P_201610_mean <- cellStats(UTAH_P_201610, mean)
UTAH_P_201611_mean <- cellStats(UTAH_P_201611, mean)
UTAH_P_201612_mean <- cellStats(UTAH_P_201612, mean)

#2017
UTAH_P_201701_mean <- cellStats(UTAH_P_201701, mean)
UTAH_P_201702_mean <- cellStats(UTAH_P_201702, mean)
UTAH_P_201703_mean <- cellStats(UTAH_P_201703, mean)
UTAH_P_201704_mean <- cellStats(UTAH_P_201704, mean)
UTAH_P_201705_mean <- cellStats(UTAH_P_201705, mean)
UTAH_P_201706_mean <- cellStats(UTAH_P_201706, mean)
UTAH_P_201707_mean <- cellStats(UTAH_P_201707, mean)
UTAH_P_201708_mean <- cellStats(UTAH_P_201708, mean)
UTAH_P_201709_mean <- cellStats(UTAH_P_201709, mean)
UTAH_P_201710_mean <- cellStats(UTAH_P_201710, mean)
UTAH_P_201711_mean <- cellStats(UTAH_P_201711, mean)
UTAH_P_201712_mean <- cellStats(UTAH_P_201712, mean)

#2018
UTAH_P_201801_mean <- cellStats(UTAH_P_201801, mean)
UTAH_P_201802_mean <- cellStats(UTAH_P_201802, mean)
UTAH_P_201803_mean <- cellStats(UTAH_P_201803, mean)
UTAH_P_201804_mean <- cellStats(UTAH_P_201804, mean)
UTAH_P_201805_mean <- cellStats(UTAH_P_201805, mean)
UTAH_P_201806_mean <- cellStats(UTAH_P_201806, mean)
UTAH_P_201807_mean <- cellStats(UTAH_P_201807, mean)
UTAH_P_201808_mean <- cellStats(UTAH_P_201808, mean)
UTAH_P_201809_mean <- cellStats(UTAH_P_201809, mean)
UTAH_P_201810_mean <- cellStats(UTAH_P_201810, mean)
UTAH_P_201811_mean <- cellStats(UTAH_P_201811, mean)
UTAH_P_201812_mean <- cellStats(UTAH_P_201812, mean)

# UINTAH

#2000
UINTAH_P_200001 <- crop(P_200001, UINTAH) 
UINTAH_P_200002 <- crop(P_200002, UINTAH)
UINTAH_P_200003 <- crop(P_200003, UINTAH)
UINTAH_P_200004 <- crop(P_200004, UINTAH)
UINTAH_P_200005 <- crop(P_200005, UINTAH)
UINTAH_P_200006 <- crop(P_200006, UINTAH)  
UINTAH_P_200007 <- crop(P_200007, UINTAH)  
UINTAH_P_200008 <- crop(P_200008, UINTAH)  
UINTAH_P_200009 <- crop(P_200009, UINTAH)  
UINTAH_P_200010 <- crop(P_200010, UINTAH)  
UINTAH_P_200011 <- crop(P_200011, UINTAH)  
UINTAH_P_200012 <- crop(P_200012, UINTAH)  
#2001
UINTAH_P_200101 <- crop(P_200101, UINTAH) 
UINTAH_P_200102 <- crop(P_200102, UINTAH)
UINTAH_P_200103 <- crop(P_200103, UINTAH)
UINTAH_P_200104 <- crop(P_200104, UINTAH)
UINTAH_P_200105 <- crop(P_200105, UINTAH)
UINTAH_P_200106 <- crop(P_200106, UINTAH)  
UINTAH_P_200107 <- crop(P_200107, UINTAH)  
UINTAH_P_200108 <- crop(P_200108, UINTAH)  
UINTAH_P_200109 <- crop(P_200109, UINTAH)  
UINTAH_P_200110 <- crop(P_200110, UINTAH)  
UINTAH_P_200111 <- crop(P_200111, UINTAH)  
UINTAH_P_200112 <- crop(P_200112, UINTAH)  

#2002
UINTAH_P_200201 <- crop(P_200201, UINTAH) 
UINTAH_P_200202 <- crop(P_200202, UINTAH)
UINTAH_P_200203 <- crop(P_200203, UINTAH)
UINTAH_P_200204 <- crop(P_200204, UINTAH)
UINTAH_P_200205 <- crop(P_200205, UINTAH)
UINTAH_P_200206 <- crop(P_200206, UINTAH)  
UINTAH_P_200207 <- crop(P_200207, UINTAH)  
UINTAH_P_200208 <- crop(P_200208, UINTAH)  
UINTAH_P_200209 <- crop(P_200209, UINTAH)  
UINTAH_P_200210 <- crop(P_200210, UINTAH)  
UINTAH_P_200211 <- crop(P_200211, UINTAH)  
UINTAH_P_200212 <- crop(P_200212, UINTAH)  
#2003
UINTAH_P_200301 <- crop(P_200301, UINTAH) 
UINTAH_P_200302 <- crop(P_200302, UINTAH)
UINTAH_P_200303 <- crop(P_200303, UINTAH)
UINTAH_P_200304 <- crop(P_200304, UINTAH)
UINTAH_P_200305 <- crop(P_200305, UINTAH)
UINTAH_P_200306 <- crop(P_200306, UINTAH)  
UINTAH_P_200307 <- crop(P_200307, UINTAH)  
UINTAH_P_200308 <- crop(P_200308, UINTAH)  
UINTAH_P_200309 <- crop(P_200309, UINTAH)  
UINTAH_P_200310 <- crop(P_200310, UINTAH)  
UINTAH_P_200311 <- crop(P_200311, UINTAH)  
UINTAH_P_200312 <- crop(P_200312, UINTAH)  
#2004
UINTAH_P_200401 <- crop(P_200401, UINTAH) 
UINTAH_P_200402 <- crop(P_200402, UINTAH)
UINTAH_P_200403 <- crop(P_200403, UINTAH)
UINTAH_P_200404 <- crop(P_200404, UINTAH)
UINTAH_P_200405 <- crop(P_200405, UINTAH)
UINTAH_P_200406 <- crop(P_200406, UINTAH)  
UINTAH_P_200407 <- crop(P_200407, UINTAH)  
UINTAH_P_200408 <- crop(P_200408, UINTAH)  
UINTAH_P_200409 <- crop(P_200409, UINTAH)  
UINTAH_P_200410 <- crop(P_200410, UINTAH)  
UINTAH_P_200411 <- crop(P_200411, UINTAH)  
UINTAH_P_200412 <- crop(P_200412, UINTAH)  
#2005
UINTAH_P_200501 <- crop(P_200501, UINTAH) 
UINTAH_P_200502 <- crop(P_200502, UINTAH)
UINTAH_P_200503 <- crop(P_200503, UINTAH)
UINTAH_P_200504 <- crop(P_200504, UINTAH)
UINTAH_P_200505 <- crop(P_200505, UINTAH)
UINTAH_P_200506 <- crop(P_200506, UINTAH)  
UINTAH_P_200507 <- crop(P_200507, UINTAH)  
UINTAH_P_200508 <- crop(P_200508, UINTAH)  
UINTAH_P_200509 <- crop(P_200509, UINTAH)  
UINTAH_P_200510 <- crop(P_200510, UINTAH)  
UINTAH_P_200511 <- crop(P_200511, UINTAH)  
UINTAH_P_200512 <- crop(P_200512, UINTAH)  
#2006
UINTAH_P_200601 <- crop(P_200601, UINTAH) 
UINTAH_P_200602 <- crop(P_200602, UINTAH)
UINTAH_P_200603 <- crop(P_200603, UINTAH)
UINTAH_P_200604 <- crop(P_200604, UINTAH)
UINTAH_P_200605 <- crop(P_200605, UINTAH)
UINTAH_P_200606 <- crop(P_200606, UINTAH)  
UINTAH_P_200607 <- crop(P_200607, UINTAH)  
UINTAH_P_200608 <- crop(P_200608, UINTAH)  
UINTAH_P_200609 <- crop(P_200609, UINTAH)  
UINTAH_P_200610 <- crop(P_200610, UINTAH)  
UINTAH_P_200611 <- crop(P_200611, UINTAH)  
UINTAH_P_200612 <- crop(P_200612, UINTAH)  
#2007
UINTAH_P_200701 <- crop(P_200701, UINTAH) 
UINTAH_P_200702 <- crop(P_200702, UINTAH)
UINTAH_P_200703 <- crop(P_200703, UINTAH)
UINTAH_P_200704 <- crop(P_200704, UINTAH)
UINTAH_P_200705 <- crop(P_200705, UINTAH)
UINTAH_P_200706 <- crop(P_200706, UINTAH)  
UINTAH_P_200707 <- crop(P_200707, UINTAH)  
UINTAH_P_200708 <- crop(P_200708, UINTAH)  
UINTAH_P_200709 <- crop(P_200709, UINTAH)  
UINTAH_P_200710 <- crop(P_200710, UINTAH)  
UINTAH_P_200711 <- crop(P_200711, UINTAH)  
UINTAH_P_200712 <- crop(P_200712, UINTAH)  
#2008
UINTAH_P_200801 <- crop(P_200801, UINTAH) 
UINTAH_P_200802 <- crop(P_200802, UINTAH)
UINTAH_P_200803 <- crop(P_200803, UINTAH)
UINTAH_P_200804 <- crop(P_200804, UINTAH)
UINTAH_P_200805 <- crop(P_200805, UINTAH)
UINTAH_P_200806 <- crop(P_200806, UINTAH)  
UINTAH_P_200807 <- crop(P_200807, UINTAH)  
UINTAH_P_200808 <- crop(P_200808, UINTAH)  
UINTAH_P_200809 <- crop(P_200809, UINTAH)  
UINTAH_P_200810 <- crop(P_200810, UINTAH)  
UINTAH_P_200811 <- crop(P_200811, UINTAH)  
UINTAH_P_200812 <- crop(P_200812, UINTAH)  
#2009
UINTAH_P_200901 <- crop(P_200901, UINTAH) 
UINTAH_P_200902 <- crop(P_200902, UINTAH)
UINTAH_P_200903 <- crop(P_200903, UINTAH)
UINTAH_P_200904 <- crop(P_200904, UINTAH)
UINTAH_P_200905 <- crop(P_200905, UINTAH)
UINTAH_P_200906 <- crop(P_200906, UINTAH)  
UINTAH_P_200907 <- crop(P_200907, UINTAH)  
UINTAH_P_200908 <- crop(P_200908, UINTAH)  
UINTAH_P_200909 <- crop(P_200909, UINTAH)  
UINTAH_P_200910 <- crop(P_200910, UINTAH)  
UINTAH_P_200911 <- crop(P_200911, UINTAH)  
UINTAH_P_200912 <- crop(P_200912, UINTAH)  
#2010
UINTAH_P_201001 <- crop(P_201001, UINTAH) 
UINTAH_P_201002 <- crop(P_201002, UINTAH)
UINTAH_P_201003 <- crop(P_201003, UINTAH)
UINTAH_P_201004 <- crop(P_201004, UINTAH)
UINTAH_P_201005 <- crop(P_201005, UINTAH)
UINTAH_P_201006 <- crop(P_201006, UINTAH)  
UINTAH_P_201007 <- crop(P_201007, UINTAH)  
UINTAH_P_201008 <- crop(P_201008, UINTAH)  
UINTAH_P_201009 <- crop(P_201009, UINTAH)  
UINTAH_P_201010 <- crop(P_201010, UINTAH)  
UINTAH_P_201011 <- crop(P_201011, UINTAH)  
UINTAH_P_201012 <- crop(P_201012, UINTAH)  
#2011
UINTAH_P_201101 <- crop(P_201101, UINTAH) 
UINTAH_P_201102 <- crop(P_201102, UINTAH)
UINTAH_P_201103 <- crop(P_201103, UINTAH)
UINTAH_P_201104 <- crop(P_201104, UINTAH)
UINTAH_P_201105 <- crop(P_201105, UINTAH)
UINTAH_P_201106 <- crop(P_201106, UINTAH)  
UINTAH_P_201107 <- crop(P_201107, UINTAH)  
UINTAH_P_201108 <- crop(P_201108, UINTAH)  
UINTAH_P_201109 <- crop(P_201109, UINTAH)  
UINTAH_P_201110 <- crop(P_201110, UINTAH)  
UINTAH_P_201111 <- crop(P_201111, UINTAH)  
UINTAH_P_201112 <- crop(P_201112, UINTAH)  
#2012
UINTAH_P_201201 <- crop(P_201201, UINTAH) 
UINTAH_P_201202 <- crop(P_201202, UINTAH)
UINTAH_P_201203 <- crop(P_201203, UINTAH)
UINTAH_P_201204 <- crop(P_201204, UINTAH)
UINTAH_P_201205 <- crop(P_201205, UINTAH)
UINTAH_P_201206 <- crop(P_201206, UINTAH)  
UINTAH_P_201207 <- crop(P_201207, UINTAH)  
UINTAH_P_201208 <- crop(P_201208, UINTAH)  
UINTAH_P_201209 <- crop(P_201209, UINTAH)  
UINTAH_P_201210 <- crop(P_201210, UINTAH)  
UINTAH_P_201211 <- crop(P_201211, UINTAH)  
UINTAH_P_201212 <- crop(P_201212, UINTAH)  
#2013
UINTAH_P_201301 <- crop(P_201301, UINTAH) 
UINTAH_P_201302 <- crop(P_201302, UINTAH)
UINTAH_P_201303 <- crop(P_201303, UINTAH)
UINTAH_P_201304 <- crop(P_201304, UINTAH)
UINTAH_P_201305 <- crop(P_201305, UINTAH)
UINTAH_P_201306 <- crop(P_201306, UINTAH)  
UINTAH_P_201307 <- crop(P_201307, UINTAH)  
UINTAH_P_201308 <- crop(P_201308, UINTAH)  
UINTAH_P_201309 <- crop(P_201309, UINTAH)  
UINTAH_P_201310 <- crop(P_201310, UINTAH)  
UINTAH_P_201311 <- crop(P_201311, UINTAH)  
UINTAH_P_201312 <- crop(P_201312, UINTAH)  
#2014
UINTAH_P_201401 <- crop(P_201401, UINTAH) 
UINTAH_P_201402 <- crop(P_201402, UINTAH)
UINTAH_P_201403 <- crop(P_201403, UINTAH)
UINTAH_P_201404 <- crop(P_201404, UINTAH)
UINTAH_P_201405 <- crop(P_201405, UINTAH)
UINTAH_P_201406 <- crop(P_201406, UINTAH)  
UINTAH_P_201407 <- crop(P_201407, UINTAH)  
UINTAH_P_201408 <- crop(P_201408, UINTAH)  
UINTAH_P_201409 <- crop(P_201409, UINTAH)  
UINTAH_P_201410 <- crop(P_201410, UINTAH)  
UINTAH_P_201411 <- crop(P_201411, UINTAH)  
UINTAH_P_201412 <- crop(P_201412, UINTAH)  
#2015
UINTAH_P_201501 <- crop(P_201501, UINTAH) 
UINTAH_P_201502 <- crop(P_201502, UINTAH)
UINTAH_P_201503 <- crop(P_201503, UINTAH)
UINTAH_P_201504 <- crop(P_201504, UINTAH)
UINTAH_P_201505 <- crop(P_201505, UINTAH)
UINTAH_P_201506 <- crop(P_201506, UINTAH)  
UINTAH_P_201507 <- crop(P_201507, UINTAH)  
UINTAH_P_201508 <- crop(P_201508, UINTAH)  
UINTAH_P_201509 <- crop(P_201509, UINTAH)  
UINTAH_P_201510 <- crop(P_201510, UINTAH)  
UINTAH_P_201511 <- crop(P_201511, UINTAH)  
UINTAH_P_201512 <- crop(P_201512, UINTAH)  
#2016
UINTAH_P_201601 <- crop(P_201601, UINTAH) 
UINTAH_P_201602 <- crop(P_201602, UINTAH)
UINTAH_P_201603 <- crop(P_201603, UINTAH)
UINTAH_P_201604 <- crop(P_201604, UINTAH)
UINTAH_P_201605 <- crop(P_201605, UINTAH)
UINTAH_P_201606 <- crop(P_201606, UINTAH)  
UINTAH_P_201607 <- crop(P_201607, UINTAH)  
UINTAH_P_201608 <- crop(P_201608, UINTAH)  
UINTAH_P_201609 <- crop(P_201609, UINTAH)  
UINTAH_P_201610 <- crop(P_201610, UINTAH)  
UINTAH_P_201611 <- crop(P_201611, UINTAH)  
UINTAH_P_201612 <- crop(P_201612, UINTAH)  
#2017
UINTAH_P_201701 <- crop(P_201701, UINTAH) 
UINTAH_P_201702 <- crop(P_201702, UINTAH)
UINTAH_P_201703 <- crop(P_201703, UINTAH)
UINTAH_P_201704 <- crop(P_201704, UINTAH)
UINTAH_P_201705 <- crop(P_201705, UINTAH)
UINTAH_P_201706 <- crop(P_201706, UINTAH)  
UINTAH_P_201707 <- crop(P_201707, UINTAH)  
UINTAH_P_201708 <- crop(P_201708, UINTAH)  
UINTAH_P_201709 <- crop(P_201709, UINTAH)  
UINTAH_P_201710 <- crop(P_201710, UINTAH)  
UINTAH_P_201711 <- crop(P_201711, UINTAH)  
UINTAH_P_201712 <- crop(P_201712, UINTAH)  

#2018

UINTAH_P_201801 <- crop(P_201801, UINTAH) 
UINTAH_P_201802 <- crop(P_201802, UINTAH)
UINTAH_P_201803 <- crop(P_201803, UINTAH)
UINTAH_P_201804 <- crop(P_201804, UINTAH)
UINTAH_P_201805 <- crop(P_201805, UINTAH)
UINTAH_P_201806 <- crop(P_201806, UINTAH)  
UINTAH_P_201807 <- crop(P_201807, UINTAH)  
UINTAH_P_201808 <- crop(P_201808, UINTAH)  
UINTAH_P_201809 <- crop(P_201809, UINTAH)  
UINTAH_P_201810 <- crop(P_201810, UINTAH)  
UINTAH_P_201811 <- crop(P_201811, UINTAH)  
UINTAH_P_201812 <- crop(P_201812, UINTAH)  


# Mean Monthly Precipitation
#2000
UINTAH_P_200001_mean <- cellStats(UINTAH_P_200001, mean)
UINTAH_P_200002_mean <- cellStats(UINTAH_P_200002, mean)
UINTAH_P_200003_mean <- cellStats(UINTAH_P_200003, mean)
UINTAH_P_200004_mean <- cellStats(UINTAH_P_200004, mean)
UINTAH_P_200005_mean <- cellStats(UINTAH_P_200005, mean)
UINTAH_P_200006_mean <- cellStats(UINTAH_P_200006, mean)
UINTAH_P_200007_mean <- cellStats(UINTAH_P_200007, mean)
UINTAH_P_200008_mean <- cellStats(UINTAH_P_200008, mean)
UINTAH_P_200009_mean <- cellStats(UINTAH_P_200009, mean)
UINTAH_P_200010_mean <- cellStats(UINTAH_P_200010, mean)
UINTAH_P_200011_mean <- cellStats(UINTAH_P_200011, mean)
UINTAH_P_200012_mean <- cellStats(UINTAH_P_200012, mean)
#2001
UINTAH_P_200101_mean <- cellStats(UINTAH_P_200101, mean)
UINTAH_P_200102_mean <- cellStats(UINTAH_P_200102, mean)
UINTAH_P_200103_mean <- cellStats(UINTAH_P_200103, mean)
UINTAH_P_200104_mean <- cellStats(UINTAH_P_200104, mean)
UINTAH_P_200105_mean <- cellStats(UINTAH_P_200105, mean)
UINTAH_P_200106_mean <- cellStats(UINTAH_P_200106, mean)
UINTAH_P_200107_mean <- cellStats(UINTAH_P_200107, mean)
UINTAH_P_200108_mean <- cellStats(UINTAH_P_200108, mean)
UINTAH_P_200109_mean <- cellStats(UINTAH_P_200109, mean)
UINTAH_P_200110_mean <- cellStats(UINTAH_P_200110, mean)
UINTAH_P_200111_mean <- cellStats(UINTAH_P_200111, mean)
UINTAH_P_200112_mean <- cellStats(UINTAH_P_200112, mean)

#2002
UINTAH_P_200201_mean <- cellStats(UINTAH_P_200201, mean)
UINTAH_P_200202_mean <- cellStats(UINTAH_P_200202, mean)
UINTAH_P_200203_mean <- cellStats(UINTAH_P_200203, mean)
UINTAH_P_200204_mean <- cellStats(UINTAH_P_200204, mean)
UINTAH_P_200205_mean <- cellStats(UINTAH_P_200205, mean)
UINTAH_P_200206_mean <- cellStats(UINTAH_P_200206, mean)
UINTAH_P_200207_mean <- cellStats(UINTAH_P_200207, mean)
UINTAH_P_200208_mean <- cellStats(UINTAH_P_200208, mean)
UINTAH_P_200209_mean <- cellStats(UINTAH_P_200209, mean)
UINTAH_P_200210_mean <- cellStats(UINTAH_P_200210, mean)
UINTAH_P_200211_mean <- cellStats(UINTAH_P_200211, mean)
UINTAH_P_200212_mean <- cellStats(UINTAH_P_200212, mean)

#2003
UINTAH_P_200301_mean <- cellStats(UINTAH_P_200301, mean)
UINTAH_P_200302_mean <- cellStats(UINTAH_P_200302, mean)
UINTAH_P_200303_mean <- cellStats(UINTAH_P_200303, mean)
UINTAH_P_200304_mean <- cellStats(UINTAH_P_200304, mean)
UINTAH_P_200305_mean <- cellStats(UINTAH_P_200305, mean)
UINTAH_P_200306_mean <- cellStats(UINTAH_P_200306, mean)
UINTAH_P_200307_mean <- cellStats(UINTAH_P_200307, mean)
UINTAH_P_200308_mean <- cellStats(UINTAH_P_200308, mean)
UINTAH_P_200309_mean <- cellStats(UINTAH_P_200309, mean)
UINTAH_P_200310_mean <- cellStats(UINTAH_P_200310, mean)
UINTAH_P_200311_mean <- cellStats(UINTAH_P_200311, mean)
UINTAH_P_200312_mean <- cellStats(UINTAH_P_200312, mean)

#2004

UINTAH_P_200401_mean <- cellStats(UINTAH_P_200401, mean)
UINTAH_P_200402_mean <- cellStats(UINTAH_P_200402, mean)
UINTAH_P_200403_mean <- cellStats(UINTAH_P_200403, mean)
UINTAH_P_200404_mean <- cellStats(UINTAH_P_200404, mean)
UINTAH_P_200405_mean <- cellStats(UINTAH_P_200405, mean)
UINTAH_P_200406_mean <- cellStats(UINTAH_P_200406, mean)
UINTAH_P_200407_mean <- cellStats(UINTAH_P_200407, mean)
UINTAH_P_200408_mean <- cellStats(UINTAH_P_200408, mean)
UINTAH_P_200409_mean <- cellStats(UINTAH_P_200409, mean)
UINTAH_P_200410_mean <- cellStats(UINTAH_P_200410, mean)
UINTAH_P_200411_mean <- cellStats(UINTAH_P_200411, mean)
UINTAH_P_200412_mean <- cellStats(UINTAH_P_200412, mean)

#2005

UINTAH_P_200501_mean <- cellStats(UINTAH_P_200501, mean)
UINTAH_P_200502_mean <- cellStats(UINTAH_P_200502, mean)
UINTAH_P_200503_mean <- cellStats(UINTAH_P_200503, mean)
UINTAH_P_200504_mean <- cellStats(UINTAH_P_200504, mean)
UINTAH_P_200505_mean <- cellStats(UINTAH_P_200505, mean)
UINTAH_P_200506_mean <- cellStats(UINTAH_P_200506, mean)
UINTAH_P_200507_mean <- cellStats(UINTAH_P_200507, mean)
UINTAH_P_200508_mean <- cellStats(UINTAH_P_200508, mean)
UINTAH_P_200509_mean <- cellStats(UINTAH_P_200509, mean)
UINTAH_P_200510_mean <- cellStats(UINTAH_P_200510, mean)
UINTAH_P_200511_mean <- cellStats(UINTAH_P_200511, mean)
UINTAH_P_200512_mean <- cellStats(UINTAH_P_200512, mean)

#2006

UINTAH_P_200601_mean <- cellStats(UINTAH_P_200601, mean)
UINTAH_P_200602_mean <- cellStats(UINTAH_P_200602, mean)
UINTAH_P_200603_mean <- cellStats(UINTAH_P_200603, mean)
UINTAH_P_200604_mean <- cellStats(UINTAH_P_200604, mean)
UINTAH_P_200605_mean <- cellStats(UINTAH_P_200605, mean)
UINTAH_P_200606_mean <- cellStats(UINTAH_P_200606, mean)
UINTAH_P_200607_mean <- cellStats(UINTAH_P_200607, mean)
UINTAH_P_200608_mean <- cellStats(UINTAH_P_200608, mean)
UINTAH_P_200609_mean <- cellStats(UINTAH_P_200609, mean)
UINTAH_P_200610_mean <- cellStats(UINTAH_P_200610, mean)
UINTAH_P_200611_mean <- cellStats(UINTAH_P_200611, mean)
UINTAH_P_200612_mean <- cellStats(UINTAH_P_200612, mean)

#2007

UINTAH_P_200701_mean <- cellStats(UINTAH_P_200701, mean)
UINTAH_P_200702_mean <- cellStats(UINTAH_P_200702, mean)
UINTAH_P_200703_mean <- cellStats(UINTAH_P_200703, mean)
UINTAH_P_200704_mean <- cellStats(UINTAH_P_200704, mean)
UINTAH_P_200705_mean <- cellStats(UINTAH_P_200705, mean)
UINTAH_P_200706_mean <- cellStats(UINTAH_P_200706, mean)
UINTAH_P_200707_mean <- cellStats(UINTAH_P_200707, mean)
UINTAH_P_200708_mean <- cellStats(UINTAH_P_200708, mean)
UINTAH_P_200709_mean <- cellStats(UINTAH_P_200709, mean)
UINTAH_P_200710_mean <- cellStats(UINTAH_P_200710, mean)
UINTAH_P_200711_mean <- cellStats(UINTAH_P_200711, mean)
UINTAH_P_200712_mean <- cellStats(UINTAH_P_200712, mean)

#2008

UINTAH_P_200801_mean <- cellStats(UINTAH_P_200801, mean)
UINTAH_P_200802_mean <- cellStats(UINTAH_P_200802, mean)
UINTAH_P_200803_mean <- cellStats(UINTAH_P_200803, mean)
UINTAH_P_200804_mean <- cellStats(UINTAH_P_200804, mean)
UINTAH_P_200805_mean <- cellStats(UINTAH_P_200805, mean)
UINTAH_P_200806_mean <- cellStats(UINTAH_P_200806, mean)
UINTAH_P_200807_mean <- cellStats(UINTAH_P_200807, mean)
UINTAH_P_200808_mean <- cellStats(UINTAH_P_200808, mean)
UINTAH_P_200809_mean <- cellStats(UINTAH_P_200809, mean)
UINTAH_P_200810_mean <- cellStats(UINTAH_P_200810, mean)
UINTAH_P_200811_mean <- cellStats(UINTAH_P_200811, mean)
UINTAH_P_200812_mean <- cellStats(UINTAH_P_200812, mean)

#2009

UINTAH_P_200901_mean <- cellStats(UINTAH_P_200901, mean)
UINTAH_P_200902_mean <- cellStats(UINTAH_P_200902, mean)
UINTAH_P_200903_mean <- cellStats(UINTAH_P_200903, mean)
UINTAH_P_200904_mean <- cellStats(UINTAH_P_200904, mean)
UINTAH_P_200905_mean <- cellStats(UINTAH_P_200905, mean)
UINTAH_P_200906_mean <- cellStats(UINTAH_P_200906, mean)
UINTAH_P_200907_mean <- cellStats(UINTAH_P_200907, mean)
UINTAH_P_200908_mean <- cellStats(UINTAH_P_200908, mean)
UINTAH_P_200909_mean <- cellStats(UINTAH_P_200909, mean)
UINTAH_P_200910_mean <- cellStats(UINTAH_P_200910, mean)
UINTAH_P_200911_mean <- cellStats(UINTAH_P_200911, mean)
UINTAH_P_200912_mean <- cellStats(UINTAH_P_200912, mean)

#2010

UINTAH_P_201001_mean <- cellStats(UINTAH_P_201001, mean)
UINTAH_P_201002_mean <- cellStats(UINTAH_P_201002, mean)
UINTAH_P_201003_mean <- cellStats(UINTAH_P_201003, mean)
UINTAH_P_201004_mean <- cellStats(UINTAH_P_201004, mean)
UINTAH_P_201005_mean <- cellStats(UINTAH_P_201005, mean)
UINTAH_P_201006_mean <- cellStats(UINTAH_P_201006, mean)
UINTAH_P_201007_mean <- cellStats(UINTAH_P_201007, mean)
UINTAH_P_201008_mean <- cellStats(UINTAH_P_201008, mean)
UINTAH_P_201009_mean <- cellStats(UINTAH_P_201009, mean)
UINTAH_P_201010_mean <- cellStats(UINTAH_P_201010, mean)
UINTAH_P_201011_mean <- cellStats(UINTAH_P_201011, mean)
UINTAH_P_201012_mean <- cellStats(UINTAH_P_201012, mean)

#2011

UINTAH_P_201101_mean <- cellStats(UINTAH_P_201101, mean)
UINTAH_P_201102_mean <- cellStats(UINTAH_P_201102, mean)
UINTAH_P_201103_mean <- cellStats(UINTAH_P_201103, mean)
UINTAH_P_201104_mean <- cellStats(UINTAH_P_201104, mean)
UINTAH_P_201105_mean <- cellStats(UINTAH_P_201105, mean)
UINTAH_P_201106_mean <- cellStats(UINTAH_P_201106, mean)
UINTAH_P_201107_mean <- cellStats(UINTAH_P_201107, mean)
UINTAH_P_201108_mean <- cellStats(UINTAH_P_201108, mean)
UINTAH_P_201109_mean <- cellStats(UINTAH_P_201109, mean)
UINTAH_P_201110_mean <- cellStats(UINTAH_P_201110, mean)
UINTAH_P_201111_mean <- cellStats(UINTAH_P_201111, mean)
UINTAH_P_201112_mean <- cellStats(UINTAH_P_201112, mean)

#2012
UINTAH_P_201201_mean <- cellStats(UINTAH_P_201201, mean)
UINTAH_P_201202_mean <- cellStats(UINTAH_P_201202, mean)
UINTAH_P_201203_mean <- cellStats(UINTAH_P_201203, mean)
UINTAH_P_201204_mean <- cellStats(UINTAH_P_201204, mean)
UINTAH_P_201205_mean <- cellStats(UINTAH_P_201205, mean)
UINTAH_P_201206_mean <- cellStats(UINTAH_P_201206, mean)
UINTAH_P_201207_mean <- cellStats(UINTAH_P_201207, mean)
UINTAH_P_201208_mean <- cellStats(UINTAH_P_201208, mean)
UINTAH_P_201209_mean <- cellStats(UINTAH_P_201209, mean)
UINTAH_P_201210_mean <- cellStats(UINTAH_P_201210, mean)
UINTAH_P_201211_mean <- cellStats(UINTAH_P_201211, mean)
UINTAH_P_201212_mean <- cellStats(UINTAH_P_201212, mean)

#2013
UINTAH_P_201301_mean <- cellStats(UINTAH_P_201301, mean)
UINTAH_P_201302_mean <- cellStats(UINTAH_P_201302, mean)
UINTAH_P_201303_mean <- cellStats(UINTAH_P_201303, mean)
UINTAH_P_201304_mean <- cellStats(UINTAH_P_201304, mean)
UINTAH_P_201305_mean <- cellStats(UINTAH_P_201305, mean)
UINTAH_P_201306_mean <- cellStats(UINTAH_P_201306, mean)
UINTAH_P_201307_mean <- cellStats(UINTAH_P_201307, mean)
UINTAH_P_201308_mean <- cellStats(UINTAH_P_201308, mean)
UINTAH_P_201309_mean <- cellStats(UINTAH_P_201309, mean)
UINTAH_P_201310_mean <- cellStats(UINTAH_P_201310, mean)
UINTAH_P_201311_mean <- cellStats(UINTAH_P_201311, mean)
UINTAH_P_201312_mean <- cellStats(UINTAH_P_201312, mean)

#2014
UINTAH_P_201401_mean <- cellStats(UINTAH_P_201401, mean)
UINTAH_P_201402_mean <- cellStats(UINTAH_P_201402, mean)
UINTAH_P_201403_mean <- cellStats(UINTAH_P_201403, mean)
UINTAH_P_201404_mean <- cellStats(UINTAH_P_201404, mean)
UINTAH_P_201405_mean <- cellStats(UINTAH_P_201405, mean)
UINTAH_P_201406_mean <- cellStats(UINTAH_P_201406, mean)
UINTAH_P_201407_mean <- cellStats(UINTAH_P_201407, mean)
UINTAH_P_201408_mean <- cellStats(UINTAH_P_201408, mean)
UINTAH_P_201409_mean <- cellStats(UINTAH_P_201409, mean)
UINTAH_P_201410_mean <- cellStats(UINTAH_P_201410, mean)
UINTAH_P_201411_mean <- cellStats(UINTAH_P_201411, mean)
UINTAH_P_201412_mean <- cellStats(UINTAH_P_201412, mean)

#2015
UINTAH_P_201501_mean <- cellStats(UINTAH_P_201501, mean)
UINTAH_P_201502_mean <- cellStats(UINTAH_P_201502, mean)
UINTAH_P_201503_mean <- cellStats(UINTAH_P_201503, mean)
UINTAH_P_201504_mean <- cellStats(UINTAH_P_201504, mean)
UINTAH_P_201505_mean <- cellStats(UINTAH_P_201505, mean)
UINTAH_P_201506_mean <- cellStats(UINTAH_P_201506, mean)
UINTAH_P_201507_mean <- cellStats(UINTAH_P_201507, mean)
UINTAH_P_201508_mean <- cellStats(UINTAH_P_201508, mean)
UINTAH_P_201509_mean <- cellStats(UINTAH_P_201509, mean)
UINTAH_P_201510_mean <- cellStats(UINTAH_P_201510, mean)
UINTAH_P_201511_mean <- cellStats(UINTAH_P_201511, mean)
UINTAH_P_201512_mean <- cellStats(UINTAH_P_201512, mean)

#2016
UINTAH_P_201601_mean <- cellStats(UINTAH_P_201601, mean)
UINTAH_P_201602_mean <- cellStats(UINTAH_P_201602, mean)
UINTAH_P_201603_mean <- cellStats(UINTAH_P_201603, mean)
UINTAH_P_201604_mean <- cellStats(UINTAH_P_201604, mean)
UINTAH_P_201605_mean <- cellStats(UINTAH_P_201605, mean)
UINTAH_P_201606_mean <- cellStats(UINTAH_P_201606, mean)
UINTAH_P_201607_mean <- cellStats(UINTAH_P_201607, mean)
UINTAH_P_201608_mean <- cellStats(UINTAH_P_201608, mean)
UINTAH_P_201609_mean <- cellStats(UINTAH_P_201609, mean)
UINTAH_P_201610_mean <- cellStats(UINTAH_P_201610, mean)
UINTAH_P_201611_mean <- cellStats(UINTAH_P_201611, mean)
UINTAH_P_201612_mean <- cellStats(UINTAH_P_201612, mean)

#2017
UINTAH_P_201701_mean <- cellStats(UINTAH_P_201701, mean)
UINTAH_P_201702_mean <- cellStats(UINTAH_P_201702, mean)
UINTAH_P_201703_mean <- cellStats(UINTAH_P_201703, mean)
UINTAH_P_201704_mean <- cellStats(UINTAH_P_201704, mean)
UINTAH_P_201705_mean <- cellStats(UINTAH_P_201705, mean)
UINTAH_P_201706_mean <- cellStats(UINTAH_P_201706, mean)
UINTAH_P_201707_mean <- cellStats(UINTAH_P_201707, mean)
UINTAH_P_201708_mean <- cellStats(UINTAH_P_201708, mean)
UINTAH_P_201709_mean <- cellStats(UINTAH_P_201709, mean)
UINTAH_P_201710_mean <- cellStats(UINTAH_P_201710, mean)
UINTAH_P_201711_mean <- cellStats(UINTAH_P_201711, mean)
UINTAH_P_201712_mean <- cellStats(UINTAH_P_201712, mean)

#2018
UINTAH_P_201801_mean <- cellStats(UINTAH_P_201801, mean)
UINTAH_P_201802_mean <- cellStats(UINTAH_P_201802, mean)
UINTAH_P_201803_mean <- cellStats(UINTAH_P_201803, mean)
UINTAH_P_201804_mean <- cellStats(UINTAH_P_201804, mean)
UINTAH_P_201805_mean <- cellStats(UINTAH_P_201805, mean)
UINTAH_P_201806_mean <- cellStats(UINTAH_P_201806, mean)
UINTAH_P_201807_mean <- cellStats(UINTAH_P_201807, mean)
UINTAH_P_201808_mean <- cellStats(UINTAH_P_201808, mean)
UINTAH_P_201809_mean <- cellStats(UINTAH_P_201809, mean)
UINTAH_P_201810_mean <- cellStats(UINTAH_P_201810, mean)
UINTAH_P_201811_mean <- cellStats(UINTAH_P_201811, mean)
UINTAH_P_201812_mean <- cellStats(UINTAH_P_201812, mean)

# WAYNE

#2000
WAYNE_P_200001 <- crop(P_200001, WAYNE) 
WAYNE_P_200002 <- crop(P_200002, WAYNE)
WAYNE_P_200003 <- crop(P_200003, WAYNE)
WAYNE_P_200004 <- crop(P_200004, WAYNE)
WAYNE_P_200005 <- crop(P_200005, WAYNE)
WAYNE_P_200006 <- crop(P_200006, WAYNE)  
WAYNE_P_200007 <- crop(P_200007, WAYNE)  
WAYNE_P_200008 <- crop(P_200008, WAYNE)  
WAYNE_P_200009 <- crop(P_200009, WAYNE)  
WAYNE_P_200010 <- crop(P_200010, WAYNE)  
WAYNE_P_200011 <- crop(P_200011, WAYNE)  
WAYNE_P_200012 <- crop(P_200012, WAYNE)  
#2001
WAYNE_P_200101 <- crop(P_200101, WAYNE) 
WAYNE_P_200102 <- crop(P_200102, WAYNE)
WAYNE_P_200103 <- crop(P_200103, WAYNE)
WAYNE_P_200104 <- crop(P_200104, WAYNE)
WAYNE_P_200105 <- crop(P_200105, WAYNE)
WAYNE_P_200106 <- crop(P_200106, WAYNE)  
WAYNE_P_200107 <- crop(P_200107, WAYNE)  
WAYNE_P_200108 <- crop(P_200108, WAYNE)  
WAYNE_P_200109 <- crop(P_200109, WAYNE)  
WAYNE_P_200110 <- crop(P_200110, WAYNE)  
WAYNE_P_200111 <- crop(P_200111, WAYNE)  
WAYNE_P_200112 <- crop(P_200112, WAYNE)  

#2002
WAYNE_P_200201 <- crop(P_200201, WAYNE) 
WAYNE_P_200202 <- crop(P_200202, WAYNE)
WAYNE_P_200203 <- crop(P_200203, WAYNE)
WAYNE_P_200204 <- crop(P_200204, WAYNE)
WAYNE_P_200205 <- crop(P_200205, WAYNE)
WAYNE_P_200206 <- crop(P_200206, WAYNE)  
WAYNE_P_200207 <- crop(P_200207, WAYNE)  
WAYNE_P_200208 <- crop(P_200208, WAYNE)  
WAYNE_P_200209 <- crop(P_200209, WAYNE)  
WAYNE_P_200210 <- crop(P_200210, WAYNE)  
WAYNE_P_200211 <- crop(P_200211, WAYNE)  
WAYNE_P_200212 <- crop(P_200212, WAYNE)  
#2003
WAYNE_P_200301 <- crop(P_200301, WAYNE) 
WAYNE_P_200302 <- crop(P_200302, WAYNE)
WAYNE_P_200303 <- crop(P_200303, WAYNE)
WAYNE_P_200304 <- crop(P_200304, WAYNE)
WAYNE_P_200305 <- crop(P_200305, WAYNE)
WAYNE_P_200306 <- crop(P_200306, WAYNE)  
WAYNE_P_200307 <- crop(P_200307, WAYNE)  
WAYNE_P_200308 <- crop(P_200308, WAYNE)  
WAYNE_P_200309 <- crop(P_200309, WAYNE)  
WAYNE_P_200310 <- crop(P_200310, WAYNE)  
WAYNE_P_200311 <- crop(P_200311, WAYNE)  
WAYNE_P_200312 <- crop(P_200312, WAYNE)  
#2004
WAYNE_P_200401 <- crop(P_200401, WAYNE) 
WAYNE_P_200402 <- crop(P_200402, WAYNE)
WAYNE_P_200403 <- crop(P_200403, WAYNE)
WAYNE_P_200404 <- crop(P_200404, WAYNE)
WAYNE_P_200405 <- crop(P_200405, WAYNE)
WAYNE_P_200406 <- crop(P_200406, WAYNE)  
WAYNE_P_200407 <- crop(P_200407, WAYNE)  
WAYNE_P_200408 <- crop(P_200408, WAYNE)  
WAYNE_P_200409 <- crop(P_200409, WAYNE)  
WAYNE_P_200410 <- crop(P_200410, WAYNE)  
WAYNE_P_200411 <- crop(P_200411, WAYNE)  
WAYNE_P_200412 <- crop(P_200412, WAYNE)  
#2005
WAYNE_P_200501 <- crop(P_200501, WAYNE) 
WAYNE_P_200502 <- crop(P_200502, WAYNE)
WAYNE_P_200503 <- crop(P_200503, WAYNE)
WAYNE_P_200504 <- crop(P_200504, WAYNE)
WAYNE_P_200505 <- crop(P_200505, WAYNE)
WAYNE_P_200506 <- crop(P_200506, WAYNE)  
WAYNE_P_200507 <- crop(P_200507, WAYNE)  
WAYNE_P_200508 <- crop(P_200508, WAYNE)  
WAYNE_P_200509 <- crop(P_200509, WAYNE)  
WAYNE_P_200510 <- crop(P_200510, WAYNE)  
WAYNE_P_200511 <- crop(P_200511, WAYNE)  
WAYNE_P_200512 <- crop(P_200512, WAYNE)  
#2006
WAYNE_P_200601 <- crop(P_200601, WAYNE) 
WAYNE_P_200602 <- crop(P_200602, WAYNE)
WAYNE_P_200603 <- crop(P_200603, WAYNE)
WAYNE_P_200604 <- crop(P_200604, WAYNE)
WAYNE_P_200605 <- crop(P_200605, WAYNE)
WAYNE_P_200606 <- crop(P_200606, WAYNE)  
WAYNE_P_200607 <- crop(P_200607, WAYNE)  
WAYNE_P_200608 <- crop(P_200608, WAYNE)  
WAYNE_P_200609 <- crop(P_200609, WAYNE)  
WAYNE_P_200610 <- crop(P_200610, WAYNE)  
WAYNE_P_200611 <- crop(P_200611, WAYNE)  
WAYNE_P_200612 <- crop(P_200612, WAYNE)  
#2007
WAYNE_P_200701 <- crop(P_200701, WAYNE) 
WAYNE_P_200702 <- crop(P_200702, WAYNE)
WAYNE_P_200703 <- crop(P_200703, WAYNE)
WAYNE_P_200704 <- crop(P_200704, WAYNE)
WAYNE_P_200705 <- crop(P_200705, WAYNE)
WAYNE_P_200706 <- crop(P_200706, WAYNE)  
WAYNE_P_200707 <- crop(P_200707, WAYNE)  
WAYNE_P_200708 <- crop(P_200708, WAYNE)  
WAYNE_P_200709 <- crop(P_200709, WAYNE)  
WAYNE_P_200710 <- crop(P_200710, WAYNE)  
WAYNE_P_200711 <- crop(P_200711, WAYNE)  
WAYNE_P_200712 <- crop(P_200712, WAYNE)  
#2008
WAYNE_P_200801 <- crop(P_200801, WAYNE) 
WAYNE_P_200802 <- crop(P_200802, WAYNE)
WAYNE_P_200803 <- crop(P_200803, WAYNE)
WAYNE_P_200804 <- crop(P_200804, WAYNE)
WAYNE_P_200805 <- crop(P_200805, WAYNE)
WAYNE_P_200806 <- crop(P_200806, WAYNE)  
WAYNE_P_200807 <- crop(P_200807, WAYNE)  
WAYNE_P_200808 <- crop(P_200808, WAYNE)  
WAYNE_P_200809 <- crop(P_200809, WAYNE)  
WAYNE_P_200810 <- crop(P_200810, WAYNE)  
WAYNE_P_200811 <- crop(P_200811, WAYNE)  
WAYNE_P_200812 <- crop(P_200812, WAYNE)  
#2009
WAYNE_P_200901 <- crop(P_200901, WAYNE) 
WAYNE_P_200902 <- crop(P_200902, WAYNE)
WAYNE_P_200903 <- crop(P_200903, WAYNE)
WAYNE_P_200904 <- crop(P_200904, WAYNE)
WAYNE_P_200905 <- crop(P_200905, WAYNE)
WAYNE_P_200906 <- crop(P_200906, WAYNE)  
WAYNE_P_200907 <- crop(P_200907, WAYNE)  
WAYNE_P_200908 <- crop(P_200908, WAYNE)  
WAYNE_P_200909 <- crop(P_200909, WAYNE)  
WAYNE_P_200910 <- crop(P_200910, WAYNE)  
WAYNE_P_200911 <- crop(P_200911, WAYNE)  
WAYNE_P_200912 <- crop(P_200912, WAYNE)  
#2010
WAYNE_P_201001 <- crop(P_201001, WAYNE) 
WAYNE_P_201002 <- crop(P_201002, WAYNE)
WAYNE_P_201003 <- crop(P_201003, WAYNE)
WAYNE_P_201004 <- crop(P_201004, WAYNE)
WAYNE_P_201005 <- crop(P_201005, WAYNE)
WAYNE_P_201006 <- crop(P_201006, WAYNE)  
WAYNE_P_201007 <- crop(P_201007, WAYNE)  
WAYNE_P_201008 <- crop(P_201008, WAYNE)  
WAYNE_P_201009 <- crop(P_201009, WAYNE)  
WAYNE_P_201010 <- crop(P_201010, WAYNE)  
WAYNE_P_201011 <- crop(P_201011, WAYNE)  
WAYNE_P_201012 <- crop(P_201012, WAYNE)  
#2011
WAYNE_P_201101 <- crop(P_201101, WAYNE) 
WAYNE_P_201102 <- crop(P_201102, WAYNE)
WAYNE_P_201103 <- crop(P_201103, WAYNE)
WAYNE_P_201104 <- crop(P_201104, WAYNE)
WAYNE_P_201105 <- crop(P_201105, WAYNE)
WAYNE_P_201106 <- crop(P_201106, WAYNE)  
WAYNE_P_201107 <- crop(P_201107, WAYNE)  
WAYNE_P_201108 <- crop(P_201108, WAYNE)  
WAYNE_P_201109 <- crop(P_201109, WAYNE)  
WAYNE_P_201110 <- crop(P_201110, WAYNE)  
WAYNE_P_201111 <- crop(P_201111, WAYNE)  
WAYNE_P_201112 <- crop(P_201112, WAYNE)  
#2012
WAYNE_P_201201 <- crop(P_201201, WAYNE) 
WAYNE_P_201202 <- crop(P_201202, WAYNE)
WAYNE_P_201203 <- crop(P_201203, WAYNE)
WAYNE_P_201204 <- crop(P_201204, WAYNE)
WAYNE_P_201205 <- crop(P_201205, WAYNE)
WAYNE_P_201206 <- crop(P_201206, WAYNE)  
WAYNE_P_201207 <- crop(P_201207, WAYNE)  
WAYNE_P_201208 <- crop(P_201208, WAYNE)  
WAYNE_P_201209 <- crop(P_201209, WAYNE)  
WAYNE_P_201210 <- crop(P_201210, WAYNE)  
WAYNE_P_201211 <- crop(P_201211, WAYNE)  
WAYNE_P_201212 <- crop(P_201212, WAYNE)  
#2013
WAYNE_P_201301 <- crop(P_201301, WAYNE) 
WAYNE_P_201302 <- crop(P_201302, WAYNE)
WAYNE_P_201303 <- crop(P_201303, WAYNE)
WAYNE_P_201304 <- crop(P_201304, WAYNE)
WAYNE_P_201305 <- crop(P_201305, WAYNE)
WAYNE_P_201306 <- crop(P_201306, WAYNE)  
WAYNE_P_201307 <- crop(P_201307, WAYNE)  
WAYNE_P_201308 <- crop(P_201308, WAYNE)  
WAYNE_P_201309 <- crop(P_201309, WAYNE)  
WAYNE_P_201310 <- crop(P_201310, WAYNE)  
WAYNE_P_201311 <- crop(P_201311, WAYNE)  
WAYNE_P_201312 <- crop(P_201312, WAYNE)  
#2014
WAYNE_P_201401 <- crop(P_201401, WAYNE) 
WAYNE_P_201402 <- crop(P_201402, WAYNE)
WAYNE_P_201403 <- crop(P_201403, WAYNE)
WAYNE_P_201404 <- crop(P_201404, WAYNE)
WAYNE_P_201405 <- crop(P_201405, WAYNE)
WAYNE_P_201406 <- crop(P_201406, WAYNE)  
WAYNE_P_201407 <- crop(P_201407, WAYNE)  
WAYNE_P_201408 <- crop(P_201408, WAYNE)  
WAYNE_P_201409 <- crop(P_201409, WAYNE)  
WAYNE_P_201410 <- crop(P_201410, WAYNE)  
WAYNE_P_201411 <- crop(P_201411, WAYNE)  
WAYNE_P_201412 <- crop(P_201412, WAYNE)  
#2015
WAYNE_P_201501 <- crop(P_201501, WAYNE) 
WAYNE_P_201502 <- crop(P_201502, WAYNE)
WAYNE_P_201503 <- crop(P_201503, WAYNE)
WAYNE_P_201504 <- crop(P_201504, WAYNE)
WAYNE_P_201505 <- crop(P_201505, WAYNE)
WAYNE_P_201506 <- crop(P_201506, WAYNE)  
WAYNE_P_201507 <- crop(P_201507, WAYNE)  
WAYNE_P_201508 <- crop(P_201508, WAYNE)  
WAYNE_P_201509 <- crop(P_201509, WAYNE)  
WAYNE_P_201510 <- crop(P_201510, WAYNE)  
WAYNE_P_201511 <- crop(P_201511, WAYNE)  
WAYNE_P_201512 <- crop(P_201512, WAYNE)  
#2016
WAYNE_P_201601 <- crop(P_201601, WAYNE) 
WAYNE_P_201602 <- crop(P_201602, WAYNE)
WAYNE_P_201603 <- crop(P_201603, WAYNE)
WAYNE_P_201604 <- crop(P_201604, WAYNE)
WAYNE_P_201605 <- crop(P_201605, WAYNE)
WAYNE_P_201606 <- crop(P_201606, WAYNE)  
WAYNE_P_201607 <- crop(P_201607, WAYNE)  
WAYNE_P_201608 <- crop(P_201608, WAYNE)  
WAYNE_P_201609 <- crop(P_201609, WAYNE)  
WAYNE_P_201610 <- crop(P_201610, WAYNE)  
WAYNE_P_201611 <- crop(P_201611, WAYNE)  
WAYNE_P_201612 <- crop(P_201612, WAYNE)  
#2017
WAYNE_P_201701 <- crop(P_201701, WAYNE) 
WAYNE_P_201702 <- crop(P_201702, WAYNE)
WAYNE_P_201703 <- crop(P_201703, WAYNE)
WAYNE_P_201704 <- crop(P_201704, WAYNE)
WAYNE_P_201705 <- crop(P_201705, WAYNE)
WAYNE_P_201706 <- crop(P_201706, WAYNE)  
WAYNE_P_201707 <- crop(P_201707, WAYNE)  
WAYNE_P_201708 <- crop(P_201708, WAYNE)  
WAYNE_P_201709 <- crop(P_201709, WAYNE)  
WAYNE_P_201710 <- crop(P_201710, WAYNE)  
WAYNE_P_201711 <- crop(P_201711, WAYNE)  
WAYNE_P_201712 <- crop(P_201712, WAYNE)  

#2018

WAYNE_P_201801 <- crop(P_201801, WAYNE) 
WAYNE_P_201802 <- crop(P_201802, WAYNE)
WAYNE_P_201803 <- crop(P_201803, WAYNE)
WAYNE_P_201804 <- crop(P_201804, WAYNE)
WAYNE_P_201805 <- crop(P_201805, WAYNE)
WAYNE_P_201806 <- crop(P_201806, WAYNE)  
WAYNE_P_201807 <- crop(P_201807, WAYNE)  
WAYNE_P_201808 <- crop(P_201808, WAYNE)  
WAYNE_P_201809 <- crop(P_201809, WAYNE)  
WAYNE_P_201810 <- crop(P_201810, WAYNE)  
WAYNE_P_201811 <- crop(P_201811, WAYNE)  
WAYNE_P_201812 <- crop(P_201812, WAYNE)  


# Mean Monthly Precipitation
#2000
WAYNE_P_200001_mean <- cellStats(WAYNE_P_200001, mean)
WAYNE_P_200002_mean <- cellStats(WAYNE_P_200002, mean)
WAYNE_P_200003_mean <- cellStats(WAYNE_P_200003, mean)
WAYNE_P_200004_mean <- cellStats(WAYNE_P_200004, mean)
WAYNE_P_200005_mean <- cellStats(WAYNE_P_200005, mean)
WAYNE_P_200006_mean <- cellStats(WAYNE_P_200006, mean)
WAYNE_P_200007_mean <- cellStats(WAYNE_P_200007, mean)
WAYNE_P_200008_mean <- cellStats(WAYNE_P_200008, mean)
WAYNE_P_200009_mean <- cellStats(WAYNE_P_200009, mean)
WAYNE_P_200010_mean <- cellStats(WAYNE_P_200010, mean)
WAYNE_P_200011_mean <- cellStats(WAYNE_P_200011, mean)
WAYNE_P_200012_mean <- cellStats(WAYNE_P_200012, mean)
#2001
WAYNE_P_200101_mean <- cellStats(WAYNE_P_200101, mean)
WAYNE_P_200102_mean <- cellStats(WAYNE_P_200102, mean)
WAYNE_P_200103_mean <- cellStats(WAYNE_P_200103, mean)
WAYNE_P_200104_mean <- cellStats(WAYNE_P_200104, mean)
WAYNE_P_200105_mean <- cellStats(WAYNE_P_200105, mean)
WAYNE_P_200106_mean <- cellStats(WAYNE_P_200106, mean)
WAYNE_P_200107_mean <- cellStats(WAYNE_P_200107, mean)
WAYNE_P_200108_mean <- cellStats(WAYNE_P_200108, mean)
WAYNE_P_200109_mean <- cellStats(WAYNE_P_200109, mean)
WAYNE_P_200110_mean <- cellStats(WAYNE_P_200110, mean)
WAYNE_P_200111_mean <- cellStats(WAYNE_P_200111, mean)
WAYNE_P_200112_mean <- cellStats(WAYNE_P_200112, mean)

#2002
WAYNE_P_200201_mean <- cellStats(WAYNE_P_200201, mean)
WAYNE_P_200202_mean <- cellStats(WAYNE_P_200202, mean)
WAYNE_P_200203_mean <- cellStats(WAYNE_P_200203, mean)
WAYNE_P_200204_mean <- cellStats(WAYNE_P_200204, mean)
WAYNE_P_200205_mean <- cellStats(WAYNE_P_200205, mean)
WAYNE_P_200206_mean <- cellStats(WAYNE_P_200206, mean)
WAYNE_P_200207_mean <- cellStats(WAYNE_P_200207, mean)
WAYNE_P_200208_mean <- cellStats(WAYNE_P_200208, mean)
WAYNE_P_200209_mean <- cellStats(WAYNE_P_200209, mean)
WAYNE_P_200210_mean <- cellStats(WAYNE_P_200210, mean)
WAYNE_P_200211_mean <- cellStats(WAYNE_P_200211, mean)
WAYNE_P_200212_mean <- cellStats(WAYNE_P_200212, mean)

#2003
WAYNE_P_200301_mean <- cellStats(WAYNE_P_200301, mean)
WAYNE_P_200302_mean <- cellStats(WAYNE_P_200302, mean)
WAYNE_P_200303_mean <- cellStats(WAYNE_P_200303, mean)
WAYNE_P_200304_mean <- cellStats(WAYNE_P_200304, mean)
WAYNE_P_200305_mean <- cellStats(WAYNE_P_200305, mean)
WAYNE_P_200306_mean <- cellStats(WAYNE_P_200306, mean)
WAYNE_P_200307_mean <- cellStats(WAYNE_P_200307, mean)
WAYNE_P_200308_mean <- cellStats(WAYNE_P_200308, mean)
WAYNE_P_200309_mean <- cellStats(WAYNE_P_200309, mean)
WAYNE_P_200310_mean <- cellStats(WAYNE_P_200310, mean)
WAYNE_P_200311_mean <- cellStats(WAYNE_P_200311, mean)
WAYNE_P_200312_mean <- cellStats(WAYNE_P_200312, mean)

#2004

WAYNE_P_200401_mean <- cellStats(WAYNE_P_200401, mean)
WAYNE_P_200402_mean <- cellStats(WAYNE_P_200402, mean)
WAYNE_P_200403_mean <- cellStats(WAYNE_P_200403, mean)
WAYNE_P_200404_mean <- cellStats(WAYNE_P_200404, mean)
WAYNE_P_200405_mean <- cellStats(WAYNE_P_200405, mean)
WAYNE_P_200406_mean <- cellStats(WAYNE_P_200406, mean)
WAYNE_P_200407_mean <- cellStats(WAYNE_P_200407, mean)
WAYNE_P_200408_mean <- cellStats(WAYNE_P_200408, mean)
WAYNE_P_200409_mean <- cellStats(WAYNE_P_200409, mean)
WAYNE_P_200410_mean <- cellStats(WAYNE_P_200410, mean)
WAYNE_P_200411_mean <- cellStats(WAYNE_P_200411, mean)
WAYNE_P_200412_mean <- cellStats(WAYNE_P_200412, mean)

#2005

WAYNE_P_200501_mean <- cellStats(WAYNE_P_200501, mean)
WAYNE_P_200502_mean <- cellStats(WAYNE_P_200502, mean)
WAYNE_P_200503_mean <- cellStats(WAYNE_P_200503, mean)
WAYNE_P_200504_mean <- cellStats(WAYNE_P_200504, mean)
WAYNE_P_200505_mean <- cellStats(WAYNE_P_200505, mean)
WAYNE_P_200506_mean <- cellStats(WAYNE_P_200506, mean)
WAYNE_P_200507_mean <- cellStats(WAYNE_P_200507, mean)
WAYNE_P_200508_mean <- cellStats(WAYNE_P_200508, mean)
WAYNE_P_200509_mean <- cellStats(WAYNE_P_200509, mean)
WAYNE_P_200510_mean <- cellStats(WAYNE_P_200510, mean)
WAYNE_P_200511_mean <- cellStats(WAYNE_P_200511, mean)
WAYNE_P_200512_mean <- cellStats(WAYNE_P_200512, mean)

#2006

WAYNE_P_200601_mean <- cellStats(WAYNE_P_200601, mean)
WAYNE_P_200602_mean <- cellStats(WAYNE_P_200602, mean)
WAYNE_P_200603_mean <- cellStats(WAYNE_P_200603, mean)
WAYNE_P_200604_mean <- cellStats(WAYNE_P_200604, mean)
WAYNE_P_200605_mean <- cellStats(WAYNE_P_200605, mean)
WAYNE_P_200606_mean <- cellStats(WAYNE_P_200606, mean)
WAYNE_P_200607_mean <- cellStats(WAYNE_P_200607, mean)
WAYNE_P_200608_mean <- cellStats(WAYNE_P_200608, mean)
WAYNE_P_200609_mean <- cellStats(WAYNE_P_200609, mean)
WAYNE_P_200610_mean <- cellStats(WAYNE_P_200610, mean)
WAYNE_P_200611_mean <- cellStats(WAYNE_P_200611, mean)
WAYNE_P_200612_mean <- cellStats(WAYNE_P_200612, mean)

#2007

WAYNE_P_200701_mean <- cellStats(WAYNE_P_200701, mean)
WAYNE_P_200702_mean <- cellStats(WAYNE_P_200702, mean)
WAYNE_P_200703_mean <- cellStats(WAYNE_P_200703, mean)
WAYNE_P_200704_mean <- cellStats(WAYNE_P_200704, mean)
WAYNE_P_200705_mean <- cellStats(WAYNE_P_200705, mean)
WAYNE_P_200706_mean <- cellStats(WAYNE_P_200706, mean)
WAYNE_P_200707_mean <- cellStats(WAYNE_P_200707, mean)
WAYNE_P_200708_mean <- cellStats(WAYNE_P_200708, mean)
WAYNE_P_200709_mean <- cellStats(WAYNE_P_200709, mean)
WAYNE_P_200710_mean <- cellStats(WAYNE_P_200710, mean)
WAYNE_P_200711_mean <- cellStats(WAYNE_P_200711, mean)
WAYNE_P_200712_mean <- cellStats(WAYNE_P_200712, mean)

#2008

WAYNE_P_200801_mean <- cellStats(WAYNE_P_200801, mean)
WAYNE_P_200802_mean <- cellStats(WAYNE_P_200802, mean)
WAYNE_P_200803_mean <- cellStats(WAYNE_P_200803, mean)
WAYNE_P_200804_mean <- cellStats(WAYNE_P_200804, mean)
WAYNE_P_200805_mean <- cellStats(WAYNE_P_200805, mean)
WAYNE_P_200806_mean <- cellStats(WAYNE_P_200806, mean)
WAYNE_P_200807_mean <- cellStats(WAYNE_P_200807, mean)
WAYNE_P_200808_mean <- cellStats(WAYNE_P_200808, mean)
WAYNE_P_200809_mean <- cellStats(WAYNE_P_200809, mean)
WAYNE_P_200810_mean <- cellStats(WAYNE_P_200810, mean)
WAYNE_P_200811_mean <- cellStats(WAYNE_P_200811, mean)
WAYNE_P_200812_mean <- cellStats(WAYNE_P_200812, mean)

#2009

WAYNE_P_200901_mean <- cellStats(WAYNE_P_200901, mean)
WAYNE_P_200902_mean <- cellStats(WAYNE_P_200902, mean)
WAYNE_P_200903_mean <- cellStats(WAYNE_P_200903, mean)
WAYNE_P_200904_mean <- cellStats(WAYNE_P_200904, mean)
WAYNE_P_200905_mean <- cellStats(WAYNE_P_200905, mean)
WAYNE_P_200906_mean <- cellStats(WAYNE_P_200906, mean)
WAYNE_P_200907_mean <- cellStats(WAYNE_P_200907, mean)
WAYNE_P_200908_mean <- cellStats(WAYNE_P_200908, mean)
WAYNE_P_200909_mean <- cellStats(WAYNE_P_200909, mean)
WAYNE_P_200910_mean <- cellStats(WAYNE_P_200910, mean)
WAYNE_P_200911_mean <- cellStats(WAYNE_P_200911, mean)
WAYNE_P_200912_mean <- cellStats(WAYNE_P_200912, mean)

#2010

WAYNE_P_201001_mean <- cellStats(WAYNE_P_201001, mean)
WAYNE_P_201002_mean <- cellStats(WAYNE_P_201002, mean)
WAYNE_P_201003_mean <- cellStats(WAYNE_P_201003, mean)
WAYNE_P_201004_mean <- cellStats(WAYNE_P_201004, mean)
WAYNE_P_201005_mean <- cellStats(WAYNE_P_201005, mean)
WAYNE_P_201006_mean <- cellStats(WAYNE_P_201006, mean)
WAYNE_P_201007_mean <- cellStats(WAYNE_P_201007, mean)
WAYNE_P_201008_mean <- cellStats(WAYNE_P_201008, mean)
WAYNE_P_201009_mean <- cellStats(WAYNE_P_201009, mean)
WAYNE_P_201010_mean <- cellStats(WAYNE_P_201010, mean)
WAYNE_P_201011_mean <- cellStats(WAYNE_P_201011, mean)
WAYNE_P_201012_mean <- cellStats(WAYNE_P_201012, mean)

#2011

WAYNE_P_201101_mean <- cellStats(WAYNE_P_201101, mean)
WAYNE_P_201102_mean <- cellStats(WAYNE_P_201102, mean)
WAYNE_P_201103_mean <- cellStats(WAYNE_P_201103, mean)
WAYNE_P_201104_mean <- cellStats(WAYNE_P_201104, mean)
WAYNE_P_201105_mean <- cellStats(WAYNE_P_201105, mean)
WAYNE_P_201106_mean <- cellStats(WAYNE_P_201106, mean)
WAYNE_P_201107_mean <- cellStats(WAYNE_P_201107, mean)
WAYNE_P_201108_mean <- cellStats(WAYNE_P_201108, mean)
WAYNE_P_201109_mean <- cellStats(WAYNE_P_201109, mean)
WAYNE_P_201110_mean <- cellStats(WAYNE_P_201110, mean)
WAYNE_P_201111_mean <- cellStats(WAYNE_P_201111, mean)
WAYNE_P_201112_mean <- cellStats(WAYNE_P_201112, mean)

#2012
WAYNE_P_201201_mean <- cellStats(WAYNE_P_201201, mean)
WAYNE_P_201202_mean <- cellStats(WAYNE_P_201202, mean)
WAYNE_P_201203_mean <- cellStats(WAYNE_P_201203, mean)
WAYNE_P_201204_mean <- cellStats(WAYNE_P_201204, mean)
WAYNE_P_201205_mean <- cellStats(WAYNE_P_201205, mean)
WAYNE_P_201206_mean <- cellStats(WAYNE_P_201206, mean)
WAYNE_P_201207_mean <- cellStats(WAYNE_P_201207, mean)
WAYNE_P_201208_mean <- cellStats(WAYNE_P_201208, mean)
WAYNE_P_201209_mean <- cellStats(WAYNE_P_201209, mean)
WAYNE_P_201210_mean <- cellStats(WAYNE_P_201210, mean)
WAYNE_P_201211_mean <- cellStats(WAYNE_P_201211, mean)
WAYNE_P_201212_mean <- cellStats(WAYNE_P_201212, mean)

#2013
WAYNE_P_201301_mean <- cellStats(WAYNE_P_201301, mean)
WAYNE_P_201302_mean <- cellStats(WAYNE_P_201302, mean)
WAYNE_P_201303_mean <- cellStats(WAYNE_P_201303, mean)
WAYNE_P_201304_mean <- cellStats(WAYNE_P_201304, mean)
WAYNE_P_201305_mean <- cellStats(WAYNE_P_201305, mean)
WAYNE_P_201306_mean <- cellStats(WAYNE_P_201306, mean)
WAYNE_P_201307_mean <- cellStats(WAYNE_P_201307, mean)
WAYNE_P_201308_mean <- cellStats(WAYNE_P_201308, mean)
WAYNE_P_201309_mean <- cellStats(WAYNE_P_201309, mean)
WAYNE_P_201310_mean <- cellStats(WAYNE_P_201310, mean)
WAYNE_P_201311_mean <- cellStats(WAYNE_P_201311, mean)
WAYNE_P_201312_mean <- cellStats(WAYNE_P_201312, mean)

#2014
WAYNE_P_201401_mean <- cellStats(WAYNE_P_201401, mean)
WAYNE_P_201402_mean <- cellStats(WAYNE_P_201402, mean)
WAYNE_P_201403_mean <- cellStats(WAYNE_P_201403, mean)
WAYNE_P_201404_mean <- cellStats(WAYNE_P_201404, mean)
WAYNE_P_201405_mean <- cellStats(WAYNE_P_201405, mean)
WAYNE_P_201406_mean <- cellStats(WAYNE_P_201406, mean)
WAYNE_P_201407_mean <- cellStats(WAYNE_P_201407, mean)
WAYNE_P_201408_mean <- cellStats(WAYNE_P_201408, mean)
WAYNE_P_201409_mean <- cellStats(WAYNE_P_201409, mean)
WAYNE_P_201410_mean <- cellStats(WAYNE_P_201410, mean)
WAYNE_P_201411_mean <- cellStats(WAYNE_P_201411, mean)
WAYNE_P_201412_mean <- cellStats(WAYNE_P_201412, mean)

#2015
WAYNE_P_201501_mean <- cellStats(WAYNE_P_201501, mean)
WAYNE_P_201502_mean <- cellStats(WAYNE_P_201502, mean)
WAYNE_P_201503_mean <- cellStats(WAYNE_P_201503, mean)
WAYNE_P_201504_mean <- cellStats(WAYNE_P_201504, mean)
WAYNE_P_201505_mean <- cellStats(WAYNE_P_201505, mean)
WAYNE_P_201506_mean <- cellStats(WAYNE_P_201506, mean)
WAYNE_P_201507_mean <- cellStats(WAYNE_P_201507, mean)
WAYNE_P_201508_mean <- cellStats(WAYNE_P_201508, mean)
WAYNE_P_201509_mean <- cellStats(WAYNE_P_201509, mean)
WAYNE_P_201510_mean <- cellStats(WAYNE_P_201510, mean)
WAYNE_P_201511_mean <- cellStats(WAYNE_P_201511, mean)
WAYNE_P_201512_mean <- cellStats(WAYNE_P_201512, mean)

#2016
WAYNE_P_201601_mean <- cellStats(WAYNE_P_201601, mean)
WAYNE_P_201602_mean <- cellStats(WAYNE_P_201602, mean)
WAYNE_P_201603_mean <- cellStats(WAYNE_P_201603, mean)
WAYNE_P_201604_mean <- cellStats(WAYNE_P_201604, mean)
WAYNE_P_201605_mean <- cellStats(WAYNE_P_201605, mean)
WAYNE_P_201606_mean <- cellStats(WAYNE_P_201606, mean)
WAYNE_P_201607_mean <- cellStats(WAYNE_P_201607, mean)
WAYNE_P_201608_mean <- cellStats(WAYNE_P_201608, mean)
WAYNE_P_201609_mean <- cellStats(WAYNE_P_201609, mean)
WAYNE_P_201610_mean <- cellStats(WAYNE_P_201610, mean)
WAYNE_P_201611_mean <- cellStats(WAYNE_P_201611, mean)
WAYNE_P_201612_mean <- cellStats(WAYNE_P_201612, mean)

#2017
WAYNE_P_201701_mean <- cellStats(WAYNE_P_201701, mean)
WAYNE_P_201702_mean <- cellStats(WAYNE_P_201702, mean)
WAYNE_P_201703_mean <- cellStats(WAYNE_P_201703, mean)
WAYNE_P_201704_mean <- cellStats(WAYNE_P_201704, mean)
WAYNE_P_201705_mean <- cellStats(WAYNE_P_201705, mean)
WAYNE_P_201706_mean <- cellStats(WAYNE_P_201706, mean)
WAYNE_P_201707_mean <- cellStats(WAYNE_P_201707, mean)
WAYNE_P_201708_mean <- cellStats(WAYNE_P_201708, mean)
WAYNE_P_201709_mean <- cellStats(WAYNE_P_201709, mean)
WAYNE_P_201710_mean <- cellStats(WAYNE_P_201710, mean)
WAYNE_P_201711_mean <- cellStats(WAYNE_P_201711, mean)
WAYNE_P_201712_mean <- cellStats(WAYNE_P_201712, mean)

#2018
WAYNE_P_201801_mean <- cellStats(WAYNE_P_201801, mean)
WAYNE_P_201802_mean <- cellStats(WAYNE_P_201802, mean)
WAYNE_P_201803_mean <- cellStats(WAYNE_P_201803, mean)
WAYNE_P_201804_mean <- cellStats(WAYNE_P_201804, mean)
WAYNE_P_201805_mean <- cellStats(WAYNE_P_201805, mean)
WAYNE_P_201806_mean <- cellStats(WAYNE_P_201806, mean)
WAYNE_P_201807_mean <- cellStats(WAYNE_P_201807, mean)
WAYNE_P_201808_mean <- cellStats(WAYNE_P_201808, mean)
WAYNE_P_201809_mean <- cellStats(WAYNE_P_201809, mean)
WAYNE_P_201810_mean <- cellStats(WAYNE_P_201810, mean)
WAYNE_P_201811_mean <- cellStats(WAYNE_P_201811, mean)
WAYNE_P_201812_mean <- cellStats(WAYNE_P_201812, mean)


# WASTACH


#2000
WASATCH_P_200001 <- crop(P_200001, WASATCH) 
WASATCH_P_200002 <- crop(P_200002, WASATCH)
WASATCH_P_200003 <- crop(P_200003, WASATCH)
WASATCH_P_200004 <- crop(P_200004, WASATCH)
WASATCH_P_200005 <- crop(P_200005, WASATCH)
WASATCH_P_200006 <- crop(P_200006, WASATCH)  
WASATCH_P_200007 <- crop(P_200007, WASATCH)  
WASATCH_P_200008 <- crop(P_200008, WASATCH)  
WASATCH_P_200009 <- crop(P_200009, WASATCH)  
WASATCH_P_200010 <- crop(P_200010, WASATCH)  
WASATCH_P_200011 <- crop(P_200011, WASATCH)  
WASATCH_P_200012 <- crop(P_200012, WASATCH)  
#2001
WASATCH_P_200101 <- crop(P_200101, WASATCH) 
WASATCH_P_200102 <- crop(P_200102, WASATCH)
WASATCH_P_200103 <- crop(P_200103, WASATCH)
WASATCH_P_200104 <- crop(P_200104, WASATCH)
WASATCH_P_200105 <- crop(P_200105, WASATCH)
WASATCH_P_200106 <- crop(P_200106, WASATCH)  
WASATCH_P_200107 <- crop(P_200107, WASATCH)  
WASATCH_P_200108 <- crop(P_200108, WASATCH)  
WASATCH_P_200109 <- crop(P_200109, WASATCH)  
WASATCH_P_200110 <- crop(P_200110, WASATCH)  
WASATCH_P_200111 <- crop(P_200111, WASATCH)  
WASATCH_P_200112 <- crop(P_200112, WASATCH)  

#2002
WASATCH_P_200201 <- crop(P_200201, WASATCH) 
WASATCH_P_200202 <- crop(P_200202, WASATCH)
WASATCH_P_200203 <- crop(P_200203, WASATCH)
WASATCH_P_200204 <- crop(P_200204, WASATCH)
WASATCH_P_200205 <- crop(P_200205, WASATCH)
WASATCH_P_200206 <- crop(P_200206, WASATCH)  
WASATCH_P_200207 <- crop(P_200207, WASATCH)  
WASATCH_P_200208 <- crop(P_200208, WASATCH)  
WASATCH_P_200209 <- crop(P_200209, WASATCH)  
WASATCH_P_200210 <- crop(P_200210, WASATCH)  
WASATCH_P_200211 <- crop(P_200211, WASATCH)  
WASATCH_P_200212 <- crop(P_200212, WASATCH)  
#2003
WASATCH_P_200301 <- crop(P_200301, WASATCH) 
WASATCH_P_200302 <- crop(P_200302, WASATCH)
WASATCH_P_200303 <- crop(P_200303, WASATCH)
WASATCH_P_200304 <- crop(P_200304, WASATCH)
WASATCH_P_200305 <- crop(P_200305, WASATCH)
WASATCH_P_200306 <- crop(P_200306, WASATCH)  
WASATCH_P_200307 <- crop(P_200307, WASATCH)  
WASATCH_P_200308 <- crop(P_200308, WASATCH)  
WASATCH_P_200309 <- crop(P_200309, WASATCH)  
WASATCH_P_200310 <- crop(P_200310, WASATCH)  
WASATCH_P_200311 <- crop(P_200311, WASATCH)  
WASATCH_P_200312 <- crop(P_200312, WASATCH)  
#2004
WASATCH_P_200401 <- crop(P_200401, WASATCH) 
WASATCH_P_200402 <- crop(P_200402, WASATCH)
WASATCH_P_200403 <- crop(P_200403, WASATCH)
WASATCH_P_200404 <- crop(P_200404, WASATCH)
WASATCH_P_200405 <- crop(P_200405, WASATCH)
WASATCH_P_200406 <- crop(P_200406, WASATCH)  
WASATCH_P_200407 <- crop(P_200407, WASATCH)  
WASATCH_P_200408 <- crop(P_200408, WASATCH)  
WASATCH_P_200409 <- crop(P_200409, WASATCH)  
WASATCH_P_200410 <- crop(P_200410, WASATCH)  
WASATCH_P_200411 <- crop(P_200411, WASATCH)  
WASATCH_P_200412 <- crop(P_200412, WASATCH)  
#2005
WASATCH_P_200501 <- crop(P_200501, WASATCH) 
WASATCH_P_200502 <- crop(P_200502, WASATCH)
WASATCH_P_200503 <- crop(P_200503, WASATCH)
WASATCH_P_200504 <- crop(P_200504, WASATCH)
WASATCH_P_200505 <- crop(P_200505, WASATCH)
WASATCH_P_200506 <- crop(P_200506, WASATCH)  
WASATCH_P_200507 <- crop(P_200507, WASATCH)  
WASATCH_P_200508 <- crop(P_200508, WASATCH)  
WASATCH_P_200509 <- crop(P_200509, WASATCH)  
WASATCH_P_200510 <- crop(P_200510, WASATCH)  
WASATCH_P_200511 <- crop(P_200511, WASATCH)  
WASATCH_P_200512 <- crop(P_200512, WASATCH)  
#2006
WASATCH_P_200601 <- crop(P_200601, WASATCH) 
WASATCH_P_200602 <- crop(P_200602, WASATCH)
WASATCH_P_200603 <- crop(P_200603, WASATCH)
WASATCH_P_200604 <- crop(P_200604, WASATCH)
WASATCH_P_200605 <- crop(P_200605, WASATCH)
WASATCH_P_200606 <- crop(P_200606, WASATCH)  
WASATCH_P_200607 <- crop(P_200607, WASATCH)  
WASATCH_P_200608 <- crop(P_200608, WASATCH)  
WASATCH_P_200609 <- crop(P_200609, WASATCH)  
WASATCH_P_200610 <- crop(P_200610, WASATCH)  
WASATCH_P_200611 <- crop(P_200611, WASATCH)  
WASATCH_P_200612 <- crop(P_200612, WASATCH)  
#2007
WASATCH_P_200701 <- crop(P_200701, WASATCH) 
WASATCH_P_200702 <- crop(P_200702, WASATCH)
WASATCH_P_200703 <- crop(P_200703, WASATCH)
WASATCH_P_200704 <- crop(P_200704, WASATCH)
WASATCH_P_200705 <- crop(P_200705, WASATCH)
WASATCH_P_200706 <- crop(P_200706, WASATCH)  
WASATCH_P_200707 <- crop(P_200707, WASATCH)  
WASATCH_P_200708 <- crop(P_200708, WASATCH)  
WASATCH_P_200709 <- crop(P_200709, WASATCH)  
WASATCH_P_200710 <- crop(P_200710, WASATCH)  
WASATCH_P_200711 <- crop(P_200711, WASATCH)  
WASATCH_P_200712 <- crop(P_200712, WASATCH)  
#2008
WASATCH_P_200801 <- crop(P_200801, WASATCH) 
WASATCH_P_200802 <- crop(P_200802, WASATCH)
WASATCH_P_200803 <- crop(P_200803, WASATCH)
WASATCH_P_200804 <- crop(P_200804, WASATCH)
WASATCH_P_200805 <- crop(P_200805, WASATCH)
WASATCH_P_200806 <- crop(P_200806, WASATCH)  
WASATCH_P_200807 <- crop(P_200807, WASATCH)  
WASATCH_P_200808 <- crop(P_200808, WASATCH)  
WASATCH_P_200809 <- crop(P_200809, WASATCH)  
WASATCH_P_200810 <- crop(P_200810, WASATCH)  
WASATCH_P_200811 <- crop(P_200811, WASATCH)  
WASATCH_P_200812 <- crop(P_200812, WASATCH)  
#2009
WASATCH_P_200901 <- crop(P_200901, WASATCH) 
WASATCH_P_200902 <- crop(P_200902, WASATCH)
WASATCH_P_200903 <- crop(P_200903, WASATCH)
WASATCH_P_200904 <- crop(P_200904, WASATCH)
WASATCH_P_200905 <- crop(P_200905, WASATCH)
WASATCH_P_200906 <- crop(P_200906, WASATCH)  
WASATCH_P_200907 <- crop(P_200907, WASATCH)  
WASATCH_P_200908 <- crop(P_200908, WASATCH)  
WASATCH_P_200909 <- crop(P_200909, WASATCH)  
WASATCH_P_200910 <- crop(P_200910, WASATCH)  
WASATCH_P_200911 <- crop(P_200911, WASATCH)  
WASATCH_P_200912 <- crop(P_200912, WASATCH)  
#2010
WASATCH_P_201001 <- crop(P_201001, WASATCH) 
WASATCH_P_201002 <- crop(P_201002, WASATCH)
WASATCH_P_201003 <- crop(P_201003, WASATCH)
WASATCH_P_201004 <- crop(P_201004, WASATCH)
WASATCH_P_201005 <- crop(P_201005, WASATCH)
WASATCH_P_201006 <- crop(P_201006, WASATCH)  
WASATCH_P_201007 <- crop(P_201007, WASATCH)  
WASATCH_P_201008 <- crop(P_201008, WASATCH)  
WASATCH_P_201009 <- crop(P_201009, WASATCH)  
WASATCH_P_201010 <- crop(P_201010, WASATCH)  
WASATCH_P_201011 <- crop(P_201011, WASATCH)  
WASATCH_P_201012 <- crop(P_201012, WASATCH)  
#2011
WASATCH_P_201101 <- crop(P_201101, WASATCH) 
WASATCH_P_201102 <- crop(P_201102, WASATCH)
WASATCH_P_201103 <- crop(P_201103, WASATCH)
WASATCH_P_201104 <- crop(P_201104, WASATCH)
WASATCH_P_201105 <- crop(P_201105, WASATCH)
WASATCH_P_201106 <- crop(P_201106, WASATCH)  
WASATCH_P_201107 <- crop(P_201107, WASATCH)  
WASATCH_P_201108 <- crop(P_201108, WASATCH)  
WASATCH_P_201109 <- crop(P_201109, WASATCH)  
WASATCH_P_201110 <- crop(P_201110, WASATCH)  
WASATCH_P_201111 <- crop(P_201111, WASATCH)  
WASATCH_P_201112 <- crop(P_201112, WASATCH)  
#2012
WASATCH_P_201201 <- crop(P_201201, WASATCH) 
WASATCH_P_201202 <- crop(P_201202, WASATCH)
WASATCH_P_201203 <- crop(P_201203, WASATCH)
WASATCH_P_201204 <- crop(P_201204, WASATCH)
WASATCH_P_201205 <- crop(P_201205, WASATCH)
WASATCH_P_201206 <- crop(P_201206, WASATCH)  
WASATCH_P_201207 <- crop(P_201207, WASATCH)  
WASATCH_P_201208 <- crop(P_201208, WASATCH)  
WASATCH_P_201209 <- crop(P_201209, WASATCH)  
WASATCH_P_201210 <- crop(P_201210, WASATCH)  
WASATCH_P_201211 <- crop(P_201211, WASATCH)  
WASATCH_P_201212 <- crop(P_201212, WASATCH)  
#2013
WASATCH_P_201301 <- crop(P_201301, WASATCH) 
WASATCH_P_201302 <- crop(P_201302, WASATCH)
WASATCH_P_201303 <- crop(P_201303, WASATCH)
WASATCH_P_201304 <- crop(P_201304, WASATCH)
WASATCH_P_201305 <- crop(P_201305, WASATCH)
WASATCH_P_201306 <- crop(P_201306, WASATCH)  
WASATCH_P_201307 <- crop(P_201307, WASATCH)  
WASATCH_P_201308 <- crop(P_201308, WASATCH)  
WASATCH_P_201309 <- crop(P_201309, WASATCH)  
WASATCH_P_201310 <- crop(P_201310, WASATCH)  
WASATCH_P_201311 <- crop(P_201311, WASATCH)  
WASATCH_P_201312 <- crop(P_201312, WASATCH)  
#2014
WASATCH_P_201401 <- crop(P_201401, WASATCH) 
WASATCH_P_201402 <- crop(P_201402, WASATCH)
WASATCH_P_201403 <- crop(P_201403, WASATCH)
WASATCH_P_201404 <- crop(P_201404, WASATCH)
WASATCH_P_201405 <- crop(P_201405, WASATCH)
WASATCH_P_201406 <- crop(P_201406, WASATCH)  
WASATCH_P_201407 <- crop(P_201407, WASATCH)  
WASATCH_P_201408 <- crop(P_201408, WASATCH)  
WASATCH_P_201409 <- crop(P_201409, WASATCH)  
WASATCH_P_201410 <- crop(P_201410, WASATCH)  
WASATCH_P_201411 <- crop(P_201411, WASATCH)  
WASATCH_P_201412 <- crop(P_201412, WASATCH)  
#2015
WASATCH_P_201501 <- crop(P_201501, WASATCH) 
WASATCH_P_201502 <- crop(P_201502, WASATCH)
WASATCH_P_201503 <- crop(P_201503, WASATCH)
WASATCH_P_201504 <- crop(P_201504, WASATCH)
WASATCH_P_201505 <- crop(P_201505, WASATCH)
WASATCH_P_201506 <- crop(P_201506, WASATCH)  
WASATCH_P_201507 <- crop(P_201507, WASATCH)  
WASATCH_P_201508 <- crop(P_201508, WASATCH)  
WASATCH_P_201509 <- crop(P_201509, WASATCH)  
WASATCH_P_201510 <- crop(P_201510, WASATCH)  
WASATCH_P_201511 <- crop(P_201511, WASATCH)  
WASATCH_P_201512 <- crop(P_201512, WASATCH)  
#2016
WASATCH_P_201601 <- crop(P_201601, WASATCH) 
WASATCH_P_201602 <- crop(P_201602, WASATCH)
WASATCH_P_201603 <- crop(P_201603, WASATCH)
WASATCH_P_201604 <- crop(P_201604, WASATCH)
WASATCH_P_201605 <- crop(P_201605, WASATCH)
WASATCH_P_201606 <- crop(P_201606, WASATCH)  
WASATCH_P_201607 <- crop(P_201607, WASATCH)  
WASATCH_P_201608 <- crop(P_201608, WASATCH)  
WASATCH_P_201609 <- crop(P_201609, WASATCH)  
WASATCH_P_201610 <- crop(P_201610, WASATCH)  
WASATCH_P_201611 <- crop(P_201611, WASATCH)  
WASATCH_P_201612 <- crop(P_201612, WASATCH)  
#2017
WASATCH_P_201701 <- crop(P_201701, WASATCH) 
WASATCH_P_201702 <- crop(P_201702, WASATCH)
WASATCH_P_201703 <- crop(P_201703, WASATCH)
WASATCH_P_201704 <- crop(P_201704, WASATCH)
WASATCH_P_201705 <- crop(P_201705, WASATCH)
WASATCH_P_201706 <- crop(P_201706, WASATCH)  
WASATCH_P_201707 <- crop(P_201707, WASATCH)  
WASATCH_P_201708 <- crop(P_201708, WASATCH)  
WASATCH_P_201709 <- crop(P_201709, WASATCH)  
WASATCH_P_201710 <- crop(P_201710, WASATCH)  
WASATCH_P_201711 <- crop(P_201711, WASATCH)  
WASATCH_P_201712 <- crop(P_201712, WASATCH)  

#2018

WASATCH_P_201801 <- crop(P_201801, WASATCH) 
WASATCH_P_201802 <- crop(P_201802, WASATCH)
WASATCH_P_201803 <- crop(P_201803, WASATCH)
WASATCH_P_201804 <- crop(P_201804, WASATCH)
WASATCH_P_201805 <- crop(P_201805, WASATCH)
WASATCH_P_201806 <- crop(P_201806, WASATCH)  
WASATCH_P_201807 <- crop(P_201807, WASATCH)  
WASATCH_P_201808 <- crop(P_201808, WASATCH)  
WASATCH_P_201809 <- crop(P_201809, WASATCH)  
WASATCH_P_201810 <- crop(P_201810, WASATCH)  
WASATCH_P_201811 <- crop(P_201811, WASATCH)  
WASATCH_P_201812 <- crop(P_201812, WASATCH)  


# Mean Monthly Precipitation
#2000
WASATCH_P_200001_mean <- cellStats(WASATCH_P_200001, mean)
WASATCH_P_200002_mean <- cellStats(WASATCH_P_200002, mean)
WASATCH_P_200003_mean <- cellStats(WASATCH_P_200003, mean)
WASATCH_P_200004_mean <- cellStats(WASATCH_P_200004, mean)
WASATCH_P_200005_mean <- cellStats(WASATCH_P_200005, mean)
WASATCH_P_200006_mean <- cellStats(WASATCH_P_200006, mean)
WASATCH_P_200007_mean <- cellStats(WASATCH_P_200007, mean)
WASATCH_P_200008_mean <- cellStats(WASATCH_P_200008, mean)
WASATCH_P_200009_mean <- cellStats(WASATCH_P_200009, mean)
WASATCH_P_200010_mean <- cellStats(WASATCH_P_200010, mean)
WASATCH_P_200011_mean <- cellStats(WASATCH_P_200011, mean)
WASATCH_P_200012_mean <- cellStats(WASATCH_P_200012, mean)
#2001
WASATCH_P_200101_mean <- cellStats(WASATCH_P_200101, mean)
WASATCH_P_200102_mean <- cellStats(WASATCH_P_200102, mean)
WASATCH_P_200103_mean <- cellStats(WASATCH_P_200103, mean)
WASATCH_P_200104_mean <- cellStats(WASATCH_P_200104, mean)
WASATCH_P_200105_mean <- cellStats(WASATCH_P_200105, mean)
WASATCH_P_200106_mean <- cellStats(WASATCH_P_200106, mean)
WASATCH_P_200107_mean <- cellStats(WASATCH_P_200107, mean)
WASATCH_P_200108_mean <- cellStats(WASATCH_P_200108, mean)
WASATCH_P_200109_mean <- cellStats(WASATCH_P_200109, mean)
WASATCH_P_200110_mean <- cellStats(WASATCH_P_200110, mean)
WASATCH_P_200111_mean <- cellStats(WASATCH_P_200111, mean)
WASATCH_P_200112_mean <- cellStats(WASATCH_P_200112, mean)

#2002
WASATCH_P_200201_mean <- cellStats(WASATCH_P_200201, mean)
WASATCH_P_200202_mean <- cellStats(WASATCH_P_200202, mean)
WASATCH_P_200203_mean <- cellStats(WASATCH_P_200203, mean)
WASATCH_P_200204_mean <- cellStats(WASATCH_P_200204, mean)
WASATCH_P_200205_mean <- cellStats(WASATCH_P_200205, mean)
WASATCH_P_200206_mean <- cellStats(WASATCH_P_200206, mean)
WASATCH_P_200207_mean <- cellStats(WASATCH_P_200207, mean)
WASATCH_P_200208_mean <- cellStats(WASATCH_P_200208, mean)
WASATCH_P_200209_mean <- cellStats(WASATCH_P_200209, mean)
WASATCH_P_200210_mean <- cellStats(WASATCH_P_200210, mean)
WASATCH_P_200211_mean <- cellStats(WASATCH_P_200211, mean)
WASATCH_P_200212_mean <- cellStats(WASATCH_P_200212, mean)

#2003
WASATCH_P_200301_mean <- cellStats(WASATCH_P_200301, mean)
WASATCH_P_200302_mean <- cellStats(WASATCH_P_200302, mean)
WASATCH_P_200303_mean <- cellStats(WASATCH_P_200303, mean)
WASATCH_P_200304_mean <- cellStats(WASATCH_P_200304, mean)
WASATCH_P_200305_mean <- cellStats(WASATCH_P_200305, mean)
WASATCH_P_200306_mean <- cellStats(WASATCH_P_200306, mean)
WASATCH_P_200307_mean <- cellStats(WASATCH_P_200307, mean)
WASATCH_P_200308_mean <- cellStats(WASATCH_P_200308, mean)
WASATCH_P_200309_mean <- cellStats(WASATCH_P_200309, mean)
WASATCH_P_200310_mean <- cellStats(WASATCH_P_200310, mean)
WASATCH_P_200311_mean <- cellStats(WASATCH_P_200311, mean)
WASATCH_P_200312_mean <- cellStats(WASATCH_P_200312, mean)

#2004

WASATCH_P_200401_mean <- cellStats(WASATCH_P_200401, mean)
WASATCH_P_200402_mean <- cellStats(WASATCH_P_200402, mean)
WASATCH_P_200403_mean <- cellStats(WASATCH_P_200403, mean)
WASATCH_P_200404_mean <- cellStats(WASATCH_P_200404, mean)
WASATCH_P_200405_mean <- cellStats(WASATCH_P_200405, mean)
WASATCH_P_200406_mean <- cellStats(WASATCH_P_200406, mean)
WASATCH_P_200407_mean <- cellStats(WASATCH_P_200407, mean)
WASATCH_P_200408_mean <- cellStats(WASATCH_P_200408, mean)
WASATCH_P_200409_mean <- cellStats(WASATCH_P_200409, mean)
WASATCH_P_200410_mean <- cellStats(WASATCH_P_200410, mean)
WASATCH_P_200411_mean <- cellStats(WASATCH_P_200411, mean)
WASATCH_P_200412_mean <- cellStats(WASATCH_P_200412, mean)

#2005

WASATCH_P_200501_mean <- cellStats(WASATCH_P_200501, mean)
WASATCH_P_200502_mean <- cellStats(WASATCH_P_200502, mean)
WASATCH_P_200503_mean <- cellStats(WASATCH_P_200503, mean)
WASATCH_P_200504_mean <- cellStats(WASATCH_P_200504, mean)
WASATCH_P_200505_mean <- cellStats(WASATCH_P_200505, mean)
WASATCH_P_200506_mean <- cellStats(WASATCH_P_200506, mean)
WASATCH_P_200507_mean <- cellStats(WASATCH_P_200507, mean)
WASATCH_P_200508_mean <- cellStats(WASATCH_P_200508, mean)
WASATCH_P_200509_mean <- cellStats(WASATCH_P_200509, mean)
WASATCH_P_200510_mean <- cellStats(WASATCH_P_200510, mean)
WASATCH_P_200511_mean <- cellStats(WASATCH_P_200511, mean)
WASATCH_P_200512_mean <- cellStats(WASATCH_P_200512, mean)

#2006

WASATCH_P_200601_mean <- cellStats(WASATCH_P_200601, mean)
WASATCH_P_200602_mean <- cellStats(WASATCH_P_200602, mean)
WASATCH_P_200603_mean <- cellStats(WASATCH_P_200603, mean)
WASATCH_P_200604_mean <- cellStats(WASATCH_P_200604, mean)
WASATCH_P_200605_mean <- cellStats(WASATCH_P_200605, mean)
WASATCH_P_200606_mean <- cellStats(WASATCH_P_200606, mean)
WASATCH_P_200607_mean <- cellStats(WASATCH_P_200607, mean)
WASATCH_P_200608_mean <- cellStats(WASATCH_P_200608, mean)
WASATCH_P_200609_mean <- cellStats(WASATCH_P_200609, mean)
WASATCH_P_200610_mean <- cellStats(WASATCH_P_200610, mean)
WASATCH_P_200611_mean <- cellStats(WASATCH_P_200611, mean)
WASATCH_P_200612_mean <- cellStats(WASATCH_P_200612, mean)

#2007

WASATCH_P_200701_mean <- cellStats(WASATCH_P_200701, mean)
WASATCH_P_200702_mean <- cellStats(WASATCH_P_200702, mean)
WASATCH_P_200703_mean <- cellStats(WASATCH_P_200703, mean)
WASATCH_P_200704_mean <- cellStats(WASATCH_P_200704, mean)
WASATCH_P_200705_mean <- cellStats(WASATCH_P_200705, mean)
WASATCH_P_200706_mean <- cellStats(WASATCH_P_200706, mean)
WASATCH_P_200707_mean <- cellStats(WASATCH_P_200707, mean)
WASATCH_P_200708_mean <- cellStats(WASATCH_P_200708, mean)
WASATCH_P_200709_mean <- cellStats(WASATCH_P_200709, mean)
WASATCH_P_200710_mean <- cellStats(WASATCH_P_200710, mean)
WASATCH_P_200711_mean <- cellStats(WASATCH_P_200711, mean)
WASATCH_P_200712_mean <- cellStats(WASATCH_P_200712, mean)

#2008

WASATCH_P_200801_mean <- cellStats(WASATCH_P_200801, mean)
WASATCH_P_200802_mean <- cellStats(WASATCH_P_200802, mean)
WASATCH_P_200803_mean <- cellStats(WASATCH_P_200803, mean)
WASATCH_P_200804_mean <- cellStats(WASATCH_P_200804, mean)
WASATCH_P_200805_mean <- cellStats(WASATCH_P_200805, mean)
WASATCH_P_200806_mean <- cellStats(WASATCH_P_200806, mean)
WASATCH_P_200807_mean <- cellStats(WASATCH_P_200807, mean)
WASATCH_P_200808_mean <- cellStats(WASATCH_P_200808, mean)
WASATCH_P_200809_mean <- cellStats(WASATCH_P_200809, mean)
WASATCH_P_200810_mean <- cellStats(WASATCH_P_200810, mean)
WASATCH_P_200811_mean <- cellStats(WASATCH_P_200811, mean)
WASATCH_P_200812_mean <- cellStats(WASATCH_P_200812, mean)

#2009

WASATCH_P_200901_mean <- cellStats(WASATCH_P_200901, mean)
WASATCH_P_200902_mean <- cellStats(WASATCH_P_200902, mean)
WASATCH_P_200903_mean <- cellStats(WASATCH_P_200903, mean)
WASATCH_P_200904_mean <- cellStats(WASATCH_P_200904, mean)
WASATCH_P_200905_mean <- cellStats(WASATCH_P_200905, mean)
WASATCH_P_200906_mean <- cellStats(WASATCH_P_200906, mean)
WASATCH_P_200907_mean <- cellStats(WASATCH_P_200907, mean)
WASATCH_P_200908_mean <- cellStats(WASATCH_P_200908, mean)
WASATCH_P_200909_mean <- cellStats(WASATCH_P_200909, mean)
WASATCH_P_200910_mean <- cellStats(WASATCH_P_200910, mean)
WASATCH_P_200911_mean <- cellStats(WASATCH_P_200911, mean)
WASATCH_P_200912_mean <- cellStats(WASATCH_P_200912, mean)

#2010

WASATCH_P_201001_mean <- cellStats(WASATCH_P_201001, mean)
WASATCH_P_201002_mean <- cellStats(WASATCH_P_201002, mean)
WASATCH_P_201003_mean <- cellStats(WASATCH_P_201003, mean)
WASATCH_P_201004_mean <- cellStats(WASATCH_P_201004, mean)
WASATCH_P_201005_mean <- cellStats(WASATCH_P_201005, mean)
WASATCH_P_201006_mean <- cellStats(WASATCH_P_201006, mean)
WASATCH_P_201007_mean <- cellStats(WASATCH_P_201007, mean)
WASATCH_P_201008_mean <- cellStats(WASATCH_P_201008, mean)
WASATCH_P_201009_mean <- cellStats(WASATCH_P_201009, mean)
WASATCH_P_201010_mean <- cellStats(WASATCH_P_201010, mean)
WASATCH_P_201011_mean <- cellStats(WASATCH_P_201011, mean)
WASATCH_P_201012_mean <- cellStats(WASATCH_P_201012, mean)

#2011

WASATCH_P_201101_mean <- cellStats(WASATCH_P_201101, mean)
WASATCH_P_201102_mean <- cellStats(WASATCH_P_201102, mean)
WASATCH_P_201103_mean <- cellStats(WASATCH_P_201103, mean)
WASATCH_P_201104_mean <- cellStats(WASATCH_P_201104, mean)
WASATCH_P_201105_mean <- cellStats(WASATCH_P_201105, mean)
WASATCH_P_201106_mean <- cellStats(WASATCH_P_201106, mean)
WASATCH_P_201107_mean <- cellStats(WASATCH_P_201107, mean)
WASATCH_P_201108_mean <- cellStats(WASATCH_P_201108, mean)
WASATCH_P_201109_mean <- cellStats(WASATCH_P_201109, mean)
WASATCH_P_201110_mean <- cellStats(WASATCH_P_201110, mean)
WASATCH_P_201111_mean <- cellStats(WASATCH_P_201111, mean)
WASATCH_P_201112_mean <- cellStats(WASATCH_P_201112, mean)

#2012
WASATCH_P_201201_mean <- cellStats(WASATCH_P_201201, mean)
WASATCH_P_201202_mean <- cellStats(WASATCH_P_201202, mean)
WASATCH_P_201203_mean <- cellStats(WASATCH_P_201203, mean)
WASATCH_P_201204_mean <- cellStats(WASATCH_P_201204, mean)
WASATCH_P_201205_mean <- cellStats(WASATCH_P_201205, mean)
WASATCH_P_201206_mean <- cellStats(WASATCH_P_201206, mean)
WASATCH_P_201207_mean <- cellStats(WASATCH_P_201207, mean)
WASATCH_P_201208_mean <- cellStats(WASATCH_P_201208, mean)
WASATCH_P_201209_mean <- cellStats(WASATCH_P_201209, mean)
WASATCH_P_201210_mean <- cellStats(WASATCH_P_201210, mean)
WASATCH_P_201211_mean <- cellStats(WASATCH_P_201211, mean)
WASATCH_P_201212_mean <- cellStats(WASATCH_P_201212, mean)

#2013
WASATCH_P_201301_mean <- cellStats(WASATCH_P_201301, mean)
WASATCH_P_201302_mean <- cellStats(WASATCH_P_201302, mean)
WASATCH_P_201303_mean <- cellStats(WASATCH_P_201303, mean)
WASATCH_P_201304_mean <- cellStats(WASATCH_P_201304, mean)
WASATCH_P_201305_mean <- cellStats(WASATCH_P_201305, mean)
WASATCH_P_201306_mean <- cellStats(WASATCH_P_201306, mean)
WASATCH_P_201307_mean <- cellStats(WASATCH_P_201307, mean)
WASATCH_P_201308_mean <- cellStats(WASATCH_P_201308, mean)
WASATCH_P_201309_mean <- cellStats(WASATCH_P_201309, mean)
WASATCH_P_201310_mean <- cellStats(WASATCH_P_201310, mean)
WASATCH_P_201311_mean <- cellStats(WASATCH_P_201311, mean)
WASATCH_P_201312_mean <- cellStats(WASATCH_P_201312, mean)

#2014
WASATCH_P_201401_mean <- cellStats(WASATCH_P_201401, mean)
WASATCH_P_201402_mean <- cellStats(WASATCH_P_201402, mean)
WASATCH_P_201403_mean <- cellStats(WASATCH_P_201403, mean)
WASATCH_P_201404_mean <- cellStats(WASATCH_P_201404, mean)
WASATCH_P_201405_mean <- cellStats(WASATCH_P_201405, mean)
WASATCH_P_201406_mean <- cellStats(WASATCH_P_201406, mean)
WASATCH_P_201407_mean <- cellStats(WASATCH_P_201407, mean)
WASATCH_P_201408_mean <- cellStats(WASATCH_P_201408, mean)
WASATCH_P_201409_mean <- cellStats(WASATCH_P_201409, mean)
WASATCH_P_201410_mean <- cellStats(WASATCH_P_201410, mean)
WASATCH_P_201411_mean <- cellStats(WASATCH_P_201411, mean)
WASATCH_P_201412_mean <- cellStats(WASATCH_P_201412, mean)

#2015
WASATCH_P_201501_mean <- cellStats(WASATCH_P_201501, mean)
WASATCH_P_201502_mean <- cellStats(WASATCH_P_201502, mean)
WASATCH_P_201503_mean <- cellStats(WASATCH_P_201503, mean)
WASATCH_P_201504_mean <- cellStats(WASATCH_P_201504, mean)
WASATCH_P_201505_mean <- cellStats(WASATCH_P_201505, mean)
WASATCH_P_201506_mean <- cellStats(WASATCH_P_201506, mean)
WASATCH_P_201507_mean <- cellStats(WASATCH_P_201507, mean)
WASATCH_P_201508_mean <- cellStats(WASATCH_P_201508, mean)
WASATCH_P_201509_mean <- cellStats(WASATCH_P_201509, mean)
WASATCH_P_201510_mean <- cellStats(WASATCH_P_201510, mean)
WASATCH_P_201511_mean <- cellStats(WASATCH_P_201511, mean)
WASATCH_P_201512_mean <- cellStats(WASATCH_P_201512, mean)

#2016
WASATCH_P_201601_mean <- cellStats(WASATCH_P_201601, mean)
WASATCH_P_201602_mean <- cellStats(WASATCH_P_201602, mean)
WASATCH_P_201603_mean <- cellStats(WASATCH_P_201603, mean)
WASATCH_P_201604_mean <- cellStats(WASATCH_P_201604, mean)
WASATCH_P_201605_mean <- cellStats(WASATCH_P_201605, mean)
WASATCH_P_201606_mean <- cellStats(WASATCH_P_201606, mean)
WASATCH_P_201607_mean <- cellStats(WASATCH_P_201607, mean)
WASATCH_P_201608_mean <- cellStats(WASATCH_P_201608, mean)
WASATCH_P_201609_mean <- cellStats(WASATCH_P_201609, mean)
WASATCH_P_201610_mean <- cellStats(WASATCH_P_201610, mean)
WASATCH_P_201611_mean <- cellStats(WASATCH_P_201611, mean)
WASATCH_P_201612_mean <- cellStats(WASATCH_P_201612, mean)

#2017
WASATCH_P_201701_mean <- cellStats(WASATCH_P_201701, mean)
WASATCH_P_201702_mean <- cellStats(WASATCH_P_201702, mean)
WASATCH_P_201703_mean <- cellStats(WASATCH_P_201703, mean)
WASATCH_P_201704_mean <- cellStats(WASATCH_P_201704, mean)
WASATCH_P_201705_mean <- cellStats(WASATCH_P_201705, mean)
WASATCH_P_201706_mean <- cellStats(WASATCH_P_201706, mean)
WASATCH_P_201707_mean <- cellStats(WASATCH_P_201707, mean)
WASATCH_P_201708_mean <- cellStats(WASATCH_P_201708, mean)
WASATCH_P_201709_mean <- cellStats(WASATCH_P_201709, mean)
WASATCH_P_201710_mean <- cellStats(WASATCH_P_201710, mean)
WASATCH_P_201711_mean <- cellStats(WASATCH_P_201711, mean)
WASATCH_P_201712_mean <- cellStats(WASATCH_P_201712, mean)

#2018
WASATCH_P_201801_mean <- cellStats(WASATCH_P_201801, mean)
WASATCH_P_201802_mean <- cellStats(WASATCH_P_201802, mean)
WASATCH_P_201803_mean <- cellStats(WASATCH_P_201803, mean)
WASATCH_P_201804_mean <- cellStats(WASATCH_P_201804, mean)
WASATCH_P_201805_mean <- cellStats(WASATCH_P_201805, mean)
WASATCH_P_201806_mean <- cellStats(WASATCH_P_201806, mean)
WASATCH_P_201807_mean <- cellStats(WASATCH_P_201807, mean)
WASATCH_P_201808_mean <- cellStats(WASATCH_P_201808, mean)
WASATCH_P_201809_mean <- cellStats(WASATCH_P_201809, mean)
WASATCH_P_201810_mean <- cellStats(WASATCH_P_201810, mean)
WASATCH_P_201811_mean <- cellStats(WASATCH_P_201811, mean)
WASATCH_P_201812_mean <- cellStats(WASATCH_P_201812, mean)

# Washington


#2000
WASHINGTON_P_200001 <- crop(P_200001, WASHINGTON) 
WASHINGTON_P_200002 <- crop(P_200002, WASHINGTON)
WASHINGTON_P_200003 <- crop(P_200003, WASHINGTON)
WASHINGTON_P_200004 <- crop(P_200004, WASHINGTON)
WASHINGTON_P_200005 <- crop(P_200005, WASHINGTON)
WASHINGTON_P_200006 <- crop(P_200006, WASHINGTON)  
WASHINGTON_P_200007 <- crop(P_200007, WASHINGTON)  
WASHINGTON_P_200008 <- crop(P_200008, WASHINGTON)  
WASHINGTON_P_200009 <- crop(P_200009, WASHINGTON)  
WASHINGTON_P_200010 <- crop(P_200010, WASHINGTON)  
WASHINGTON_P_200011 <- crop(P_200011, WASHINGTON)  
WASHINGTON_P_200012 <- crop(P_200012, WASHINGTON)  
#2001
WASHINGTON_P_200101 <- crop(P_200101, WASHINGTON) 
WASHINGTON_P_200102 <- crop(P_200102, WASHINGTON)
WASHINGTON_P_200103 <- crop(P_200103, WASHINGTON)
WASHINGTON_P_200104 <- crop(P_200104, WASHINGTON)
WASHINGTON_P_200105 <- crop(P_200105, WASHINGTON)
WASHINGTON_P_200106 <- crop(P_200106, WASHINGTON)  
WASHINGTON_P_200107 <- crop(P_200107, WASHINGTON)  
WASHINGTON_P_200108 <- crop(P_200108, WASHINGTON)  
WASHINGTON_P_200109 <- crop(P_200109, WASHINGTON)  
WASHINGTON_P_200110 <- crop(P_200110, WASHINGTON)  
WASHINGTON_P_200111 <- crop(P_200111, WASHINGTON)  
WASHINGTON_P_200112 <- crop(P_200112, WASHINGTON)  

#2002
WASHINGTON_P_200201 <- crop(P_200201, WASHINGTON) 
WASHINGTON_P_200202 <- crop(P_200202, WASHINGTON)
WASHINGTON_P_200203 <- crop(P_200203, WASHINGTON)
WASHINGTON_P_200204 <- crop(P_200204, WASHINGTON)
WASHINGTON_P_200205 <- crop(P_200205, WASHINGTON)
WASHINGTON_P_200206 <- crop(P_200206, WASHINGTON)  
WASHINGTON_P_200207 <- crop(P_200207, WASHINGTON)  
WASHINGTON_P_200208 <- crop(P_200208, WASHINGTON)  
WASHINGTON_P_200209 <- crop(P_200209, WASHINGTON)  
WASHINGTON_P_200210 <- crop(P_200210, WASHINGTON)  
WASHINGTON_P_200211 <- crop(P_200211, WASHINGTON)  
WASHINGTON_P_200212 <- crop(P_200212, WASHINGTON)  
#2003
WASHINGTON_P_200301 <- crop(P_200301, WASHINGTON) 
WASHINGTON_P_200302 <- crop(P_200302, WASHINGTON)
WASHINGTON_P_200303 <- crop(P_200303, WASHINGTON)
WASHINGTON_P_200304 <- crop(P_200304, WASHINGTON)
WASHINGTON_P_200305 <- crop(P_200305, WASHINGTON)
WASHINGTON_P_200306 <- crop(P_200306, WASHINGTON)  
WASHINGTON_P_200307 <- crop(P_200307, WASHINGTON)  
WASHINGTON_P_200308 <- crop(P_200308, WASHINGTON)  
WASHINGTON_P_200309 <- crop(P_200309, WASHINGTON)  
WASHINGTON_P_200310 <- crop(P_200310, WASHINGTON)  
WASHINGTON_P_200311 <- crop(P_200311, WASHINGTON)  
WASHINGTON_P_200312 <- crop(P_200312, WASHINGTON)  
#2004
WASHINGTON_P_200401 <- crop(P_200401, WASHINGTON) 
WASHINGTON_P_200402 <- crop(P_200402, WASHINGTON)
WASHINGTON_P_200403 <- crop(P_200403, WASHINGTON)
WASHINGTON_P_200404 <- crop(P_200404, WASHINGTON)
WASHINGTON_P_200405 <- crop(P_200405, WASHINGTON)
WASHINGTON_P_200406 <- crop(P_200406, WASHINGTON)  
WASHINGTON_P_200407 <- crop(P_200407, WASHINGTON)  
WASHINGTON_P_200408 <- crop(P_200408, WASHINGTON)  
WASHINGTON_P_200409 <- crop(P_200409, WASHINGTON)  
WASHINGTON_P_200410 <- crop(P_200410, WASHINGTON)  
WASHINGTON_P_200411 <- crop(P_200411, WASHINGTON)  
WASHINGTON_P_200412 <- crop(P_200412, WASHINGTON)  
#2005
WASHINGTON_P_200501 <- crop(P_200501, WASHINGTON) 
WASHINGTON_P_200502 <- crop(P_200502, WASHINGTON)
WASHINGTON_P_200503 <- crop(P_200503, WASHINGTON)
WASHINGTON_P_200504 <- crop(P_200504, WASHINGTON)
WASHINGTON_P_200505 <- crop(P_200505, WASHINGTON)
WASHINGTON_P_200506 <- crop(P_200506, WASHINGTON)  
WASHINGTON_P_200507 <- crop(P_200507, WASHINGTON)  
WASHINGTON_P_200508 <- crop(P_200508, WASHINGTON)  
WASHINGTON_P_200509 <- crop(P_200509, WASHINGTON)  
WASHINGTON_P_200510 <- crop(P_200510, WASHINGTON)  
WASHINGTON_P_200511 <- crop(P_200511, WASHINGTON)  
WASHINGTON_P_200512 <- crop(P_200512, WASHINGTON)  
#2006
WASHINGTON_P_200601 <- crop(P_200601, WASHINGTON) 
WASHINGTON_P_200602 <- crop(P_200602, WASHINGTON)
WASHINGTON_P_200603 <- crop(P_200603, WASHINGTON)
WASHINGTON_P_200604 <- crop(P_200604, WASHINGTON)
WASHINGTON_P_200605 <- crop(P_200605, WASHINGTON)
WASHINGTON_P_200606 <- crop(P_200606, WASHINGTON)  
WASHINGTON_P_200607 <- crop(P_200607, WASHINGTON)  
WASHINGTON_P_200608 <- crop(P_200608, WASHINGTON)  
WASHINGTON_P_200609 <- crop(P_200609, WASHINGTON)  
WASHINGTON_P_200610 <- crop(P_200610, WASHINGTON)  
WASHINGTON_P_200611 <- crop(P_200611, WASHINGTON)  
WASHINGTON_P_200612 <- crop(P_200612, WASHINGTON)  
#2007
WASHINGTON_P_200701 <- crop(P_200701, WASHINGTON) 
WASHINGTON_P_200702 <- crop(P_200702, WASHINGTON)
WASHINGTON_P_200703 <- crop(P_200703, WASHINGTON)
WASHINGTON_P_200704 <- crop(P_200704, WASHINGTON)
WASHINGTON_P_200705 <- crop(P_200705, WASHINGTON)
WASHINGTON_P_200706 <- crop(P_200706, WASHINGTON)  
WASHINGTON_P_200707 <- crop(P_200707, WASHINGTON)  
WASHINGTON_P_200708 <- crop(P_200708, WASHINGTON)  
WASHINGTON_P_200709 <- crop(P_200709, WASHINGTON)  
WASHINGTON_P_200710 <- crop(P_200710, WASHINGTON)  
WASHINGTON_P_200711 <- crop(P_200711, WASHINGTON)  
WASHINGTON_P_200712 <- crop(P_200712, WASHINGTON)  
#2008
WASHINGTON_P_200801 <- crop(P_200801, WASHINGTON) 
WASHINGTON_P_200802 <- crop(P_200802, WASHINGTON)
WASHINGTON_P_200803 <- crop(P_200803, WASHINGTON)
WASHINGTON_P_200804 <- crop(P_200804, WASHINGTON)
WASHINGTON_P_200805 <- crop(P_200805, WASHINGTON)
WASHINGTON_P_200806 <- crop(P_200806, WASHINGTON)  
WASHINGTON_P_200807 <- crop(P_200807, WASHINGTON)  
WASHINGTON_P_200808 <- crop(P_200808, WASHINGTON)  
WASHINGTON_P_200809 <- crop(P_200809, WASHINGTON)  
WASHINGTON_P_200810 <- crop(P_200810, WASHINGTON)  
WASHINGTON_P_200811 <- crop(P_200811, WASHINGTON)  
WASHINGTON_P_200812 <- crop(P_200812, WASHINGTON)  
#2009
WASHINGTON_P_200901 <- crop(P_200901, WASHINGTON) 
WASHINGTON_P_200902 <- crop(P_200902, WASHINGTON)
WASHINGTON_P_200903 <- crop(P_200903, WASHINGTON)
WASHINGTON_P_200904 <- crop(P_200904, WASHINGTON)
WASHINGTON_P_200905 <- crop(P_200905, WASHINGTON)
WASHINGTON_P_200906 <- crop(P_200906, WASHINGTON)  
WASHINGTON_P_200907 <- crop(P_200907, WASHINGTON)  
WASHINGTON_P_200908 <- crop(P_200908, WASHINGTON)  
WASHINGTON_P_200909 <- crop(P_200909, WASHINGTON)  
WASHINGTON_P_200910 <- crop(P_200910, WASHINGTON)  
WASHINGTON_P_200911 <- crop(P_200911, WASHINGTON)  
WASHINGTON_P_200912 <- crop(P_200912, WASHINGTON)  
#2010
WASHINGTON_P_201001 <- crop(P_201001, WASHINGTON) 
WASHINGTON_P_201002 <- crop(P_201002, WASHINGTON)
WASHINGTON_P_201003 <- crop(P_201003, WASHINGTON)
WASHINGTON_P_201004 <- crop(P_201004, WASHINGTON)
WASHINGTON_P_201005 <- crop(P_201005, WASHINGTON)
WASHINGTON_P_201006 <- crop(P_201006, WASHINGTON)  
WASHINGTON_P_201007 <- crop(P_201007, WASHINGTON)  
WASHINGTON_P_201008 <- crop(P_201008, WASHINGTON)  
WASHINGTON_P_201009 <- crop(P_201009, WASHINGTON)  
WASHINGTON_P_201010 <- crop(P_201010, WASHINGTON)  
WASHINGTON_P_201011 <- crop(P_201011, WASHINGTON)  
WASHINGTON_P_201012 <- crop(P_201012, WASHINGTON)  
#2011
WASHINGTON_P_201101 <- crop(P_201101, WASHINGTON) 
WASHINGTON_P_201102 <- crop(P_201102, WASHINGTON)
WASHINGTON_P_201103 <- crop(P_201103, WASHINGTON)
WASHINGTON_P_201104 <- crop(P_201104, WASHINGTON)
WASHINGTON_P_201105 <- crop(P_201105, WASHINGTON)
WASHINGTON_P_201106 <- crop(P_201106, WASHINGTON)  
WASHINGTON_P_201107 <- crop(P_201107, WASHINGTON)  
WASHINGTON_P_201108 <- crop(P_201108, WASHINGTON)  
WASHINGTON_P_201109 <- crop(P_201109, WASHINGTON)  
WASHINGTON_P_201110 <- crop(P_201110, WASHINGTON)  
WASHINGTON_P_201111 <- crop(P_201111, WASHINGTON)  
WASHINGTON_P_201112 <- crop(P_201112, WASHINGTON)  
#2012
WASHINGTON_P_201201 <- crop(P_201201, WASHINGTON) 
WASHINGTON_P_201202 <- crop(P_201202, WASHINGTON)
WASHINGTON_P_201203 <- crop(P_201203, WASHINGTON)
WASHINGTON_P_201204 <- crop(P_201204, WASHINGTON)
WASHINGTON_P_201205 <- crop(P_201205, WASHINGTON)
WASHINGTON_P_201206 <- crop(P_201206, WASHINGTON)  
WASHINGTON_P_201207 <- crop(P_201207, WASHINGTON)  
WASHINGTON_P_201208 <- crop(P_201208, WASHINGTON)  
WASHINGTON_P_201209 <- crop(P_201209, WASHINGTON)  
WASHINGTON_P_201210 <- crop(P_201210, WASHINGTON)  
WASHINGTON_P_201211 <- crop(P_201211, WASHINGTON)  
WASHINGTON_P_201212 <- crop(P_201212, WASHINGTON)  
#2013
WASHINGTON_P_201301 <- crop(P_201301, WASHINGTON) 
WASHINGTON_P_201302 <- crop(P_201302, WASHINGTON)
WASHINGTON_P_201303 <- crop(P_201303, WASHINGTON)
WASHINGTON_P_201304 <- crop(P_201304, WASHINGTON)
WASHINGTON_P_201305 <- crop(P_201305, WASHINGTON)
WASHINGTON_P_201306 <- crop(P_201306, WASHINGTON)  
WASHINGTON_P_201307 <- crop(P_201307, WASHINGTON)  
WASHINGTON_P_201308 <- crop(P_201308, WASHINGTON)  
WASHINGTON_P_201309 <- crop(P_201309, WASHINGTON)  
WASHINGTON_P_201310 <- crop(P_201310, WASHINGTON)  
WASHINGTON_P_201311 <- crop(P_201311, WASHINGTON)  
WASHINGTON_P_201312 <- crop(P_201312, WASHINGTON)  
#2014
WASHINGTON_P_201401 <- crop(P_201401, WASHINGTON) 
WASHINGTON_P_201402 <- crop(P_201402, WASHINGTON)
WASHINGTON_P_201403 <- crop(P_201403, WASHINGTON)
WASHINGTON_P_201404 <- crop(P_201404, WASHINGTON)
WASHINGTON_P_201405 <- crop(P_201405, WASHINGTON)
WASHINGTON_P_201406 <- crop(P_201406, WASHINGTON)  
WASHINGTON_P_201407 <- crop(P_201407, WASHINGTON)  
WASHINGTON_P_201408 <- crop(P_201408, WASHINGTON)  
WASHINGTON_P_201409 <- crop(P_201409, WASHINGTON)  
WASHINGTON_P_201410 <- crop(P_201410, WASHINGTON)  
WASHINGTON_P_201411 <- crop(P_201411, WASHINGTON)  
WASHINGTON_P_201412 <- crop(P_201412, WASHINGTON)  
#2015
WASHINGTON_P_201501 <- crop(P_201501, WASHINGTON) 
WASHINGTON_P_201502 <- crop(P_201502, WASHINGTON)
WASHINGTON_P_201503 <- crop(P_201503, WASHINGTON)
WASHINGTON_P_201504 <- crop(P_201504, WASHINGTON)
WASHINGTON_P_201505 <- crop(P_201505, WASHINGTON)
WASHINGTON_P_201506 <- crop(P_201506, WASHINGTON)  
WASHINGTON_P_201507 <- crop(P_201507, WASHINGTON)  
WASHINGTON_P_201508 <- crop(P_201508, WASHINGTON)  
WASHINGTON_P_201509 <- crop(P_201509, WASHINGTON)  
WASHINGTON_P_201510 <- crop(P_201510, WASHINGTON)  
WASHINGTON_P_201511 <- crop(P_201511, WASHINGTON)  
WASHINGTON_P_201512 <- crop(P_201512, WASHINGTON)  
#2016
WASHINGTON_P_201601 <- crop(P_201601, WASHINGTON) 
WASHINGTON_P_201602 <- crop(P_201602, WASHINGTON)
WASHINGTON_P_201603 <- crop(P_201603, WASHINGTON)
WASHINGTON_P_201604 <- crop(P_201604, WASHINGTON)
WASHINGTON_P_201605 <- crop(P_201605, WASHINGTON)
WASHINGTON_P_201606 <- crop(P_201606, WASHINGTON)  
WASHINGTON_P_201607 <- crop(P_201607, WASHINGTON)  
WASHINGTON_P_201608 <- crop(P_201608, WASHINGTON)  
WASHINGTON_P_201609 <- crop(P_201609, WASHINGTON)  
WASHINGTON_P_201610 <- crop(P_201610, WASHINGTON)  
WASHINGTON_P_201611 <- crop(P_201611, WASHINGTON)  
WASHINGTON_P_201612 <- crop(P_201612, WASHINGTON)  
#2017
WASHINGTON_P_201701 <- crop(P_201701, WASHINGTON) 
WASHINGTON_P_201702 <- crop(P_201702, WASHINGTON)
WASHINGTON_P_201703 <- crop(P_201703, WASHINGTON)
WASHINGTON_P_201704 <- crop(P_201704, WASHINGTON)
WASHINGTON_P_201705 <- crop(P_201705, WASHINGTON)
WASHINGTON_P_201706 <- crop(P_201706, WASHINGTON)  
WASHINGTON_P_201707 <- crop(P_201707, WASHINGTON)  
WASHINGTON_P_201708 <- crop(P_201708, WASHINGTON)  
WASHINGTON_P_201709 <- crop(P_201709, WASHINGTON)  
WASHINGTON_P_201710 <- crop(P_201710, WASHINGTON)  
WASHINGTON_P_201711 <- crop(P_201711, WASHINGTON)  
WASHINGTON_P_201712 <- crop(P_201712, WASHINGTON)  

#2018

WASHINGTON_P_201801 <- crop(P_201801, WASHINGTON) 
WASHINGTON_P_201802 <- crop(P_201802, WASHINGTON)
WASHINGTON_P_201803 <- crop(P_201803, WASHINGTON)
WASHINGTON_P_201804 <- crop(P_201804, WASHINGTON)
WASHINGTON_P_201805 <- crop(P_201805, WASHINGTON)
WASHINGTON_P_201806 <- crop(P_201806, WASHINGTON)  
WASHINGTON_P_201807 <- crop(P_201807, WASHINGTON)  
WASHINGTON_P_201808 <- crop(P_201808, WASHINGTON)  
WASHINGTON_P_201809 <- crop(P_201809, WASHINGTON)  
WASHINGTON_P_201810 <- crop(P_201810, WASHINGTON)  
WASHINGTON_P_201811 <- crop(P_201811, WASHINGTON)  
WASHINGTON_P_201812 <- crop(P_201812, WASHINGTON)  


# Mean Monthly Precipitation
#2000
WASHINGTON_P_200001_mean <- cellStats(WASHINGTON_P_200001, mean)
WASHINGTON_P_200002_mean <- cellStats(WASHINGTON_P_200002, mean)
WASHINGTON_P_200003_mean <- cellStats(WASHINGTON_P_200003, mean)
WASHINGTON_P_200004_mean <- cellStats(WASHINGTON_P_200004, mean)
WASHINGTON_P_200005_mean <- cellStats(WASHINGTON_P_200005, mean)
WASHINGTON_P_200006_mean <- cellStats(WASHINGTON_P_200006, mean)
WASHINGTON_P_200007_mean <- cellStats(WASHINGTON_P_200007, mean)
WASHINGTON_P_200008_mean <- cellStats(WASHINGTON_P_200008, mean)
WASHINGTON_P_200009_mean <- cellStats(WASHINGTON_P_200009, mean)
WASHINGTON_P_200010_mean <- cellStats(WASHINGTON_P_200010, mean)
WASHINGTON_P_200011_mean <- cellStats(WASHINGTON_P_200011, mean)
WASHINGTON_P_200012_mean <- cellStats(WASHINGTON_P_200012, mean)
#2001
WASHINGTON_P_200101_mean <- cellStats(WASHINGTON_P_200101, mean)
WASHINGTON_P_200102_mean <- cellStats(WASHINGTON_P_200102, mean)
WASHINGTON_P_200103_mean <- cellStats(WASHINGTON_P_200103, mean)
WASHINGTON_P_200104_mean <- cellStats(WASHINGTON_P_200104, mean)
WASHINGTON_P_200105_mean <- cellStats(WASHINGTON_P_200105, mean)
WASHINGTON_P_200106_mean <- cellStats(WASHINGTON_P_200106, mean)
WASHINGTON_P_200107_mean <- cellStats(WASHINGTON_P_200107, mean)
WASHINGTON_P_200108_mean <- cellStats(WASHINGTON_P_200108, mean)
WASHINGTON_P_200109_mean <- cellStats(WASHINGTON_P_200109, mean)
WASHINGTON_P_200110_mean <- cellStats(WASHINGTON_P_200110, mean)
WASHINGTON_P_200111_mean <- cellStats(WASHINGTON_P_200111, mean)
WASHINGTON_P_200112_mean <- cellStats(WASHINGTON_P_200112, mean)

#2002
WASHINGTON_P_200201_mean <- cellStats(WASHINGTON_P_200201, mean)
WASHINGTON_P_200202_mean <- cellStats(WASHINGTON_P_200202, mean)
WASHINGTON_P_200203_mean <- cellStats(WASHINGTON_P_200203, mean)
WASHINGTON_P_200204_mean <- cellStats(WASHINGTON_P_200204, mean)
WASHINGTON_P_200205_mean <- cellStats(WASHINGTON_P_200205, mean)
WASHINGTON_P_200206_mean <- cellStats(WASHINGTON_P_200206, mean)
WASHINGTON_P_200207_mean <- cellStats(WASHINGTON_P_200207, mean)
WASHINGTON_P_200208_mean <- cellStats(WASHINGTON_P_200208, mean)
WASHINGTON_P_200209_mean <- cellStats(WASHINGTON_P_200209, mean)
WASHINGTON_P_200210_mean <- cellStats(WASHINGTON_P_200210, mean)
WASHINGTON_P_200211_mean <- cellStats(WASHINGTON_P_200211, mean)
WASHINGTON_P_200212_mean <- cellStats(WASHINGTON_P_200212, mean)

#2003
WASHINGTON_P_200301_mean <- cellStats(WASHINGTON_P_200301, mean)
WASHINGTON_P_200302_mean <- cellStats(WASHINGTON_P_200302, mean)
WASHINGTON_P_200303_mean <- cellStats(WASHINGTON_P_200303, mean)
WASHINGTON_P_200304_mean <- cellStats(WASHINGTON_P_200304, mean)
WASHINGTON_P_200305_mean <- cellStats(WASHINGTON_P_200305, mean)
WASHINGTON_P_200306_mean <- cellStats(WASHINGTON_P_200306, mean)
WASHINGTON_P_200307_mean <- cellStats(WASHINGTON_P_200307, mean)
WASHINGTON_P_200308_mean <- cellStats(WASHINGTON_P_200308, mean)
WASHINGTON_P_200309_mean <- cellStats(WASHINGTON_P_200309, mean)
WASHINGTON_P_200310_mean <- cellStats(WASHINGTON_P_200310, mean)
WASHINGTON_P_200311_mean <- cellStats(WASHINGTON_P_200311, mean)
WASHINGTON_P_200312_mean <- cellStats(WASHINGTON_P_200312, mean)

#2004

WASHINGTON_P_200401_mean <- cellStats(WASHINGTON_P_200401, mean)
WASHINGTON_P_200402_mean <- cellStats(WASHINGTON_P_200402, mean)
WASHINGTON_P_200403_mean <- cellStats(WASHINGTON_P_200403, mean)
WASHINGTON_P_200404_mean <- cellStats(WASHINGTON_P_200404, mean)
WASHINGTON_P_200405_mean <- cellStats(WASHINGTON_P_200405, mean)
WASHINGTON_P_200406_mean <- cellStats(WASHINGTON_P_200406, mean)
WASHINGTON_P_200407_mean <- cellStats(WASHINGTON_P_200407, mean)
WASHINGTON_P_200408_mean <- cellStats(WASHINGTON_P_200408, mean)
WASHINGTON_P_200409_mean <- cellStats(WASHINGTON_P_200409, mean)
WASHINGTON_P_200410_mean <- cellStats(WASHINGTON_P_200410, mean)
WASHINGTON_P_200411_mean <- cellStats(WASHINGTON_P_200411, mean)
WASHINGTON_P_200412_mean <- cellStats(WASHINGTON_P_200412, mean)

#2005

WASHINGTON_P_200501_mean <- cellStats(WASHINGTON_P_200501, mean)
WASHINGTON_P_200502_mean <- cellStats(WASHINGTON_P_200502, mean)
WASHINGTON_P_200503_mean <- cellStats(WASHINGTON_P_200503, mean)
WASHINGTON_P_200504_mean <- cellStats(WASHINGTON_P_200504, mean)
WASHINGTON_P_200505_mean <- cellStats(WASHINGTON_P_200505, mean)
WASHINGTON_P_200506_mean <- cellStats(WASHINGTON_P_200506, mean)
WASHINGTON_P_200507_mean <- cellStats(WASHINGTON_P_200507, mean)
WASHINGTON_P_200508_mean <- cellStats(WASHINGTON_P_200508, mean)
WASHINGTON_P_200509_mean <- cellStats(WASHINGTON_P_200509, mean)
WASHINGTON_P_200510_mean <- cellStats(WASHINGTON_P_200510, mean)
WASHINGTON_P_200511_mean <- cellStats(WASHINGTON_P_200511, mean)
WASHINGTON_P_200512_mean <- cellStats(WASHINGTON_P_200512, mean)

#2006

WASHINGTON_P_200601_mean <- cellStats(WASHINGTON_P_200601, mean)
WASHINGTON_P_200602_mean <- cellStats(WASHINGTON_P_200602, mean)
WASHINGTON_P_200603_mean <- cellStats(WASHINGTON_P_200603, mean)
WASHINGTON_P_200604_mean <- cellStats(WASHINGTON_P_200604, mean)
WASHINGTON_P_200605_mean <- cellStats(WASHINGTON_P_200605, mean)
WASHINGTON_P_200606_mean <- cellStats(WASHINGTON_P_200606, mean)
WASHINGTON_P_200607_mean <- cellStats(WASHINGTON_P_200607, mean)
WASHINGTON_P_200608_mean <- cellStats(WASHINGTON_P_200608, mean)
WASHINGTON_P_200609_mean <- cellStats(WASHINGTON_P_200609, mean)
WASHINGTON_P_200610_mean <- cellStats(WASHINGTON_P_200610, mean)
WASHINGTON_P_200611_mean <- cellStats(WASHINGTON_P_200611, mean)
WASHINGTON_P_200612_mean <- cellStats(WASHINGTON_P_200612, mean)

#2007

WASHINGTON_P_200701_mean <- cellStats(WASHINGTON_P_200701, mean)
WASHINGTON_P_200702_mean <- cellStats(WASHINGTON_P_200702, mean)
WASHINGTON_P_200703_mean <- cellStats(WASHINGTON_P_200703, mean)
WASHINGTON_P_200704_mean <- cellStats(WASHINGTON_P_200704, mean)
WASHINGTON_P_200705_mean <- cellStats(WASHINGTON_P_200705, mean)
WASHINGTON_P_200706_mean <- cellStats(WASHINGTON_P_200706, mean)
WASHINGTON_P_200707_mean <- cellStats(WASHINGTON_P_200707, mean)
WASHINGTON_P_200708_mean <- cellStats(WASHINGTON_P_200708, mean)
WASHINGTON_P_200709_mean <- cellStats(WASHINGTON_P_200709, mean)
WASHINGTON_P_200710_mean <- cellStats(WASHINGTON_P_200710, mean)
WASHINGTON_P_200711_mean <- cellStats(WASHINGTON_P_200711, mean)
WASHINGTON_P_200712_mean <- cellStats(WASHINGTON_P_200712, mean)

#2008

WASHINGTON_P_200801_mean <- cellStats(WASHINGTON_P_200801, mean)
WASHINGTON_P_200802_mean <- cellStats(WASHINGTON_P_200802, mean)
WASHINGTON_P_200803_mean <- cellStats(WASHINGTON_P_200803, mean)
WASHINGTON_P_200804_mean <- cellStats(WASHINGTON_P_200804, mean)
WASHINGTON_P_200805_mean <- cellStats(WASHINGTON_P_200805, mean)
WASHINGTON_P_200806_mean <- cellStats(WASHINGTON_P_200806, mean)
WASHINGTON_P_200807_mean <- cellStats(WASHINGTON_P_200807, mean)
WASHINGTON_P_200808_mean <- cellStats(WASHINGTON_P_200808, mean)
WASHINGTON_P_200809_mean <- cellStats(WASHINGTON_P_200809, mean)
WASHINGTON_P_200810_mean <- cellStats(WASHINGTON_P_200810, mean)
WASHINGTON_P_200811_mean <- cellStats(WASHINGTON_P_200811, mean)
WASHINGTON_P_200812_mean <- cellStats(WASHINGTON_P_200812, mean)

#2009

WASHINGTON_P_200901_mean <- cellStats(WASHINGTON_P_200901, mean)
WASHINGTON_P_200902_mean <- cellStats(WASHINGTON_P_200902, mean)
WASHINGTON_P_200903_mean <- cellStats(WASHINGTON_P_200903, mean)
WASHINGTON_P_200904_mean <- cellStats(WASHINGTON_P_200904, mean)
WASHINGTON_P_200905_mean <- cellStats(WASHINGTON_P_200905, mean)
WASHINGTON_P_200906_mean <- cellStats(WASHINGTON_P_200906, mean)
WASHINGTON_P_200907_mean <- cellStats(WASHINGTON_P_200907, mean)
WASHINGTON_P_200908_mean <- cellStats(WASHINGTON_P_200908, mean)
WASHINGTON_P_200909_mean <- cellStats(WASHINGTON_P_200909, mean)
WASHINGTON_P_200910_mean <- cellStats(WASHINGTON_P_200910, mean)
WASHINGTON_P_200911_mean <- cellStats(WASHINGTON_P_200911, mean)
WASHINGTON_P_200912_mean <- cellStats(WASHINGTON_P_200912, mean)

#2010

WASHINGTON_P_201001_mean <- cellStats(WASHINGTON_P_201001, mean)
WASHINGTON_P_201002_mean <- cellStats(WASHINGTON_P_201002, mean)
WASHINGTON_P_201003_mean <- cellStats(WASHINGTON_P_201003, mean)
WASHINGTON_P_201004_mean <- cellStats(WASHINGTON_P_201004, mean)
WASHINGTON_P_201005_mean <- cellStats(WASHINGTON_P_201005, mean)
WASHINGTON_P_201006_mean <- cellStats(WASHINGTON_P_201006, mean)
WASHINGTON_P_201007_mean <- cellStats(WASHINGTON_P_201007, mean)
WASHINGTON_P_201008_mean <- cellStats(WASHINGTON_P_201008, mean)
WASHINGTON_P_201009_mean <- cellStats(WASHINGTON_P_201009, mean)
WASHINGTON_P_201010_mean <- cellStats(WASHINGTON_P_201010, mean)
WASHINGTON_P_201011_mean <- cellStats(WASHINGTON_P_201011, mean)
WASHINGTON_P_201012_mean <- cellStats(WASHINGTON_P_201012, mean)

#2011

WASHINGTON_P_201101_mean <- cellStats(WASHINGTON_P_201101, mean)
WASHINGTON_P_201102_mean <- cellStats(WASHINGTON_P_201102, mean)
WASHINGTON_P_201103_mean <- cellStats(WASHINGTON_P_201103, mean)
WASHINGTON_P_201104_mean <- cellStats(WASHINGTON_P_201104, mean)
WASHINGTON_P_201105_mean <- cellStats(WASHINGTON_P_201105, mean)
WASHINGTON_P_201106_mean <- cellStats(WASHINGTON_P_201106, mean)
WASHINGTON_P_201107_mean <- cellStats(WASHINGTON_P_201107, mean)
WASHINGTON_P_201108_mean <- cellStats(WASHINGTON_P_201108, mean)
WASHINGTON_P_201109_mean <- cellStats(WASHINGTON_P_201109, mean)
WASHINGTON_P_201110_mean <- cellStats(WASHINGTON_P_201110, mean)
WASHINGTON_P_201111_mean <- cellStats(WASHINGTON_P_201111, mean)
WASHINGTON_P_201112_mean <- cellStats(WASHINGTON_P_201112, mean)

#2012
WASHINGTON_P_201201_mean <- cellStats(WASHINGTON_P_201201, mean)
WASHINGTON_P_201202_mean <- cellStats(WASHINGTON_P_201202, mean)
WASHINGTON_P_201203_mean <- cellStats(WASHINGTON_P_201203, mean)
WASHINGTON_P_201204_mean <- cellStats(WASHINGTON_P_201204, mean)
WASHINGTON_P_201205_mean <- cellStats(WASHINGTON_P_201205, mean)
WASHINGTON_P_201206_mean <- cellStats(WASHINGTON_P_201206, mean)
WASHINGTON_P_201207_mean <- cellStats(WASHINGTON_P_201207, mean)
WASHINGTON_P_201208_mean <- cellStats(WASHINGTON_P_201208, mean)
WASHINGTON_P_201209_mean <- cellStats(WASHINGTON_P_201209, mean)
WASHINGTON_P_201210_mean <- cellStats(WASHINGTON_P_201210, mean)
WASHINGTON_P_201211_mean <- cellStats(WASHINGTON_P_201211, mean)
WASHINGTON_P_201212_mean <- cellStats(WASHINGTON_P_201212, mean)

#2013
WASHINGTON_P_201301_mean <- cellStats(WASHINGTON_P_201301, mean)
WASHINGTON_P_201302_mean <- cellStats(WASHINGTON_P_201302, mean)
WASHINGTON_P_201303_mean <- cellStats(WASHINGTON_P_201303, mean)
WASHINGTON_P_201304_mean <- cellStats(WASHINGTON_P_201304, mean)
WASHINGTON_P_201305_mean <- cellStats(WASHINGTON_P_201305, mean)
WASHINGTON_P_201306_mean <- cellStats(WASHINGTON_P_201306, mean)
WASHINGTON_P_201307_mean <- cellStats(WASHINGTON_P_201307, mean)
WASHINGTON_P_201308_mean <- cellStats(WASHINGTON_P_201308, mean)
WASHINGTON_P_201309_mean <- cellStats(WASHINGTON_P_201309, mean)
WASHINGTON_P_201310_mean <- cellStats(WASHINGTON_P_201310, mean)
WASHINGTON_P_201311_mean <- cellStats(WASHINGTON_P_201311, mean)
WASHINGTON_P_201312_mean <- cellStats(WASHINGTON_P_201312, mean)

#2014
WASHINGTON_P_201401_mean <- cellStats(WASHINGTON_P_201401, mean)
WASHINGTON_P_201402_mean <- cellStats(WASHINGTON_P_201402, mean)
WASHINGTON_P_201403_mean <- cellStats(WASHINGTON_P_201403, mean)
WASHINGTON_P_201404_mean <- cellStats(WASHINGTON_P_201404, mean)
WASHINGTON_P_201405_mean <- cellStats(WASHINGTON_P_201405, mean)
WASHINGTON_P_201406_mean <- cellStats(WASHINGTON_P_201406, mean)
WASHINGTON_P_201407_mean <- cellStats(WASHINGTON_P_201407, mean)
WASHINGTON_P_201408_mean <- cellStats(WASHINGTON_P_201408, mean)
WASHINGTON_P_201409_mean <- cellStats(WASHINGTON_P_201409, mean)
WASHINGTON_P_201410_mean <- cellStats(WASHINGTON_P_201410, mean)
WASHINGTON_P_201411_mean <- cellStats(WASHINGTON_P_201411, mean)
WASHINGTON_P_201412_mean <- cellStats(WASHINGTON_P_201412, mean)

#2015
WASHINGTON_P_201501_mean <- cellStats(WASHINGTON_P_201501, mean)
WASHINGTON_P_201502_mean <- cellStats(WASHINGTON_P_201502, mean)
WASHINGTON_P_201503_mean <- cellStats(WASHINGTON_P_201503, mean)
WASHINGTON_P_201504_mean <- cellStats(WASHINGTON_P_201504, mean)
WASHINGTON_P_201505_mean <- cellStats(WASHINGTON_P_201505, mean)
WASHINGTON_P_201506_mean <- cellStats(WASHINGTON_P_201506, mean)
WASHINGTON_P_201507_mean <- cellStats(WASHINGTON_P_201507, mean)
WASHINGTON_P_201508_mean <- cellStats(WASHINGTON_P_201508, mean)
WASHINGTON_P_201509_mean <- cellStats(WASHINGTON_P_201509, mean)
WASHINGTON_P_201510_mean <- cellStats(WASHINGTON_P_201510, mean)
WASHINGTON_P_201511_mean <- cellStats(WASHINGTON_P_201511, mean)
WASHINGTON_P_201512_mean <- cellStats(WASHINGTON_P_201512, mean)

#2016
WASHINGTON_P_201601_mean <- cellStats(WASHINGTON_P_201601, mean)
WASHINGTON_P_201602_mean <- cellStats(WASHINGTON_P_201602, mean)
WASHINGTON_P_201603_mean <- cellStats(WASHINGTON_P_201603, mean)
WASHINGTON_P_201604_mean <- cellStats(WASHINGTON_P_201604, mean)
WASHINGTON_P_201605_mean <- cellStats(WASHINGTON_P_201605, mean)
WASHINGTON_P_201606_mean <- cellStats(WASHINGTON_P_201606, mean)
WASHINGTON_P_201607_mean <- cellStats(WASHINGTON_P_201607, mean)
WASHINGTON_P_201608_mean <- cellStats(WASHINGTON_P_201608, mean)
WASHINGTON_P_201609_mean <- cellStats(WASHINGTON_P_201609, mean)
WASHINGTON_P_201610_mean <- cellStats(WASHINGTON_P_201610, mean)
WASHINGTON_P_201611_mean <- cellStats(WASHINGTON_P_201611, mean)
WASHINGTON_P_201612_mean <- cellStats(WASHINGTON_P_201612, mean)

#2017
WASHINGTON_P_201701_mean <- cellStats(WASHINGTON_P_201701, mean)
WASHINGTON_P_201702_mean <- cellStats(WASHINGTON_P_201702, mean)
WASHINGTON_P_201703_mean <- cellStats(WASHINGTON_P_201703, mean)
WASHINGTON_P_201704_mean <- cellStats(WASHINGTON_P_201704, mean)
WASHINGTON_P_201705_mean <- cellStats(WASHINGTON_P_201705, mean)
WASHINGTON_P_201706_mean <- cellStats(WASHINGTON_P_201706, mean)
WASHINGTON_P_201707_mean <- cellStats(WASHINGTON_P_201707, mean)
WASHINGTON_P_201708_mean <- cellStats(WASHINGTON_P_201708, mean)
WASHINGTON_P_201709_mean <- cellStats(WASHINGTON_P_201709, mean)
WASHINGTON_P_201710_mean <- cellStats(WASHINGTON_P_201710, mean)
WASHINGTON_P_201711_mean <- cellStats(WASHINGTON_P_201711, mean)
WASHINGTON_P_201712_mean <- cellStats(WASHINGTON_P_201712, mean)

#2018
WASHINGTON_P_201801_mean <- cellStats(WASHINGTON_P_201801, mean)
WASHINGTON_P_201802_mean <- cellStats(WASHINGTON_P_201802, mean)
WASHINGTON_P_201803_mean <- cellStats(WASHINGTON_P_201803, mean)
WASHINGTON_P_201804_mean <- cellStats(WASHINGTON_P_201804, mean)
WASHINGTON_P_201805_mean <- cellStats(WASHINGTON_P_201805, mean)
WASHINGTON_P_201806_mean <- cellStats(WASHINGTON_P_201806, mean)
WASHINGTON_P_201807_mean <- cellStats(WASHINGTON_P_201807, mean)
WASHINGTON_P_201808_mean <- cellStats(WASHINGTON_P_201808, mean)
WASHINGTON_P_201809_mean <- cellStats(WASHINGTON_P_201809, mean)
WASHINGTON_P_201810_mean <- cellStats(WASHINGTON_P_201810, mean)
WASHINGTON_P_201811_mean <- cellStats(WASHINGTON_P_201811, mean)
WASHINGTON_P_201812_mean <- cellStats(WASHINGTON_P_201812, mean)

# WEBER

#2000
WEBER_P_200001 <- crop(P_200001, WEBER) 
WEBER_P_200002 <- crop(P_200002, WEBER)
WEBER_P_200003 <- crop(P_200003, WEBER)
WEBER_P_200004 <- crop(P_200004, WEBER)
WEBER_P_200005 <- crop(P_200005, WEBER)
WEBER_P_200006 <- crop(P_200006, WEBER)  
WEBER_P_200007 <- crop(P_200007, WEBER)  
WEBER_P_200008 <- crop(P_200008, WEBER)  
WEBER_P_200009 <- crop(P_200009, WEBER)  
WEBER_P_200010 <- crop(P_200010, WEBER)  
WEBER_P_200011 <- crop(P_200011, WEBER)  
WEBER_P_200012 <- crop(P_200012, WEBER)  
#2001
WEBER_P_200101 <- crop(P_200101, WEBER) 
WEBER_P_200102 <- crop(P_200102, WEBER)
WEBER_P_200103 <- crop(P_200103, WEBER)
WEBER_P_200104 <- crop(P_200104, WEBER)
WEBER_P_200105 <- crop(P_200105, WEBER)
WEBER_P_200106 <- crop(P_200106, WEBER)  
WEBER_P_200107 <- crop(P_200107, WEBER)  
WEBER_P_200108 <- crop(P_200108, WEBER)  
WEBER_P_200109 <- crop(P_200109, WEBER)  
WEBER_P_200110 <- crop(P_200110, WEBER)  
WEBER_P_200111 <- crop(P_200111, WEBER)  
WEBER_P_200112 <- crop(P_200112, WEBER)  

#2002
WEBER_P_200201 <- crop(P_200201, WEBER) 
WEBER_P_200202 <- crop(P_200202, WEBER)
WEBER_P_200203 <- crop(P_200203, WEBER)
WEBER_P_200204 <- crop(P_200204, WEBER)
WEBER_P_200205 <- crop(P_200205, WEBER)
WEBER_P_200206 <- crop(P_200206, WEBER)  
WEBER_P_200207 <- crop(P_200207, WEBER)  
WEBER_P_200208 <- crop(P_200208, WEBER)  
WEBER_P_200209 <- crop(P_200209, WEBER)  
WEBER_P_200210 <- crop(P_200210, WEBER)  
WEBER_P_200211 <- crop(P_200211, WEBER)  
WEBER_P_200212 <- crop(P_200212, WEBER)  
#2003
WEBER_P_200301 <- crop(P_200301, WEBER) 
WEBER_P_200302 <- crop(P_200302, WEBER)
WEBER_P_200303 <- crop(P_200303, WEBER)
WEBER_P_200304 <- crop(P_200304, WEBER)
WEBER_P_200305 <- crop(P_200305, WEBER)
WEBER_P_200306 <- crop(P_200306, WEBER)  
WEBER_P_200307 <- crop(P_200307, WEBER)  
WEBER_P_200308 <- crop(P_200308, WEBER)  
WEBER_P_200309 <- crop(P_200309, WEBER)  
WEBER_P_200310 <- crop(P_200310, WEBER)  
WEBER_P_200311 <- crop(P_200311, WEBER)  
WEBER_P_200312 <- crop(P_200312, WEBER)  
#2004
WEBER_P_200401 <- crop(P_200401, WEBER) 
WEBER_P_200402 <- crop(P_200402, WEBER)
WEBER_P_200403 <- crop(P_200403, WEBER)
WEBER_P_200404 <- crop(P_200404, WEBER)
WEBER_P_200405 <- crop(P_200405, WEBER)
WEBER_P_200406 <- crop(P_200406, WEBER)  
WEBER_P_200407 <- crop(P_200407, WEBER)  
WEBER_P_200408 <- crop(P_200408, WEBER)  
WEBER_P_200409 <- crop(P_200409, WEBER)  
WEBER_P_200410 <- crop(P_200410, WEBER)  
WEBER_P_200411 <- crop(P_200411, WEBER)  
WEBER_P_200412 <- crop(P_200412, WEBER)  
#2005
WEBER_P_200501 <- crop(P_200501, WEBER) 
WEBER_P_200502 <- crop(P_200502, WEBER)
WEBER_P_200503 <- crop(P_200503, WEBER)
WEBER_P_200504 <- crop(P_200504, WEBER)
WEBER_P_200505 <- crop(P_200505, WEBER)
WEBER_P_200506 <- crop(P_200506, WEBER)  
WEBER_P_200507 <- crop(P_200507, WEBER)  
WEBER_P_200508 <- crop(P_200508, WEBER)  
WEBER_P_200509 <- crop(P_200509, WEBER)  
WEBER_P_200510 <- crop(P_200510, WEBER)  
WEBER_P_200511 <- crop(P_200511, WEBER)  
WEBER_P_200512 <- crop(P_200512, WEBER)  
#2006
WEBER_P_200601 <- crop(P_200601, WEBER) 
WEBER_P_200602 <- crop(P_200602, WEBER)
WEBER_P_200603 <- crop(P_200603, WEBER)
WEBER_P_200604 <- crop(P_200604, WEBER)
WEBER_P_200605 <- crop(P_200605, WEBER)
WEBER_P_200606 <- crop(P_200606, WEBER)  
WEBER_P_200607 <- crop(P_200607, WEBER)  
WEBER_P_200608 <- crop(P_200608, WEBER)  
WEBER_P_200609 <- crop(P_200609, WEBER)  
WEBER_P_200610 <- crop(P_200610, WEBER)  
WEBER_P_200611 <- crop(P_200611, WEBER)  
WEBER_P_200612 <- crop(P_200612, WEBER)  
#2007
WEBER_P_200701 <- crop(P_200701, WEBER) 
WEBER_P_200702 <- crop(P_200702, WEBER)
WEBER_P_200703 <- crop(P_200703, WEBER)
WEBER_P_200704 <- crop(P_200704, WEBER)
WEBER_P_200705 <- crop(P_200705, WEBER)
WEBER_P_200706 <- crop(P_200706, WEBER)  
WEBER_P_200707 <- crop(P_200707, WEBER)  
WEBER_P_200708 <- crop(P_200708, WEBER)  
WEBER_P_200709 <- crop(P_200709, WEBER)  
WEBER_P_200710 <- crop(P_200710, WEBER)  
WEBER_P_200711 <- crop(P_200711, WEBER)  
WEBER_P_200712 <- crop(P_200712, WEBER)  
#2008
WEBER_P_200801 <- crop(P_200801, WEBER) 
WEBER_P_200802 <- crop(P_200802, WEBER)
WEBER_P_200803 <- crop(P_200803, WEBER)
WEBER_P_200804 <- crop(P_200804, WEBER)
WEBER_P_200805 <- crop(P_200805, WEBER)
WEBER_P_200806 <- crop(P_200806, WEBER)  
WEBER_P_200807 <- crop(P_200807, WEBER)  
WEBER_P_200808 <- crop(P_200808, WEBER)  
WEBER_P_200809 <- crop(P_200809, WEBER)  
WEBER_P_200810 <- crop(P_200810, WEBER)  
WEBER_P_200811 <- crop(P_200811, WEBER)  
WEBER_P_200812 <- crop(P_200812, WEBER)  
#2009
WEBER_P_200901 <- crop(P_200901, WEBER) 
WEBER_P_200902 <- crop(P_200902, WEBER)
WEBER_P_200903 <- crop(P_200903, WEBER)
WEBER_P_200904 <- crop(P_200904, WEBER)
WEBER_P_200905 <- crop(P_200905, WEBER)
WEBER_P_200906 <- crop(P_200906, WEBER)  
WEBER_P_200907 <- crop(P_200907, WEBER)  
WEBER_P_200908 <- crop(P_200908, WEBER)  
WEBER_P_200909 <- crop(P_200909, WEBER)  
WEBER_P_200910 <- crop(P_200910, WEBER)  
WEBER_P_200911 <- crop(P_200911, WEBER)  
WEBER_P_200912 <- crop(P_200912, WEBER)  
#2010
WEBER_P_201001 <- crop(P_201001, WEBER) 
WEBER_P_201002 <- crop(P_201002, WEBER)
WEBER_P_201003 <- crop(P_201003, WEBER)
WEBER_P_201004 <- crop(P_201004, WEBER)
WEBER_P_201005 <- crop(P_201005, WEBER)
WEBER_P_201006 <- crop(P_201006, WEBER)  
WEBER_P_201007 <- crop(P_201007, WEBER)  
WEBER_P_201008 <- crop(P_201008, WEBER)  
WEBER_P_201009 <- crop(P_201009, WEBER)  
WEBER_P_201010 <- crop(P_201010, WEBER)  
WEBER_P_201011 <- crop(P_201011, WEBER)  
WEBER_P_201012 <- crop(P_201012, WEBER)  
#2011
WEBER_P_201101 <- crop(P_201101, WEBER) 
WEBER_P_201102 <- crop(P_201102, WEBER)
WEBER_P_201103 <- crop(P_201103, WEBER)
WEBER_P_201104 <- crop(P_201104, WEBER)
WEBER_P_201105 <- crop(P_201105, WEBER)
WEBER_P_201106 <- crop(P_201106, WEBER)  
WEBER_P_201107 <- crop(P_201107, WEBER)  
WEBER_P_201108 <- crop(P_201108, WEBER)  
WEBER_P_201109 <- crop(P_201109, WEBER)  
WEBER_P_201110 <- crop(P_201110, WEBER)  
WEBER_P_201111 <- crop(P_201111, WEBER)  
WEBER_P_201112 <- crop(P_201112, WEBER)  
#2012
WEBER_P_201201 <- crop(P_201201, WEBER) 
WEBER_P_201202 <- crop(P_201202, WEBER)
WEBER_P_201203 <- crop(P_201203, WEBER)
WEBER_P_201204 <- crop(P_201204, WEBER)
WEBER_P_201205 <- crop(P_201205, WEBER)
WEBER_P_201206 <- crop(P_201206, WEBER)  
WEBER_P_201207 <- crop(P_201207, WEBER)  
WEBER_P_201208 <- crop(P_201208, WEBER)  
WEBER_P_201209 <- crop(P_201209, WEBER)  
WEBER_P_201210 <- crop(P_201210, WEBER)  
WEBER_P_201211 <- crop(P_201211, WEBER)  
WEBER_P_201212 <- crop(P_201212, WEBER)  
#2013
WEBER_P_201301 <- crop(P_201301, WEBER) 
WEBER_P_201302 <- crop(P_201302, WEBER)
WEBER_P_201303 <- crop(P_201303, WEBER)
WEBER_P_201304 <- crop(P_201304, WEBER)
WEBER_P_201305 <- crop(P_201305, WEBER)
WEBER_P_201306 <- crop(P_201306, WEBER)  
WEBER_P_201307 <- crop(P_201307, WEBER)  
WEBER_P_201308 <- crop(P_201308, WEBER)  
WEBER_P_201309 <- crop(P_201309, WEBER)  
WEBER_P_201310 <- crop(P_201310, WEBER)  
WEBER_P_201311 <- crop(P_201311, WEBER)  
WEBER_P_201312 <- crop(P_201312, WEBER)  
#2014
WEBER_P_201401 <- crop(P_201401, WEBER) 
WEBER_P_201402 <- crop(P_201402, WEBER)
WEBER_P_201403 <- crop(P_201403, WEBER)
WEBER_P_201404 <- crop(P_201404, WEBER)
WEBER_P_201405 <- crop(P_201405, WEBER)
WEBER_P_201406 <- crop(P_201406, WEBER)  
WEBER_P_201407 <- crop(P_201407, WEBER)  
WEBER_P_201408 <- crop(P_201408, WEBER)  
WEBER_P_201409 <- crop(P_201409, WEBER)  
WEBER_P_201410 <- crop(P_201410, WEBER)  
WEBER_P_201411 <- crop(P_201411, WEBER)  
WEBER_P_201412 <- crop(P_201412, WEBER)  
#2015
WEBER_P_201501 <- crop(P_201501, WEBER) 
WEBER_P_201502 <- crop(P_201502, WEBER)
WEBER_P_201503 <- crop(P_201503, WEBER)
WEBER_P_201504 <- crop(P_201504, WEBER)
WEBER_P_201505 <- crop(P_201505, WEBER)
WEBER_P_201506 <- crop(P_201506, WEBER)  
WEBER_P_201507 <- crop(P_201507, WEBER)  
WEBER_P_201508 <- crop(P_201508, WEBER)  
WEBER_P_201509 <- crop(P_201509, WEBER)  
WEBER_P_201510 <- crop(P_201510, WEBER)  
WEBER_P_201511 <- crop(P_201511, WEBER)  
WEBER_P_201512 <- crop(P_201512, WEBER)  
#2016
WEBER_P_201601 <- crop(P_201601, WEBER) 
WEBER_P_201602 <- crop(P_201602, WEBER)
WEBER_P_201603 <- crop(P_201603, WEBER)
WEBER_P_201604 <- crop(P_201604, WEBER)
WEBER_P_201605 <- crop(P_201605, WEBER)
WEBER_P_201606 <- crop(P_201606, WEBER)  
WEBER_P_201607 <- crop(P_201607, WEBER)  
WEBER_P_201608 <- crop(P_201608, WEBER)  
WEBER_P_201609 <- crop(P_201609, WEBER)  
WEBER_P_201610 <- crop(P_201610, WEBER)  
WEBER_P_201611 <- crop(P_201611, WEBER)  
WEBER_P_201612 <- crop(P_201612, WEBER)  
#2017
WEBER_P_201701 <- crop(P_201701, WEBER) 
WEBER_P_201702 <- crop(P_201702, WEBER)
WEBER_P_201703 <- crop(P_201703, WEBER)
WEBER_P_201704 <- crop(P_201704, WEBER)
WEBER_P_201705 <- crop(P_201705, WEBER)
WEBER_P_201706 <- crop(P_201706, WEBER)  
WEBER_P_201707 <- crop(P_201707, WEBER)  
WEBER_P_201708 <- crop(P_201708, WEBER)  
WEBER_P_201709 <- crop(P_201709, WEBER)  
WEBER_P_201710 <- crop(P_201710, WEBER)  
WEBER_P_201711 <- crop(P_201711, WEBER)  
WEBER_P_201712 <- crop(P_201712, WEBER)  

#2018

WEBER_P_201801 <- crop(P_201801, WEBER) 
WEBER_P_201802 <- crop(P_201802, WEBER)
WEBER_P_201803 <- crop(P_201803, WEBER)
WEBER_P_201804 <- crop(P_201804, WEBER)
WEBER_P_201805 <- crop(P_201805, WEBER)
WEBER_P_201806 <- crop(P_201806, WEBER)  
WEBER_P_201807 <- crop(P_201807, WEBER)  
WEBER_P_201808 <- crop(P_201808, WEBER)  
WEBER_P_201809 <- crop(P_201809, WEBER)  
WEBER_P_201810 <- crop(P_201810, WEBER)  
WEBER_P_201811 <- crop(P_201811, WEBER)  
WEBER_P_201812 <- crop(P_201812, WEBER)  


# Mean Monthly Precipitation
#2000
WEBER_P_200001_mean <- cellStats(WEBER_P_200001, mean)
WEBER_P_200002_mean <- cellStats(WEBER_P_200002, mean)
WEBER_P_200003_mean <- cellStats(WEBER_P_200003, mean)
WEBER_P_200004_mean <- cellStats(WEBER_P_200004, mean)
WEBER_P_200005_mean <- cellStats(WEBER_P_200005, mean)
WEBER_P_200006_mean <- cellStats(WEBER_P_200006, mean)
WEBER_P_200007_mean <- cellStats(WEBER_P_200007, mean)
WEBER_P_200008_mean <- cellStats(WEBER_P_200008, mean)
WEBER_P_200009_mean <- cellStats(WEBER_P_200009, mean)
WEBER_P_200010_mean <- cellStats(WEBER_P_200010, mean)
WEBER_P_200011_mean <- cellStats(WEBER_P_200011, mean)
WEBER_P_200012_mean <- cellStats(WEBER_P_200012, mean)
#2001
WEBER_P_200101_mean <- cellStats(WEBER_P_200101, mean)
WEBER_P_200102_mean <- cellStats(WEBER_P_200102, mean)
WEBER_P_200103_mean <- cellStats(WEBER_P_200103, mean)
WEBER_P_200104_mean <- cellStats(WEBER_P_200104, mean)
WEBER_P_200105_mean <- cellStats(WEBER_P_200105, mean)
WEBER_P_200106_mean <- cellStats(WEBER_P_200106, mean)
WEBER_P_200107_mean <- cellStats(WEBER_P_200107, mean)
WEBER_P_200108_mean <- cellStats(WEBER_P_200108, mean)
WEBER_P_200109_mean <- cellStats(WEBER_P_200109, mean)
WEBER_P_200110_mean <- cellStats(WEBER_P_200110, mean)
WEBER_P_200111_mean <- cellStats(WEBER_P_200111, mean)
WEBER_P_200112_mean <- cellStats(WEBER_P_200112, mean)

#2002
WEBER_P_200201_mean <- cellStats(WEBER_P_200201, mean)
WEBER_P_200202_mean <- cellStats(WEBER_P_200202, mean)
WEBER_P_200203_mean <- cellStats(WEBER_P_200203, mean)
WEBER_P_200204_mean <- cellStats(WEBER_P_200204, mean)
WEBER_P_200205_mean <- cellStats(WEBER_P_200205, mean)
WEBER_P_200206_mean <- cellStats(WEBER_P_200206, mean)
WEBER_P_200207_mean <- cellStats(WEBER_P_200207, mean)
WEBER_P_200208_mean <- cellStats(WEBER_P_200208, mean)
WEBER_P_200209_mean <- cellStats(WEBER_P_200209, mean)
WEBER_P_200210_mean <- cellStats(WEBER_P_200210, mean)
WEBER_P_200211_mean <- cellStats(WEBER_P_200211, mean)
WEBER_P_200212_mean <- cellStats(WEBER_P_200212, mean)

#2003
WEBER_P_200301_mean <- cellStats(WEBER_P_200301, mean)
WEBER_P_200302_mean <- cellStats(WEBER_P_200302, mean)
WEBER_P_200303_mean <- cellStats(WEBER_P_200303, mean)
WEBER_P_200304_mean <- cellStats(WEBER_P_200304, mean)
WEBER_P_200305_mean <- cellStats(WEBER_P_200305, mean)
WEBER_P_200306_mean <- cellStats(WEBER_P_200306, mean)
WEBER_P_200307_mean <- cellStats(WEBER_P_200307, mean)
WEBER_P_200308_mean <- cellStats(WEBER_P_200308, mean)
WEBER_P_200309_mean <- cellStats(WEBER_P_200309, mean)
WEBER_P_200310_mean <- cellStats(WEBER_P_200310, mean)
WEBER_P_200311_mean <- cellStats(WEBER_P_200311, mean)
WEBER_P_200312_mean <- cellStats(WEBER_P_200312, mean)

#2004

WEBER_P_200401_mean <- cellStats(WEBER_P_200401, mean)
WEBER_P_200402_mean <- cellStats(WEBER_P_200402, mean)
WEBER_P_200403_mean <- cellStats(WEBER_P_200403, mean)
WEBER_P_200404_mean <- cellStats(WEBER_P_200404, mean)
WEBER_P_200405_mean <- cellStats(WEBER_P_200405, mean)
WEBER_P_200406_mean <- cellStats(WEBER_P_200406, mean)
WEBER_P_200407_mean <- cellStats(WEBER_P_200407, mean)
WEBER_P_200408_mean <- cellStats(WEBER_P_200408, mean)
WEBER_P_200409_mean <- cellStats(WEBER_P_200409, mean)
WEBER_P_200410_mean <- cellStats(WEBER_P_200410, mean)
WEBER_P_200411_mean <- cellStats(WEBER_P_200411, mean)
WEBER_P_200412_mean <- cellStats(WEBER_P_200412, mean)

#2005

WEBER_P_200501_mean <- cellStats(WEBER_P_200501, mean)
WEBER_P_200502_mean <- cellStats(WEBER_P_200502, mean)
WEBER_P_200503_mean <- cellStats(WEBER_P_200503, mean)
WEBER_P_200504_mean <- cellStats(WEBER_P_200504, mean)
WEBER_P_200505_mean <- cellStats(WEBER_P_200505, mean)
WEBER_P_200506_mean <- cellStats(WEBER_P_200506, mean)
WEBER_P_200507_mean <- cellStats(WEBER_P_200507, mean)
WEBER_P_200508_mean <- cellStats(WEBER_P_200508, mean)
WEBER_P_200509_mean <- cellStats(WEBER_P_200509, mean)
WEBER_P_200510_mean <- cellStats(WEBER_P_200510, mean)
WEBER_P_200511_mean <- cellStats(WEBER_P_200511, mean)
WEBER_P_200512_mean <- cellStats(WEBER_P_200512, mean)

#2006

WEBER_P_200601_mean <- cellStats(WEBER_P_200601, mean)
WEBER_P_200602_mean <- cellStats(WEBER_P_200602, mean)
WEBER_P_200603_mean <- cellStats(WEBER_P_200603, mean)
WEBER_P_200604_mean <- cellStats(WEBER_P_200604, mean)
WEBER_P_200605_mean <- cellStats(WEBER_P_200605, mean)
WEBER_P_200606_mean <- cellStats(WEBER_P_200606, mean)
WEBER_P_200607_mean <- cellStats(WEBER_P_200607, mean)
WEBER_P_200608_mean <- cellStats(WEBER_P_200608, mean)
WEBER_P_200609_mean <- cellStats(WEBER_P_200609, mean)
WEBER_P_200610_mean <- cellStats(WEBER_P_200610, mean)
WEBER_P_200611_mean <- cellStats(WEBER_P_200611, mean)
WEBER_P_200612_mean <- cellStats(WEBER_P_200612, mean)

#2007

WEBER_P_200701_mean <- cellStats(WEBER_P_200701, mean)
WEBER_P_200702_mean <- cellStats(WEBER_P_200702, mean)
WEBER_P_200703_mean <- cellStats(WEBER_P_200703, mean)
WEBER_P_200704_mean <- cellStats(WEBER_P_200704, mean)
WEBER_P_200705_mean <- cellStats(WEBER_P_200705, mean)
WEBER_P_200706_mean <- cellStats(WEBER_P_200706, mean)
WEBER_P_200707_mean <- cellStats(WEBER_P_200707, mean)
WEBER_P_200708_mean <- cellStats(WEBER_P_200708, mean)
WEBER_P_200709_mean <- cellStats(WEBER_P_200709, mean)
WEBER_P_200710_mean <- cellStats(WEBER_P_200710, mean)
WEBER_P_200711_mean <- cellStats(WEBER_P_200711, mean)
WEBER_P_200712_mean <- cellStats(WEBER_P_200712, mean)

#2008

WEBER_P_200801_mean <- cellStats(WEBER_P_200801, mean)
WEBER_P_200802_mean <- cellStats(WEBER_P_200802, mean)
WEBER_P_200803_mean <- cellStats(WEBER_P_200803, mean)
WEBER_P_200804_mean <- cellStats(WEBER_P_200804, mean)
WEBER_P_200805_mean <- cellStats(WEBER_P_200805, mean)
WEBER_P_200806_mean <- cellStats(WEBER_P_200806, mean)
WEBER_P_200807_mean <- cellStats(WEBER_P_200807, mean)
WEBER_P_200808_mean <- cellStats(WEBER_P_200808, mean)
WEBER_P_200809_mean <- cellStats(WEBER_P_200809, mean)
WEBER_P_200810_mean <- cellStats(WEBER_P_200810, mean)
WEBER_P_200811_mean <- cellStats(WEBER_P_200811, mean)
WEBER_P_200812_mean <- cellStats(WEBER_P_200812, mean)

#2009

WEBER_P_200901_mean <- cellStats(WEBER_P_200901, mean)
WEBER_P_200902_mean <- cellStats(WEBER_P_200902, mean)
WEBER_P_200903_mean <- cellStats(WEBER_P_200903, mean)
WEBER_P_200904_mean <- cellStats(WEBER_P_200904, mean)
WEBER_P_200905_mean <- cellStats(WEBER_P_200905, mean)
WEBER_P_200906_mean <- cellStats(WEBER_P_200906, mean)
WEBER_P_200907_mean <- cellStats(WEBER_P_200907, mean)
WEBER_P_200908_mean <- cellStats(WEBER_P_200908, mean)
WEBER_P_200909_mean <- cellStats(WEBER_P_200909, mean)
WEBER_P_200910_mean <- cellStats(WEBER_P_200910, mean)
WEBER_P_200911_mean <- cellStats(WEBER_P_200911, mean)
WEBER_P_200912_mean <- cellStats(WEBER_P_200912, mean)

#2010

WEBER_P_201001_mean <- cellStats(WEBER_P_201001, mean)
WEBER_P_201002_mean <- cellStats(WEBER_P_201002, mean)
WEBER_P_201003_mean <- cellStats(WEBER_P_201003, mean)
WEBER_P_201004_mean <- cellStats(WEBER_P_201004, mean)
WEBER_P_201005_mean <- cellStats(WEBER_P_201005, mean)
WEBER_P_201006_mean <- cellStats(WEBER_P_201006, mean)
WEBER_P_201007_mean <- cellStats(WEBER_P_201007, mean)
WEBER_P_201008_mean <- cellStats(WEBER_P_201008, mean)
WEBER_P_201009_mean <- cellStats(WEBER_P_201009, mean)
WEBER_P_201010_mean <- cellStats(WEBER_P_201010, mean)
WEBER_P_201011_mean <- cellStats(WEBER_P_201011, mean)
WEBER_P_201012_mean <- cellStats(WEBER_P_201012, mean)

#2011

WEBER_P_201101_mean <- cellStats(WEBER_P_201101, mean)
WEBER_P_201102_mean <- cellStats(WEBER_P_201102, mean)
WEBER_P_201103_mean <- cellStats(WEBER_P_201103, mean)
WEBER_P_201104_mean <- cellStats(WEBER_P_201104, mean)
WEBER_P_201105_mean <- cellStats(WEBER_P_201105, mean)
WEBER_P_201106_mean <- cellStats(WEBER_P_201106, mean)
WEBER_P_201107_mean <- cellStats(WEBER_P_201107, mean)
WEBER_P_201108_mean <- cellStats(WEBER_P_201108, mean)
WEBER_P_201109_mean <- cellStats(WEBER_P_201109, mean)
WEBER_P_201110_mean <- cellStats(WEBER_P_201110, mean)
WEBER_P_201111_mean <- cellStats(WEBER_P_201111, mean)
WEBER_P_201112_mean <- cellStats(WEBER_P_201112, mean)

#2012
WEBER_P_201201_mean <- cellStats(WEBER_P_201201, mean)
WEBER_P_201202_mean <- cellStats(WEBER_P_201202, mean)
WEBER_P_201203_mean <- cellStats(WEBER_P_201203, mean)
WEBER_P_201204_mean <- cellStats(WEBER_P_201204, mean)
WEBER_P_201205_mean <- cellStats(WEBER_P_201205, mean)
WEBER_P_201206_mean <- cellStats(WEBER_P_201206, mean)
WEBER_P_201207_mean <- cellStats(WEBER_P_201207, mean)
WEBER_P_201208_mean <- cellStats(WEBER_P_201208, mean)
WEBER_P_201209_mean <- cellStats(WEBER_P_201209, mean)
WEBER_P_201210_mean <- cellStats(WEBER_P_201210, mean)
WEBER_P_201211_mean <- cellStats(WEBER_P_201211, mean)
WEBER_P_201212_mean <- cellStats(WEBER_P_201212, mean)

#2013
WEBER_P_201301_mean <- cellStats(WEBER_P_201301, mean)
WEBER_P_201302_mean <- cellStats(WEBER_P_201302, mean)
WEBER_P_201303_mean <- cellStats(WEBER_P_201303, mean)
WEBER_P_201304_mean <- cellStats(WEBER_P_201304, mean)
WEBER_P_201305_mean <- cellStats(WEBER_P_201305, mean)
WEBER_P_201306_mean <- cellStats(WEBER_P_201306, mean)
WEBER_P_201307_mean <- cellStats(WEBER_P_201307, mean)
WEBER_P_201308_mean <- cellStats(WEBER_P_201308, mean)
WEBER_P_201309_mean <- cellStats(WEBER_P_201309, mean)
WEBER_P_201310_mean <- cellStats(WEBER_P_201310, mean)
WEBER_P_201311_mean <- cellStats(WEBER_P_201311, mean)
WEBER_P_201312_mean <- cellStats(WEBER_P_201312, mean)

#2014
WEBER_P_201401_mean <- cellStats(WEBER_P_201401, mean)
WEBER_P_201402_mean <- cellStats(WEBER_P_201402, mean)
WEBER_P_201403_mean <- cellStats(WEBER_P_201403, mean)
WEBER_P_201404_mean <- cellStats(WEBER_P_201404, mean)
WEBER_P_201405_mean <- cellStats(WEBER_P_201405, mean)
WEBER_P_201406_mean <- cellStats(WEBER_P_201406, mean)
WEBER_P_201407_mean <- cellStats(WEBER_P_201407, mean)
WEBER_P_201408_mean <- cellStats(WEBER_P_201408, mean)
WEBER_P_201409_mean <- cellStats(WEBER_P_201409, mean)
WEBER_P_201410_mean <- cellStats(WEBER_P_201410, mean)
WEBER_P_201411_mean <- cellStats(WEBER_P_201411, mean)
WEBER_P_201412_mean <- cellStats(WEBER_P_201412, mean)

#2015
WEBER_P_201501_mean <- cellStats(WEBER_P_201501, mean)
WEBER_P_201502_mean <- cellStats(WEBER_P_201502, mean)
WEBER_P_201503_mean <- cellStats(WEBER_P_201503, mean)
WEBER_P_201504_mean <- cellStats(WEBER_P_201504, mean)
WEBER_P_201505_mean <- cellStats(WEBER_P_201505, mean)
WEBER_P_201506_mean <- cellStats(WEBER_P_201506, mean)
WEBER_P_201507_mean <- cellStats(WEBER_P_201507, mean)
WEBER_P_201508_mean <- cellStats(WEBER_P_201508, mean)
WEBER_P_201509_mean <- cellStats(WEBER_P_201509, mean)
WEBER_P_201510_mean <- cellStats(WEBER_P_201510, mean)
WEBER_P_201511_mean <- cellStats(WEBER_P_201511, mean)
WEBER_P_201512_mean <- cellStats(WEBER_P_201512, mean)

#2016
WEBER_P_201601_mean <- cellStats(WEBER_P_201601, mean)
WEBER_P_201602_mean <- cellStats(WEBER_P_201602, mean)
WEBER_P_201603_mean <- cellStats(WEBER_P_201603, mean)
WEBER_P_201604_mean <- cellStats(WEBER_P_201604, mean)
WEBER_P_201605_mean <- cellStats(WEBER_P_201605, mean)
WEBER_P_201606_mean <- cellStats(WEBER_P_201606, mean)
WEBER_P_201607_mean <- cellStats(WEBER_P_201607, mean)
WEBER_P_201608_mean <- cellStats(WEBER_P_201608, mean)
WEBER_P_201609_mean <- cellStats(WEBER_P_201609, mean)
WEBER_P_201610_mean <- cellStats(WEBER_P_201610, mean)
WEBER_P_201611_mean <- cellStats(WEBER_P_201611, mean)
WEBER_P_201612_mean <- cellStats(WEBER_P_201612, mean)

#2017
WEBER_P_201701_mean <- cellStats(WEBER_P_201701, mean)
WEBER_P_201702_mean <- cellStats(WEBER_P_201702, mean)
WEBER_P_201703_mean <- cellStats(WEBER_P_201703, mean)
WEBER_P_201704_mean <- cellStats(WEBER_P_201704, mean)
WEBER_P_201705_mean <- cellStats(WEBER_P_201705, mean)
WEBER_P_201706_mean <- cellStats(WEBER_P_201706, mean)
WEBER_P_201707_mean <- cellStats(WEBER_P_201707, mean)
WEBER_P_201708_mean <- cellStats(WEBER_P_201708, mean)
WEBER_P_201709_mean <- cellStats(WEBER_P_201709, mean)
WEBER_P_201710_mean <- cellStats(WEBER_P_201710, mean)
WEBER_P_201711_mean <- cellStats(WEBER_P_201711, mean)
WEBER_P_201712_mean <- cellStats(WEBER_P_201712, mean)

#2018
WEBER_P_201801_mean <- cellStats(WEBER_P_201801, mean)
WEBER_P_201802_mean <- cellStats(WEBER_P_201802, mean)
WEBER_P_201803_mean <- cellStats(WEBER_P_201803, mean)
WEBER_P_201804_mean <- cellStats(WEBER_P_201804, mean)
WEBER_P_201805_mean <- cellStats(WEBER_P_201805, mean)
WEBER_P_201806_mean <- cellStats(WEBER_P_201806, mean)
WEBER_P_201807_mean <- cellStats(WEBER_P_201807, mean)
WEBER_P_201808_mean <- cellStats(WEBER_P_201808, mean)
WEBER_P_201809_mean <- cellStats(WEBER_P_201809, mean)
WEBER_P_201810_mean <- cellStats(WEBER_P_201810, mean)
WEBER_P_201811_mean <- cellStats(WEBER_P_201811, mean)
WEBER_P_201812_mean <- cellStats(WEBER_P_201812, mean)

# Data Frame
Year <- c(2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009,
           2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018)


# Yearly Cummulative
#Box Elder
BOX_ELDER_2000 <- data.frame(BOX_ELDER_P_200001_mean, BOX_ELDER_P_200002_mean, BOX_ELDER_P_200003_mean, BOX_ELDER_P_200004_mean, 
                      BOX_ELDER_P_200005_mean, BOX_ELDER_P_200006_mean, BOX_ELDER_P_200007_mean, BOX_ELDER_P_200008_mean, 
                      BOX_ELDER_P_200009_mean, BOX_ELDER_P_200010_mean, BOX_ELDER_P_200011_mean, BOX_ELDER_P_200012_mean)
BOX_ELDER_2001 <- data.frame(BOX_ELDER_P_200101_mean, BOX_ELDER_P_200102_mean, BOX_ELDER_P_200103_mean, BOX_ELDER_P_200104_mean, 
                             BOX_ELDER_P_200105_mean, BOX_ELDER_P_200106_mean, BOX_ELDER_P_200107_mean, BOX_ELDER_P_200108_mean, 
                             BOX_ELDER_P_200109_mean, BOX_ELDER_P_200110_mean, BOX_ELDER_P_200111_mean, BOX_ELDER_P_200112_mean)
BOX_ELDER_2002 <- data.frame(BOX_ELDER_P_200201_mean, BOX_ELDER_P_200202_mean, BOX_ELDER_P_200203_mean, BOX_ELDER_P_200204_mean, 
                             BOX_ELDER_P_200205_mean, BOX_ELDER_P_200206_mean, BOX_ELDER_P_200207_mean, BOX_ELDER_P_200208_mean, 
                             BOX_ELDER_P_200209_mean, BOX_ELDER_P_200210_mean, BOX_ELDER_P_200211_mean, BOX_ELDER_P_200212_mean)
BOX_ELDER_2003 <- data.frame(BOX_ELDER_P_200301_mean, BOX_ELDER_P_200302_mean, BOX_ELDER_P_200303_mean, BOX_ELDER_P_200304_mean, 
                             BOX_ELDER_P_200305_mean, BOX_ELDER_P_200306_mean, BOX_ELDER_P_200307_mean, BOX_ELDER_P_200308_mean, 
                             BOX_ELDER_P_200309_mean, BOX_ELDER_P_200310_mean, BOX_ELDER_P_200311_mean, BOX_ELDER_P_200312_mean)
BOX_ELDER_2004 <- data.frame(BOX_ELDER_P_200401_mean, BOX_ELDER_P_200402_mean, BOX_ELDER_P_200403_mean, BOX_ELDER_P_200404_mean, 
                             BOX_ELDER_P_200405_mean, BOX_ELDER_P_200406_mean, BOX_ELDER_P_200407_mean, BOX_ELDER_P_200408_mean, 
                             BOX_ELDER_P_200409_mean, BOX_ELDER_P_200410_mean, BOX_ELDER_P_200411_mean, BOX_ELDER_P_200412_mean)
BOX_ELDER_2005 <- data.frame(BOX_ELDER_P_200501_mean, BOX_ELDER_P_200502_mean, BOX_ELDER_P_200503_mean, BOX_ELDER_P_200504_mean, 
                             BOX_ELDER_P_200505_mean, BOX_ELDER_P_200506_mean, BOX_ELDER_P_200507_mean, BOX_ELDER_P_200508_mean, 
                             BOX_ELDER_P_200509_mean, BOX_ELDER_P_200510_mean, BOX_ELDER_P_200511_mean, BOX_ELDER_P_200512_mean)
BOX_ELDER_2006 <- data.frame(BOX_ELDER_P_200601_mean, BOX_ELDER_P_200602_mean, BOX_ELDER_P_200603_mean, BOX_ELDER_P_200604_mean, 
                             BOX_ELDER_P_200605_mean, BOX_ELDER_P_200606_mean, BOX_ELDER_P_200607_mean, BOX_ELDER_P_200608_mean, 
                             BOX_ELDER_P_200609_mean, BOX_ELDER_P_200610_mean, BOX_ELDER_P_200611_mean, BOX_ELDER_P_200612_mean)
BOX_ELDER_2007 <- data.frame(BOX_ELDER_P_200701_mean, BOX_ELDER_P_200702_mean, BOX_ELDER_P_200703_mean, BOX_ELDER_P_200704_mean, 
                             BOX_ELDER_P_200705_mean, BOX_ELDER_P_200706_mean, BOX_ELDER_P_200707_mean, BOX_ELDER_P_200708_mean, 
                             BOX_ELDER_P_200709_mean, BOX_ELDER_P_200710_mean, BOX_ELDER_P_200711_mean, BOX_ELDER_P_200712_mean)
BOX_ELDER_2008 <- data.frame(BOX_ELDER_P_200801_mean, BOX_ELDER_P_200802_mean, BOX_ELDER_P_200803_mean, BOX_ELDER_P_200804_mean, 
                             BOX_ELDER_P_200805_mean, BOX_ELDER_P_200806_mean, BOX_ELDER_P_200807_mean, BOX_ELDER_P_200808_mean, 
                             BOX_ELDER_P_200809_mean, BOX_ELDER_P_200810_mean, BOX_ELDER_P_200811_mean, BOX_ELDER_P_200812_mean)
BOX_ELDER_2009 <- data.frame(BOX_ELDER_P_200901_mean, BOX_ELDER_P_200902_mean, BOX_ELDER_P_200903_mean, BOX_ELDER_P_200904_mean, 
                             BOX_ELDER_P_200905_mean, BOX_ELDER_P_200906_mean, BOX_ELDER_P_200907_mean, BOX_ELDER_P_200908_mean, 
                             BOX_ELDER_P_200909_mean, BOX_ELDER_P_200910_mean, BOX_ELDER_P_200911_mean, BOX_ELDER_P_200912_mean)
BOX_ELDER_2010 <- data.frame(BOX_ELDER_P_201001_mean, BOX_ELDER_P_201002_mean, BOX_ELDER_P_201003_mean, BOX_ELDER_P_201004_mean, 
                             BOX_ELDER_P_201005_mean, BOX_ELDER_P_201006_mean, BOX_ELDER_P_201007_mean, BOX_ELDER_P_201008_mean, 
                             BOX_ELDER_P_201009_mean, BOX_ELDER_P_201010_mean, BOX_ELDER_P_201011_mean, BOX_ELDER_P_201012_mean)
BOX_ELDER_2011 <- data.frame(BOX_ELDER_P_201101_mean, BOX_ELDER_P_201102_mean, BOX_ELDER_P_201103_mean, BOX_ELDER_P_201104_mean, 
                             BOX_ELDER_P_201105_mean, BOX_ELDER_P_201106_mean, BOX_ELDER_P_201107_mean, BOX_ELDER_P_201108_mean, 
                             BOX_ELDER_P_201109_mean, BOX_ELDER_P_201110_mean, BOX_ELDER_P_201111_mean, BOX_ELDER_P_201112_mean)
BOX_ELDER_2012 <- data.frame(BOX_ELDER_P_201201_mean, BOX_ELDER_P_201202_mean, BOX_ELDER_P_201203_mean, BOX_ELDER_P_201204_mean, 
                             BOX_ELDER_P_201205_mean, BOX_ELDER_P_201206_mean, BOX_ELDER_P_201207_mean, BOX_ELDER_P_201208_mean, 
                             BOX_ELDER_P_201209_mean, BOX_ELDER_P_201210_mean, BOX_ELDER_P_201211_mean, BOX_ELDER_P_201212_mean)
BOX_ELDER_2013 <- data.frame(BOX_ELDER_P_201301_mean, BOX_ELDER_P_201302_mean, BOX_ELDER_P_201303_mean, BOX_ELDER_P_201304_mean, 
                             BOX_ELDER_P_201305_mean, BOX_ELDER_P_201306_mean, BOX_ELDER_P_201307_mean, BOX_ELDER_P_201308_mean, 
                             BOX_ELDER_P_201309_mean, BOX_ELDER_P_201310_mean, BOX_ELDER_P_201311_mean, BOX_ELDER_P_201312_mean)
BOX_ELDER_2014 <- data.frame(BOX_ELDER_P_201401_mean, BOX_ELDER_P_201402_mean, BOX_ELDER_P_201403_mean, BOX_ELDER_P_201404_mean, 
                             BOX_ELDER_P_201405_mean, BOX_ELDER_P_201406_mean, BOX_ELDER_P_201407_mean, BOX_ELDER_P_201408_mean, 
                             BOX_ELDER_P_201409_mean, BOX_ELDER_P_201410_mean, BOX_ELDER_P_201411_mean, BOX_ELDER_P_201412_mean)
BOX_ELDER_2015 <- data.frame(BOX_ELDER_P_201501_mean, BOX_ELDER_P_201502_mean, BOX_ELDER_P_201503_mean, BOX_ELDER_P_201504_mean, 
                             BOX_ELDER_P_201505_mean, BOX_ELDER_P_201506_mean, BOX_ELDER_P_201507_mean, BOX_ELDER_P_201508_mean, 
                             BOX_ELDER_P_201509_mean, BOX_ELDER_P_201510_mean, BOX_ELDER_P_201511_mean, BOX_ELDER_P_201512_mean)
BOX_ELDER_2016 <- data.frame(BOX_ELDER_P_201601_mean, BOX_ELDER_P_201602_mean, BOX_ELDER_P_201603_mean, BOX_ELDER_P_201604_mean, 
                             BOX_ELDER_P_201605_mean, BOX_ELDER_P_201606_mean, BOX_ELDER_P_201607_mean, BOX_ELDER_P_201608_mean, 
                             BOX_ELDER_P_201609_mean, BOX_ELDER_P_201610_mean, BOX_ELDER_P_201611_mean, BOX_ELDER_P_201612_mean)
BOX_ELDER_2017 <- data.frame(BOX_ELDER_P_201701_mean, BOX_ELDER_P_201702_mean, BOX_ELDER_P_201703_mean, BOX_ELDER_P_201704_mean, 
                             BOX_ELDER_P_201705_mean, BOX_ELDER_P_201706_mean, BOX_ELDER_P_201707_mean, BOX_ELDER_P_201708_mean, 
                             BOX_ELDER_P_201709_mean, BOX_ELDER_P_201710_mean, BOX_ELDER_P_201711_mean, BOX_ELDER_P_201712_mean)
BOX_ELDER_2018 <- data.frame(BOX_ELDER_P_201801_mean, BOX_ELDER_P_201802_mean, BOX_ELDER_P_201803_mean, BOX_ELDER_P_201804_mean, 
                             BOX_ELDER_P_201805_mean, BOX_ELDER_P_201806_mean, BOX_ELDER_P_201807_mean, BOX_ELDER_P_201808_mean, 
                             BOX_ELDER_P_201809_mean)

#Beaver
BEAVER_2000 <- data.frame(BEAVER_P_200001_mean, BEAVER_P_200002_mean, BEAVER_P_200003_mean, BEAVER_P_200004_mean, 
                          BEAVER_P_200005_mean, BEAVER_P_200006_mean, BEAVER_P_200007_mean, BEAVER_P_200008_mean, 
                          BEAVER_P_200009_mean, BEAVER_P_200010_mean, BEAVER_P_200011_mean, BEAVER_P_200012_mean)
BEAVER_2001 <- data.frame(BEAVER_P_200101_mean, BEAVER_P_200102_mean, BEAVER_P_200103_mean, BEAVER_P_200104_mean, 
                          BEAVER_P_200105_mean, BEAVER_P_200106_mean, BEAVER_P_200107_mean, BEAVER_P_200108_mean, 
                          BEAVER_P_200109_mean, BEAVER_P_200110_mean, BEAVER_P_200111_mean, BEAVER_P_200112_mean)
BEAVER_2002 <- data.frame(BEAVER_P_200201_mean, BEAVER_P_200202_mean, BEAVER_P_200203_mean, BEAVER_P_200204_mean, 
                          BEAVER_P_200205_mean, BEAVER_P_200206_mean, BEAVER_P_200207_mean, BEAVER_P_200208_mean, 
                          BEAVER_P_200209_mean, BEAVER_P_200210_mean, BEAVER_P_200211_mean, BEAVER_P_200212_mean)
BEAVER_2003 <- data.frame(BEAVER_P_200301_mean, BEAVER_P_200302_mean, BEAVER_P_200303_mean, BEAVER_P_200304_mean, 
                          BEAVER_P_200305_mean, BEAVER_P_200306_mean, BEAVER_P_200307_mean, BEAVER_P_200308_mean, 
                          BEAVER_P_200309_mean, BEAVER_P_200310_mean, BEAVER_P_200311_mean, BEAVER_P_200312_mean)
BEAVER_2004 <- data.frame(BEAVER_P_200401_mean, BEAVER_P_200402_mean, BEAVER_P_200403_mean, BEAVER_P_200404_mean, 
                          BEAVER_P_200405_mean, BEAVER_P_200406_mean, BEAVER_P_200407_mean, BEAVER_P_200408_mean, 
                          BEAVER_P_200409_mean, BEAVER_P_200410_mean, BEAVER_P_200411_mean, BEAVER_P_200412_mean)
BEAVER_2005 <- data.frame(BEAVER_P_200501_mean, BEAVER_P_200502_mean, BEAVER_P_200503_mean, BEAVER_P_200504_mean, 
                          BEAVER_P_200505_mean, BEAVER_P_200506_mean, BEAVER_P_200507_mean, BEAVER_P_200508_mean, 
                          BEAVER_P_200509_mean, BEAVER_P_200510_mean, BEAVER_P_200511_mean, BEAVER_P_200512_mean)
BEAVER_2006 <- data.frame(BEAVER_P_200601_mean, BEAVER_P_200602_mean, BEAVER_P_200603_mean, BEAVER_P_200604_mean, 
                          BEAVER_P_200605_mean, BEAVER_P_200606_mean, BEAVER_P_200607_mean, BEAVER_P_200608_mean, 
                          BEAVER_P_200609_mean, BEAVER_P_200610_mean, BEAVER_P_200611_mean, BEAVER_P_200612_mean)
BEAVER_2007 <- data.frame(BEAVER_P_200701_mean, BEAVER_P_200702_mean, BEAVER_P_200703_mean, BEAVER_P_200704_mean, 
                          BEAVER_P_200705_mean, BEAVER_P_200706_mean, BEAVER_P_200707_mean, BEAVER_P_200708_mean, 
                          BEAVER_P_200709_mean, BEAVER_P_200710_mean, BEAVER_P_200711_mean, BEAVER_P_200712_mean)
BEAVER_2008 <- data.frame(BEAVER_P_200801_mean, BEAVER_P_200802_mean, BEAVER_P_200803_mean, BEAVER_P_200804_mean, 
                          BEAVER_P_200805_mean, BEAVER_P_200806_mean, BEAVER_P_200807_mean, BEAVER_P_200808_mean, 
                          BEAVER_P_200809_mean, BEAVER_P_200810_mean, BEAVER_P_200811_mean, BEAVER_P_200812_mean)
BEAVER_2009 <- data.frame(BEAVER_P_200901_mean, BEAVER_P_200902_mean, BEAVER_P_200903_mean, BEAVER_P_200904_mean, 
                          BEAVER_P_200905_mean, BEAVER_P_200906_mean, BEAVER_P_200907_mean, BEAVER_P_200908_mean, 
                          BEAVER_P_200909_mean, BEAVER_P_200910_mean, BEAVER_P_200911_mean, BEAVER_P_200912_mean)
BEAVER_2010 <- data.frame(BEAVER_P_201001_mean, BEAVER_P_201002_mean, BEAVER_P_201003_mean, BEAVER_P_201004_mean, 
                          BEAVER_P_201005_mean, BEAVER_P_201006_mean, BEAVER_P_201007_mean, BEAVER_P_201008_mean, 
                          BEAVER_P_201009_mean, BEAVER_P_201010_mean, BEAVER_P_201011_mean, BEAVER_P_201012_mean)
BEAVER_2011 <- data.frame(BEAVER_P_201101_mean, BEAVER_P_201102_mean, BEAVER_P_201103_mean, BEAVER_P_201104_mean, 
                          BEAVER_P_201105_mean, BEAVER_P_201106_mean, BEAVER_P_201107_mean, BEAVER_P_201108_mean, 
                          BEAVER_P_201109_mean, BEAVER_P_201110_mean, BEAVER_P_201111_mean, BEAVER_P_201112_mean)
BEAVER_2012 <- data.frame(BEAVER_P_201201_mean, BEAVER_P_201202_mean, BEAVER_P_201203_mean, BEAVER_P_201204_mean, 
                          BEAVER_P_201205_mean, BEAVER_P_201206_mean, BEAVER_P_201207_mean, BEAVER_P_201208_mean, 
                          BEAVER_P_201209_mean, BEAVER_P_201210_mean, BEAVER_P_201211_mean, BEAVER_P_201212_mean)
BEAVER_2013 <- data.frame(BEAVER_P_201301_mean, BEAVER_P_201302_mean, BEAVER_P_201303_mean, BEAVER_P_201304_mean, 
                          BEAVER_P_201305_mean, BEAVER_P_201306_mean, BEAVER_P_201307_mean, BEAVER_P_201308_mean, 
                          BEAVER_P_201309_mean, BEAVER_P_201310_mean, BEAVER_P_201311_mean, BEAVER_P_201312_mean)
BEAVER_2014 <- data.frame(BEAVER_P_201401_mean, BEAVER_P_201402_mean, BEAVER_P_201403_mean, BEAVER_P_201404_mean, 
                          BEAVER_P_201405_mean, BEAVER_P_201406_mean, BEAVER_P_201407_mean, BEAVER_P_201408_mean, 
                          BEAVER_P_201409_mean, BEAVER_P_201410_mean, BEAVER_P_201411_mean, BEAVER_P_201412_mean)
BEAVER_2015 <- data.frame(BEAVER_P_201501_mean, BEAVER_P_201502_mean, BEAVER_P_201503_mean, BEAVER_P_201504_mean, 
                          BEAVER_P_201505_mean, BEAVER_P_201506_mean, BEAVER_P_201507_mean, BEAVER_P_201508_mean, 
                          BEAVER_P_201509_mean, BEAVER_P_201510_mean, BEAVER_P_201511_mean, BEAVER_P_201512_mean)
BEAVER_2016 <- data.frame(BEAVER_P_201601_mean, BEAVER_P_201602_mean, BEAVER_P_201603_mean, BEAVER_P_201604_mean, 
                          BEAVER_P_201605_mean, BEAVER_P_201606_mean, BEAVER_P_201607_mean, BEAVER_P_201608_mean, 
                          BEAVER_P_201609_mean, BEAVER_P_201610_mean, BEAVER_P_201611_mean, BEAVER_P_201612_mean)
BEAVER_2017 <- data.frame(BEAVER_P_201701_mean, BEAVER_P_201702_mean, BEAVER_P_201703_mean, BEAVER_P_201704_mean, 
                          BEAVER_P_201705_mean, BEAVER_P_201706_mean, BEAVER_P_201707_mean, BEAVER_P_201708_mean, 
                          BEAVER_P_201709_mean, BEAVER_P_201710_mean, BEAVER_P_201711_mean, BEAVER_P_201712_mean)
BEAVER_2018 <- data.frame(BEAVER_P_201801_mean, BEAVER_P_201802_mean, BEAVER_P_201803_mean, BEAVER_P_201804_mean, 
                          BEAVER_P_201805_mean, BEAVER_P_201806_mean, BEAVER_P_201807_mean, BEAVER_P_201808_mean, 
                          BEAVER_P_201809_mean)

#cACHE
CACHE_2000 <- data.frame(CACHE_P_200001_mean, CACHE_P_200002_mean, CACHE_P_200003_mean, CACHE_P_200004_mean, 
                         CACHE_P_200005_mean, CACHE_P_200006_mean, CACHE_P_200007_mean, CACHE_P_200008_mean, 
                         CACHE_P_200009_mean, CACHE_P_200010_mean, CACHE_P_200011_mean, CACHE_P_200012_mean)
CACHE_2001 <- data.frame(CACHE_P_200101_mean, CACHE_P_200102_mean, CACHE_P_200103_mean, CACHE_P_200104_mean, 
                         CACHE_P_200105_mean, CACHE_P_200106_mean, CACHE_P_200107_mean, CACHE_P_200108_mean, 
                         CACHE_P_200109_mean, CACHE_P_200110_mean, CACHE_P_200111_mean, CACHE_P_200112_mean)
CACHE_2002 <- data.frame(CACHE_P_200201_mean, CACHE_P_200202_mean, CACHE_P_200203_mean, CACHE_P_200204_mean, 
                         CACHE_P_200205_mean, CACHE_P_200206_mean, CACHE_P_200207_mean, CACHE_P_200208_mean, 
                         CACHE_P_200209_mean, CACHE_P_200210_mean, CACHE_P_200211_mean, CACHE_P_200212_mean)
CACHE_2003 <- data.frame(CACHE_P_200301_mean, CACHE_P_200302_mean, CACHE_P_200303_mean, CACHE_P_200304_mean, 
                         CACHE_P_200305_mean, CACHE_P_200306_mean, CACHE_P_200307_mean, CACHE_P_200308_mean, 
                         CACHE_P_200309_mean, CACHE_P_200310_mean, CACHE_P_200311_mean, CACHE_P_200312_mean)
CACHE_2004 <- data.frame(CACHE_P_200401_mean, CACHE_P_200402_mean, CACHE_P_200403_mean, CACHE_P_200404_mean, 
                         CACHE_P_200405_mean, CACHE_P_200406_mean, CACHE_P_200407_mean, CACHE_P_200408_mean, 
                         CACHE_P_200409_mean, CACHE_P_200410_mean, CACHE_P_200411_mean, CACHE_P_200412_mean)
CACHE_2005 <- data.frame(CACHE_P_200501_mean, CACHE_P_200502_mean, CACHE_P_200503_mean, CACHE_P_200504_mean, 
                         CACHE_P_200505_mean, CACHE_P_200506_mean, CACHE_P_200507_mean, CACHE_P_200508_mean, 
                         CACHE_P_200509_mean, CACHE_P_200510_mean, CACHE_P_200511_mean, CACHE_P_200512_mean)
CACHE_2006 <- data.frame(CACHE_P_200601_mean, CACHE_P_200602_mean, CACHE_P_200603_mean, CACHE_P_200604_mean, 
                         CACHE_P_200605_mean, CACHE_P_200606_mean, CACHE_P_200607_mean, CACHE_P_200608_mean, 
                         CACHE_P_200609_mean, CACHE_P_200610_mean, CACHE_P_200611_mean, CACHE_P_200612_mean)
CACHE_2007 <- data.frame(CACHE_P_200701_mean, CACHE_P_200702_mean, CACHE_P_200703_mean, CACHE_P_200704_mean, 
                         CACHE_P_200705_mean, CACHE_P_200706_mean, CACHE_P_200707_mean, CACHE_P_200708_mean, 
                         CACHE_P_200709_mean, CACHE_P_200710_mean, CACHE_P_200711_mean, CACHE_P_200712_mean)
CACHE_2008 <- data.frame(CACHE_P_200801_mean, CACHE_P_200802_mean, CACHE_P_200803_mean, CACHE_P_200804_mean, 
                         CACHE_P_200805_mean, CACHE_P_200806_mean, CACHE_P_200807_mean, CACHE_P_200808_mean, 
                         CACHE_P_200809_mean, CACHE_P_200810_mean, CACHE_P_200811_mean, CACHE_P_200812_mean)
CACHE_2009 <- data.frame(CACHE_P_200901_mean, CACHE_P_200902_mean, CACHE_P_200903_mean, CACHE_P_200904_mean, 
                         CACHE_P_200905_mean, CACHE_P_200906_mean, CACHE_P_200907_mean, CACHE_P_200908_mean, 
                         CACHE_P_200909_mean, CACHE_P_200910_mean, CACHE_P_200911_mean, CACHE_P_200912_mean)
CACHE_2010 <- data.frame(CACHE_P_201001_mean, CACHE_P_201002_mean, CACHE_P_201003_mean, CACHE_P_201004_mean, 
                         CACHE_P_201005_mean, CACHE_P_201006_mean, CACHE_P_201007_mean, CACHE_P_201008_mean, 
                         CACHE_P_201009_mean, CACHE_P_201010_mean, CACHE_P_201011_mean, CACHE_P_201012_mean)
CACHE_2011 <- data.frame(CACHE_P_201101_mean, CACHE_P_201102_mean, CACHE_P_201103_mean, CACHE_P_201104_mean, 
                         CACHE_P_201105_mean, CACHE_P_201106_mean, CACHE_P_201107_mean, CACHE_P_201108_mean, 
                         CACHE_P_201109_mean, CACHE_P_201110_mean, CACHE_P_201111_mean, CACHE_P_201112_mean)
CACHE_2012 <- data.frame(CACHE_P_201201_mean, CACHE_P_201202_mean, CACHE_P_201203_mean, CACHE_P_201204_mean, 
                         CACHE_P_201205_mean, CACHE_P_201206_mean, CACHE_P_201207_mean, CACHE_P_201208_mean, 
                         CACHE_P_201209_mean, CACHE_P_201210_mean, CACHE_P_201211_mean, CACHE_P_201212_mean)
CACHE_2013 <- data.frame(CACHE_P_201301_mean, CACHE_P_201302_mean, CACHE_P_201303_mean, CACHE_P_201304_mean, 
                         CACHE_P_201305_mean, CACHE_P_201306_mean, CACHE_P_201307_mean, CACHE_P_201308_mean, 
                         CACHE_P_201309_mean, CACHE_P_201310_mean, CACHE_P_201311_mean, CACHE_P_201312_mean)
CACHE_2014 <- data.frame(CACHE_P_201401_mean, CACHE_P_201402_mean, CACHE_P_201403_mean, CACHE_P_201404_mean, 
                         CACHE_P_201405_mean, CACHE_P_201406_mean, CACHE_P_201407_mean, CACHE_P_201408_mean, 
                         CACHE_P_201409_mean, CACHE_P_201410_mean, CACHE_P_201411_mean, CACHE_P_201412_mean)
CACHE_2015 <- data.frame(CACHE_P_201501_mean, CACHE_P_201502_mean, CACHE_P_201503_mean, CACHE_P_201504_mean, 
                         CACHE_P_201505_mean, CACHE_P_201506_mean, CACHE_P_201507_mean, CACHE_P_201508_mean, 
                         CACHE_P_201509_mean, CACHE_P_201510_mean, CACHE_P_201511_mean, CACHE_P_201512_mean)
CACHE_2016 <- data.frame(CACHE_P_201601_mean, CACHE_P_201602_mean, CACHE_P_201603_mean, CACHE_P_201604_mean, 
                         CACHE_P_201605_mean, CACHE_P_201606_mean, CACHE_P_201607_mean, CACHE_P_201608_mean, 
                         CACHE_P_201609_mean, CACHE_P_201610_mean, CACHE_P_201611_mean, CACHE_P_201612_mean)
CACHE_2017 <- data.frame(CACHE_P_201701_mean, CACHE_P_201702_mean, CACHE_P_201703_mean, CACHE_P_201704_mean, 
                         CACHE_P_201705_mean, CACHE_P_201706_mean, CACHE_P_201707_mean, CACHE_P_201708_mean, 
                         CACHE_P_201709_mean, CACHE_P_201710_mean, CACHE_P_201711_mean, CACHE_P_201712_mean)
CACHE_2018 <- data.frame(CACHE_P_201801_mean, CACHE_P_201802_mean, CACHE_P_201803_mean, CACHE_P_201804_mean, 
                         CACHE_P_201805_mean, CACHE_P_201806_mean, CACHE_P_201807_mean, CACHE_P_201808_mean, 
                         CACHE_P_201809_mean)

#CARBON
CARBON_2000 <- data.frame(CARBON_P_200001_mean, CARBON_P_200002_mean, CARBON_P_200003_mean, CARBON_P_200004_mean, 
                          CARBON_P_200005_mean, CARBON_P_200006_mean, CARBON_P_200007_mean, CARBON_P_200008_mean, 
                          CARBON_P_200009_mean, CARBON_P_200010_mean, CARBON_P_200011_mean, CARBON_P_200012_mean)
CARBON_2001 <- data.frame(CARBON_P_200101_mean, CARBON_P_200102_mean, CARBON_P_200103_mean, CARBON_P_200104_mean, 
                          CARBON_P_200105_mean, CARBON_P_200106_mean, CARBON_P_200107_mean, CARBON_P_200108_mean, 
                          CARBON_P_200109_mean, CARBON_P_200110_mean, CARBON_P_200111_mean, CARBON_P_200112_mean)
CARBON_2002 <- data.frame(CARBON_P_200201_mean, CARBON_P_200202_mean, CARBON_P_200203_mean, CARBON_P_200204_mean, 
                          CARBON_P_200205_mean, CARBON_P_200206_mean, CARBON_P_200207_mean, CARBON_P_200208_mean, 
                          CARBON_P_200209_mean, CARBON_P_200210_mean, CARBON_P_200211_mean, CARBON_P_200212_mean)
CARBON_2003 <- data.frame(CARBON_P_200301_mean, CARBON_P_200302_mean, CARBON_P_200303_mean, CARBON_P_200304_mean, 
                          CARBON_P_200305_mean, CARBON_P_200306_mean, CARBON_P_200307_mean, CARBON_P_200308_mean, 
                          CARBON_P_200309_mean, CARBON_P_200310_mean, CARBON_P_200311_mean, CARBON_P_200312_mean)
CARBON_2004 <- data.frame(CARBON_P_200401_mean, CARBON_P_200402_mean, CARBON_P_200403_mean, CARBON_P_200404_mean, 
                          CARBON_P_200405_mean, CARBON_P_200406_mean, CARBON_P_200407_mean, CARBON_P_200408_mean, 
                          CARBON_P_200409_mean, CARBON_P_200410_mean, CARBON_P_200411_mean, CARBON_P_200412_mean)
CARBON_2005 <- data.frame(CARBON_P_200501_mean, CARBON_P_200502_mean, CARBON_P_200503_mean, CARBON_P_200504_mean, 
                          CARBON_P_200505_mean, CARBON_P_200506_mean, CARBON_P_200507_mean, CARBON_P_200508_mean, 
                          CARBON_P_200509_mean, CARBON_P_200510_mean, CARBON_P_200511_mean, CARBON_P_200512_mean)
CARBON_2006 <- data.frame(CARBON_P_200601_mean, CARBON_P_200602_mean, CARBON_P_200603_mean, CARBON_P_200604_mean, 
                          CARBON_P_200605_mean, CARBON_P_200606_mean, CARBON_P_200607_mean, CARBON_P_200608_mean, 
                          CARBON_P_200609_mean, CARBON_P_200610_mean, CARBON_P_200611_mean, CARBON_P_200612_mean)
CARBON_2007 <- data.frame(CARBON_P_200701_mean, CARBON_P_200702_mean, CARBON_P_200703_mean, CARBON_P_200704_mean, 
                          CARBON_P_200705_mean, CARBON_P_200706_mean, CARBON_P_200707_mean, CARBON_P_200708_mean, 
                          CARBON_P_200709_mean, CARBON_P_200710_mean, CARBON_P_200711_mean, CARBON_P_200712_mean)
CARBON_2008 <- data.frame(CARBON_P_200801_mean, CARBON_P_200802_mean, CARBON_P_200803_mean, CARBON_P_200804_mean, 
                          CARBON_P_200805_mean, CARBON_P_200806_mean, CARBON_P_200807_mean, CARBON_P_200808_mean, 
                          CARBON_P_200809_mean, CARBON_P_200810_mean, CARBON_P_200811_mean, CARBON_P_200812_mean)
CARBON_2009 <- data.frame(CARBON_P_200901_mean, CARBON_P_200902_mean, CARBON_P_200903_mean, CARBON_P_200904_mean, 
                          CARBON_P_200905_mean, CARBON_P_200906_mean, CARBON_P_200907_mean, CARBON_P_200908_mean, 
                          CARBON_P_200909_mean, CARBON_P_200910_mean, CARBON_P_200911_mean, CARBON_P_200912_mean)
CARBON_2010 <- data.frame(CARBON_P_201001_mean, CARBON_P_201002_mean, CARBON_P_201003_mean, CARBON_P_201004_mean, 
                          CARBON_P_201005_mean, CARBON_P_201006_mean, CARBON_P_201007_mean, CARBON_P_201008_mean, 
                          CARBON_P_201009_mean, CARBON_P_201010_mean, CARBON_P_201011_mean, CARBON_P_201012_mean)
CARBON_2011 <- data.frame(CARBON_P_201101_mean, CARBON_P_201102_mean, CARBON_P_201103_mean, CARBON_P_201104_mean, 
                          CARBON_P_201105_mean, CARBON_P_201106_mean, CARBON_P_201107_mean, CARBON_P_201108_mean, 
                          CARBON_P_201109_mean, CARBON_P_201110_mean, CARBON_P_201111_mean, CARBON_P_201112_mean)
CARBON_2012 <- data.frame(CARBON_P_201201_mean, CARBON_P_201202_mean, CARBON_P_201203_mean, CARBON_P_201204_mean, 
                          CARBON_P_201205_mean, CARBON_P_201206_mean, CARBON_P_201207_mean, CARBON_P_201208_mean, 
                          CARBON_P_201209_mean, CARBON_P_201210_mean, CARBON_P_201211_mean, CARBON_P_201212_mean)
CARBON_2013 <- data.frame(CARBON_P_201301_mean, CARBON_P_201302_mean, CARBON_P_201303_mean, CARBON_P_201304_mean, 
                          CARBON_P_201305_mean, CARBON_P_201306_mean, CARBON_P_201307_mean, CARBON_P_201308_mean, 
                          CARBON_P_201309_mean, CARBON_P_201310_mean, CARBON_P_201311_mean, CARBON_P_201312_mean)
CARBON_2014 <- data.frame(CARBON_P_201401_mean, CARBON_P_201402_mean, CARBON_P_201403_mean, CARBON_P_201404_mean, 
                          CARBON_P_201405_mean, CARBON_P_201406_mean, CARBON_P_201407_mean, CARBON_P_201408_mean, 
                          CARBON_P_201409_mean, CARBON_P_201410_mean, CARBON_P_201411_mean, CARBON_P_201412_mean)
CARBON_2015 <- data.frame(CARBON_P_201501_mean, CARBON_P_201502_mean, CARBON_P_201503_mean, CARBON_P_201504_mean, 
                          CARBON_P_201505_mean, CARBON_P_201506_mean, CARBON_P_201507_mean, CARBON_P_201508_mean, 
                          CARBON_P_201509_mean, CARBON_P_201510_mean, CARBON_P_201511_mean, CARBON_P_201512_mean)
CARBON_2016 <- data.frame(CARBON_P_201601_mean, CARBON_P_201602_mean, CARBON_P_201603_mean, CARBON_P_201604_mean, 
                          CARBON_P_201605_mean, CARBON_P_201606_mean, CARBON_P_201607_mean, CARBON_P_201608_mean, 
                          CARBON_P_201609_mean, CARBON_P_201610_mean, CARBON_P_201611_mean, CARBON_P_201612_mean)
CARBON_2017 <- data.frame(CARBON_P_201701_mean, CARBON_P_201702_mean, CARBON_P_201703_mean, CARBON_P_201704_mean, 
                          CARBON_P_201705_mean, CARBON_P_201706_mean, CARBON_P_201707_mean, CARBON_P_201708_mean, 
                          CARBON_P_201709_mean, CARBON_P_201710_mean, CARBON_P_201711_mean, CARBON_P_201712_mean)
CARBON_2018 <- data.frame(CARBON_P_201801_mean, CARBON_P_201802_mean, CARBON_P_201803_mean, CARBON_P_201804_mean, 
                          CARBON_P_201805_mean, CARBON_P_201806_mean, CARBON_P_201807_mean, CARBON_P_201808_mean, 
                          CARBON_P_201809_mean)

#DAVIS
DAVIS_2000 <- data.frame(DAVIS_P_200001_mean, DAVIS_P_200002_mean, DAVIS_P_200003_mean, DAVIS_P_200004_mean, 
                         DAVIS_P_200005_mean, DAVIS_P_200006_mean, DAVIS_P_200007_mean, DAVIS_P_200008_mean, 
                         DAVIS_P_200009_mean, DAVIS_P_200010_mean, DAVIS_P_200011_mean, DAVIS_P_200012_mean)
DAVIS_2001 <- data.frame(DAVIS_P_200101_mean, DAVIS_P_200102_mean, DAVIS_P_200103_mean, DAVIS_P_200104_mean, 
                         DAVIS_P_200105_mean, DAVIS_P_200106_mean, DAVIS_P_200107_mean, DAVIS_P_200108_mean, 
                         DAVIS_P_200109_mean, DAVIS_P_200110_mean, DAVIS_P_200111_mean, DAVIS_P_200112_mean)
DAVIS_2002 <- data.frame(DAVIS_P_200201_mean, DAVIS_P_200202_mean, DAVIS_P_200203_mean, DAVIS_P_200204_mean, 
                         DAVIS_P_200205_mean, DAVIS_P_200206_mean, DAVIS_P_200207_mean, DAVIS_P_200208_mean, 
                         DAVIS_P_200209_mean, DAVIS_P_200210_mean, DAVIS_P_200211_mean, DAVIS_P_200212_mean)
DAVIS_2003 <- data.frame(DAVIS_P_200301_mean, DAVIS_P_200302_mean, DAVIS_P_200303_mean, DAVIS_P_200304_mean, 
                         DAVIS_P_200305_mean, DAVIS_P_200306_mean, DAVIS_P_200307_mean, DAVIS_P_200308_mean, 
                         DAVIS_P_200309_mean, DAVIS_P_200310_mean, DAVIS_P_200311_mean, DAVIS_P_200312_mean)
DAVIS_2004 <- data.frame(DAVIS_P_200401_mean, DAVIS_P_200402_mean, DAVIS_P_200403_mean, DAVIS_P_200404_mean, 
                         DAVIS_P_200405_mean, DAVIS_P_200406_mean, DAVIS_P_200407_mean, DAVIS_P_200408_mean, 
                         DAVIS_P_200409_mean, DAVIS_P_200410_mean, DAVIS_P_200411_mean, DAVIS_P_200412_mean)
DAVIS_2005 <- data.frame(DAVIS_P_200501_mean, DAVIS_P_200502_mean, DAVIS_P_200503_mean, DAVIS_P_200504_mean, 
                         DAVIS_P_200505_mean, DAVIS_P_200506_mean, DAVIS_P_200507_mean, DAVIS_P_200508_mean, 
                         DAVIS_P_200509_mean, DAVIS_P_200510_mean, DAVIS_P_200511_mean, DAVIS_P_200512_mean)
DAVIS_2006 <- data.frame(DAVIS_P_200601_mean, DAVIS_P_200602_mean, DAVIS_P_200603_mean, DAVIS_P_200604_mean, 
                         DAVIS_P_200605_mean, DAVIS_P_200606_mean, DAVIS_P_200607_mean, DAVIS_P_200608_mean, 
                         DAVIS_P_200609_mean, DAVIS_P_200610_mean, DAVIS_P_200611_mean, DAVIS_P_200612_mean)
DAVIS_2007 <- data.frame(DAVIS_P_200701_mean, DAVIS_P_200702_mean, DAVIS_P_200703_mean, DAVIS_P_200704_mean, 
                         DAVIS_P_200705_mean, DAVIS_P_200706_mean, DAVIS_P_200707_mean, DAVIS_P_200708_mean, 
                         DAVIS_P_200709_mean, DAVIS_P_200710_mean, DAVIS_P_200711_mean, DAVIS_P_200712_mean)
DAVIS_2008 <- data.frame(DAVIS_P_200801_mean, DAVIS_P_200802_mean, DAVIS_P_200803_mean, DAVIS_P_200804_mean, 
                         DAVIS_P_200805_mean, DAVIS_P_200806_mean, DAVIS_P_200807_mean, DAVIS_P_200808_mean, 
                         DAVIS_P_200809_mean, DAVIS_P_200810_mean, DAVIS_P_200811_mean, DAVIS_P_200812_mean)
DAVIS_2009 <- data.frame(DAVIS_P_200901_mean, DAVIS_P_200902_mean, DAVIS_P_200903_mean, DAVIS_P_200904_mean, 
                         DAVIS_P_200905_mean, DAVIS_P_200906_mean, DAVIS_P_200907_mean, DAVIS_P_200908_mean, 
                         DAVIS_P_200909_mean, DAVIS_P_200910_mean, DAVIS_P_200911_mean, DAVIS_P_200912_mean)
DAVIS_2010 <- data.frame(DAVIS_P_201001_mean, DAVIS_P_201002_mean, DAVIS_P_201003_mean, DAVIS_P_201004_mean, 
                         DAVIS_P_201005_mean, DAVIS_P_201006_mean, DAVIS_P_201007_mean, DAVIS_P_201008_mean, 
                         DAVIS_P_201009_mean, DAVIS_P_201010_mean, DAVIS_P_201011_mean, DAVIS_P_201012_mean)
DAVIS_2011 <- data.frame(DAVIS_P_201101_mean, DAVIS_P_201102_mean, DAVIS_P_201103_mean, DAVIS_P_201104_mean, 
                         DAVIS_P_201105_mean, DAVIS_P_201106_mean, DAVIS_P_201107_mean, DAVIS_P_201108_mean, 
                         DAVIS_P_201109_mean, DAVIS_P_201110_mean, DAVIS_P_201111_mean, DAVIS_P_201112_mean)
DAVIS_2012 <- data.frame(DAVIS_P_201201_mean, DAVIS_P_201202_mean, DAVIS_P_201203_mean, DAVIS_P_201204_mean, 
                         DAVIS_P_201205_mean, DAVIS_P_201206_mean, DAVIS_P_201207_mean, DAVIS_P_201208_mean, 
                         DAVIS_P_201209_mean, DAVIS_P_201210_mean, DAVIS_P_201211_mean, DAVIS_P_201212_mean)
DAVIS_2013 <- data.frame(DAVIS_P_201301_mean, DAVIS_P_201302_mean, DAVIS_P_201303_mean, DAVIS_P_201304_mean, 
                         DAVIS_P_201305_mean, DAVIS_P_201306_mean, DAVIS_P_201307_mean, DAVIS_P_201308_mean, 
                         DAVIS_P_201309_mean, DAVIS_P_201310_mean, DAVIS_P_201311_mean, DAVIS_P_201312_mean)
DAVIS_2014 <- data.frame(DAVIS_P_201401_mean, DAVIS_P_201402_mean, DAVIS_P_201403_mean, DAVIS_P_201404_mean, 
                         DAVIS_P_201405_mean, DAVIS_P_201406_mean, DAVIS_P_201407_mean, DAVIS_P_201408_mean, 
                         DAVIS_P_201409_mean, DAVIS_P_201410_mean, DAVIS_P_201411_mean, DAVIS_P_201412_mean)
DAVIS_2015 <- data.frame(DAVIS_P_201501_mean, DAVIS_P_201502_mean, DAVIS_P_201503_mean, DAVIS_P_201504_mean, 
                         DAVIS_P_201505_mean, DAVIS_P_201506_mean, DAVIS_P_201507_mean, DAVIS_P_201508_mean, 
                         DAVIS_P_201509_mean, DAVIS_P_201510_mean, DAVIS_P_201511_mean, DAVIS_P_201512_mean)
DAVIS_2016 <- data.frame(DAVIS_P_201601_mean, DAVIS_P_201602_mean, DAVIS_P_201603_mean, DAVIS_P_201604_mean, 
                         DAVIS_P_201605_mean, DAVIS_P_201606_mean, DAVIS_P_201607_mean, DAVIS_P_201608_mean, 
                         DAVIS_P_201609_mean, DAVIS_P_201610_mean, DAVIS_P_201611_mean, DAVIS_P_201612_mean)
DAVIS_2017 <- data.frame(DAVIS_P_201701_mean, DAVIS_P_201702_mean, DAVIS_P_201703_mean, DAVIS_P_201704_mean, 
                         DAVIS_P_201705_mean, DAVIS_P_201706_mean, DAVIS_P_201707_mean, DAVIS_P_201708_mean, 
                         DAVIS_P_201709_mean, DAVIS_P_201710_mean, DAVIS_P_201711_mean, DAVIS_P_201712_mean)
DAVIS_2018 <- data.frame(DAVIS_P_201801_mean, DAVIS_P_201802_mean, DAVIS_P_201803_mean, DAVIS_P_201804_mean, 
                         DAVIS_P_201805_mean, DAVIS_P_201806_mean, DAVIS_P_201807_mean, DAVIS_P_201808_mean, 
                         DAVIS_P_201809_mean)

#DAGGETT
DAGGETT_2000 <- data.frame(DAGGETT_P_200001_mean, DAGGETT_P_200002_mean, DAGGETT_P_200003_mean, DAGGETT_P_200004_mean, 
                           DAGGETT_P_200005_mean, DAGGETT_P_200006_mean, DAGGETT_P_200007_mean, DAGGETT_P_200008_mean, 
                           DAGGETT_P_200009_mean, DAGGETT_P_200010_mean, DAGGETT_P_200011_mean, DAGGETT_P_200012_mean)
DAGGETT_2001 <- data.frame(DAGGETT_P_200101_mean, DAGGETT_P_200102_mean, DAGGETT_P_200103_mean, DAGGETT_P_200104_mean, 
                           DAGGETT_P_200105_mean, DAGGETT_P_200106_mean, DAGGETT_P_200107_mean, DAGGETT_P_200108_mean, 
                           DAGGETT_P_200109_mean, DAGGETT_P_200110_mean, DAGGETT_P_200111_mean, DAGGETT_P_200112_mean)
DAGGETT_2002 <- data.frame(DAGGETT_P_200201_mean, DAGGETT_P_200202_mean, DAGGETT_P_200203_mean, DAGGETT_P_200204_mean, 
                           DAGGETT_P_200205_mean, DAGGETT_P_200206_mean, DAGGETT_P_200207_mean, DAGGETT_P_200208_mean, 
                           DAGGETT_P_200209_mean, DAGGETT_P_200210_mean, DAGGETT_P_200211_mean, DAGGETT_P_200212_mean)
DAGGETT_2003 <- data.frame(DAGGETT_P_200301_mean, DAGGETT_P_200302_mean, DAGGETT_P_200303_mean, DAGGETT_P_200304_mean, 
                           DAGGETT_P_200305_mean, DAGGETT_P_200306_mean, DAGGETT_P_200307_mean, DAGGETT_P_200308_mean, 
                           DAGGETT_P_200309_mean, DAGGETT_P_200310_mean, DAGGETT_P_200311_mean, DAGGETT_P_200312_mean)
DAGGETT_2004 <- data.frame(DAGGETT_P_200401_mean, DAGGETT_P_200402_mean, DAGGETT_P_200403_mean, DAGGETT_P_200404_mean, 
                           DAGGETT_P_200405_mean, DAGGETT_P_200406_mean, DAGGETT_P_200407_mean, DAGGETT_P_200408_mean, 
                           DAGGETT_P_200409_mean, DAGGETT_P_200410_mean, DAGGETT_P_200411_mean, DAGGETT_P_200412_mean)
DAGGETT_2005 <- data.frame(DAGGETT_P_200501_mean, DAGGETT_P_200502_mean, DAGGETT_P_200503_mean, DAGGETT_P_200504_mean, 
                           DAGGETT_P_200505_mean, DAGGETT_P_200506_mean, DAGGETT_P_200507_mean, DAGGETT_P_200508_mean, 
                           DAGGETT_P_200509_mean, DAGGETT_P_200510_mean, DAGGETT_P_200511_mean, DAGGETT_P_200512_mean)
DAGGETT_2006 <- data.frame(DAGGETT_P_200601_mean, DAGGETT_P_200602_mean, DAGGETT_P_200603_mean, DAGGETT_P_200604_mean, 
                           DAGGETT_P_200605_mean, DAGGETT_P_200606_mean, DAGGETT_P_200607_mean, DAGGETT_P_200608_mean, 
                           DAGGETT_P_200609_mean, DAGGETT_P_200610_mean, DAGGETT_P_200611_mean, DAGGETT_P_200612_mean)
DAGGETT_2007 <- data.frame(DAGGETT_P_200701_mean, DAGGETT_P_200702_mean, DAGGETT_P_200703_mean, DAGGETT_P_200704_mean, 
                           DAGGETT_P_200705_mean, DAGGETT_P_200706_mean, DAGGETT_P_200707_mean, DAGGETT_P_200708_mean, 
                           DAGGETT_P_200709_mean, DAGGETT_P_200710_mean, DAGGETT_P_200711_mean, DAGGETT_P_200712_mean)
DAGGETT_2008 <- data.frame(DAGGETT_P_200801_mean, DAGGETT_P_200802_mean, DAGGETT_P_200803_mean, DAGGETT_P_200804_mean, 
                           DAGGETT_P_200805_mean, DAGGETT_P_200806_mean, DAGGETT_P_200807_mean, DAGGETT_P_200808_mean, 
                           DAGGETT_P_200809_mean, DAGGETT_P_200810_mean, DAGGETT_P_200811_mean, DAGGETT_P_200812_mean)
DAGGETT_2009 <- data.frame(DAGGETT_P_200901_mean, DAGGETT_P_200902_mean, DAGGETT_P_200903_mean, DAGGETT_P_200904_mean, 
                           DAGGETT_P_200905_mean, DAGGETT_P_200906_mean, DAGGETT_P_200907_mean, DAGGETT_P_200908_mean, 
                           DAGGETT_P_200909_mean, DAGGETT_P_200910_mean, DAGGETT_P_200911_mean, DAGGETT_P_200912_mean)
DAGGETT_2010 <- data.frame(DAGGETT_P_201001_mean, DAGGETT_P_201002_mean, DAGGETT_P_201003_mean, DAGGETT_P_201004_mean, 
                           DAGGETT_P_201005_mean, DAGGETT_P_201006_mean, DAGGETT_P_201007_mean, DAGGETT_P_201008_mean, 
                           DAGGETT_P_201009_mean, DAGGETT_P_201010_mean, DAGGETT_P_201011_mean, DAGGETT_P_201012_mean)
DAGGETT_2011 <- data.frame(DAGGETT_P_201101_mean, DAGGETT_P_201102_mean, DAGGETT_P_201103_mean, DAGGETT_P_201104_mean, 
                           DAGGETT_P_201105_mean, DAGGETT_P_201106_mean, DAGGETT_P_201107_mean, DAGGETT_P_201108_mean, 
                           DAGGETT_P_201109_mean, DAGGETT_P_201110_mean, DAGGETT_P_201111_mean, DAGGETT_P_201112_mean)
DAGGETT_2012 <- data.frame(DAGGETT_P_201201_mean, DAGGETT_P_201202_mean, DAGGETT_P_201203_mean, DAGGETT_P_201204_mean, 
                           DAGGETT_P_201205_mean, DAGGETT_P_201206_mean, DAGGETT_P_201207_mean, DAGGETT_P_201208_mean, 
                           DAGGETT_P_201209_mean, DAGGETT_P_201210_mean, DAGGETT_P_201211_mean, DAGGETT_P_201212_mean)
DAGGETT_2013 <- data.frame(DAGGETT_P_201301_mean, DAGGETT_P_201302_mean, DAGGETT_P_201303_mean, DAGGETT_P_201304_mean, 
                           DAGGETT_P_201305_mean, DAGGETT_P_201306_mean, DAGGETT_P_201307_mean, DAGGETT_P_201308_mean, 
                           DAGGETT_P_201309_mean, DAGGETT_P_201310_mean, DAGGETT_P_201311_mean, DAGGETT_P_201312_mean)
DAGGETT_2014 <- data.frame(DAGGETT_P_201401_mean, DAGGETT_P_201402_mean, DAGGETT_P_201403_mean, DAGGETT_P_201404_mean, 
                           DAGGETT_P_201405_mean, DAGGETT_P_201406_mean, DAGGETT_P_201407_mean, DAGGETT_P_201408_mean, 
                           DAGGETT_P_201409_mean, DAGGETT_P_201410_mean, DAGGETT_P_201411_mean, DAGGETT_P_201412_mean)
DAGGETT_2015 <- data.frame(DAGGETT_P_201501_mean, DAGGETT_P_201502_mean, DAGGETT_P_201503_mean, DAGGETT_P_201504_mean, 
                           DAGGETT_P_201505_mean, DAGGETT_P_201506_mean, DAGGETT_P_201507_mean, DAGGETT_P_201508_mean, 
                           DAGGETT_P_201509_mean, DAGGETT_P_201510_mean, DAGGETT_P_201511_mean, DAGGETT_P_201512_mean)
DAGGETT_2016 <- data.frame(DAGGETT_P_201601_mean, DAGGETT_P_201602_mean, DAGGETT_P_201603_mean, DAGGETT_P_201604_mean, 
                           DAGGETT_P_201605_mean, DAGGETT_P_201606_mean, DAGGETT_P_201607_mean, DAGGETT_P_201608_mean, 
                           DAGGETT_P_201609_mean, DAGGETT_P_201610_mean, DAGGETT_P_201611_mean, DAGGETT_P_201612_mean)
DAGGETT_2017 <- data.frame(DAGGETT_P_201701_mean, DAGGETT_P_201702_mean, DAGGETT_P_201703_mean, DAGGETT_P_201704_mean, 
                           DAGGETT_P_201705_mean, DAGGETT_P_201706_mean, DAGGETT_P_201707_mean, DAGGETT_P_201708_mean, 
                           DAGGETT_P_201709_mean, DAGGETT_P_201710_mean, DAGGETT_P_201711_mean, DAGGETT_P_201712_mean)
DAGGETT_2018 <- data.frame(DAGGETT_P_201801_mean, DAGGETT_P_201802_mean, DAGGETT_P_201803_mean, DAGGETT_P_201804_mean, 
                           DAGGETT_P_201805_mean, DAGGETT_P_201806_mean, DAGGETT_P_201807_mean, DAGGETT_P_201808_mean, 
                           DAGGETT_P_201809_mean)


#DUCHESNE
DUCHESNE_2000 <- data.frame(DUCHESNE_P_200001_mean, DUCHESNE_P_200002_mean, DUCHESNE_P_200003_mean, DUCHESNE_P_200004_mean, 
                            DUCHESNE_P_200005_mean, DUCHESNE_P_200006_mean, DUCHESNE_P_200007_mean, DUCHESNE_P_200008_mean, 
                            DUCHESNE_P_200009_mean, DUCHESNE_P_200010_mean, DUCHESNE_P_200011_mean, DUCHESNE_P_200012_mean)
DUCHESNE_2001 <- data.frame(DUCHESNE_P_200101_mean, DUCHESNE_P_200102_mean, DUCHESNE_P_200103_mean, DUCHESNE_P_200104_mean, 
                            DUCHESNE_P_200105_mean, DUCHESNE_P_200106_mean, DUCHESNE_P_200107_mean, DUCHESNE_P_200108_mean, 
                            DUCHESNE_P_200109_mean, DUCHESNE_P_200110_mean, DUCHESNE_P_200111_mean, DUCHESNE_P_200112_mean)
DUCHESNE_2002 <- data.frame(DUCHESNE_P_200201_mean, DUCHESNE_P_200202_mean, DUCHESNE_P_200203_mean, DUCHESNE_P_200204_mean, 
                            DUCHESNE_P_200205_mean, DUCHESNE_P_200206_mean, DUCHESNE_P_200207_mean, DUCHESNE_P_200208_mean, 
                            DUCHESNE_P_200209_mean, DUCHESNE_P_200210_mean, DUCHESNE_P_200211_mean, DUCHESNE_P_200212_mean)
DUCHESNE_2003 <- data.frame(DUCHESNE_P_200301_mean, DUCHESNE_P_200302_mean, DUCHESNE_P_200303_mean, DUCHESNE_P_200304_mean, 
                            DUCHESNE_P_200305_mean, DUCHESNE_P_200306_mean, DUCHESNE_P_200307_mean, DUCHESNE_P_200308_mean, 
                            DUCHESNE_P_200309_mean, DUCHESNE_P_200310_mean, DUCHESNE_P_200311_mean, DUCHESNE_P_200312_mean)
DUCHESNE_2004 <- data.frame(DUCHESNE_P_200401_mean, DUCHESNE_P_200402_mean, DUCHESNE_P_200403_mean, DUCHESNE_P_200404_mean, 
                            DUCHESNE_P_200405_mean, DUCHESNE_P_200406_mean, DUCHESNE_P_200407_mean, DUCHESNE_P_200408_mean, 
                            DUCHESNE_P_200409_mean, DUCHESNE_P_200410_mean, DUCHESNE_P_200411_mean, DUCHESNE_P_200412_mean)
DUCHESNE_2005 <- data.frame(DUCHESNE_P_200501_mean, DUCHESNE_P_200502_mean, DUCHESNE_P_200503_mean, DUCHESNE_P_200504_mean, 
                            DUCHESNE_P_200505_mean, DUCHESNE_P_200506_mean, DUCHESNE_P_200507_mean, DUCHESNE_P_200508_mean, 
                            DUCHESNE_P_200509_mean, DUCHESNE_P_200510_mean, DUCHESNE_P_200511_mean, DUCHESNE_P_200512_mean)
DUCHESNE_2006 <- data.frame(DUCHESNE_P_200601_mean, DUCHESNE_P_200602_mean, DUCHESNE_P_200603_mean, DUCHESNE_P_200604_mean, 
                            DUCHESNE_P_200605_mean, DUCHESNE_P_200606_mean, DUCHESNE_P_200607_mean, DUCHESNE_P_200608_mean, 
                            DUCHESNE_P_200609_mean, DUCHESNE_P_200610_mean, DUCHESNE_P_200611_mean, DUCHESNE_P_200612_mean)
DUCHESNE_2007 <- data.frame(DUCHESNE_P_200701_mean, DUCHESNE_P_200702_mean, DUCHESNE_P_200703_mean, DUCHESNE_P_200704_mean, 
                            DUCHESNE_P_200705_mean, DUCHESNE_P_200706_mean, DUCHESNE_P_200707_mean, DUCHESNE_P_200708_mean, 
                            DUCHESNE_P_200709_mean, DUCHESNE_P_200710_mean, DUCHESNE_P_200711_mean, DUCHESNE_P_200712_mean)
DUCHESNE_2008 <- data.frame(DUCHESNE_P_200801_mean, DUCHESNE_P_200802_mean, DUCHESNE_P_200803_mean, DUCHESNE_P_200804_mean, 
                            DUCHESNE_P_200805_mean, DUCHESNE_P_200806_mean, DUCHESNE_P_200807_mean, DUCHESNE_P_200808_mean, 
                            DUCHESNE_P_200809_mean, DUCHESNE_P_200810_mean, DUCHESNE_P_200811_mean, DUCHESNE_P_200812_mean)
DUCHESNE_2009 <- data.frame(DUCHESNE_P_200901_mean, DUCHESNE_P_200902_mean, DUCHESNE_P_200903_mean, DUCHESNE_P_200904_mean, 
                            DUCHESNE_P_200905_mean, DUCHESNE_P_200906_mean, DUCHESNE_P_200907_mean, DUCHESNE_P_200908_mean, 
                            DUCHESNE_P_200909_mean, DUCHESNE_P_200910_mean, DUCHESNE_P_200911_mean, DUCHESNE_P_200912_mean)
DUCHESNE_2010 <- data.frame(DUCHESNE_P_201001_mean, DUCHESNE_P_201002_mean, DUCHESNE_P_201003_mean, DUCHESNE_P_201004_mean, 
                            DUCHESNE_P_201005_mean, DUCHESNE_P_201006_mean, DUCHESNE_P_201007_mean, DUCHESNE_P_201008_mean, 
                            DUCHESNE_P_201009_mean, DUCHESNE_P_201010_mean, DUCHESNE_P_201011_mean, DUCHESNE_P_201012_mean)
DUCHESNE_2011 <- data.frame(DUCHESNE_P_201101_mean, DUCHESNE_P_201102_mean, DUCHESNE_P_201103_mean, DUCHESNE_P_201104_mean, 
                            DUCHESNE_P_201105_mean, DUCHESNE_P_201106_mean, DUCHESNE_P_201107_mean, DUCHESNE_P_201108_mean, 
                            DUCHESNE_P_201109_mean, DUCHESNE_P_201110_mean, DUCHESNE_P_201111_mean, DUCHESNE_P_201112_mean)
DUCHESNE_2012 <- data.frame(DUCHESNE_P_201201_mean, DUCHESNE_P_201202_mean, DUCHESNE_P_201203_mean, DUCHESNE_P_201204_mean, 
                            DUCHESNE_P_201205_mean, DUCHESNE_P_201206_mean, DUCHESNE_P_201207_mean, DUCHESNE_P_201208_mean, 
                            DUCHESNE_P_201209_mean, DUCHESNE_P_201210_mean, DUCHESNE_P_201211_mean, DUCHESNE_P_201212_mean)
DUCHESNE_2013 <- data.frame(DUCHESNE_P_201301_mean, DUCHESNE_P_201302_mean, DUCHESNE_P_201303_mean, DUCHESNE_P_201304_mean, 
                            DUCHESNE_P_201305_mean, DUCHESNE_P_201306_mean, DUCHESNE_P_201307_mean, DUCHESNE_P_201308_mean, 
                            DUCHESNE_P_201309_mean, DUCHESNE_P_201310_mean, DUCHESNE_P_201311_mean, DUCHESNE_P_201312_mean)
DUCHESNE_2014 <- data.frame(DUCHESNE_P_201401_mean, DUCHESNE_P_201402_mean, DUCHESNE_P_201403_mean, DUCHESNE_P_201404_mean, 
                            DUCHESNE_P_201405_mean, DUCHESNE_P_201406_mean, DUCHESNE_P_201407_mean, DUCHESNE_P_201408_mean, 
                            DUCHESNE_P_201409_mean, DUCHESNE_P_201410_mean, DUCHESNE_P_201411_mean, DUCHESNE_P_201412_mean)
DUCHESNE_2015 <- data.frame(DUCHESNE_P_201501_mean, DUCHESNE_P_201502_mean, DUCHESNE_P_201503_mean, DUCHESNE_P_201504_mean, 
                            DUCHESNE_P_201505_mean, DUCHESNE_P_201506_mean, DUCHESNE_P_201507_mean, DUCHESNE_P_201508_mean, 
                            DUCHESNE_P_201509_mean, DUCHESNE_P_201510_mean, DUCHESNE_P_201511_mean, DUCHESNE_P_201512_mean)
DUCHESNE_2016 <- data.frame(DUCHESNE_P_201601_mean, DUCHESNE_P_201602_mean, DUCHESNE_P_201603_mean, DUCHESNE_P_201604_mean, 
                            DUCHESNE_P_201605_mean, DUCHESNE_P_201606_mean, DUCHESNE_P_201607_mean, DUCHESNE_P_201608_mean, 
                            DUCHESNE_P_201609_mean, DUCHESNE_P_201610_mean, DUCHESNE_P_201611_mean, DUCHESNE_P_201612_mean)
DUCHESNE_2017 <- data.frame(DUCHESNE_P_201701_mean, DUCHESNE_P_201702_mean, DUCHESNE_P_201703_mean, DUCHESNE_P_201704_mean, 
                            DUCHESNE_P_201705_mean, DUCHESNE_P_201706_mean, DUCHESNE_P_201707_mean, DUCHESNE_P_201708_mean, 
                            DUCHESNE_P_201709_mean, DUCHESNE_P_201710_mean, DUCHESNE_P_201711_mean, DUCHESNE_P_201712_mean)
DUCHESNE_2018 <- data.frame(DUCHESNE_P_201801_mean, DUCHESNE_P_201802_mean, DUCHESNE_P_201803_mean, DUCHESNE_P_201804_mean, 
                            DUCHESNE_P_201805_mean, DUCHESNE_P_201806_mean, DUCHESNE_P_201807_mean, DUCHESNE_P_201808_mean, 
                            DUCHESNE_P_201809_mean)


#EMERY
EMERY_2000 <- data.frame(EMERY_P_200001_mean, EMERY_P_200002_mean, EMERY_P_200003_mean, EMERY_P_200004_mean, 
                         EMERY_P_200005_mean, EMERY_P_200006_mean, EMERY_P_200007_mean, EMERY_P_200008_mean, 
                         EMERY_P_200009_mean, EMERY_P_200010_mean, EMERY_P_200011_mean, EMERY_P_200012_mean)
EMERY_2001 <- data.frame(EMERY_P_200101_mean, EMERY_P_200102_mean, EMERY_P_200103_mean, EMERY_P_200104_mean, 
                         EMERY_P_200105_mean, EMERY_P_200106_mean, EMERY_P_200107_mean, EMERY_P_200108_mean, 
                         EMERY_P_200109_mean, EMERY_P_200110_mean, EMERY_P_200111_mean, EMERY_P_200112_mean)
EMERY_2002 <- data.frame(EMERY_P_200201_mean, EMERY_P_200202_mean, EMERY_P_200203_mean, EMERY_P_200204_mean, 
                         EMERY_P_200205_mean, EMERY_P_200206_mean, EMERY_P_200207_mean, EMERY_P_200208_mean, 
                         EMERY_P_200209_mean, EMERY_P_200210_mean, EMERY_P_200211_mean, EMERY_P_200212_mean)
EMERY_2003 <- data.frame(EMERY_P_200301_mean, EMERY_P_200302_mean, EMERY_P_200303_mean, EMERY_P_200304_mean, 
                         EMERY_P_200305_mean, EMERY_P_200306_mean, EMERY_P_200307_mean, EMERY_P_200308_mean, 
                         EMERY_P_200309_mean, EMERY_P_200310_mean, EMERY_P_200311_mean, EMERY_P_200312_mean)
EMERY_2004 <- data.frame(EMERY_P_200401_mean, EMERY_P_200402_mean, EMERY_P_200403_mean, EMERY_P_200404_mean, 
                         EMERY_P_200405_mean, EMERY_P_200406_mean, EMERY_P_200407_mean, EMERY_P_200408_mean, 
                         EMERY_P_200409_mean, EMERY_P_200410_mean, EMERY_P_200411_mean, EMERY_P_200412_mean)
EMERY_2005 <- data.frame(EMERY_P_200501_mean, EMERY_P_200502_mean, EMERY_P_200503_mean, EMERY_P_200504_mean, 
                         EMERY_P_200505_mean, EMERY_P_200506_mean, EMERY_P_200507_mean, EMERY_P_200508_mean, 
                         EMERY_P_200509_mean, EMERY_P_200510_mean, EMERY_P_200511_mean, EMERY_P_200512_mean)
EMERY_2006 <- data.frame(EMERY_P_200601_mean, EMERY_P_200602_mean, EMERY_P_200603_mean, EMERY_P_200604_mean, 
                         EMERY_P_200605_mean, EMERY_P_200606_mean, EMERY_P_200607_mean, EMERY_P_200608_mean, 
                         EMERY_P_200609_mean, EMERY_P_200610_mean, EMERY_P_200611_mean, EMERY_P_200612_mean)
EMERY_2007 <- data.frame(EMERY_P_200701_mean, EMERY_P_200702_mean, EMERY_P_200703_mean, EMERY_P_200704_mean, 
                         EMERY_P_200705_mean, EMERY_P_200706_mean, EMERY_P_200707_mean, EMERY_P_200708_mean, 
                         EMERY_P_200709_mean, EMERY_P_200710_mean, EMERY_P_200711_mean, EMERY_P_200712_mean)
EMERY_2008 <- data.frame(EMERY_P_200801_mean, EMERY_P_200802_mean, EMERY_P_200803_mean, EMERY_P_200804_mean, 
                         EMERY_P_200805_mean, EMERY_P_200806_mean, EMERY_P_200807_mean, EMERY_P_200808_mean, 
                         EMERY_P_200809_mean, EMERY_P_200810_mean, EMERY_P_200811_mean, EMERY_P_200812_mean)
EMERY_2009 <- data.frame(EMERY_P_200901_mean, EMERY_P_200902_mean, EMERY_P_200903_mean, EMERY_P_200904_mean, 
                         EMERY_P_200905_mean, EMERY_P_200906_mean, EMERY_P_200907_mean, EMERY_P_200908_mean, 
                         EMERY_P_200909_mean, EMERY_P_200910_mean, EMERY_P_200911_mean, EMERY_P_200912_mean)
EMERY_2010 <- data.frame(EMERY_P_201001_mean, EMERY_P_201002_mean, EMERY_P_201003_mean, EMERY_P_201004_mean, 
                         EMERY_P_201005_mean, EMERY_P_201006_mean, EMERY_P_201007_mean, EMERY_P_201008_mean, 
                         EMERY_P_201009_mean, EMERY_P_201010_mean, EMERY_P_201011_mean, EMERY_P_201012_mean)
EMERY_2011 <- data.frame(EMERY_P_201101_mean, EMERY_P_201102_mean, EMERY_P_201103_mean, EMERY_P_201104_mean, 
                         EMERY_P_201105_mean, EMERY_P_201106_mean, EMERY_P_201107_mean, EMERY_P_201108_mean, 
                         EMERY_P_201109_mean, EMERY_P_201110_mean, EMERY_P_201111_mean, EMERY_P_201112_mean)
EMERY_2012 <- data.frame(EMERY_P_201201_mean, EMERY_P_201202_mean, EMERY_P_201203_mean, EMERY_P_201204_mean, 
                         EMERY_P_201205_mean, EMERY_P_201206_mean, EMERY_P_201207_mean, EMERY_P_201208_mean, 
                         EMERY_P_201209_mean, EMERY_P_201210_mean, EMERY_P_201211_mean, EMERY_P_201212_mean)
EMERY_2013 <- data.frame(EMERY_P_201301_mean, EMERY_P_201302_mean, EMERY_P_201303_mean, EMERY_P_201304_mean, 
                         EMERY_P_201305_mean, EMERY_P_201306_mean, EMERY_P_201307_mean, EMERY_P_201308_mean, 
                         EMERY_P_201309_mean, EMERY_P_201310_mean, EMERY_P_201311_mean, EMERY_P_201312_mean)
EMERY_2014 <- data.frame(EMERY_P_201401_mean, EMERY_P_201402_mean, EMERY_P_201403_mean, EMERY_P_201404_mean, 
                         EMERY_P_201405_mean, EMERY_P_201406_mean, EMERY_P_201407_mean, EMERY_P_201408_mean, 
                         EMERY_P_201409_mean, EMERY_P_201410_mean, EMERY_P_201411_mean, EMERY_P_201412_mean)
EMERY_2015 <- data.frame(EMERY_P_201501_mean, EMERY_P_201502_mean, EMERY_P_201503_mean, EMERY_P_201504_mean, 
                         EMERY_P_201505_mean, EMERY_P_201506_mean, EMERY_P_201507_mean, EMERY_P_201508_mean, 
                         EMERY_P_201509_mean, EMERY_P_201510_mean, EMERY_P_201511_mean, EMERY_P_201512_mean)
EMERY_2016 <- data.frame(EMERY_P_201601_mean, EMERY_P_201602_mean, EMERY_P_201603_mean, EMERY_P_201604_mean, 
                         EMERY_P_201605_mean, EMERY_P_201606_mean, EMERY_P_201607_mean, EMERY_P_201608_mean, 
                         EMERY_P_201609_mean, EMERY_P_201610_mean, EMERY_P_201611_mean, EMERY_P_201612_mean)
EMERY_2017 <- data.frame(EMERY_P_201701_mean, EMERY_P_201702_mean, EMERY_P_201703_mean, EMERY_P_201704_mean, 
                         EMERY_P_201705_mean, EMERY_P_201706_mean, EMERY_P_201707_mean, EMERY_P_201708_mean, 
                         EMERY_P_201709_mean, EMERY_P_201710_mean, EMERY_P_201711_mean, EMERY_P_201712_mean)
EMERY_2018 <- data.frame(EMERY_P_201801_mean, EMERY_P_201802_mean, EMERY_P_201803_mean, EMERY_P_201804_mean, 
                         EMERY_P_201805_mean, EMERY_P_201806_mean, EMERY_P_201807_mean, EMERY_P_201808_mean, 
                         EMERY_P_201809_mean)


#GARFIELD
GARFIELD_2000 <- data.frame(GARFIELD_P_200001_mean, GARFIELD_P_200002_mean, GARFIELD_P_200003_mean, GARFIELD_P_200004_mean, 
                            GARFIELD_P_200005_mean, GARFIELD_P_200006_mean, GARFIELD_P_200007_mean, GARFIELD_P_200008_mean, 
                            GARFIELD_P_200009_mean, GARFIELD_P_200010_mean, GARFIELD_P_200011_mean, GARFIELD_P_200012_mean)
GARFIELD_2001 <- data.frame(GARFIELD_P_200101_mean, GARFIELD_P_200102_mean, GARFIELD_P_200103_mean, GARFIELD_P_200104_mean, 
                            GARFIELD_P_200105_mean, GARFIELD_P_200106_mean, GARFIELD_P_200107_mean, GARFIELD_P_200108_mean, 
                            GARFIELD_P_200109_mean, GARFIELD_P_200110_mean, GARFIELD_P_200111_mean, GARFIELD_P_200112_mean)
GARFIELD_2002 <- data.frame(GARFIELD_P_200201_mean, GARFIELD_P_200202_mean, GARFIELD_P_200203_mean, GARFIELD_P_200204_mean, 
                            GARFIELD_P_200205_mean, GARFIELD_P_200206_mean, GARFIELD_P_200207_mean, GARFIELD_P_200208_mean, 
                            GARFIELD_P_200209_mean, GARFIELD_P_200210_mean, GARFIELD_P_200211_mean, GARFIELD_P_200212_mean)
GARFIELD_2003 <- data.frame(GARFIELD_P_200301_mean, GARFIELD_P_200302_mean, GARFIELD_P_200303_mean, GARFIELD_P_200304_mean, 
                            GARFIELD_P_200305_mean, GARFIELD_P_200306_mean, GARFIELD_P_200307_mean, GARFIELD_P_200308_mean, 
                            GARFIELD_P_200309_mean, GARFIELD_P_200310_mean, GARFIELD_P_200311_mean, GARFIELD_P_200312_mean)
GARFIELD_2004 <- data.frame(GARFIELD_P_200401_mean, GARFIELD_P_200402_mean, GARFIELD_P_200403_mean, GARFIELD_P_200404_mean, 
                            GARFIELD_P_200405_mean, GARFIELD_P_200406_mean, GARFIELD_P_200407_mean, GARFIELD_P_200408_mean, 
                            GARFIELD_P_200409_mean, GARFIELD_P_200410_mean, GARFIELD_P_200411_mean, GARFIELD_P_200412_mean)
GARFIELD_2005 <- data.frame(GARFIELD_P_200501_mean, GARFIELD_P_200502_mean, GARFIELD_P_200503_mean, GARFIELD_P_200504_mean, 
                            GARFIELD_P_200505_mean, GARFIELD_P_200506_mean, GARFIELD_P_200507_mean, GARFIELD_P_200508_mean, 
                            GARFIELD_P_200509_mean, GARFIELD_P_200510_mean, GARFIELD_P_200511_mean, GARFIELD_P_200512_mean)
GARFIELD_2006 <- data.frame(GARFIELD_P_200601_mean, GARFIELD_P_200602_mean, GARFIELD_P_200603_mean, GARFIELD_P_200604_mean, 
                            GARFIELD_P_200605_mean, GARFIELD_P_200606_mean, GARFIELD_P_200607_mean, GARFIELD_P_200608_mean, 
                            GARFIELD_P_200609_mean, GARFIELD_P_200610_mean, GARFIELD_P_200611_mean, GARFIELD_P_200612_mean)
GARFIELD_2007 <- data.frame(GARFIELD_P_200701_mean, GARFIELD_P_200702_mean, GARFIELD_P_200703_mean, GARFIELD_P_200704_mean, 
                            GARFIELD_P_200705_mean, GARFIELD_P_200706_mean, GARFIELD_P_200707_mean, GARFIELD_P_200708_mean, 
                            GARFIELD_P_200709_mean, GARFIELD_P_200710_mean, GARFIELD_P_200711_mean, GARFIELD_P_200712_mean)
GARFIELD_2008 <- data.frame(GARFIELD_P_200801_mean, GARFIELD_P_200802_mean, GARFIELD_P_200803_mean, GARFIELD_P_200804_mean, 
                            GARFIELD_P_200805_mean, GARFIELD_P_200806_mean, GARFIELD_P_200807_mean, GARFIELD_P_200808_mean, 
                            GARFIELD_P_200809_mean, GARFIELD_P_200810_mean, GARFIELD_P_200811_mean, GARFIELD_P_200812_mean)
GARFIELD_2009 <- data.frame(GARFIELD_P_200901_mean, GARFIELD_P_200902_mean, GARFIELD_P_200903_mean, GARFIELD_P_200904_mean, 
                            GARFIELD_P_200905_mean, GARFIELD_P_200906_mean, GARFIELD_P_200907_mean, GARFIELD_P_200908_mean, 
                            GARFIELD_P_200909_mean, GARFIELD_P_200910_mean, GARFIELD_P_200911_mean, GARFIELD_P_200912_mean)
GARFIELD_2010 <- data.frame(GARFIELD_P_201001_mean, GARFIELD_P_201002_mean, GARFIELD_P_201003_mean, GARFIELD_P_201004_mean, 
                            GARFIELD_P_201005_mean, GARFIELD_P_201006_mean, GARFIELD_P_201007_mean, GARFIELD_P_201008_mean, 
                            GARFIELD_P_201009_mean, GARFIELD_P_201010_mean, GARFIELD_P_201011_mean, GARFIELD_P_201012_mean)
GARFIELD_2011 <- data.frame(GARFIELD_P_201101_mean, GARFIELD_P_201102_mean, GARFIELD_P_201103_mean, GARFIELD_P_201104_mean, 
                            GARFIELD_P_201105_mean, GARFIELD_P_201106_mean, GARFIELD_P_201107_mean, GARFIELD_P_201108_mean, 
                            GARFIELD_P_201109_mean, GARFIELD_P_201110_mean, GARFIELD_P_201111_mean, GARFIELD_P_201112_mean)
GARFIELD_2012 <- data.frame(GARFIELD_P_201201_mean, GARFIELD_P_201202_mean, GARFIELD_P_201203_mean, GARFIELD_P_201204_mean, 
                            GARFIELD_P_201205_mean, GARFIELD_P_201206_mean, GARFIELD_P_201207_mean, GARFIELD_P_201208_mean, 
                            GARFIELD_P_201209_mean, GARFIELD_P_201210_mean, GARFIELD_P_201211_mean, GARFIELD_P_201212_mean)
GARFIELD_2013 <- data.frame(GARFIELD_P_201301_mean, GARFIELD_P_201302_mean, GARFIELD_P_201303_mean, GARFIELD_P_201304_mean, 
                            GARFIELD_P_201305_mean, GARFIELD_P_201306_mean, GARFIELD_P_201307_mean, GARFIELD_P_201308_mean, 
                            GARFIELD_P_201309_mean, GARFIELD_P_201310_mean, GARFIELD_P_201311_mean, GARFIELD_P_201312_mean)
GARFIELD_2014 <- data.frame(GARFIELD_P_201401_mean, GARFIELD_P_201402_mean, GARFIELD_P_201403_mean, GARFIELD_P_201404_mean, 
                            GARFIELD_P_201405_mean, GARFIELD_P_201406_mean, GARFIELD_P_201407_mean, GARFIELD_P_201408_mean, 
                            GARFIELD_P_201409_mean, GARFIELD_P_201410_mean, GARFIELD_P_201411_mean, GARFIELD_P_201412_mean)
GARFIELD_2015 <- data.frame(GARFIELD_P_201501_mean, GARFIELD_P_201502_mean, GARFIELD_P_201503_mean, GARFIELD_P_201504_mean, 
                            GARFIELD_P_201505_mean, GARFIELD_P_201506_mean, GARFIELD_P_201507_mean, GARFIELD_P_201508_mean, 
                            GARFIELD_P_201509_mean, GARFIELD_P_201510_mean, GARFIELD_P_201511_mean, GARFIELD_P_201512_mean)
GARFIELD_2016 <- data.frame(GARFIELD_P_201601_mean, GARFIELD_P_201602_mean, GARFIELD_P_201603_mean, GARFIELD_P_201604_mean, 
                            GARFIELD_P_201605_mean, GARFIELD_P_201606_mean, GARFIELD_P_201607_mean, GARFIELD_P_201608_mean, 
                            GARFIELD_P_201609_mean, GARFIELD_P_201610_mean, GARFIELD_P_201611_mean, GARFIELD_P_201612_mean)
GARFIELD_2017 <- data.frame(GARFIELD_P_201701_mean, GARFIELD_P_201702_mean, GARFIELD_P_201703_mean, GARFIELD_P_201704_mean, 
                            GARFIELD_P_201705_mean, GARFIELD_P_201706_mean, GARFIELD_P_201707_mean, GARFIELD_P_201708_mean, 
                            GARFIELD_P_201709_mean, GARFIELD_P_201710_mean, GARFIELD_P_201711_mean, GARFIELD_P_201712_mean)
GARFIELD_2018 <- data.frame(GARFIELD_P_201801_mean, GARFIELD_P_201802_mean, GARFIELD_P_201803_mean, GARFIELD_P_201804_mean, 
                            GARFIELD_P_201805_mean, GARFIELD_P_201806_mean, GARFIELD_P_201807_mean, GARFIELD_P_201808_mean, 
                            GARFIELD_P_201809_mean)

#GRAND
GRAND_2000 <- data.frame(GRAND_P_200001_mean, GRAND_P_200002_mean, GRAND_P_200003_mean, GRAND_P_200004_mean, 
                         GRAND_P_200005_mean, GRAND_P_200006_mean, GRAND_P_200007_mean, GRAND_P_200008_mean, 
                         GRAND_P_200009_mean, GRAND_P_200010_mean, GRAND_P_200011_mean, GRAND_P_200012_mean)
GRAND_2001 <- data.frame(GRAND_P_200101_mean, GRAND_P_200102_mean, GRAND_P_200103_mean, GRAND_P_200104_mean, 
                         GRAND_P_200105_mean, GRAND_P_200106_mean, GRAND_P_200107_mean, GRAND_P_200108_mean, 
                         GRAND_P_200109_mean, GRAND_P_200110_mean, GRAND_P_200111_mean, GRAND_P_200112_mean)
GRAND_2002 <- data.frame(GRAND_P_200201_mean, GRAND_P_200202_mean, GRAND_P_200203_mean, GRAND_P_200204_mean, 
                         GRAND_P_200205_mean, GRAND_P_200206_mean, GRAND_P_200207_mean, GRAND_P_200208_mean, 
                         GRAND_P_200209_mean, GRAND_P_200210_mean, GRAND_P_200211_mean, GRAND_P_200212_mean)
GRAND_2003 <- data.frame(GRAND_P_200301_mean, GRAND_P_200302_mean, GRAND_P_200303_mean, GRAND_P_200304_mean, 
                         GRAND_P_200305_mean, GRAND_P_200306_mean, GRAND_P_200307_mean, GRAND_P_200308_mean, 
                         GRAND_P_200309_mean, GRAND_P_200310_mean, GRAND_P_200311_mean, GRAND_P_200312_mean)
GRAND_2004 <- data.frame(GRAND_P_200401_mean, GRAND_P_200402_mean, GRAND_P_200403_mean, GRAND_P_200404_mean, 
                         GRAND_P_200405_mean, GRAND_P_200406_mean, GRAND_P_200407_mean, GRAND_P_200408_mean, 
                         GRAND_P_200409_mean, GRAND_P_200410_mean, GRAND_P_200411_mean, GRAND_P_200412_mean)
GRAND_2005 <- data.frame(GRAND_P_200501_mean, GRAND_P_200502_mean, GRAND_P_200503_mean, GRAND_P_200504_mean, 
                         GRAND_P_200505_mean, GRAND_P_200506_mean, GRAND_P_200507_mean, GRAND_P_200508_mean, 
                         GRAND_P_200509_mean, GRAND_P_200510_mean, GRAND_P_200511_mean, GRAND_P_200512_mean)
GRAND_2006 <- data.frame(GRAND_P_200601_mean, GRAND_P_200602_mean, GRAND_P_200603_mean, GRAND_P_200604_mean, 
                         GRAND_P_200605_mean, GRAND_P_200606_mean, GRAND_P_200607_mean, GRAND_P_200608_mean, 
                         GRAND_P_200609_mean, GRAND_P_200610_mean, GRAND_P_200611_mean, GRAND_P_200612_mean)
GRAND_2007 <- data.frame(GRAND_P_200701_mean, GRAND_P_200702_mean, GRAND_P_200703_mean, GRAND_P_200704_mean, 
                         GRAND_P_200705_mean, GRAND_P_200706_mean, GRAND_P_200707_mean, GRAND_P_200708_mean, 
                         GRAND_P_200709_mean, GRAND_P_200710_mean, GRAND_P_200711_mean, GRAND_P_200712_mean)
GRAND_2008 <- data.frame(GRAND_P_200801_mean, GRAND_P_200802_mean, GRAND_P_200803_mean, GRAND_P_200804_mean, 
                         GRAND_P_200805_mean, GRAND_P_200806_mean, GRAND_P_200807_mean, GRAND_P_200808_mean, 
                         GRAND_P_200809_mean, GRAND_P_200810_mean, GRAND_P_200811_mean, GRAND_P_200812_mean)
GRAND_2009 <- data.frame(GRAND_P_200901_mean, GRAND_P_200902_mean, GRAND_P_200903_mean, GRAND_P_200904_mean, 
                         GRAND_P_200905_mean, GRAND_P_200906_mean, GRAND_P_200907_mean, GRAND_P_200908_mean, 
                         GRAND_P_200909_mean, GRAND_P_200910_mean, GRAND_P_200911_mean, GRAND_P_200912_mean)
GRAND_2010 <- data.frame(GRAND_P_201001_mean, GRAND_P_201002_mean, GRAND_P_201003_mean, GRAND_P_201004_mean, 
                         GRAND_P_201005_mean, GRAND_P_201006_mean, GRAND_P_201007_mean, GRAND_P_201008_mean, 
                         GRAND_P_201009_mean, GRAND_P_201010_mean, GRAND_P_201011_mean, GRAND_P_201012_mean)
GRAND_2011 <- data.frame(GRAND_P_201101_mean, GRAND_P_201102_mean, GRAND_P_201103_mean, GRAND_P_201104_mean, 
                         GRAND_P_201105_mean, GRAND_P_201106_mean, GRAND_P_201107_mean, GRAND_P_201108_mean, 
                         GRAND_P_201109_mean, GRAND_P_201110_mean, GRAND_P_201111_mean, GRAND_P_201112_mean)
GRAND_2012 <- data.frame(GRAND_P_201201_mean, GRAND_P_201202_mean, GRAND_P_201203_mean, GRAND_P_201204_mean, 
                         GRAND_P_201205_mean, GRAND_P_201206_mean, GRAND_P_201207_mean, GRAND_P_201208_mean, 
                         GRAND_P_201209_mean, GRAND_P_201210_mean, GRAND_P_201211_mean, GRAND_P_201212_mean)
GRAND_2013 <- data.frame(GRAND_P_201301_mean, GRAND_P_201302_mean, GRAND_P_201303_mean, GRAND_P_201304_mean, 
                         GRAND_P_201305_mean, GRAND_P_201306_mean, GRAND_P_201307_mean, GRAND_P_201308_mean, 
                         GRAND_P_201309_mean, GRAND_P_201310_mean, GRAND_P_201311_mean, GRAND_P_201312_mean)
GRAND_2014 <- data.frame(GRAND_P_201401_mean, GRAND_P_201402_mean, GRAND_P_201403_mean, GRAND_P_201404_mean, 
                         GRAND_P_201405_mean, GRAND_P_201406_mean, GRAND_P_201407_mean, GRAND_P_201408_mean, 
                         GRAND_P_201409_mean, GRAND_P_201410_mean, GRAND_P_201411_mean, GRAND_P_201412_mean)
GRAND_2015 <- data.frame(GRAND_P_201501_mean, GRAND_P_201502_mean, GRAND_P_201503_mean, GRAND_P_201504_mean, 
                         GRAND_P_201505_mean, GRAND_P_201506_mean, GRAND_P_201507_mean, GRAND_P_201508_mean, 
                         GRAND_P_201509_mean, GRAND_P_201510_mean, GRAND_P_201511_mean, GRAND_P_201512_mean)
GRAND_2016 <- data.frame(GRAND_P_201601_mean, GRAND_P_201602_mean, GRAND_P_201603_mean, GRAND_P_201604_mean, 
                         GRAND_P_201605_mean, GRAND_P_201606_mean, GRAND_P_201607_mean, GRAND_P_201608_mean, 
                         GRAND_P_201609_mean, GRAND_P_201610_mean, GRAND_P_201611_mean, GRAND_P_201612_mean)
GRAND_2017 <- data.frame(GRAND_P_201701_mean, GRAND_P_201702_mean, GRAND_P_201703_mean, GRAND_P_201704_mean, 
                         GRAND_P_201705_mean, GRAND_P_201706_mean, GRAND_P_201707_mean, GRAND_P_201708_mean, 
                         GRAND_P_201709_mean, GRAND_P_201710_mean, GRAND_P_201711_mean, GRAND_P_201712_mean)
GRAND_2018 <- data.frame(GRAND_P_201801_mean, GRAND_P_201802_mean, GRAND_P_201803_mean, GRAND_P_201804_mean, 
                         GRAND_P_201805_mean, GRAND_P_201806_mean, GRAND_P_201807_mean, GRAND_P_201808_mean, 
                         GRAND_P_201809_mean)
#IRON
IRON_2000 <- data.frame(IRON_P_200001_mean, IRON_P_200002_mean, IRON_P_200003_mean, IRON_P_200004_mean, 
                        IRON_P_200005_mean, IRON_P_200006_mean, IRON_P_200007_mean, IRON_P_200008_mean, 
                        IRON_P_200009_mean, IRON_P_200010_mean, IRON_P_200011_mean, IRON_P_200012_mean)
IRON_2001 <- data.frame(IRON_P_200101_mean, IRON_P_200102_mean, IRON_P_200103_mean, IRON_P_200104_mean, 
                        IRON_P_200105_mean, IRON_P_200106_mean, IRON_P_200107_mean, IRON_P_200108_mean, 
                        IRON_P_200109_mean, IRON_P_200110_mean, IRON_P_200111_mean, IRON_P_200112_mean)
IRON_2002 <- data.frame(IRON_P_200201_mean, IRON_P_200202_mean, IRON_P_200203_mean, IRON_P_200204_mean, 
                        IRON_P_200205_mean, IRON_P_200206_mean, IRON_P_200207_mean, IRON_P_200208_mean, 
                        IRON_P_200209_mean, IRON_P_200210_mean, IRON_P_200211_mean, IRON_P_200212_mean)
IRON_2003 <- data.frame(IRON_P_200301_mean, IRON_P_200302_mean, IRON_P_200303_mean, IRON_P_200304_mean, 
                        IRON_P_200305_mean, IRON_P_200306_mean, IRON_P_200307_mean, IRON_P_200308_mean, 
                        IRON_P_200309_mean, IRON_P_200310_mean, IRON_P_200311_mean, IRON_P_200312_mean)
IRON_2004 <- data.frame(IRON_P_200401_mean, IRON_P_200402_mean, IRON_P_200403_mean, IRON_P_200404_mean, 
                        IRON_P_200405_mean, IRON_P_200406_mean, IRON_P_200407_mean, IRON_P_200408_mean, 
                        IRON_P_200409_mean, IRON_P_200410_mean, IRON_P_200411_mean, IRON_P_200412_mean)
IRON_2005 <- data.frame(IRON_P_200501_mean, IRON_P_200502_mean, IRON_P_200503_mean, IRON_P_200504_mean, 
                        IRON_P_200505_mean, IRON_P_200506_mean, IRON_P_200507_mean, IRON_P_200508_mean, 
                        IRON_P_200509_mean, IRON_P_200510_mean, IRON_P_200511_mean, IRON_P_200512_mean)
IRON_2006 <- data.frame(IRON_P_200601_mean, IRON_P_200602_mean, IRON_P_200603_mean, IRON_P_200604_mean, 
                        IRON_P_200605_mean, IRON_P_200606_mean, IRON_P_200607_mean, IRON_P_200608_mean, 
                        IRON_P_200609_mean, IRON_P_200610_mean, IRON_P_200611_mean, IRON_P_200612_mean)
IRON_2007 <- data.frame(IRON_P_200701_mean, IRON_P_200702_mean, IRON_P_200703_mean, IRON_P_200704_mean, 
                        IRON_P_200705_mean, IRON_P_200706_mean, IRON_P_200707_mean, IRON_P_200708_mean, 
                        IRON_P_200709_mean, IRON_P_200710_mean, IRON_P_200711_mean, IRON_P_200712_mean)
IRON_2008 <- data.frame(IRON_P_200801_mean, IRON_P_200802_mean, IRON_P_200803_mean, IRON_P_200804_mean, 
                        IRON_P_200805_mean, IRON_P_200806_mean, IRON_P_200807_mean, IRON_P_200808_mean, 
                        IRON_P_200809_mean, IRON_P_200810_mean, IRON_P_200811_mean, IRON_P_200812_mean)
IRON_2009 <- data.frame(IRON_P_200901_mean, IRON_P_200902_mean, IRON_P_200903_mean, IRON_P_200904_mean, 
                        IRON_P_200905_mean, IRON_P_200906_mean, IRON_P_200907_mean, IRON_P_200908_mean, 
                        IRON_P_200909_mean, IRON_P_200910_mean, IRON_P_200911_mean, IRON_P_200912_mean)
IRON_2010 <- data.frame(IRON_P_201001_mean, IRON_P_201002_mean, IRON_P_201003_mean, IRON_P_201004_mean, 
                        IRON_P_201005_mean, IRON_P_201006_mean, IRON_P_201007_mean, IRON_P_201008_mean, 
                        IRON_P_201009_mean, IRON_P_201010_mean, IRON_P_201011_mean, IRON_P_201012_mean)
IRON_2011 <- data.frame(IRON_P_201101_mean, IRON_P_201102_mean, IRON_P_201103_mean, IRON_P_201104_mean, 
                        IRON_P_201105_mean, IRON_P_201106_mean, IRON_P_201107_mean, IRON_P_201108_mean, 
                        IRON_P_201109_mean, IRON_P_201110_mean, IRON_P_201111_mean, IRON_P_201112_mean)
IRON_2012 <- data.frame(IRON_P_201201_mean, IRON_P_201202_mean, IRON_P_201203_mean, IRON_P_201204_mean, 
                        IRON_P_201205_mean, IRON_P_201206_mean, IRON_P_201207_mean, IRON_P_201208_mean, 
                        IRON_P_201209_mean, IRON_P_201210_mean, IRON_P_201211_mean, IRON_P_201212_mean)
IRON_2013 <- data.frame(IRON_P_201301_mean, IRON_P_201302_mean, IRON_P_201303_mean, IRON_P_201304_mean, 
                        IRON_P_201305_mean, IRON_P_201306_mean, IRON_P_201307_mean, IRON_P_201308_mean, 
                        IRON_P_201309_mean, IRON_P_201310_mean, IRON_P_201311_mean, IRON_P_201312_mean)
IRON_2014 <- data.frame(IRON_P_201401_mean, IRON_P_201402_mean, IRON_P_201403_mean, IRON_P_201404_mean, 
                        IRON_P_201405_mean, IRON_P_201406_mean, IRON_P_201407_mean, IRON_P_201408_mean, 
                        IRON_P_201409_mean, IRON_P_201410_mean, IRON_P_201411_mean, IRON_P_201412_mean)
IRON_2015 <- data.frame(IRON_P_201501_mean, IRON_P_201502_mean, IRON_P_201503_mean, IRON_P_201504_mean, 
                        IRON_P_201505_mean, IRON_P_201506_mean, IRON_P_201507_mean, IRON_P_201508_mean, 
                        IRON_P_201509_mean, IRON_P_201510_mean, IRON_P_201511_mean, IRON_P_201512_mean)
IRON_2016 <- data.frame(IRON_P_201601_mean, IRON_P_201602_mean, IRON_P_201603_mean, IRON_P_201604_mean, 
                        IRON_P_201605_mean, IRON_P_201606_mean, IRON_P_201607_mean, IRON_P_201608_mean, 
                        IRON_P_201609_mean, IRON_P_201610_mean, IRON_P_201611_mean, IRON_P_201612_mean)
IRON_2017 <- data.frame(IRON_P_201701_mean, IRON_P_201702_mean, IRON_P_201703_mean, IRON_P_201704_mean, 
                        IRON_P_201705_mean, IRON_P_201706_mean, IRON_P_201707_mean, IRON_P_201708_mean, 
                        IRON_P_201709_mean, IRON_P_201710_mean, IRON_P_201711_mean, IRON_P_201712_mean)
IRON_2018 <- data.frame(IRON_P_201801_mean, IRON_P_201802_mean, IRON_P_201803_mean, IRON_P_201804_mean, 
                        IRON_P_201805_mean, IRON_P_201806_mean, IRON_P_201807_mean, IRON_P_201808_mean, 
                        IRON_P_201809_mean)

#JUAB
JUAB_2000 <- data.frame(JUAB_P_200001_mean, JUAB_P_200002_mean, JUAB_P_200003_mean, JUAB_P_200004_mean, 
                        JUAB_P_200005_mean, JUAB_P_200006_mean, JUAB_P_200007_mean, JUAB_P_200008_mean, 
                        JUAB_P_200009_mean, JUAB_P_200010_mean, JUAB_P_200011_mean, JUAB_P_200012_mean)
JUAB_2001 <- data.frame(JUAB_P_200101_mean, JUAB_P_200102_mean, JUAB_P_200103_mean, JUAB_P_200104_mean, 
                        JUAB_P_200105_mean, JUAB_P_200106_mean, JUAB_P_200107_mean, JUAB_P_200108_mean, 
                        JUAB_P_200109_mean, JUAB_P_200110_mean, JUAB_P_200111_mean, JUAB_P_200112_mean)
JUAB_2002 <- data.frame(JUAB_P_200201_mean, JUAB_P_200202_mean, JUAB_P_200203_mean, JUAB_P_200204_mean, 
                        JUAB_P_200205_mean, JUAB_P_200206_mean, JUAB_P_200207_mean, JUAB_P_200208_mean, 
                        JUAB_P_200209_mean, JUAB_P_200210_mean, JUAB_P_200211_mean, JUAB_P_200212_mean)
JUAB_2003 <- data.frame(JUAB_P_200301_mean, JUAB_P_200302_mean, JUAB_P_200303_mean, JUAB_P_200304_mean, 
                        JUAB_P_200305_mean, JUAB_P_200306_mean, JUAB_P_200307_mean, JUAB_P_200308_mean, 
                        JUAB_P_200309_mean, JUAB_P_200310_mean, JUAB_P_200311_mean, JUAB_P_200312_mean)
JUAB_2004 <- data.frame(JUAB_P_200401_mean, JUAB_P_200402_mean, JUAB_P_200403_mean, JUAB_P_200404_mean, 
                        JUAB_P_200405_mean, JUAB_P_200406_mean, JUAB_P_200407_mean, JUAB_P_200408_mean, 
                        JUAB_P_200409_mean, JUAB_P_200410_mean, JUAB_P_200411_mean, JUAB_P_200412_mean)
JUAB_2005 <- data.frame(JUAB_P_200501_mean, JUAB_P_200502_mean, JUAB_P_200503_mean, JUAB_P_200504_mean, 
                        JUAB_P_200505_mean, JUAB_P_200506_mean, JUAB_P_200507_mean, JUAB_P_200508_mean, 
                        JUAB_P_200509_mean, JUAB_P_200510_mean, JUAB_P_200511_mean, JUAB_P_200512_mean)
JUAB_2006 <- data.frame(JUAB_P_200601_mean, JUAB_P_200602_mean, JUAB_P_200603_mean, JUAB_P_200604_mean, 
                        JUAB_P_200605_mean, JUAB_P_200606_mean, JUAB_P_200607_mean, JUAB_P_200608_mean, 
                        JUAB_P_200609_mean, JUAB_P_200610_mean, JUAB_P_200611_mean, JUAB_P_200612_mean)
JUAB_2007 <- data.frame(JUAB_P_200701_mean, JUAB_P_200702_mean, JUAB_P_200703_mean, JUAB_P_200704_mean, 
                        JUAB_P_200705_mean, JUAB_P_200706_mean, JUAB_P_200707_mean, JUAB_P_200708_mean, 
                        JUAB_P_200709_mean, JUAB_P_200710_mean, JUAB_P_200711_mean, JUAB_P_200712_mean)
JUAB_2008 <- data.frame(JUAB_P_200801_mean, JUAB_P_200802_mean, JUAB_P_200803_mean, JUAB_P_200804_mean, 
                        JUAB_P_200805_mean, JUAB_P_200806_mean, JUAB_P_200807_mean, JUAB_P_200808_mean, 
                        JUAB_P_200809_mean, JUAB_P_200810_mean, JUAB_P_200811_mean, JUAB_P_200812_mean)
JUAB_2009 <- data.frame(JUAB_P_200901_mean, JUAB_P_200902_mean, JUAB_P_200903_mean, JUAB_P_200904_mean, 
                        JUAB_P_200905_mean, JUAB_P_200906_mean, JUAB_P_200907_mean, JUAB_P_200908_mean, 
                        JUAB_P_200909_mean, JUAB_P_200910_mean, JUAB_P_200911_mean, JUAB_P_200912_mean)
JUAB_2010 <- data.frame(JUAB_P_201001_mean, JUAB_P_201002_mean, JUAB_P_201003_mean, JUAB_P_201004_mean, 
                        JUAB_P_201005_mean, JUAB_P_201006_mean, JUAB_P_201007_mean, JUAB_P_201008_mean, 
                        JUAB_P_201009_mean, JUAB_P_201010_mean, JUAB_P_201011_mean, JUAB_P_201012_mean)
JUAB_2011 <- data.frame(JUAB_P_201101_mean, JUAB_P_201102_mean, JUAB_P_201103_mean, JUAB_P_201104_mean, 
                        JUAB_P_201105_mean, JUAB_P_201106_mean, JUAB_P_201107_mean, JUAB_P_201108_mean, 
                        JUAB_P_201109_mean, JUAB_P_201110_mean, JUAB_P_201111_mean, JUAB_P_201112_mean)
JUAB_2012 <- data.frame(JUAB_P_201201_mean, JUAB_P_201202_mean, JUAB_P_201203_mean, JUAB_P_201204_mean, 
                        JUAB_P_201205_mean, JUAB_P_201206_mean, JUAB_P_201207_mean, JUAB_P_201208_mean, 
                        JUAB_P_201209_mean, JUAB_P_201210_mean, JUAB_P_201211_mean, JUAB_P_201212_mean)
JUAB_2013 <- data.frame(JUAB_P_201301_mean, JUAB_P_201302_mean, JUAB_P_201303_mean, JUAB_P_201304_mean, 
                        JUAB_P_201305_mean, JUAB_P_201306_mean, JUAB_P_201307_mean, JUAB_P_201308_mean, 
                        JUAB_P_201309_mean, JUAB_P_201310_mean, JUAB_P_201311_mean, JUAB_P_201312_mean)
JUAB_2014 <- data.frame(JUAB_P_201401_mean, JUAB_P_201402_mean, JUAB_P_201403_mean, JUAB_P_201404_mean, 
                        JUAB_P_201405_mean, JUAB_P_201406_mean, JUAB_P_201407_mean, JUAB_P_201408_mean, 
                        JUAB_P_201409_mean, JUAB_P_201410_mean, JUAB_P_201411_mean, JUAB_P_201412_mean)
JUAB_2015 <- data.frame(JUAB_P_201501_mean, JUAB_P_201502_mean, JUAB_P_201503_mean, JUAB_P_201504_mean, 
                        JUAB_P_201505_mean, JUAB_P_201506_mean, JUAB_P_201507_mean, JUAB_P_201508_mean, 
                        JUAB_P_201509_mean, JUAB_P_201510_mean, JUAB_P_201511_mean, JUAB_P_201512_mean)
JUAB_2016 <- data.frame(JUAB_P_201601_mean, JUAB_P_201602_mean, JUAB_P_201603_mean, JUAB_P_201604_mean, 
                        JUAB_P_201605_mean, JUAB_P_201606_mean, JUAB_P_201607_mean, JUAB_P_201608_mean, 
                        JUAB_P_201609_mean, JUAB_P_201610_mean, JUAB_P_201611_mean, JUAB_P_201612_mean)
JUAB_2017 <- data.frame(JUAB_P_201701_mean, JUAB_P_201702_mean, JUAB_P_201703_mean, JUAB_P_201704_mean, 
                        JUAB_P_201705_mean, JUAB_P_201706_mean, JUAB_P_201707_mean, JUAB_P_201708_mean, 
                        JUAB_P_201709_mean, JUAB_P_201710_mean, JUAB_P_201711_mean, JUAB_P_201712_mean)
JUAB_2018 <- data.frame(JUAB_P_201801_mean, JUAB_P_201802_mean, JUAB_P_201803_mean, JUAB_P_201804_mean, 
                        JUAB_P_201805_mean, JUAB_P_201806_mean, JUAB_P_201807_mean, JUAB_P_201808_mean, 
                        JUAB_P_201809_mean)
#KANE
KANE_2000 <- data.frame(KANE_P_200001_mean, KANE_P_200002_mean, KANE_P_200003_mean, KANE_P_200004_mean, 
                        KANE_P_200005_mean, KANE_P_200006_mean, KANE_P_200007_mean, KANE_P_200008_mean, 
                        KANE_P_200009_mean, KANE_P_200010_mean, KANE_P_200011_mean, KANE_P_200012_mean)
KANE_2001 <- data.frame(KANE_P_200101_mean, KANE_P_200102_mean, KANE_P_200103_mean, KANE_P_200104_mean, 
                        KANE_P_200105_mean, KANE_P_200106_mean, KANE_P_200107_mean, KANE_P_200108_mean, 
                        KANE_P_200109_mean, KANE_P_200110_mean, KANE_P_200111_mean, KANE_P_200112_mean)
KANE_2002 <- data.frame(KANE_P_200201_mean, KANE_P_200202_mean, KANE_P_200203_mean, KANE_P_200204_mean, 
                        KANE_P_200205_mean, KANE_P_200206_mean, KANE_P_200207_mean, KANE_P_200208_mean, 
                        KANE_P_200209_mean, KANE_P_200210_mean, KANE_P_200211_mean, KANE_P_200212_mean)
KANE_2003 <- data.frame(KANE_P_200301_mean, KANE_P_200302_mean, KANE_P_200303_mean, KANE_P_200304_mean, 
                        KANE_P_200305_mean, KANE_P_200306_mean, KANE_P_200307_mean, KANE_P_200308_mean, 
                        KANE_P_200309_mean, KANE_P_200310_mean, KANE_P_200311_mean, KANE_P_200312_mean)
KANE_2004 <- data.frame(KANE_P_200401_mean, KANE_P_200402_mean, KANE_P_200403_mean, KANE_P_200404_mean, 
                        KANE_P_200405_mean, KANE_P_200406_mean, KANE_P_200407_mean, KANE_P_200408_mean, 
                        KANE_P_200409_mean, KANE_P_200410_mean, KANE_P_200411_mean, KANE_P_200412_mean)
KANE_2005 <- data.frame(KANE_P_200501_mean, KANE_P_200502_mean, KANE_P_200503_mean, KANE_P_200504_mean, 
                        KANE_P_200505_mean, KANE_P_200506_mean, KANE_P_200507_mean, KANE_P_200508_mean, 
                        KANE_P_200509_mean, KANE_P_200510_mean, KANE_P_200511_mean, KANE_P_200512_mean)
KANE_2006 <- data.frame(KANE_P_200601_mean, KANE_P_200602_mean, KANE_P_200603_mean, KANE_P_200604_mean, 
                        KANE_P_200605_mean, KANE_P_200606_mean, KANE_P_200607_mean, KANE_P_200608_mean, 
                        KANE_P_200609_mean, KANE_P_200610_mean, KANE_P_200611_mean, KANE_P_200612_mean)
KANE_2007 <- data.frame(KANE_P_200701_mean, KANE_P_200702_mean, KANE_P_200703_mean, KANE_P_200704_mean, 
                        KANE_P_200705_mean, KANE_P_200706_mean, KANE_P_200707_mean, KANE_P_200708_mean, 
                        KANE_P_200709_mean, KANE_P_200710_mean, KANE_P_200711_mean, KANE_P_200712_mean)
KANE_2008 <- data.frame(KANE_P_200801_mean, KANE_P_200802_mean, KANE_P_200803_mean, KANE_P_200804_mean, 
                        KANE_P_200805_mean, KANE_P_200806_mean, KANE_P_200807_mean, KANE_P_200808_mean, 
                        KANE_P_200809_mean, KANE_P_200810_mean, KANE_P_200811_mean, KANE_P_200812_mean)
KANE_2009 <- data.frame(KANE_P_200901_mean, KANE_P_200902_mean, KANE_P_200903_mean, KANE_P_200904_mean, 
                        KANE_P_200905_mean, KANE_P_200906_mean, KANE_P_200907_mean, KANE_P_200908_mean, 
                        KANE_P_200909_mean, KANE_P_200910_mean, KANE_P_200911_mean, KANE_P_200912_mean)
KANE_2010 <- data.frame(KANE_P_201001_mean, KANE_P_201002_mean, KANE_P_201003_mean, KANE_P_201004_mean, 
                        KANE_P_201005_mean, KANE_P_201006_mean, KANE_P_201007_mean, KANE_P_201008_mean, 
                        KANE_P_201009_mean, KANE_P_201010_mean, KANE_P_201011_mean, KANE_P_201012_mean)
KANE_2011 <- data.frame(KANE_P_201101_mean, KANE_P_201102_mean, KANE_P_201103_mean, KANE_P_201104_mean, 
                        KANE_P_201105_mean, KANE_P_201106_mean, KANE_P_201107_mean, KANE_P_201108_mean, 
                        KANE_P_201109_mean, KANE_P_201110_mean, KANE_P_201111_mean, KANE_P_201112_mean)
KANE_2012 <- data.frame(KANE_P_201201_mean, KANE_P_201202_mean, KANE_P_201203_mean, KANE_P_201204_mean, 
                        KANE_P_201205_mean, KANE_P_201206_mean, KANE_P_201207_mean, KANE_P_201208_mean, 
                        KANE_P_201209_mean, KANE_P_201210_mean, KANE_P_201211_mean, KANE_P_201212_mean)
KANE_2013 <- data.frame(KANE_P_201301_mean, KANE_P_201302_mean, KANE_P_201303_mean, KANE_P_201304_mean, 
                        KANE_P_201305_mean, KANE_P_201306_mean, KANE_P_201307_mean, KANE_P_201308_mean, 
                        KANE_P_201309_mean, KANE_P_201310_mean, KANE_P_201311_mean, KANE_P_201312_mean)
KANE_2014 <- data.frame(KANE_P_201401_mean, KANE_P_201402_mean, KANE_P_201403_mean, KANE_P_201404_mean, 
                        KANE_P_201405_mean, KANE_P_201406_mean, KANE_P_201407_mean, KANE_P_201408_mean, 
                        KANE_P_201409_mean, KANE_P_201410_mean, KANE_P_201411_mean, KANE_P_201412_mean)
KANE_2015 <- data.frame(KANE_P_201501_mean, KANE_P_201502_mean, KANE_P_201503_mean, KANE_P_201504_mean, 
                        KANE_P_201505_mean, KANE_P_201506_mean, KANE_P_201507_mean, KANE_P_201508_mean, 
                        KANE_P_201509_mean, KANE_P_201510_mean, KANE_P_201511_mean, KANE_P_201512_mean)
KANE_2016 <- data.frame(KANE_P_201601_mean, KANE_P_201602_mean, KANE_P_201603_mean, KANE_P_201604_mean, 
                        KANE_P_201605_mean, KANE_P_201606_mean, KANE_P_201607_mean, KANE_P_201608_mean, 
                        KANE_P_201609_mean, KANE_P_201610_mean, KANE_P_201611_mean, KANE_P_201612_mean)
KANE_2017 <- data.frame(KANE_P_201701_mean, KANE_P_201702_mean, KANE_P_201703_mean, KANE_P_201704_mean, 
                        KANE_P_201705_mean, KANE_P_201706_mean, KANE_P_201707_mean, KANE_P_201708_mean, 
                        KANE_P_201709_mean, KANE_P_201710_mean, KANE_P_201711_mean, KANE_P_201712_mean)
KANE_2018 <- data.frame(KANE_P_201801_mean, KANE_P_201802_mean, KANE_P_201803_mean, KANE_P_201804_mean, 
                        KANE_P_201805_mean, KANE_P_201806_mean, KANE_P_201807_mean, KANE_P_201808_mean, 
                        KANE_P_201809_mean)
#MORGAN
MORGAN_2000 <- data.frame(MORGAN_P_200001_mean, MORGAN_P_200002_mean, MORGAN_P_200003_mean, MORGAN_P_200004_mean, 
                          MORGAN_P_200005_mean, MORGAN_P_200006_mean, MORGAN_P_200007_mean, MORGAN_P_200008_mean, 
                          MORGAN_P_200009_mean, MORGAN_P_200010_mean, MORGAN_P_200011_mean, MORGAN_P_200012_mean)
MORGAN_2001 <- data.frame(MORGAN_P_200101_mean, MORGAN_P_200102_mean, MORGAN_P_200103_mean, MORGAN_P_200104_mean, 
                          MORGAN_P_200105_mean, MORGAN_P_200106_mean, MORGAN_P_200107_mean, MORGAN_P_200108_mean, 
                          MORGAN_P_200109_mean, MORGAN_P_200110_mean, MORGAN_P_200111_mean, MORGAN_P_200112_mean)
MORGAN_2002 <- data.frame(MORGAN_P_200201_mean, MORGAN_P_200202_mean, MORGAN_P_200203_mean, MORGAN_P_200204_mean, 
                          MORGAN_P_200205_mean, MORGAN_P_200206_mean, MORGAN_P_200207_mean, MORGAN_P_200208_mean, 
                          MORGAN_P_200209_mean, MORGAN_P_200210_mean, MORGAN_P_200211_mean, MORGAN_P_200212_mean)
MORGAN_2003 <- data.frame(MORGAN_P_200301_mean, MORGAN_P_200302_mean, MORGAN_P_200303_mean, MORGAN_P_200304_mean, 
                          MORGAN_P_200305_mean, MORGAN_P_200306_mean, MORGAN_P_200307_mean, MORGAN_P_200308_mean, 
                          MORGAN_P_200309_mean, MORGAN_P_200310_mean, MORGAN_P_200311_mean, MORGAN_P_200312_mean)
MORGAN_2004 <- data.frame(MORGAN_P_200401_mean, MORGAN_P_200402_mean, MORGAN_P_200403_mean, MORGAN_P_200404_mean, 
                          MORGAN_P_200405_mean, MORGAN_P_200406_mean, MORGAN_P_200407_mean, MORGAN_P_200408_mean, 
                          MORGAN_P_200409_mean, MORGAN_P_200410_mean, MORGAN_P_200411_mean, MORGAN_P_200412_mean)
MORGAN_2005 <- data.frame(MORGAN_P_200501_mean, MORGAN_P_200502_mean, MORGAN_P_200503_mean, MORGAN_P_200504_mean, 
                          MORGAN_P_200505_mean, MORGAN_P_200506_mean, MORGAN_P_200507_mean, MORGAN_P_200508_mean, 
                          MORGAN_P_200509_mean, MORGAN_P_200510_mean, MORGAN_P_200511_mean, MORGAN_P_200512_mean)
MORGAN_2006 <- data.frame(MORGAN_P_200601_mean, MORGAN_P_200602_mean, MORGAN_P_200603_mean, MORGAN_P_200604_mean, 
                          MORGAN_P_200605_mean, MORGAN_P_200606_mean, MORGAN_P_200607_mean, MORGAN_P_200608_mean, 
                          MORGAN_P_200609_mean, MORGAN_P_200610_mean, MORGAN_P_200611_mean, MORGAN_P_200612_mean)
MORGAN_2007 <- data.frame(MORGAN_P_200701_mean, MORGAN_P_200702_mean, MORGAN_P_200703_mean, MORGAN_P_200704_mean, 
                          MORGAN_P_200705_mean, MORGAN_P_200706_mean, MORGAN_P_200707_mean, MORGAN_P_200708_mean, 
                          MORGAN_P_200709_mean, MORGAN_P_200710_mean, MORGAN_P_200711_mean, MORGAN_P_200712_mean)
MORGAN_2008 <- data.frame(MORGAN_P_200801_mean, MORGAN_P_200802_mean, MORGAN_P_200803_mean, MORGAN_P_200804_mean, 
                          MORGAN_P_200805_mean, MORGAN_P_200806_mean, MORGAN_P_200807_mean, MORGAN_P_200808_mean, 
                          MORGAN_P_200809_mean, MORGAN_P_200810_mean, MORGAN_P_200811_mean, MORGAN_P_200812_mean)
MORGAN_2009 <- data.frame(MORGAN_P_200901_mean, MORGAN_P_200902_mean, MORGAN_P_200903_mean, MORGAN_P_200904_mean, 
                          MORGAN_P_200905_mean, MORGAN_P_200906_mean, MORGAN_P_200907_mean, MORGAN_P_200908_mean, 
                          MORGAN_P_200909_mean, MORGAN_P_200910_mean, MORGAN_P_200911_mean, MORGAN_P_200912_mean)
MORGAN_2010 <- data.frame(MORGAN_P_201001_mean, MORGAN_P_201002_mean, MORGAN_P_201003_mean, MORGAN_P_201004_mean, 
                          MORGAN_P_201005_mean, MORGAN_P_201006_mean, MORGAN_P_201007_mean, MORGAN_P_201008_mean, 
                          MORGAN_P_201009_mean, MORGAN_P_201010_mean, MORGAN_P_201011_mean, MORGAN_P_201012_mean)
MORGAN_2011 <- data.frame(MORGAN_P_201101_mean, MORGAN_P_201102_mean, MORGAN_P_201103_mean, MORGAN_P_201104_mean, 
                          MORGAN_P_201105_mean, MORGAN_P_201106_mean, MORGAN_P_201107_mean, MORGAN_P_201108_mean, 
                          MORGAN_P_201109_mean, MORGAN_P_201110_mean, MORGAN_P_201111_mean, MORGAN_P_201112_mean)
MORGAN_2012 <- data.frame(MORGAN_P_201201_mean, MORGAN_P_201202_mean, MORGAN_P_201203_mean, MORGAN_P_201204_mean, 
                          MORGAN_P_201205_mean, MORGAN_P_201206_mean, MORGAN_P_201207_mean, MORGAN_P_201208_mean, 
                          MORGAN_P_201209_mean, MORGAN_P_201210_mean, MORGAN_P_201211_mean, MORGAN_P_201212_mean)
MORGAN_2013 <- data.frame(MORGAN_P_201301_mean, MORGAN_P_201302_mean, MORGAN_P_201303_mean, MORGAN_P_201304_mean, 
                          MORGAN_P_201305_mean, MORGAN_P_201306_mean, MORGAN_P_201307_mean, MORGAN_P_201308_mean, 
                          MORGAN_P_201309_mean, MORGAN_P_201310_mean, MORGAN_P_201311_mean, MORGAN_P_201312_mean)
MORGAN_2014 <- data.frame(MORGAN_P_201401_mean, MORGAN_P_201402_mean, MORGAN_P_201403_mean, MORGAN_P_201404_mean, 
                          MORGAN_P_201405_mean, MORGAN_P_201406_mean, MORGAN_P_201407_mean, MORGAN_P_201408_mean, 
                          MORGAN_P_201409_mean, MORGAN_P_201410_mean, MORGAN_P_201411_mean, MORGAN_P_201412_mean)
MORGAN_2015 <- data.frame(MORGAN_P_201501_mean, MORGAN_P_201502_mean, MORGAN_P_201503_mean, MORGAN_P_201504_mean, 
                          MORGAN_P_201505_mean, MORGAN_P_201506_mean, MORGAN_P_201507_mean, MORGAN_P_201508_mean, 
                          MORGAN_P_201509_mean, MORGAN_P_201510_mean, MORGAN_P_201511_mean, MORGAN_P_201512_mean)
MORGAN_2016 <- data.frame(MORGAN_P_201601_mean, MORGAN_P_201602_mean, MORGAN_P_201603_mean, MORGAN_P_201604_mean, 
                          MORGAN_P_201605_mean, MORGAN_P_201606_mean, MORGAN_P_201607_mean, MORGAN_P_201608_mean, 
                          MORGAN_P_201609_mean, MORGAN_P_201610_mean, MORGAN_P_201611_mean, MORGAN_P_201612_mean)
MORGAN_2017 <- data.frame(MORGAN_P_201701_mean, MORGAN_P_201702_mean, MORGAN_P_201703_mean, MORGAN_P_201704_mean, 
                          MORGAN_P_201705_mean, MORGAN_P_201706_mean, MORGAN_P_201707_mean, MORGAN_P_201708_mean, 
                          MORGAN_P_201709_mean, MORGAN_P_201710_mean, MORGAN_P_201711_mean, MORGAN_P_201712_mean)
MORGAN_2018 <- data.frame(MORGAN_P_201801_mean, MORGAN_P_201802_mean, MORGAN_P_201803_mean, MORGAN_P_201804_mean, 
                          MORGAN_P_201805_mean, MORGAN_P_201806_mean, MORGAN_P_201807_mean, MORGAN_P_201808_mean, 
                          MORGAN_P_201809_mean)
#MILLARD
MILLARD_2000 <- data.frame(MILLARD_P_200001_mean, MILLARD_P_200002_mean, MILLARD_P_200003_mean, MILLARD_P_200004_mean, 
                           MILLARD_P_200005_mean, MILLARD_P_200006_mean, MILLARD_P_200007_mean, MILLARD_P_200008_mean, 
                           MILLARD_P_200009_mean, MILLARD_P_200010_mean, MILLARD_P_200011_mean, MILLARD_P_200012_mean)
MILLARD_2001 <- data.frame(MILLARD_P_200101_mean, MILLARD_P_200102_mean, MILLARD_P_200103_mean, MILLARD_P_200104_mean, 
                           MILLARD_P_200105_mean, MILLARD_P_200106_mean, MILLARD_P_200107_mean, MILLARD_P_200108_mean, 
                           MILLARD_P_200109_mean, MILLARD_P_200110_mean, MILLARD_P_200111_mean, MILLARD_P_200112_mean)
MILLARD_2002 <- data.frame(MILLARD_P_200201_mean, MILLARD_P_200202_mean, MILLARD_P_200203_mean, MILLARD_P_200204_mean, 
                           MILLARD_P_200205_mean, MILLARD_P_200206_mean, MILLARD_P_200207_mean, MILLARD_P_200208_mean, 
                           MILLARD_P_200209_mean, MILLARD_P_200210_mean, MILLARD_P_200211_mean, MILLARD_P_200212_mean)
MILLARD_2003 <- data.frame(MILLARD_P_200301_mean, MILLARD_P_200302_mean, MILLARD_P_200303_mean, MILLARD_P_200304_mean, 
                           MILLARD_P_200305_mean, MILLARD_P_200306_mean, MILLARD_P_200307_mean, MILLARD_P_200308_mean, 
                           MILLARD_P_200309_mean, MILLARD_P_200310_mean, MILLARD_P_200311_mean, MILLARD_P_200312_mean)
MILLARD_2004 <- data.frame(MILLARD_P_200401_mean, MILLARD_P_200402_mean, MILLARD_P_200403_mean, MILLARD_P_200404_mean, 
                           MILLARD_P_200405_mean, MILLARD_P_200406_mean, MILLARD_P_200407_mean, MILLARD_P_200408_mean, 
                           MILLARD_P_200409_mean, MILLARD_P_200410_mean, MILLARD_P_200411_mean, MILLARD_P_200412_mean)
MILLARD_2005 <- data.frame(MILLARD_P_200501_mean, MILLARD_P_200502_mean, MILLARD_P_200503_mean, MILLARD_P_200504_mean, 
                           MILLARD_P_200505_mean, MILLARD_P_200506_mean, MILLARD_P_200507_mean, MILLARD_P_200508_mean, 
                           MILLARD_P_200509_mean, MILLARD_P_200510_mean, MILLARD_P_200511_mean, MILLARD_P_200512_mean)
MILLARD_2006 <- data.frame(MILLARD_P_200601_mean, MILLARD_P_200602_mean, MILLARD_P_200603_mean, MILLARD_P_200604_mean, 
                           MILLARD_P_200605_mean, MILLARD_P_200606_mean, MILLARD_P_200607_mean, MILLARD_P_200608_mean, 
                           MILLARD_P_200609_mean, MILLARD_P_200610_mean, MILLARD_P_200611_mean, MILLARD_P_200612_mean)
MILLARD_2007 <- data.frame(MILLARD_P_200701_mean, MILLARD_P_200702_mean, MILLARD_P_200703_mean, MILLARD_P_200704_mean, 
                           MILLARD_P_200705_mean, MILLARD_P_200706_mean, MILLARD_P_200707_mean, MILLARD_P_200708_mean, 
                           MILLARD_P_200709_mean, MILLARD_P_200710_mean, MILLARD_P_200711_mean, MILLARD_P_200712_mean)
MILLARD_2008 <- data.frame(MILLARD_P_200801_mean, MILLARD_P_200802_mean, MILLARD_P_200803_mean, MILLARD_P_200804_mean, 
                           MILLARD_P_200805_mean, MILLARD_P_200806_mean, MILLARD_P_200807_mean, MILLARD_P_200808_mean, 
                           MILLARD_P_200809_mean, MILLARD_P_200810_mean, MILLARD_P_200811_mean, MILLARD_P_200812_mean)
MILLARD_2009 <- data.frame(MILLARD_P_200901_mean, MILLARD_P_200902_mean, MILLARD_P_200903_mean, MILLARD_P_200904_mean, 
                           MILLARD_P_200905_mean, MILLARD_P_200906_mean, MILLARD_P_200907_mean, MILLARD_P_200908_mean, 
                           MILLARD_P_200909_mean, MILLARD_P_200910_mean, MILLARD_P_200911_mean, MILLARD_P_200912_mean)
MILLARD_2010 <- data.frame(MILLARD_P_201001_mean, MILLARD_P_201002_mean, MILLARD_P_201003_mean, MILLARD_P_201004_mean, 
                           MILLARD_P_201005_mean, MILLARD_P_201006_mean, MILLARD_P_201007_mean, MILLARD_P_201008_mean, 
                           MILLARD_P_201009_mean, MILLARD_P_201010_mean, MILLARD_P_201011_mean, MILLARD_P_201012_mean)
MILLARD_2011 <- data.frame(MILLARD_P_201101_mean, MILLARD_P_201102_mean, MILLARD_P_201103_mean, MILLARD_P_201104_mean, 
                           MILLARD_P_201105_mean, MILLARD_P_201106_mean, MILLARD_P_201107_mean, MILLARD_P_201108_mean, 
                           MILLARD_P_201109_mean, MILLARD_P_201110_mean, MILLARD_P_201111_mean, MILLARD_P_201112_mean)
MILLARD_2012 <- data.frame(MILLARD_P_201201_mean, MILLARD_P_201202_mean, MILLARD_P_201203_mean, MILLARD_P_201204_mean, 
                           MILLARD_P_201205_mean, MILLARD_P_201206_mean, MILLARD_P_201207_mean, MILLARD_P_201208_mean, 
                           MILLARD_P_201209_mean, MILLARD_P_201210_mean, MILLARD_P_201211_mean, MILLARD_P_201212_mean)
MILLARD_2013 <- data.frame(MILLARD_P_201301_mean, MILLARD_P_201302_mean, MILLARD_P_201303_mean, MILLARD_P_201304_mean, 
                           MILLARD_P_201305_mean, MILLARD_P_201306_mean, MILLARD_P_201307_mean, MILLARD_P_201308_mean, 
                           MILLARD_P_201309_mean, MILLARD_P_201310_mean, MILLARD_P_201311_mean, MILLARD_P_201312_mean)
MILLARD_2014 <- data.frame(MILLARD_P_201401_mean, MILLARD_P_201402_mean, MILLARD_P_201403_mean, MILLARD_P_201404_mean, 
                           MILLARD_P_201405_mean, MILLARD_P_201406_mean, MILLARD_P_201407_mean, MILLARD_P_201408_mean, 
                           MILLARD_P_201409_mean, MILLARD_P_201410_mean, MILLARD_P_201411_mean, MILLARD_P_201412_mean)
MILLARD_2015 <- data.frame(MILLARD_P_201501_mean, MILLARD_P_201502_mean, MILLARD_P_201503_mean, MILLARD_P_201504_mean, 
                           MILLARD_P_201505_mean, MILLARD_P_201506_mean, MILLARD_P_201507_mean, MILLARD_P_201508_mean, 
                           MILLARD_P_201509_mean, MILLARD_P_201510_mean, MILLARD_P_201511_mean, MILLARD_P_201512_mean)
MILLARD_2016 <- data.frame(MILLARD_P_201601_mean, MILLARD_P_201602_mean, MILLARD_P_201603_mean, MILLARD_P_201604_mean, 
                           MILLARD_P_201605_mean, MILLARD_P_201606_mean, MILLARD_P_201607_mean, MILLARD_P_201608_mean, 
                           MILLARD_P_201609_mean, MILLARD_P_201610_mean, MILLARD_P_201611_mean, MILLARD_P_201612_mean)
MILLARD_2017 <- data.frame(MILLARD_P_201701_mean, MILLARD_P_201702_mean, MILLARD_P_201703_mean, MILLARD_P_201704_mean, 
                           MILLARD_P_201705_mean, MILLARD_P_201706_mean, MILLARD_P_201707_mean, MILLARD_P_201708_mean, 
                           MILLARD_P_201709_mean, MILLARD_P_201710_mean, MILLARD_P_201711_mean, MILLARD_P_201712_mean)
MILLARD_2018 <- data.frame(MILLARD_P_201801_mean, MILLARD_P_201802_mean, MILLARD_P_201803_mean, MILLARD_P_201804_mean, 
                           MILLARD_P_201805_mean, MILLARD_P_201806_mean, MILLARD_P_201807_mean, MILLARD_P_201808_mean, 
                           MILLARD_P_201809_mean)
#PIUTE
PIUTE_2000 <- data.frame(PIUTE_P_200001_mean, PIUTE_P_200002_mean, PIUTE_P_200003_mean, PIUTE_P_200004_mean, 
                         PIUTE_P_200005_mean, PIUTE_P_200006_mean, PIUTE_P_200007_mean, PIUTE_P_200008_mean, 
                         PIUTE_P_200009_mean, PIUTE_P_200010_mean, PIUTE_P_200011_mean, PIUTE_P_200012_mean)
PIUTE_2001 <- data.frame(PIUTE_P_200101_mean, PIUTE_P_200102_mean, PIUTE_P_200103_mean, PIUTE_P_200104_mean, 
                         PIUTE_P_200105_mean, PIUTE_P_200106_mean, PIUTE_P_200107_mean, PIUTE_P_200108_mean, 
                         PIUTE_P_200109_mean, PIUTE_P_200110_mean, PIUTE_P_200111_mean, PIUTE_P_200112_mean)
PIUTE_2002 <- data.frame(PIUTE_P_200201_mean, PIUTE_P_200202_mean, PIUTE_P_200203_mean, PIUTE_P_200204_mean, 
                         PIUTE_P_200205_mean, PIUTE_P_200206_mean, PIUTE_P_200207_mean, PIUTE_P_200208_mean, 
                         PIUTE_P_200209_mean, PIUTE_P_200210_mean, PIUTE_P_200211_mean, PIUTE_P_200212_mean)
PIUTE_2003 <- data.frame(PIUTE_P_200301_mean, PIUTE_P_200302_mean, PIUTE_P_200303_mean, PIUTE_P_200304_mean, 
                         PIUTE_P_200305_mean, PIUTE_P_200306_mean, PIUTE_P_200307_mean, PIUTE_P_200308_mean, 
                         PIUTE_P_200309_mean, PIUTE_P_200310_mean, PIUTE_P_200311_mean, PIUTE_P_200312_mean)
PIUTE_2004 <- data.frame(PIUTE_P_200401_mean, PIUTE_P_200402_mean, PIUTE_P_200403_mean, PIUTE_P_200404_mean, 
                         PIUTE_P_200405_mean, PIUTE_P_200406_mean, PIUTE_P_200407_mean, PIUTE_P_200408_mean, 
                         PIUTE_P_200409_mean, PIUTE_P_200410_mean, PIUTE_P_200411_mean, PIUTE_P_200412_mean)
PIUTE_2005 <- data.frame(PIUTE_P_200501_mean, PIUTE_P_200502_mean, PIUTE_P_200503_mean, PIUTE_P_200504_mean, 
                         PIUTE_P_200505_mean, PIUTE_P_200506_mean, PIUTE_P_200507_mean, PIUTE_P_200508_mean, 
                         PIUTE_P_200509_mean, PIUTE_P_200510_mean, PIUTE_P_200511_mean, PIUTE_P_200512_mean)
PIUTE_2006 <- data.frame(PIUTE_P_200601_mean, PIUTE_P_200602_mean, PIUTE_P_200603_mean, PIUTE_P_200604_mean, 
                         PIUTE_P_200605_mean, PIUTE_P_200606_mean, PIUTE_P_200607_mean, PIUTE_P_200608_mean, 
                         PIUTE_P_200609_mean, PIUTE_P_200610_mean, PIUTE_P_200611_mean, PIUTE_P_200612_mean)
PIUTE_2007 <- data.frame(PIUTE_P_200701_mean, PIUTE_P_200702_mean, PIUTE_P_200703_mean, PIUTE_P_200704_mean, 
                         PIUTE_P_200705_mean, PIUTE_P_200706_mean, PIUTE_P_200707_mean, PIUTE_P_200708_mean, 
                         PIUTE_P_200709_mean, PIUTE_P_200710_mean, PIUTE_P_200711_mean, PIUTE_P_200712_mean)
PIUTE_2008 <- data.frame(PIUTE_P_200801_mean, PIUTE_P_200802_mean, PIUTE_P_200803_mean, PIUTE_P_200804_mean, 
                         PIUTE_P_200805_mean, PIUTE_P_200806_mean, PIUTE_P_200807_mean, PIUTE_P_200808_mean, 
                         PIUTE_P_200809_mean, PIUTE_P_200810_mean, PIUTE_P_200811_mean, PIUTE_P_200812_mean)
PIUTE_2009 <- data.frame(PIUTE_P_200901_mean, PIUTE_P_200902_mean, PIUTE_P_200903_mean, PIUTE_P_200904_mean, 
                         PIUTE_P_200905_mean, PIUTE_P_200906_mean, PIUTE_P_200907_mean, PIUTE_P_200908_mean, 
                         PIUTE_P_200909_mean, PIUTE_P_200910_mean, PIUTE_P_200911_mean, PIUTE_P_200912_mean)
PIUTE_2010 <- data.frame(PIUTE_P_201001_mean, PIUTE_P_201002_mean, PIUTE_P_201003_mean, PIUTE_P_201004_mean, 
                         PIUTE_P_201005_mean, PIUTE_P_201006_mean, PIUTE_P_201007_mean, PIUTE_P_201008_mean, 
                         PIUTE_P_201009_mean, PIUTE_P_201010_mean, PIUTE_P_201011_mean, PIUTE_P_201012_mean)
PIUTE_2011 <- data.frame(PIUTE_P_201101_mean, PIUTE_P_201102_mean, PIUTE_P_201103_mean, PIUTE_P_201104_mean, 
                         PIUTE_P_201105_mean, PIUTE_P_201106_mean, PIUTE_P_201107_mean, PIUTE_P_201108_mean, 
                         PIUTE_P_201109_mean, PIUTE_P_201110_mean, PIUTE_P_201111_mean, PIUTE_P_201112_mean)
PIUTE_2012 <- data.frame(PIUTE_P_201201_mean, PIUTE_P_201202_mean, PIUTE_P_201203_mean, PIUTE_P_201204_mean, 
                         PIUTE_P_201205_mean, PIUTE_P_201206_mean, PIUTE_P_201207_mean, PIUTE_P_201208_mean, 
                         PIUTE_P_201209_mean, PIUTE_P_201210_mean, PIUTE_P_201211_mean, PIUTE_P_201212_mean)
PIUTE_2013 <- data.frame(PIUTE_P_201301_mean, PIUTE_P_201302_mean, PIUTE_P_201303_mean, PIUTE_P_201304_mean, 
                         PIUTE_P_201305_mean, PIUTE_P_201306_mean, PIUTE_P_201307_mean, PIUTE_P_201308_mean, 
                         PIUTE_P_201309_mean, PIUTE_P_201310_mean, PIUTE_P_201311_mean, PIUTE_P_201312_mean)
PIUTE_2014 <- data.frame(PIUTE_P_201401_mean, PIUTE_P_201402_mean, PIUTE_P_201403_mean, PIUTE_P_201404_mean, 
                         PIUTE_P_201405_mean, PIUTE_P_201406_mean, PIUTE_P_201407_mean, PIUTE_P_201408_mean, 
                         PIUTE_P_201409_mean, PIUTE_P_201410_mean, PIUTE_P_201411_mean, PIUTE_P_201412_mean)
PIUTE_2015 <- data.frame(PIUTE_P_201501_mean, PIUTE_P_201502_mean, PIUTE_P_201503_mean, PIUTE_P_201504_mean, 
                         PIUTE_P_201505_mean, PIUTE_P_201506_mean, PIUTE_P_201507_mean, PIUTE_P_201508_mean, 
                         PIUTE_P_201509_mean, PIUTE_P_201510_mean, PIUTE_P_201511_mean, PIUTE_P_201512_mean)
PIUTE_2016 <- data.frame(PIUTE_P_201601_mean, PIUTE_P_201602_mean, PIUTE_P_201603_mean, PIUTE_P_201604_mean, 
                         PIUTE_P_201605_mean, PIUTE_P_201606_mean, PIUTE_P_201607_mean, PIUTE_P_201608_mean, 
                         PIUTE_P_201609_mean, PIUTE_P_201610_mean, PIUTE_P_201611_mean, PIUTE_P_201612_mean)
PIUTE_2017 <- data.frame(PIUTE_P_201701_mean, PIUTE_P_201702_mean, PIUTE_P_201703_mean, PIUTE_P_201704_mean, 
                         PIUTE_P_201705_mean, PIUTE_P_201706_mean, PIUTE_P_201707_mean, PIUTE_P_201708_mean, 
                         PIUTE_P_201709_mean, PIUTE_P_201710_mean, PIUTE_P_201711_mean, PIUTE_P_201712_mean)
PIUTE_2018 <- data.frame(PIUTE_P_201801_mean, PIUTE_P_201802_mean, PIUTE_P_201803_mean, PIUTE_P_201804_mean, 
                         PIUTE_P_201805_mean, PIUTE_P_201806_mean, PIUTE_P_201807_mean, PIUTE_P_201808_mean, 
                         PIUTE_P_201809_mean)

#RICH
RICH_2000 <- data.frame(RICH_P_200001_mean, RICH_P_200002_mean, RICH_P_200003_mean, RICH_P_200004_mean, 
                        RICH_P_200005_mean, RICH_P_200006_mean, RICH_P_200007_mean, RICH_P_200008_mean, 
                        RICH_P_200009_mean, RICH_P_200010_mean, RICH_P_200011_mean, RICH_P_200012_mean)
RICH_2001 <- data.frame(RICH_P_200101_mean, RICH_P_200102_mean, RICH_P_200103_mean, RICH_P_200104_mean, 
                        RICH_P_200105_mean, RICH_P_200106_mean, RICH_P_200107_mean, RICH_P_200108_mean, 
                        RICH_P_200109_mean, RICH_P_200110_mean, RICH_P_200111_mean, RICH_P_200112_mean)
RICH_2002 <- data.frame(RICH_P_200201_mean, RICH_P_200202_mean, RICH_P_200203_mean, RICH_P_200204_mean, 
                        RICH_P_200205_mean, RICH_P_200206_mean, RICH_P_200207_mean, RICH_P_200208_mean, 
                        RICH_P_200209_mean, RICH_P_200210_mean, RICH_P_200211_mean, RICH_P_200212_mean)
RICH_2003 <- data.frame(RICH_P_200301_mean, RICH_P_200302_mean, RICH_P_200303_mean, RICH_P_200304_mean, 
                        RICH_P_200305_mean, RICH_P_200306_mean, RICH_P_200307_mean, RICH_P_200308_mean, 
                        RICH_P_200309_mean, RICH_P_200310_mean, RICH_P_200311_mean, RICH_P_200312_mean)
RICH_2004 <- data.frame(RICH_P_200401_mean, RICH_P_200402_mean, RICH_P_200403_mean, RICH_P_200404_mean, 
                        RICH_P_200405_mean, RICH_P_200406_mean, RICH_P_200407_mean, RICH_P_200408_mean, 
                        RICH_P_200409_mean, RICH_P_200410_mean, RICH_P_200411_mean, RICH_P_200412_mean)
RICH_2005 <- data.frame(RICH_P_200501_mean, RICH_P_200502_mean, RICH_P_200503_mean, RICH_P_200504_mean, 
                        RICH_P_200505_mean, RICH_P_200506_mean, RICH_P_200507_mean, RICH_P_200508_mean, 
                        RICH_P_200509_mean, RICH_P_200510_mean, RICH_P_200511_mean, RICH_P_200512_mean)
RICH_2006 <- data.frame(RICH_P_200601_mean, RICH_P_200602_mean, RICH_P_200603_mean, RICH_P_200604_mean, 
                        RICH_P_200605_mean, RICH_P_200606_mean, RICH_P_200607_mean, RICH_P_200608_mean, 
                        RICH_P_200609_mean, RICH_P_200610_mean, RICH_P_200611_mean, RICH_P_200612_mean)
RICH_2007 <- data.frame(RICH_P_200701_mean, RICH_P_200702_mean, RICH_P_200703_mean, RICH_P_200704_mean, 
                        RICH_P_200705_mean, RICH_P_200706_mean, RICH_P_200707_mean, RICH_P_200708_mean, 
                        RICH_P_200709_mean, RICH_P_200710_mean, RICH_P_200711_mean, RICH_P_200712_mean)
RICH_2008 <- data.frame(RICH_P_200801_mean, RICH_P_200802_mean, RICH_P_200803_mean, RICH_P_200804_mean, 
                        RICH_P_200805_mean, RICH_P_200806_mean, RICH_P_200807_mean, RICH_P_200808_mean, 
                        RICH_P_200809_mean, RICH_P_200810_mean, RICH_P_200811_mean, RICH_P_200812_mean)
RICH_2009 <- data.frame(RICH_P_200901_mean, RICH_P_200902_mean, RICH_P_200903_mean, RICH_P_200904_mean, 
                        RICH_P_200905_mean, RICH_P_200906_mean, RICH_P_200907_mean, RICH_P_200908_mean, 
                        RICH_P_200909_mean, RICH_P_200910_mean, RICH_P_200911_mean, RICH_P_200912_mean)
RICH_2010 <- data.frame(RICH_P_201001_mean, RICH_P_201002_mean, RICH_P_201003_mean, RICH_P_201004_mean, 
                        RICH_P_201005_mean, RICH_P_201006_mean, RICH_P_201007_mean, RICH_P_201008_mean, 
                        RICH_P_201009_mean, RICH_P_201010_mean, RICH_P_201011_mean, RICH_P_201012_mean)
RICH_2011 <- data.frame(RICH_P_201101_mean, RICH_P_201102_mean, RICH_P_201103_mean, RICH_P_201104_mean, 
                        RICH_P_201105_mean, RICH_P_201106_mean, RICH_P_201107_mean, RICH_P_201108_mean, 
                        RICH_P_201109_mean, RICH_P_201110_mean, RICH_P_201111_mean, RICH_P_201112_mean)
RICH_2012 <- data.frame(RICH_P_201201_mean, RICH_P_201202_mean, RICH_P_201203_mean, RICH_P_201204_mean, 
                        RICH_P_201205_mean, RICH_P_201206_mean, RICH_P_201207_mean, RICH_P_201208_mean, 
                        RICH_P_201209_mean, RICH_P_201210_mean, RICH_P_201211_mean, RICH_P_201212_mean)
RICH_2013 <- data.frame(RICH_P_201301_mean, RICH_P_201302_mean, RICH_P_201303_mean, RICH_P_201304_mean, 
                        RICH_P_201305_mean, RICH_P_201306_mean, RICH_P_201307_mean, RICH_P_201308_mean, 
                        RICH_P_201309_mean, RICH_P_201310_mean, RICH_P_201311_mean, RICH_P_201312_mean)
RICH_2014 <- data.frame(RICH_P_201401_mean, RICH_P_201402_mean, RICH_P_201403_mean, RICH_P_201404_mean, 
                        RICH_P_201405_mean, RICH_P_201406_mean, RICH_P_201407_mean, RICH_P_201408_mean, 
                        RICH_P_201409_mean, RICH_P_201410_mean, RICH_P_201411_mean, RICH_P_201412_mean)
RICH_2015 <- data.frame(RICH_P_201501_mean, RICH_P_201502_mean, RICH_P_201503_mean, RICH_P_201504_mean, 
                        RICH_P_201505_mean, RICH_P_201506_mean, RICH_P_201507_mean, RICH_P_201508_mean, 
                        RICH_P_201509_mean, RICH_P_201510_mean, RICH_P_201511_mean, RICH_P_201512_mean)
RICH_2016 <- data.frame(RICH_P_201601_mean, RICH_P_201602_mean, RICH_P_201603_mean, RICH_P_201604_mean, 
                        RICH_P_201605_mean, RICH_P_201606_mean, RICH_P_201607_mean, RICH_P_201608_mean, 
                        RICH_P_201609_mean, RICH_P_201610_mean, RICH_P_201611_mean, RICH_P_201612_mean)
RICH_2017 <- data.frame(RICH_P_201701_mean, RICH_P_201702_mean, RICH_P_201703_mean, RICH_P_201704_mean, 
                        RICH_P_201705_mean, RICH_P_201706_mean, RICH_P_201707_mean, RICH_P_201708_mean, 
                        RICH_P_201709_mean, RICH_P_201710_mean, RICH_P_201711_mean, RICH_P_201712_mean)
RICH_2018 <- data.frame(RICH_P_201801_mean, RICH_P_201802_mean, RICH_P_201803_mean, RICH_P_201804_mean, 
                        RICH_P_201805_mean, RICH_P_201806_mean, RICH_P_201807_mean, RICH_P_201808_mean, 
                        RICH_P_201809_mean)

#SANPETE
SANPETE_2000 <- data.frame(SANPETE_P_200001_mean, SANPETE_P_200002_mean, SANPETE_P_200003_mean, SANPETE_P_200004_mean, 
                           SANPETE_P_200005_mean, SANPETE_P_200006_mean, SANPETE_P_200007_mean, SANPETE_P_200008_mean, 
                           SANPETE_P_200009_mean, SANPETE_P_200010_mean, SANPETE_P_200011_mean, SANPETE_P_200012_mean)
SANPETE_2001 <- data.frame(SANPETE_P_200101_mean, SANPETE_P_200102_mean, SANPETE_P_200103_mean, SANPETE_P_200104_mean, 
                           SANPETE_P_200105_mean, SANPETE_P_200106_mean, SANPETE_P_200107_mean, SANPETE_P_200108_mean, 
                           SANPETE_P_200109_mean, SANPETE_P_200110_mean, SANPETE_P_200111_mean, SANPETE_P_200112_mean)
SANPETE_2002 <- data.frame(SANPETE_P_200201_mean, SANPETE_P_200202_mean, SANPETE_P_200203_mean, SANPETE_P_200204_mean, 
                           SANPETE_P_200205_mean, SANPETE_P_200206_mean, SANPETE_P_200207_mean, SANPETE_P_200208_mean, 
                           SANPETE_P_200209_mean, SANPETE_P_200210_mean, SANPETE_P_200211_mean, SANPETE_P_200212_mean)
SANPETE_2003 <- data.frame(SANPETE_P_200301_mean, SANPETE_P_200302_mean, SANPETE_P_200303_mean, SANPETE_P_200304_mean, 
                           SANPETE_P_200305_mean, SANPETE_P_200306_mean, SANPETE_P_200307_mean, SANPETE_P_200308_mean, 
                           SANPETE_P_200309_mean, SANPETE_P_200310_mean, SANPETE_P_200311_mean, SANPETE_P_200312_mean)
SANPETE_2004 <- data.frame(SANPETE_P_200401_mean, SANPETE_P_200402_mean, SANPETE_P_200403_mean, SANPETE_P_200404_mean, 
                           SANPETE_P_200405_mean, SANPETE_P_200406_mean, SANPETE_P_200407_mean, SANPETE_P_200408_mean, 
                           SANPETE_P_200409_mean, SANPETE_P_200410_mean, SANPETE_P_200411_mean, SANPETE_P_200412_mean)
SANPETE_2005 <- data.frame(SANPETE_P_200501_mean, SANPETE_P_200502_mean, SANPETE_P_200503_mean, SANPETE_P_200504_mean, 
                           SANPETE_P_200505_mean, SANPETE_P_200506_mean, SANPETE_P_200507_mean, SANPETE_P_200508_mean, 
                           SANPETE_P_200509_mean, SANPETE_P_200510_mean, SANPETE_P_200511_mean, SANPETE_P_200512_mean)
SANPETE_2006 <- data.frame(SANPETE_P_200601_mean, SANPETE_P_200602_mean, SANPETE_P_200603_mean, SANPETE_P_200604_mean, 
                           SANPETE_P_200605_mean, SANPETE_P_200606_mean, SANPETE_P_200607_mean, SANPETE_P_200608_mean, 
                           SANPETE_P_200609_mean, SANPETE_P_200610_mean, SANPETE_P_200611_mean, SANPETE_P_200612_mean)
SANPETE_2007 <- data.frame(SANPETE_P_200701_mean, SANPETE_P_200702_mean, SANPETE_P_200703_mean, SANPETE_P_200704_mean, 
                           SANPETE_P_200705_mean, SANPETE_P_200706_mean, SANPETE_P_200707_mean, SANPETE_P_200708_mean, 
                           SANPETE_P_200709_mean, SANPETE_P_200710_mean, SANPETE_P_200711_mean, SANPETE_P_200712_mean)
SANPETE_2008 <- data.frame(SANPETE_P_200801_mean, SANPETE_P_200802_mean, SANPETE_P_200803_mean, SANPETE_P_200804_mean, 
                           SANPETE_P_200805_mean, SANPETE_P_200806_mean, SANPETE_P_200807_mean, SANPETE_P_200808_mean, 
                           SANPETE_P_200809_mean, SANPETE_P_200810_mean, SANPETE_P_200811_mean, SANPETE_P_200812_mean)
SANPETE_2009 <- data.frame(SANPETE_P_200901_mean, SANPETE_P_200902_mean, SANPETE_P_200903_mean, SANPETE_P_200904_mean, 
                           SANPETE_P_200905_mean, SANPETE_P_200906_mean, SANPETE_P_200907_mean, SANPETE_P_200908_mean, 
                           SANPETE_P_200909_mean, SANPETE_P_200910_mean, SANPETE_P_200911_mean, SANPETE_P_200912_mean)
SANPETE_2010 <- data.frame(SANPETE_P_201001_mean, SANPETE_P_201002_mean, SANPETE_P_201003_mean, SANPETE_P_201004_mean, 
                           SANPETE_P_201005_mean, SANPETE_P_201006_mean, SANPETE_P_201007_mean, SANPETE_P_201008_mean, 
                           SANPETE_P_201009_mean, SANPETE_P_201010_mean, SANPETE_P_201011_mean, SANPETE_P_201012_mean)
SANPETE_2011 <- data.frame(SANPETE_P_201101_mean, SANPETE_P_201102_mean, SANPETE_P_201103_mean, SANPETE_P_201104_mean, 
                           SANPETE_P_201105_mean, SANPETE_P_201106_mean, SANPETE_P_201107_mean, SANPETE_P_201108_mean, 
                           SANPETE_P_201109_mean, SANPETE_P_201110_mean, SANPETE_P_201111_mean, SANPETE_P_201112_mean)
SANPETE_2012 <- data.frame(SANPETE_P_201201_mean, SANPETE_P_201202_mean, SANPETE_P_201203_mean, SANPETE_P_201204_mean, 
                           SANPETE_P_201205_mean, SANPETE_P_201206_mean, SANPETE_P_201207_mean, SANPETE_P_201208_mean, 
                           SANPETE_P_201209_mean, SANPETE_P_201210_mean, SANPETE_P_201211_mean, SANPETE_P_201212_mean)
SANPETE_2013 <- data.frame(SANPETE_P_201301_mean, SANPETE_P_201302_mean, SANPETE_P_201303_mean, SANPETE_P_201304_mean, 
                           SANPETE_P_201305_mean, SANPETE_P_201306_mean, SANPETE_P_201307_mean, SANPETE_P_201308_mean, 
                           SANPETE_P_201309_mean, SANPETE_P_201310_mean, SANPETE_P_201311_mean, SANPETE_P_201312_mean)
SANPETE_2014 <- data.frame(SANPETE_P_201401_mean, SANPETE_P_201402_mean, SANPETE_P_201403_mean, SANPETE_P_201404_mean, 
                           SANPETE_P_201405_mean, SANPETE_P_201406_mean, SANPETE_P_201407_mean, SANPETE_P_201408_mean, 
                           SANPETE_P_201409_mean, SANPETE_P_201410_mean, SANPETE_P_201411_mean, SANPETE_P_201412_mean)
SANPETE_2015 <- data.frame(SANPETE_P_201501_mean, SANPETE_P_201502_mean, SANPETE_P_201503_mean, SANPETE_P_201504_mean, 
                           SANPETE_P_201505_mean, SANPETE_P_201506_mean, SANPETE_P_201507_mean, SANPETE_P_201508_mean, 
                           SANPETE_P_201509_mean, SANPETE_P_201510_mean, SANPETE_P_201511_mean, SANPETE_P_201512_mean)
SANPETE_2016 <- data.frame(SANPETE_P_201601_mean, SANPETE_P_201602_mean, SANPETE_P_201603_mean, SANPETE_P_201604_mean, 
                           SANPETE_P_201605_mean, SANPETE_P_201606_mean, SANPETE_P_201607_mean, SANPETE_P_201608_mean, 
                           SANPETE_P_201609_mean, SANPETE_P_201610_mean, SANPETE_P_201611_mean, SANPETE_P_201612_mean)
SANPETE_2017 <- data.frame(SANPETE_P_201701_mean, SANPETE_P_201702_mean, SANPETE_P_201703_mean, SANPETE_P_201704_mean, 
                           SANPETE_P_201705_mean, SANPETE_P_201706_mean, SANPETE_P_201707_mean, SANPETE_P_201708_mean, 
                           SANPETE_P_201709_mean, SANPETE_P_201710_mean, SANPETE_P_201711_mean, SANPETE_P_201712_mean)
SANPETE_2018 <- data.frame(SANPETE_P_201801_mean, SANPETE_P_201802_mean, SANPETE_P_201803_mean, SANPETE_P_201804_mean, 
                           SANPETE_P_201805_mean, SANPETE_P_201806_mean, SANPETE_P_201807_mean, SANPETE_P_201808_mean, 
                           SANPETE_P_201809_mean)
#SALTLAKE
SALTLAKE_2000 <- data.frame(SALTLAKE_P_200001_mean, SALTLAKE_P_200002_mean, SALTLAKE_P_200003_mean, SALTLAKE_P_200004_mean, 
                            SALTLAKE_P_200005_mean, SALTLAKE_P_200006_mean, SALTLAKE_P_200007_mean, SALTLAKE_P_200008_mean, 
                            SALTLAKE_P_200009_mean, SALTLAKE_P_200010_mean, SALTLAKE_P_200011_mean, SALTLAKE_P_200012_mean)
SALTLAKE_2001 <- data.frame(SALTLAKE_P_200101_mean, SALTLAKE_P_200102_mean, SALTLAKE_P_200103_mean, SALTLAKE_P_200104_mean, 
                            SALTLAKE_P_200105_mean, SALTLAKE_P_200106_mean, SALTLAKE_P_200107_mean, SALTLAKE_P_200108_mean, 
                            SALTLAKE_P_200109_mean, SALTLAKE_P_200110_mean, SALTLAKE_P_200111_mean, SALTLAKE_P_200112_mean)
SALTLAKE_2002 <- data.frame(SALTLAKE_P_200201_mean, SALTLAKE_P_200202_mean, SALTLAKE_P_200203_mean, SALTLAKE_P_200204_mean, 
                            SALTLAKE_P_200205_mean, SALTLAKE_P_200206_mean, SALTLAKE_P_200207_mean, SALTLAKE_P_200208_mean, 
                            SALTLAKE_P_200209_mean, SALTLAKE_P_200210_mean, SALTLAKE_P_200211_mean, SALTLAKE_P_200212_mean)
SALTLAKE_2003 <- data.frame(SALTLAKE_P_200301_mean, SALTLAKE_P_200302_mean, SALTLAKE_P_200303_mean, SALTLAKE_P_200304_mean, 
                            SALTLAKE_P_200305_mean, SALTLAKE_P_200306_mean, SALTLAKE_P_200307_mean, SALTLAKE_P_200308_mean, 
                            SALTLAKE_P_200309_mean, SALTLAKE_P_200310_mean, SALTLAKE_P_200311_mean, SALTLAKE_P_200312_mean)
SALTLAKE_2004 <- data.frame(SALTLAKE_P_200401_mean, SALTLAKE_P_200402_mean, SALTLAKE_P_200403_mean, SALTLAKE_P_200404_mean, 
                            SALTLAKE_P_200405_mean, SALTLAKE_P_200406_mean, SALTLAKE_P_200407_mean, SALTLAKE_P_200408_mean, 
                            SALTLAKE_P_200409_mean, SALTLAKE_P_200410_mean, SALTLAKE_P_200411_mean, SALTLAKE_P_200412_mean)
SALTLAKE_2005 <- data.frame(SALTLAKE_P_200501_mean, SALTLAKE_P_200502_mean, SALTLAKE_P_200503_mean, SALTLAKE_P_200504_mean, 
                            SALTLAKE_P_200505_mean, SALTLAKE_P_200506_mean, SALTLAKE_P_200507_mean, SALTLAKE_P_200508_mean, 
                            SALTLAKE_P_200509_mean, SALTLAKE_P_200510_mean, SALTLAKE_P_200511_mean, SALTLAKE_P_200512_mean)
SALTLAKE_2006 <- data.frame(SALTLAKE_P_200601_mean, SALTLAKE_P_200602_mean, SALTLAKE_P_200603_mean, SALTLAKE_P_200604_mean, 
                            SALTLAKE_P_200605_mean, SALTLAKE_P_200606_mean, SALTLAKE_P_200607_mean, SALTLAKE_P_200608_mean, 
                            SALTLAKE_P_200609_mean, SALTLAKE_P_200610_mean, SALTLAKE_P_200611_mean, SALTLAKE_P_200612_mean)
SALTLAKE_2007 <- data.frame(SALTLAKE_P_200701_mean, SALTLAKE_P_200702_mean, SALTLAKE_P_200703_mean, SALTLAKE_P_200704_mean, 
                            SALTLAKE_P_200705_mean, SALTLAKE_P_200706_mean, SALTLAKE_P_200707_mean, SALTLAKE_P_200708_mean, 
                            SALTLAKE_P_200709_mean, SALTLAKE_P_200710_mean, SALTLAKE_P_200711_mean, SALTLAKE_P_200712_mean)
SALTLAKE_2008 <- data.frame(SALTLAKE_P_200801_mean, SALTLAKE_P_200802_mean, SALTLAKE_P_200803_mean, SALTLAKE_P_200804_mean, 
                            SALTLAKE_P_200805_mean, SALTLAKE_P_200806_mean, SALTLAKE_P_200807_mean, SALTLAKE_P_200808_mean, 
                            SALTLAKE_P_200809_mean, SALTLAKE_P_200810_mean, SALTLAKE_P_200811_mean, SALTLAKE_P_200812_mean)
SALTLAKE_2009 <- data.frame(SALTLAKE_P_200901_mean, SALTLAKE_P_200902_mean, SALTLAKE_P_200903_mean, SALTLAKE_P_200904_mean, 
                            SALTLAKE_P_200905_mean, SALTLAKE_P_200906_mean, SALTLAKE_P_200907_mean, SALTLAKE_P_200908_mean, 
                            SALTLAKE_P_200909_mean, SALTLAKE_P_200910_mean, SALTLAKE_P_200911_mean, SALTLAKE_P_200912_mean)
SALTLAKE_2010 <- data.frame(SALTLAKE_P_201001_mean, SALTLAKE_P_201002_mean, SALTLAKE_P_201003_mean, SALTLAKE_P_201004_mean, 
                            SALTLAKE_P_201005_mean, SALTLAKE_P_201006_mean, SALTLAKE_P_201007_mean, SALTLAKE_P_201008_mean, 
                            SALTLAKE_P_201009_mean, SALTLAKE_P_201010_mean, SALTLAKE_P_201011_mean, SALTLAKE_P_201012_mean)
SALTLAKE_2011 <- data.frame(SALTLAKE_P_201101_mean, SALTLAKE_P_201102_mean, SALTLAKE_P_201103_mean, SALTLAKE_P_201104_mean, 
                            SALTLAKE_P_201105_mean, SALTLAKE_P_201106_mean, SALTLAKE_P_201107_mean, SALTLAKE_P_201108_mean, 
                            SALTLAKE_P_201109_mean, SALTLAKE_P_201110_mean, SALTLAKE_P_201111_mean, SALTLAKE_P_201112_mean)
SALTLAKE_2012 <- data.frame(SALTLAKE_P_201201_mean, SALTLAKE_P_201202_mean, SALTLAKE_P_201203_mean, SALTLAKE_P_201204_mean, 
                            SALTLAKE_P_201205_mean, SALTLAKE_P_201206_mean, SALTLAKE_P_201207_mean, SALTLAKE_P_201208_mean, 
                            SALTLAKE_P_201209_mean, SALTLAKE_P_201210_mean, SALTLAKE_P_201211_mean, SALTLAKE_P_201212_mean)
SALTLAKE_2013 <- data.frame(SALTLAKE_P_201301_mean, SALTLAKE_P_201302_mean, SALTLAKE_P_201303_mean, SALTLAKE_P_201304_mean, 
                            SALTLAKE_P_201305_mean, SALTLAKE_P_201306_mean, SALTLAKE_P_201307_mean, SALTLAKE_P_201308_mean, 
                            SALTLAKE_P_201309_mean, SALTLAKE_P_201310_mean, SALTLAKE_P_201311_mean, SALTLAKE_P_201312_mean)
SALTLAKE_2014 <- data.frame(SALTLAKE_P_201401_mean, SALTLAKE_P_201402_mean, SALTLAKE_P_201403_mean, SALTLAKE_P_201404_mean, 
                            SALTLAKE_P_201405_mean, SALTLAKE_P_201406_mean, SALTLAKE_P_201407_mean, SALTLAKE_P_201408_mean, 
                            SALTLAKE_P_201409_mean, SALTLAKE_P_201410_mean, SALTLAKE_P_201411_mean, SALTLAKE_P_201412_mean)
SALTLAKE_2015 <- data.frame(SALTLAKE_P_201501_mean, SALTLAKE_P_201502_mean, SALTLAKE_P_201503_mean, SALTLAKE_P_201504_mean, 
                            SALTLAKE_P_201505_mean, SALTLAKE_P_201506_mean, SALTLAKE_P_201507_mean, SALTLAKE_P_201508_mean, 
                            SALTLAKE_P_201509_mean, SALTLAKE_P_201510_mean, SALTLAKE_P_201511_mean, SALTLAKE_P_201512_mean)
SALTLAKE_2016 <- data.frame(SALTLAKE_P_201601_mean, SALTLAKE_P_201602_mean, SALTLAKE_P_201603_mean, SALTLAKE_P_201604_mean, 
                            SALTLAKE_P_201605_mean, SALTLAKE_P_201606_mean, SALTLAKE_P_201607_mean, SALTLAKE_P_201608_mean, 
                            SALTLAKE_P_201609_mean, SALTLAKE_P_201610_mean, SALTLAKE_P_201611_mean, SALTLAKE_P_201612_mean)
SALTLAKE_2017 <- data.frame(SALTLAKE_P_201701_mean, SALTLAKE_P_201702_mean, SALTLAKE_P_201703_mean, SALTLAKE_P_201704_mean, 
                            SALTLAKE_P_201705_mean, SALTLAKE_P_201706_mean, SALTLAKE_P_201707_mean, SALTLAKE_P_201708_mean, 
                            SALTLAKE_P_201709_mean, SALTLAKE_P_201710_mean, SALTLAKE_P_201711_mean, SALTLAKE_P_201712_mean)
SALTLAKE_2018 <- data.frame(SALTLAKE_P_201801_mean, SALTLAKE_P_201802_mean, SALTLAKE_P_201803_mean, SALTLAKE_P_201804_mean, 
                            SALTLAKE_P_201805_mean, SALTLAKE_P_201806_mean, SALTLAKE_P_201807_mean, SALTLAKE_P_201808_mean, 
                            SALTLAKE_P_201809_mean)
#SAN_JUAN
SAN_JUAN_2000 <- data.frame(SAN_JUAN_P_200001_mean, SAN_JUAN_P_200002_mean, SAN_JUAN_P_200003_mean, SAN_JUAN_P_200004_mean, 
                            SAN_JUAN_P_200005_mean, SAN_JUAN_P_200006_mean, SAN_JUAN_P_200007_mean, SAN_JUAN_P_200008_mean, 
                            SAN_JUAN_P_200009_mean, SAN_JUAN_P_200010_mean, SAN_JUAN_P_200011_mean, SAN_JUAN_P_200012_mean)
SAN_JUAN_2001 <- data.frame(SAN_JUAN_P_200101_mean, SAN_JUAN_P_200102_mean, SAN_JUAN_P_200103_mean, SAN_JUAN_P_200104_mean, 
                            SAN_JUAN_P_200105_mean, SAN_JUAN_P_200106_mean, SAN_JUAN_P_200107_mean, SAN_JUAN_P_200108_mean, 
                            SAN_JUAN_P_200109_mean, SAN_JUAN_P_200110_mean, SAN_JUAN_P_200111_mean, SAN_JUAN_P_200112_mean)
SAN_JUAN_2002 <- data.frame(SAN_JUAN_P_200201_mean, SAN_JUAN_P_200202_mean, SAN_JUAN_P_200203_mean, SAN_JUAN_P_200204_mean, 
                            SAN_JUAN_P_200205_mean, SAN_JUAN_P_200206_mean, SAN_JUAN_P_200207_mean, SAN_JUAN_P_200208_mean, 
                            SAN_JUAN_P_200209_mean, SAN_JUAN_P_200210_mean, SAN_JUAN_P_200211_mean, SAN_JUAN_P_200212_mean)
SAN_JUAN_2003 <- data.frame(SAN_JUAN_P_200301_mean, SAN_JUAN_P_200302_mean, SAN_JUAN_P_200303_mean, SAN_JUAN_P_200304_mean, 
                            SAN_JUAN_P_200305_mean, SAN_JUAN_P_200306_mean, SAN_JUAN_P_200307_mean, SAN_JUAN_P_200308_mean, 
                            SAN_JUAN_P_200309_mean, SAN_JUAN_P_200310_mean, SAN_JUAN_P_200311_mean, SAN_JUAN_P_200312_mean)
SAN_JUAN_2004 <- data.frame(SAN_JUAN_P_200401_mean, SAN_JUAN_P_200402_mean, SAN_JUAN_P_200403_mean, SAN_JUAN_P_200404_mean, 
                            SAN_JUAN_P_200405_mean, SAN_JUAN_P_200406_mean, SAN_JUAN_P_200407_mean, SAN_JUAN_P_200408_mean, 
                            SAN_JUAN_P_200409_mean, SAN_JUAN_P_200410_mean, SAN_JUAN_P_200411_mean, SAN_JUAN_P_200412_mean)
SAN_JUAN_2005 <- data.frame(SAN_JUAN_P_200501_mean, SAN_JUAN_P_200502_mean, SAN_JUAN_P_200503_mean, SAN_JUAN_P_200504_mean, 
                            SAN_JUAN_P_200505_mean, SAN_JUAN_P_200506_mean, SAN_JUAN_P_200507_mean, SAN_JUAN_P_200508_mean, 
                            SAN_JUAN_P_200509_mean, SAN_JUAN_P_200510_mean, SAN_JUAN_P_200511_mean, SAN_JUAN_P_200512_mean)
SAN_JUAN_2006 <- data.frame(SAN_JUAN_P_200601_mean, SAN_JUAN_P_200602_mean, SAN_JUAN_P_200603_mean, SAN_JUAN_P_200604_mean, 
                            SAN_JUAN_P_200605_mean, SAN_JUAN_P_200606_mean, SAN_JUAN_P_200607_mean, SAN_JUAN_P_200608_mean, 
                            SAN_JUAN_P_200609_mean, SAN_JUAN_P_200610_mean, SAN_JUAN_P_200611_mean, SAN_JUAN_P_200612_mean)
SAN_JUAN_2007 <- data.frame(SAN_JUAN_P_200701_mean, SAN_JUAN_P_200702_mean, SAN_JUAN_P_200703_mean, SAN_JUAN_P_200704_mean, 
                            SAN_JUAN_P_200705_mean, SAN_JUAN_P_200706_mean, SAN_JUAN_P_200707_mean, SAN_JUAN_P_200708_mean, 
                            SAN_JUAN_P_200709_mean, SAN_JUAN_P_200710_mean, SAN_JUAN_P_200711_mean, SAN_JUAN_P_200712_mean)
SAN_JUAN_2008 <- data.frame(SAN_JUAN_P_200801_mean, SAN_JUAN_P_200802_mean, SAN_JUAN_P_200803_mean, SAN_JUAN_P_200804_mean, 
                            SAN_JUAN_P_200805_mean, SAN_JUAN_P_200806_mean, SAN_JUAN_P_200807_mean, SAN_JUAN_P_200808_mean, 
                            SAN_JUAN_P_200809_mean, SAN_JUAN_P_200810_mean, SAN_JUAN_P_200811_mean, SAN_JUAN_P_200812_mean)
SAN_JUAN_2009 <- data.frame(SAN_JUAN_P_200901_mean, SAN_JUAN_P_200902_mean, SAN_JUAN_P_200903_mean, SAN_JUAN_P_200904_mean, 
                            SAN_JUAN_P_200905_mean, SAN_JUAN_P_200906_mean, SAN_JUAN_P_200907_mean, SAN_JUAN_P_200908_mean, 
                            SAN_JUAN_P_200909_mean, SAN_JUAN_P_200910_mean, SAN_JUAN_P_200911_mean, SAN_JUAN_P_200912_mean)
SAN_JUAN_2010 <- data.frame(SAN_JUAN_P_201001_mean, SAN_JUAN_P_201002_mean, SAN_JUAN_P_201003_mean, SAN_JUAN_P_201004_mean, 
                            SAN_JUAN_P_201005_mean, SAN_JUAN_P_201006_mean, SAN_JUAN_P_201007_mean, SAN_JUAN_P_201008_mean, 
                            SAN_JUAN_P_201009_mean, SAN_JUAN_P_201010_mean, SAN_JUAN_P_201011_mean, SAN_JUAN_P_201012_mean)
SAN_JUAN_2011 <- data.frame(SAN_JUAN_P_201101_mean, SAN_JUAN_P_201102_mean, SAN_JUAN_P_201103_mean, SAN_JUAN_P_201104_mean, 
                            SAN_JUAN_P_201105_mean, SAN_JUAN_P_201106_mean, SAN_JUAN_P_201107_mean, SAN_JUAN_P_201108_mean, 
                            SAN_JUAN_P_201109_mean, SAN_JUAN_P_201110_mean, SAN_JUAN_P_201111_mean, SAN_JUAN_P_201112_mean)
SAN_JUAN_2012 <- data.frame(SAN_JUAN_P_201201_mean, SAN_JUAN_P_201202_mean, SAN_JUAN_P_201203_mean, SAN_JUAN_P_201204_mean, 
                            SAN_JUAN_P_201205_mean, SAN_JUAN_P_201206_mean, SAN_JUAN_P_201207_mean, SAN_JUAN_P_201208_mean, 
                            SAN_JUAN_P_201209_mean, SAN_JUAN_P_201210_mean, SAN_JUAN_P_201211_mean, SAN_JUAN_P_201212_mean)
SAN_JUAN_2013 <- data.frame(SAN_JUAN_P_201301_mean, SAN_JUAN_P_201302_mean, SAN_JUAN_P_201303_mean, SAN_JUAN_P_201304_mean, 
                            SAN_JUAN_P_201305_mean, SAN_JUAN_P_201306_mean, SAN_JUAN_P_201307_mean, SAN_JUAN_P_201308_mean, 
                            SAN_JUAN_P_201309_mean, SAN_JUAN_P_201310_mean, SAN_JUAN_P_201311_mean, SAN_JUAN_P_201312_mean)
SAN_JUAN_2014 <- data.frame(SAN_JUAN_P_201401_mean, SAN_JUAN_P_201402_mean, SAN_JUAN_P_201403_mean, SAN_JUAN_P_201404_mean, 
                            SAN_JUAN_P_201405_mean, SAN_JUAN_P_201406_mean, SAN_JUAN_P_201407_mean, SAN_JUAN_P_201408_mean, 
                            SAN_JUAN_P_201409_mean, SAN_JUAN_P_201410_mean, SAN_JUAN_P_201411_mean, SAN_JUAN_P_201412_mean)
SAN_JUAN_2015 <- data.frame(SAN_JUAN_P_201501_mean, SAN_JUAN_P_201502_mean, SAN_JUAN_P_201503_mean, SAN_JUAN_P_201504_mean, 
                            SAN_JUAN_P_201505_mean, SAN_JUAN_P_201506_mean, SAN_JUAN_P_201507_mean, SAN_JUAN_P_201508_mean, 
                            SAN_JUAN_P_201509_mean, SAN_JUAN_P_201510_mean, SAN_JUAN_P_201511_mean, SAN_JUAN_P_201512_mean)
SAN_JUAN_2016 <- data.frame(SAN_JUAN_P_201601_mean, SAN_JUAN_P_201602_mean, SAN_JUAN_P_201603_mean, SAN_JUAN_P_201604_mean, 
                            SAN_JUAN_P_201605_mean, SAN_JUAN_P_201606_mean, SAN_JUAN_P_201607_mean, SAN_JUAN_P_201608_mean, 
                            SAN_JUAN_P_201609_mean, SAN_JUAN_P_201610_mean, SAN_JUAN_P_201611_mean, SAN_JUAN_P_201612_mean)
SAN_JUAN_2017 <- data.frame(SAN_JUAN_P_201701_mean, SAN_JUAN_P_201702_mean, SAN_JUAN_P_201703_mean, SAN_JUAN_P_201704_mean, 
                            SAN_JUAN_P_201705_mean, SAN_JUAN_P_201706_mean, SAN_JUAN_P_201707_mean, SAN_JUAN_P_201708_mean, 
                            SAN_JUAN_P_201709_mean, SAN_JUAN_P_201710_mean, SAN_JUAN_P_201711_mean, SAN_JUAN_P_201712_mean)
SAN_JUAN_2018 <- data.frame(SAN_JUAN_P_201801_mean, SAN_JUAN_P_201802_mean, SAN_JUAN_P_201803_mean, SAN_JUAN_P_201804_mean, 
                            SAN_JUAN_P_201805_mean, SAN_JUAN_P_201806_mean, SAN_JUAN_P_201807_mean, SAN_JUAN_P_201808_mean, 
                            SAN_JUAN_P_201809_mean)
#SEVIER
SEVIER_2000 <- data.frame(SEVIER_P_200001_mean, SEVIER_P_200002_mean, SEVIER_P_200003_mean, SEVIER_P_200004_mean, 
                          SEVIER_P_200005_mean, SEVIER_P_200006_mean, SEVIER_P_200007_mean, SEVIER_P_200008_mean, 
                          SEVIER_P_200009_mean, SEVIER_P_200010_mean, SEVIER_P_200011_mean, SEVIER_P_200012_mean)
SEVIER_2001 <- data.frame(SEVIER_P_200101_mean, SEVIER_P_200102_mean, SEVIER_P_200103_mean, SEVIER_P_200104_mean, 
                          SEVIER_P_200105_mean, SEVIER_P_200106_mean, SEVIER_P_200107_mean, SEVIER_P_200108_mean, 
                          SEVIER_P_200109_mean, SEVIER_P_200110_mean, SEVIER_P_200111_mean, SEVIER_P_200112_mean)
SEVIER_2002 <- data.frame(SEVIER_P_200201_mean, SEVIER_P_200202_mean, SEVIER_P_200203_mean, SEVIER_P_200204_mean, 
                          SEVIER_P_200205_mean, SEVIER_P_200206_mean, SEVIER_P_200207_mean, SEVIER_P_200208_mean, 
                          SEVIER_P_200209_mean, SEVIER_P_200210_mean, SEVIER_P_200211_mean, SEVIER_P_200212_mean)
SEVIER_2003 <- data.frame(SEVIER_P_200301_mean, SEVIER_P_200302_mean, SEVIER_P_200303_mean, SEVIER_P_200304_mean, 
                          SEVIER_P_200305_mean, SEVIER_P_200306_mean, SEVIER_P_200307_mean, SEVIER_P_200308_mean, 
                          SEVIER_P_200309_mean, SEVIER_P_200310_mean, SEVIER_P_200311_mean, SEVIER_P_200312_mean)
SEVIER_2004 <- data.frame(SEVIER_P_200401_mean, SEVIER_P_200402_mean, SEVIER_P_200403_mean, SEVIER_P_200404_mean, 
                          SEVIER_P_200405_mean, SEVIER_P_200406_mean, SEVIER_P_200407_mean, SEVIER_P_200408_mean, 
                          SEVIER_P_200409_mean, SEVIER_P_200410_mean, SEVIER_P_200411_mean, SEVIER_P_200412_mean)
SEVIER_2005 <- data.frame(SEVIER_P_200501_mean, SEVIER_P_200502_mean, SEVIER_P_200503_mean, SEVIER_P_200504_mean, 
                          SEVIER_P_200505_mean, SEVIER_P_200506_mean, SEVIER_P_200507_mean, SEVIER_P_200508_mean, 
                          SEVIER_P_200509_mean, SEVIER_P_200510_mean, SEVIER_P_200511_mean, SEVIER_P_200512_mean)
SEVIER_2006 <- data.frame(SEVIER_P_200601_mean, SEVIER_P_200602_mean, SEVIER_P_200603_mean, SEVIER_P_200604_mean, 
                          SEVIER_P_200605_mean, SEVIER_P_200606_mean, SEVIER_P_200607_mean, SEVIER_P_200608_mean, 
                          SEVIER_P_200609_mean, SEVIER_P_200610_mean, SEVIER_P_200611_mean, SEVIER_P_200612_mean)
SEVIER_2007 <- data.frame(SEVIER_P_200701_mean, SEVIER_P_200702_mean, SEVIER_P_200703_mean, SEVIER_P_200704_mean, 
                          SEVIER_P_200705_mean, SEVIER_P_200706_mean, SEVIER_P_200707_mean, SEVIER_P_200708_mean, 
                          SEVIER_P_200709_mean, SEVIER_P_200710_mean, SEVIER_P_200711_mean, SEVIER_P_200712_mean)
SEVIER_2008 <- data.frame(SEVIER_P_200801_mean, SEVIER_P_200802_mean, SEVIER_P_200803_mean, SEVIER_P_200804_mean, 
                          SEVIER_P_200805_mean, SEVIER_P_200806_mean, SEVIER_P_200807_mean, SEVIER_P_200808_mean, 
                          SEVIER_P_200809_mean, SEVIER_P_200810_mean, SEVIER_P_200811_mean, SEVIER_P_200812_mean)
SEVIER_2009 <- data.frame(SEVIER_P_200901_mean, SEVIER_P_200902_mean, SEVIER_P_200903_mean, SEVIER_P_200904_mean, 
                          SEVIER_P_200905_mean, SEVIER_P_200906_mean, SEVIER_P_200907_mean, SEVIER_P_200908_mean, 
                          SEVIER_P_200909_mean, SEVIER_P_200910_mean, SEVIER_P_200911_mean, SEVIER_P_200912_mean)
SEVIER_2010 <- data.frame(SEVIER_P_201001_mean, SEVIER_P_201002_mean, SEVIER_P_201003_mean, SEVIER_P_201004_mean, 
                          SEVIER_P_201005_mean, SEVIER_P_201006_mean, SEVIER_P_201007_mean, SEVIER_P_201008_mean, 
                          SEVIER_P_201009_mean, SEVIER_P_201010_mean, SEVIER_P_201011_mean, SEVIER_P_201012_mean)
SEVIER_2011 <- data.frame(SEVIER_P_201101_mean, SEVIER_P_201102_mean, SEVIER_P_201103_mean, SEVIER_P_201104_mean, 
                          SEVIER_P_201105_mean, SEVIER_P_201106_mean, SEVIER_P_201107_mean, SEVIER_P_201108_mean, 
                          SEVIER_P_201109_mean, SEVIER_P_201110_mean, SEVIER_P_201111_mean, SEVIER_P_201112_mean)
SEVIER_2012 <- data.frame(SEVIER_P_201201_mean, SEVIER_P_201202_mean, SEVIER_P_201203_mean, SEVIER_P_201204_mean, 
                          SEVIER_P_201205_mean, SEVIER_P_201206_mean, SEVIER_P_201207_mean, SEVIER_P_201208_mean, 
                          SEVIER_P_201209_mean, SEVIER_P_201210_mean, SEVIER_P_201211_mean, SEVIER_P_201212_mean)
SEVIER_2013 <- data.frame(SEVIER_P_201301_mean, SEVIER_P_201302_mean, SEVIER_P_201303_mean, SEVIER_P_201304_mean, 
                          SEVIER_P_201305_mean, SEVIER_P_201306_mean, SEVIER_P_201307_mean, SEVIER_P_201308_mean, 
                          SEVIER_P_201309_mean, SEVIER_P_201310_mean, SEVIER_P_201311_mean, SEVIER_P_201312_mean)
SEVIER_2014 <- data.frame(SEVIER_P_201401_mean, SEVIER_P_201402_mean, SEVIER_P_201403_mean, SEVIER_P_201404_mean, 
                          SEVIER_P_201405_mean, SEVIER_P_201406_mean, SEVIER_P_201407_mean, SEVIER_P_201408_mean, 
                          SEVIER_P_201409_mean, SEVIER_P_201410_mean, SEVIER_P_201411_mean, SEVIER_P_201412_mean)
SEVIER_2015 <- data.frame(SEVIER_P_201501_mean, SEVIER_P_201502_mean, SEVIER_P_201503_mean, SEVIER_P_201504_mean, 
                          SEVIER_P_201505_mean, SEVIER_P_201506_mean, SEVIER_P_201507_mean, SEVIER_P_201508_mean, 
                          SEVIER_P_201509_mean, SEVIER_P_201510_mean, SEVIER_P_201511_mean, SEVIER_P_201512_mean)
SEVIER_2016 <- data.frame(SEVIER_P_201601_mean, SEVIER_P_201602_mean, SEVIER_P_201603_mean, SEVIER_P_201604_mean, 
                          SEVIER_P_201605_mean, SEVIER_P_201606_mean, SEVIER_P_201607_mean, SEVIER_P_201608_mean, 
                          SEVIER_P_201609_mean, SEVIER_P_201610_mean, SEVIER_P_201611_mean, SEVIER_P_201612_mean)
SEVIER_2017 <- data.frame(SEVIER_P_201701_mean, SEVIER_P_201702_mean, SEVIER_P_201703_mean, SEVIER_P_201704_mean, 
                          SEVIER_P_201705_mean, SEVIER_P_201706_mean, SEVIER_P_201707_mean, SEVIER_P_201708_mean, 
                          SEVIER_P_201709_mean, SEVIER_P_201710_mean, SEVIER_P_201711_mean, SEVIER_P_201712_mean)
SEVIER_2018 <- data.frame(SEVIER_P_201801_mean, SEVIER_P_201802_mean, SEVIER_P_201803_mean, SEVIER_P_201804_mean, 
                          SEVIER_P_201805_mean, SEVIER_P_201806_mean, SEVIER_P_201807_mean, SEVIER_P_201808_mean, 
                          SEVIER_P_201809_mean)

#SUMMIT
SUMMIT_2000 <- data.frame(SUMMIT_P_200001_mean, SUMMIT_P_200002_mean, SUMMIT_P_200003_mean, SUMMIT_P_200004_mean, 
                          SUMMIT_P_200005_mean, SUMMIT_P_200006_mean, SUMMIT_P_200007_mean, SUMMIT_P_200008_mean, 
                          SUMMIT_P_200009_mean, SUMMIT_P_200010_mean, SUMMIT_P_200011_mean, SUMMIT_P_200012_mean)
SUMMIT_2001 <- data.frame(SUMMIT_P_200101_mean, SUMMIT_P_200102_mean, SUMMIT_P_200103_mean, SUMMIT_P_200104_mean, 
                          SUMMIT_P_200105_mean, SUMMIT_P_200106_mean, SUMMIT_P_200107_mean, SUMMIT_P_200108_mean, 
                          SUMMIT_P_200109_mean, SUMMIT_P_200110_mean, SUMMIT_P_200111_mean, SUMMIT_P_200112_mean)
SUMMIT_2002 <- data.frame(SUMMIT_P_200201_mean, SUMMIT_P_200202_mean, SUMMIT_P_200203_mean, SUMMIT_P_200204_mean, 
                          SUMMIT_P_200205_mean, SUMMIT_P_200206_mean, SUMMIT_P_200207_mean, SUMMIT_P_200208_mean, 
                          SUMMIT_P_200209_mean, SUMMIT_P_200210_mean, SUMMIT_P_200211_mean, SUMMIT_P_200212_mean)
SUMMIT_2003 <- data.frame(SUMMIT_P_200301_mean, SUMMIT_P_200302_mean, SUMMIT_P_200303_mean, SUMMIT_P_200304_mean, 
                          SUMMIT_P_200305_mean, SUMMIT_P_200306_mean, SUMMIT_P_200307_mean, SUMMIT_P_200308_mean, 
                          SUMMIT_P_200309_mean, SUMMIT_P_200310_mean, SUMMIT_P_200311_mean, SUMMIT_P_200312_mean)
SUMMIT_2004 <- data.frame(SUMMIT_P_200401_mean, SUMMIT_P_200402_mean, SUMMIT_P_200403_mean, SUMMIT_P_200404_mean, 
                          SUMMIT_P_200405_mean, SUMMIT_P_200406_mean, SUMMIT_P_200407_mean, SUMMIT_P_200408_mean, 
                          SUMMIT_P_200409_mean, SUMMIT_P_200410_mean, SUMMIT_P_200411_mean, SUMMIT_P_200412_mean)
SUMMIT_2005 <- data.frame(SUMMIT_P_200501_mean, SUMMIT_P_200502_mean, SUMMIT_P_200503_mean, SUMMIT_P_200504_mean, 
                          SUMMIT_P_200505_mean, SUMMIT_P_200506_mean, SUMMIT_P_200507_mean, SUMMIT_P_200508_mean, 
                          SUMMIT_P_200509_mean, SUMMIT_P_200510_mean, SUMMIT_P_200511_mean, SUMMIT_P_200512_mean)
SUMMIT_2006 <- data.frame(SUMMIT_P_200601_mean, SUMMIT_P_200602_mean, SUMMIT_P_200603_mean, SUMMIT_P_200604_mean, 
                          SUMMIT_P_200605_mean, SUMMIT_P_200606_mean, SUMMIT_P_200607_mean, SUMMIT_P_200608_mean, 
                          SUMMIT_P_200609_mean, SUMMIT_P_200610_mean, SUMMIT_P_200611_mean, SUMMIT_P_200612_mean)
SUMMIT_2007 <- data.frame(SUMMIT_P_200701_mean, SUMMIT_P_200702_mean, SUMMIT_P_200703_mean, SUMMIT_P_200704_mean, 
                          SUMMIT_P_200705_mean, SUMMIT_P_200706_mean, SUMMIT_P_200707_mean, SUMMIT_P_200708_mean, 
                          SUMMIT_P_200709_mean, SUMMIT_P_200710_mean, SUMMIT_P_200711_mean, SUMMIT_P_200712_mean)
SUMMIT_2008 <- data.frame(SUMMIT_P_200801_mean, SUMMIT_P_200802_mean, SUMMIT_P_200803_mean, SUMMIT_P_200804_mean, 
                          SUMMIT_P_200805_mean, SUMMIT_P_200806_mean, SUMMIT_P_200807_mean, SUMMIT_P_200808_mean, 
                          SUMMIT_P_200809_mean, SUMMIT_P_200810_mean, SUMMIT_P_200811_mean, SUMMIT_P_200812_mean)
SUMMIT_2009 <- data.frame(SUMMIT_P_200901_mean, SUMMIT_P_200902_mean, SUMMIT_P_200903_mean, SUMMIT_P_200904_mean, 
                          SUMMIT_P_200905_mean, SUMMIT_P_200906_mean, SUMMIT_P_200907_mean, SUMMIT_P_200908_mean, 
                          SUMMIT_P_200909_mean, SUMMIT_P_200910_mean, SUMMIT_P_200911_mean, SUMMIT_P_200912_mean)
SUMMIT_2010 <- data.frame(SUMMIT_P_201001_mean, SUMMIT_P_201002_mean, SUMMIT_P_201003_mean, SUMMIT_P_201004_mean, 
                          SUMMIT_P_201005_mean, SUMMIT_P_201006_mean, SUMMIT_P_201007_mean, SUMMIT_P_201008_mean, 
                          SUMMIT_P_201009_mean, SUMMIT_P_201010_mean, SUMMIT_P_201011_mean, SUMMIT_P_201012_mean)
SUMMIT_2011 <- data.frame(SUMMIT_P_201101_mean, SUMMIT_P_201102_mean, SUMMIT_P_201103_mean, SUMMIT_P_201104_mean, 
                          SUMMIT_P_201105_mean, SUMMIT_P_201106_mean, SUMMIT_P_201107_mean, SUMMIT_P_201108_mean, 
                          SUMMIT_P_201109_mean, SUMMIT_P_201110_mean, SUMMIT_P_201111_mean, SUMMIT_P_201112_mean)
SUMMIT_2012 <- data.frame(SUMMIT_P_201201_mean, SUMMIT_P_201202_mean, SUMMIT_P_201203_mean, SUMMIT_P_201204_mean, 
                          SUMMIT_P_201205_mean, SUMMIT_P_201206_mean, SUMMIT_P_201207_mean, SUMMIT_P_201208_mean, 
                          SUMMIT_P_201209_mean, SUMMIT_P_201210_mean, SUMMIT_P_201211_mean, SUMMIT_P_201212_mean)
SUMMIT_2013 <- data.frame(SUMMIT_P_201301_mean, SUMMIT_P_201302_mean, SUMMIT_P_201303_mean, SUMMIT_P_201304_mean, 
                          SUMMIT_P_201305_mean, SUMMIT_P_201306_mean, SUMMIT_P_201307_mean, SUMMIT_P_201308_mean, 
                          SUMMIT_P_201309_mean, SUMMIT_P_201310_mean, SUMMIT_P_201311_mean, SUMMIT_P_201312_mean)
SUMMIT_2014 <- data.frame(SUMMIT_P_201401_mean, SUMMIT_P_201402_mean, SUMMIT_P_201403_mean, SUMMIT_P_201404_mean, 
                          SUMMIT_P_201405_mean, SUMMIT_P_201406_mean, SUMMIT_P_201407_mean, SUMMIT_P_201408_mean, 
                          SUMMIT_P_201409_mean, SUMMIT_P_201410_mean, SUMMIT_P_201411_mean, SUMMIT_P_201412_mean)
SUMMIT_2015 <- data.frame(SUMMIT_P_201501_mean, SUMMIT_P_201502_mean, SUMMIT_P_201503_mean, SUMMIT_P_201504_mean, 
                          SUMMIT_P_201505_mean, SUMMIT_P_201506_mean, SUMMIT_P_201507_mean, SUMMIT_P_201508_mean, 
                          SUMMIT_P_201509_mean, SUMMIT_P_201510_mean, SUMMIT_P_201511_mean, SUMMIT_P_201512_mean)
SUMMIT_2016 <- data.frame(SUMMIT_P_201601_mean, SUMMIT_P_201602_mean, SUMMIT_P_201603_mean, SUMMIT_P_201604_mean, 
                          SUMMIT_P_201605_mean, SUMMIT_P_201606_mean, SUMMIT_P_201607_mean, SUMMIT_P_201608_mean, 
                          SUMMIT_P_201609_mean, SUMMIT_P_201610_mean, SUMMIT_P_201611_mean, SUMMIT_P_201612_mean)
SUMMIT_2017 <- data.frame(SUMMIT_P_201701_mean, SUMMIT_P_201702_mean, SUMMIT_P_201703_mean, SUMMIT_P_201704_mean, 
                          SUMMIT_P_201705_mean, SUMMIT_P_201706_mean, SUMMIT_P_201707_mean, SUMMIT_P_201708_mean, 
                          SUMMIT_P_201709_mean, SUMMIT_P_201710_mean, SUMMIT_P_201711_mean, SUMMIT_P_201712_mean)
SUMMIT_2018 <- data.frame(SUMMIT_P_201801_mean, SUMMIT_P_201802_mean, SUMMIT_P_201803_mean, SUMMIT_P_201804_mean, 
                          SUMMIT_P_201805_mean, SUMMIT_P_201806_mean, SUMMIT_P_201807_mean, SUMMIT_P_201808_mean, 
                          SUMMIT_P_201809_mean)

#TOOELE
TOOELE_2000 <- data.frame(TOOELE_P_200001_mean, TOOELE_P_200002_mean, TOOELE_P_200003_mean, TOOELE_P_200004_mean, 
                          TOOELE_P_200005_mean, TOOELE_P_200006_mean, TOOELE_P_200007_mean, TOOELE_P_200008_mean, 
                          TOOELE_P_200009_mean, TOOELE_P_200010_mean, TOOELE_P_200011_mean, TOOELE_P_200012_mean)
TOOELE_2001 <- data.frame(TOOELE_P_200101_mean, TOOELE_P_200102_mean, TOOELE_P_200103_mean, TOOELE_P_200104_mean, 
                          TOOELE_P_200105_mean, TOOELE_P_200106_mean, TOOELE_P_200107_mean, TOOELE_P_200108_mean, 
                          TOOELE_P_200109_mean, TOOELE_P_200110_mean, TOOELE_P_200111_mean, TOOELE_P_200112_mean)
TOOELE_2002 <- data.frame(TOOELE_P_200201_mean, TOOELE_P_200202_mean, TOOELE_P_200203_mean, TOOELE_P_200204_mean, 
                          TOOELE_P_200205_mean, TOOELE_P_200206_mean, TOOELE_P_200207_mean, TOOELE_P_200208_mean, 
                          TOOELE_P_200209_mean, TOOELE_P_200210_mean, TOOELE_P_200211_mean, TOOELE_P_200212_mean)
TOOELE_2003 <- data.frame(TOOELE_P_200301_mean, TOOELE_P_200302_mean, TOOELE_P_200303_mean, TOOELE_P_200304_mean, 
                          TOOELE_P_200305_mean, TOOELE_P_200306_mean, TOOELE_P_200307_mean, TOOELE_P_200308_mean, 
                          TOOELE_P_200309_mean, TOOELE_P_200310_mean, TOOELE_P_200311_mean, TOOELE_P_200312_mean)
TOOELE_2004 <- data.frame(TOOELE_P_200401_mean, TOOELE_P_200402_mean, TOOELE_P_200403_mean, TOOELE_P_200404_mean, 
                          TOOELE_P_200405_mean, TOOELE_P_200406_mean, TOOELE_P_200407_mean, TOOELE_P_200408_mean, 
                          TOOELE_P_200409_mean, TOOELE_P_200410_mean, TOOELE_P_200411_mean, TOOELE_P_200412_mean)
TOOELE_2005 <- data.frame(TOOELE_P_200501_mean, TOOELE_P_200502_mean, TOOELE_P_200503_mean, TOOELE_P_200504_mean, 
                          TOOELE_P_200505_mean, TOOELE_P_200506_mean, TOOELE_P_200507_mean, TOOELE_P_200508_mean, 
                          TOOELE_P_200509_mean, TOOELE_P_200510_mean, TOOELE_P_200511_mean, TOOELE_P_200512_mean)
TOOELE_2006 <- data.frame(TOOELE_P_200601_mean, TOOELE_P_200602_mean, TOOELE_P_200603_mean, TOOELE_P_200604_mean, 
                          TOOELE_P_200605_mean, TOOELE_P_200606_mean, TOOELE_P_200607_mean, TOOELE_P_200608_mean, 
                          TOOELE_P_200609_mean, TOOELE_P_200610_mean, TOOELE_P_200611_mean, TOOELE_P_200612_mean)
TOOELE_2007 <- data.frame(TOOELE_P_200701_mean, TOOELE_P_200702_mean, TOOELE_P_200703_mean, TOOELE_P_200704_mean, 
                          TOOELE_P_200705_mean, TOOELE_P_200706_mean, TOOELE_P_200707_mean, TOOELE_P_200708_mean, 
                          TOOELE_P_200709_mean, TOOELE_P_200710_mean, TOOELE_P_200711_mean, TOOELE_P_200712_mean)
TOOELE_2008 <- data.frame(TOOELE_P_200801_mean, TOOELE_P_200802_mean, TOOELE_P_200803_mean, TOOELE_P_200804_mean, 
                          TOOELE_P_200805_mean, TOOELE_P_200806_mean, TOOELE_P_200807_mean, TOOELE_P_200808_mean, 
                          TOOELE_P_200809_mean, TOOELE_P_200810_mean, TOOELE_P_200811_mean, TOOELE_P_200812_mean)
TOOELE_2009 <- data.frame(TOOELE_P_200901_mean, TOOELE_P_200902_mean, TOOELE_P_200903_mean, TOOELE_P_200904_mean, 
                          TOOELE_P_200905_mean, TOOELE_P_200906_mean, TOOELE_P_200907_mean, TOOELE_P_200908_mean, 
                          TOOELE_P_200909_mean, TOOELE_P_200910_mean, TOOELE_P_200911_mean, TOOELE_P_200912_mean)
TOOELE_2010 <- data.frame(TOOELE_P_201001_mean, TOOELE_P_201002_mean, TOOELE_P_201003_mean, TOOELE_P_201004_mean, 
                          TOOELE_P_201005_mean, TOOELE_P_201006_mean, TOOELE_P_201007_mean, TOOELE_P_201008_mean, 
                          TOOELE_P_201009_mean, TOOELE_P_201010_mean, TOOELE_P_201011_mean, TOOELE_P_201012_mean)
TOOELE_2011 <- data.frame(TOOELE_P_201101_mean, TOOELE_P_201102_mean, TOOELE_P_201103_mean, TOOELE_P_201104_mean, 
                          TOOELE_P_201105_mean, TOOELE_P_201106_mean, TOOELE_P_201107_mean, TOOELE_P_201108_mean, 
                          TOOELE_P_201109_mean, TOOELE_P_201110_mean, TOOELE_P_201111_mean, TOOELE_P_201112_mean)
TOOELE_2012 <- data.frame(TOOELE_P_201201_mean, TOOELE_P_201202_mean, TOOELE_P_201203_mean, TOOELE_P_201204_mean, 
                          TOOELE_P_201205_mean, TOOELE_P_201206_mean, TOOELE_P_201207_mean, TOOELE_P_201208_mean, 
                          TOOELE_P_201209_mean, TOOELE_P_201210_mean, TOOELE_P_201211_mean, TOOELE_P_201212_mean)
TOOELE_2013 <- data.frame(TOOELE_P_201301_mean, TOOELE_P_201302_mean, TOOELE_P_201303_mean, TOOELE_P_201304_mean, 
                          TOOELE_P_201305_mean, TOOELE_P_201306_mean, TOOELE_P_201307_mean, TOOELE_P_201308_mean, 
                          TOOELE_P_201309_mean, TOOELE_P_201310_mean, TOOELE_P_201311_mean, TOOELE_P_201312_mean)
TOOELE_2014 <- data.frame(TOOELE_P_201401_mean, TOOELE_P_201402_mean, TOOELE_P_201403_mean, TOOELE_P_201404_mean, 
                          TOOELE_P_201405_mean, TOOELE_P_201406_mean, TOOELE_P_201407_mean, TOOELE_P_201408_mean, 
                          TOOELE_P_201409_mean, TOOELE_P_201410_mean, TOOELE_P_201411_mean, TOOELE_P_201412_mean)
TOOELE_2015 <- data.frame(TOOELE_P_201501_mean, TOOELE_P_201502_mean, TOOELE_P_201503_mean, TOOELE_P_201504_mean, 
                          TOOELE_P_201505_mean, TOOELE_P_201506_mean, TOOELE_P_201507_mean, TOOELE_P_201508_mean, 
                          TOOELE_P_201509_mean, TOOELE_P_201510_mean, TOOELE_P_201511_mean, TOOELE_P_201512_mean)
TOOELE_2016 <- data.frame(TOOELE_P_201601_mean, TOOELE_P_201602_mean, TOOELE_P_201603_mean, TOOELE_P_201604_mean, 
                          TOOELE_P_201605_mean, TOOELE_P_201606_mean, TOOELE_P_201607_mean, TOOELE_P_201608_mean, 
                          TOOELE_P_201609_mean, TOOELE_P_201610_mean, TOOELE_P_201611_mean, TOOELE_P_201612_mean)
TOOELE_2017 <- data.frame(TOOELE_P_201701_mean, TOOELE_P_201702_mean, TOOELE_P_201703_mean, TOOELE_P_201704_mean, 
                          TOOELE_P_201705_mean, TOOELE_P_201706_mean, TOOELE_P_201707_mean, TOOELE_P_201708_mean, 
                          TOOELE_P_201709_mean, TOOELE_P_201710_mean, TOOELE_P_201711_mean, TOOELE_P_201712_mean)
TOOELE_2018 <- data.frame(TOOELE_P_201801_mean, TOOELE_P_201802_mean, TOOELE_P_201803_mean, TOOELE_P_201804_mean, 
                          TOOELE_P_201805_mean, TOOELE_P_201806_mean, TOOELE_P_201807_mean, TOOELE_P_201808_mean, 
                          TOOELE_P_201809_mean)

#UTAH
UTAH_2000 <- data.frame(UTAH_P_200001_mean, UTAH_P_200002_mean, UTAH_P_200003_mean, UTAH_P_200004_mean, 
                        UTAH_P_200005_mean, UTAH_P_200006_mean, UTAH_P_200007_mean, UTAH_P_200008_mean, 
                        UTAH_P_200009_mean, UTAH_P_200010_mean, UTAH_P_200011_mean, UTAH_P_200012_mean)
UTAH_2001 <- data.frame(UTAH_P_200101_mean, UTAH_P_200102_mean, UTAH_P_200103_mean, UTAH_P_200104_mean, 
                        UTAH_P_200105_mean, UTAH_P_200106_mean, UTAH_P_200107_mean, UTAH_P_200108_mean, 
                        UTAH_P_200109_mean, UTAH_P_200110_mean, UTAH_P_200111_mean, UTAH_P_200112_mean)
UTAH_2002 <- data.frame(UTAH_P_200201_mean, UTAH_P_200202_mean, UTAH_P_200203_mean, UTAH_P_200204_mean, 
                        UTAH_P_200205_mean, UTAH_P_200206_mean, UTAH_P_200207_mean, UTAH_P_200208_mean, 
                        UTAH_P_200209_mean, UTAH_P_200210_mean, UTAH_P_200211_mean, UTAH_P_200212_mean)
UTAH_2003 <- data.frame(UTAH_P_200301_mean, UTAH_P_200302_mean, UTAH_P_200303_mean, UTAH_P_200304_mean, 
                        UTAH_P_200305_mean, UTAH_P_200306_mean, UTAH_P_200307_mean, UTAH_P_200308_mean, 
                        UTAH_P_200309_mean, UTAH_P_200310_mean, UTAH_P_200311_mean, UTAH_P_200312_mean)
UTAH_2004 <- data.frame(UTAH_P_200401_mean, UTAH_P_200402_mean, UTAH_P_200403_mean, UTAH_P_200404_mean, 
                        UTAH_P_200405_mean, UTAH_P_200406_mean, UTAH_P_200407_mean, UTAH_P_200408_mean, 
                        UTAH_P_200409_mean, UTAH_P_200410_mean, UTAH_P_200411_mean, UTAH_P_200412_mean)
UTAH_2005 <- data.frame(UTAH_P_200501_mean, UTAH_P_200502_mean, UTAH_P_200503_mean, UTAH_P_200504_mean, 
                        UTAH_P_200505_mean, UTAH_P_200506_mean, UTAH_P_200507_mean, UTAH_P_200508_mean, 
                        UTAH_P_200509_mean, UTAH_P_200510_mean, UTAH_P_200511_mean, UTAH_P_200512_mean)
UTAH_2006 <- data.frame(UTAH_P_200601_mean, UTAH_P_200602_mean, UTAH_P_200603_mean, UTAH_P_200604_mean, 
                        UTAH_P_200605_mean, UTAH_P_200606_mean, UTAH_P_200607_mean, UTAH_P_200608_mean, 
                        UTAH_P_200609_mean, UTAH_P_200610_mean, UTAH_P_200611_mean, UTAH_P_200612_mean)
UTAH_2007 <- data.frame(UTAH_P_200701_mean, UTAH_P_200702_mean, UTAH_P_200703_mean, UTAH_P_200704_mean, 
                        UTAH_P_200705_mean, UTAH_P_200706_mean, UTAH_P_200707_mean, UTAH_P_200708_mean, 
                        UTAH_P_200709_mean, UTAH_P_200710_mean, UTAH_P_200711_mean, UTAH_P_200712_mean)
UTAH_2008 <- data.frame(UTAH_P_200801_mean, UTAH_P_200802_mean, UTAH_P_200803_mean, UTAH_P_200804_mean, 
                        UTAH_P_200805_mean, UTAH_P_200806_mean, UTAH_P_200807_mean, UTAH_P_200808_mean, 
                        UTAH_P_200809_mean, UTAH_P_200810_mean, UTAH_P_200811_mean, UTAH_P_200812_mean)
UTAH_2009 <- data.frame(UTAH_P_200901_mean, UTAH_P_200902_mean, UTAH_P_200903_mean, UTAH_P_200904_mean, 
                        UTAH_P_200905_mean, UTAH_P_200906_mean, UTAH_P_200907_mean, UTAH_P_200908_mean, 
                        UTAH_P_200909_mean, UTAH_P_200910_mean, UTAH_P_200911_mean, UTAH_P_200912_mean)
UTAH_2010 <- data.frame(UTAH_P_201001_mean, UTAH_P_201002_mean, UTAH_P_201003_mean, UTAH_P_201004_mean, 
                        UTAH_P_201005_mean, UTAH_P_201006_mean, UTAH_P_201007_mean, UTAH_P_201008_mean, 
                        UTAH_P_201009_mean, UTAH_P_201010_mean, UTAH_P_201011_mean, UTAH_P_201012_mean)
UTAH_2011 <- data.frame(UTAH_P_201101_mean, UTAH_P_201102_mean, UTAH_P_201103_mean, UTAH_P_201104_mean, 
                        UTAH_P_201105_mean, UTAH_P_201106_mean, UTAH_P_201107_mean, UTAH_P_201108_mean, 
                        UTAH_P_201109_mean, UTAH_P_201110_mean, UTAH_P_201111_mean, UTAH_P_201112_mean)
UTAH_2012 <- data.frame(UTAH_P_201201_mean, UTAH_P_201202_mean, UTAH_P_201203_mean, UTAH_P_201204_mean, 
                        UTAH_P_201205_mean, UTAH_P_201206_mean, UTAH_P_201207_mean, UTAH_P_201208_mean, 
                        UTAH_P_201209_mean, UTAH_P_201210_mean, UTAH_P_201211_mean, UTAH_P_201212_mean)
UTAH_2013 <- data.frame(UTAH_P_201301_mean, UTAH_P_201302_mean, UTAH_P_201303_mean, UTAH_P_201304_mean, 
                        UTAH_P_201305_mean, UTAH_P_201306_mean, UTAH_P_201307_mean, UTAH_P_201308_mean, 
                        UTAH_P_201309_mean, UTAH_P_201310_mean, UTAH_P_201311_mean, UTAH_P_201312_mean)
UTAH_2014 <- data.frame(UTAH_P_201401_mean, UTAH_P_201402_mean, UTAH_P_201403_mean, UTAH_P_201404_mean, 
                        UTAH_P_201405_mean, UTAH_P_201406_mean, UTAH_P_201407_mean, UTAH_P_201408_mean, 
                        UTAH_P_201409_mean, UTAH_P_201410_mean, UTAH_P_201411_mean, UTAH_P_201412_mean)
UTAH_2015 <- data.frame(UTAH_P_201501_mean, UTAH_P_201502_mean, UTAH_P_201503_mean, UTAH_P_201504_mean, 
                        UTAH_P_201505_mean, UTAH_P_201506_mean, UTAH_P_201507_mean, UTAH_P_201508_mean, 
                        UTAH_P_201509_mean, UTAH_P_201510_mean, UTAH_P_201511_mean, UTAH_P_201512_mean)
UTAH_2016 <- data.frame(UTAH_P_201601_mean, UTAH_P_201602_mean, UTAH_P_201603_mean, UTAH_P_201604_mean, 
                        UTAH_P_201605_mean, UTAH_P_201606_mean, UTAH_P_201607_mean, UTAH_P_201608_mean, 
                        UTAH_P_201609_mean, UTAH_P_201610_mean, UTAH_P_201611_mean, UTAH_P_201612_mean)
UTAH_2017 <- data.frame(UTAH_P_201701_mean, UTAH_P_201702_mean, UTAH_P_201703_mean, UTAH_P_201704_mean, 
                        UTAH_P_201705_mean, UTAH_P_201706_mean, UTAH_P_201707_mean, UTAH_P_201708_mean, 
                        UTAH_P_201709_mean, UTAH_P_201710_mean, UTAH_P_201711_mean, UTAH_P_201712_mean)
UTAH_2018 <- data.frame(UTAH_P_201801_mean, UTAH_P_201802_mean, UTAH_P_201803_mean, UTAH_P_201804_mean, 
                        UTAH_P_201805_mean, UTAH_P_201806_mean, UTAH_P_201807_mean, UTAH_P_201808_mean, 
                        UTAH_P_201809_mean)
#UINTAH
UINTAH_2000 <- data.frame(UINTAH_P_200001_mean, UINTAH_P_200002_mean, UINTAH_P_200003_mean, UINTAH_P_200004_mean, 
                          UINTAH_P_200005_mean, UINTAH_P_200006_mean, UINTAH_P_200007_mean, UINTAH_P_200008_mean, 
                          UINTAH_P_200009_mean, UINTAH_P_200010_mean, UINTAH_P_200011_mean, UINTAH_P_200012_mean)
UINTAH_2001 <- data.frame(UINTAH_P_200101_mean, UINTAH_P_200102_mean, UINTAH_P_200103_mean, UINTAH_P_200104_mean, 
                          UINTAH_P_200105_mean, UINTAH_P_200106_mean, UINTAH_P_200107_mean, UINTAH_P_200108_mean, 
                          UINTAH_P_200109_mean, UINTAH_P_200110_mean, UINTAH_P_200111_mean, UINTAH_P_200112_mean)
UINTAH_2002 <- data.frame(UINTAH_P_200201_mean, UINTAH_P_200202_mean, UINTAH_P_200203_mean, UINTAH_P_200204_mean, 
                          UINTAH_P_200205_mean, UINTAH_P_200206_mean, UINTAH_P_200207_mean, UINTAH_P_200208_mean, 
                          UINTAH_P_200209_mean, UINTAH_P_200210_mean, UINTAH_P_200211_mean, UINTAH_P_200212_mean)
UINTAH_2003 <- data.frame(UINTAH_P_200301_mean, UINTAH_P_200302_mean, UINTAH_P_200303_mean, UINTAH_P_200304_mean, 
                          UINTAH_P_200305_mean, UINTAH_P_200306_mean, UINTAH_P_200307_mean, UINTAH_P_200308_mean, 
                          UINTAH_P_200309_mean, UINTAH_P_200310_mean, UINTAH_P_200311_mean, UINTAH_P_200312_mean)
UINTAH_2004 <- data.frame(UINTAH_P_200401_mean, UINTAH_P_200402_mean, UINTAH_P_200403_mean, UINTAH_P_200404_mean, 
                          UINTAH_P_200405_mean, UINTAH_P_200406_mean, UINTAH_P_200407_mean, UINTAH_P_200408_mean, 
                          UINTAH_P_200409_mean, UINTAH_P_200410_mean, UINTAH_P_200411_mean, UINTAH_P_200412_mean)
UINTAH_2005 <- data.frame(UINTAH_P_200501_mean, UINTAH_P_200502_mean, UINTAH_P_200503_mean, UINTAH_P_200504_mean, 
                          UINTAH_P_200505_mean, UINTAH_P_200506_mean, UINTAH_P_200507_mean, UINTAH_P_200508_mean, 
                          UINTAH_P_200509_mean, UINTAH_P_200510_mean, UINTAH_P_200511_mean, UINTAH_P_200512_mean)
UINTAH_2006 <- data.frame(UINTAH_P_200601_mean, UINTAH_P_200602_mean, UINTAH_P_200603_mean, UINTAH_P_200604_mean, 
                          UINTAH_P_200605_mean, UINTAH_P_200606_mean, UINTAH_P_200607_mean, UINTAH_P_200608_mean, 
                          UINTAH_P_200609_mean, UINTAH_P_200610_mean, UINTAH_P_200611_mean, UINTAH_P_200612_mean)
UINTAH_2007 <- data.frame(UINTAH_P_200701_mean, UINTAH_P_200702_mean, UINTAH_P_200703_mean, UINTAH_P_200704_mean, 
                          UINTAH_P_200705_mean, UINTAH_P_200706_mean, UINTAH_P_200707_mean, UINTAH_P_200708_mean, 
                          UINTAH_P_200709_mean, UINTAH_P_200710_mean, UINTAH_P_200711_mean, UINTAH_P_200712_mean)
UINTAH_2008 <- data.frame(UINTAH_P_200801_mean, UINTAH_P_200802_mean, UINTAH_P_200803_mean, UINTAH_P_200804_mean, 
                          UINTAH_P_200805_mean, UINTAH_P_200806_mean, UINTAH_P_200807_mean, UINTAH_P_200808_mean, 
                          UINTAH_P_200809_mean, UINTAH_P_200810_mean, UINTAH_P_200811_mean, UINTAH_P_200812_mean)
UINTAH_2009 <- data.frame(UINTAH_P_200901_mean, UINTAH_P_200902_mean, UINTAH_P_200903_mean, UINTAH_P_200904_mean, 
                          UINTAH_P_200905_mean, UINTAH_P_200906_mean, UINTAH_P_200907_mean, UINTAH_P_200908_mean, 
                          UINTAH_P_200909_mean, UINTAH_P_200910_mean, UINTAH_P_200911_mean, UINTAH_P_200912_mean)
UINTAH_2010 <- data.frame(UINTAH_P_201001_mean, UINTAH_P_201002_mean, UINTAH_P_201003_mean, UINTAH_P_201004_mean, 
                          UINTAH_P_201005_mean, UINTAH_P_201006_mean, UINTAH_P_201007_mean, UINTAH_P_201008_mean, 
                          UINTAH_P_201009_mean, UINTAH_P_201010_mean, UINTAH_P_201011_mean, UINTAH_P_201012_mean)
UINTAH_2011 <- data.frame(UINTAH_P_201101_mean, UINTAH_P_201102_mean, UINTAH_P_201103_mean, UINTAH_P_201104_mean, 
                          UINTAH_P_201105_mean, UINTAH_P_201106_mean, UINTAH_P_201107_mean, UINTAH_P_201108_mean, 
                          UINTAH_P_201109_mean, UINTAH_P_201110_mean, UINTAH_P_201111_mean, UINTAH_P_201112_mean)
UINTAH_2012 <- data.frame(UINTAH_P_201201_mean, UINTAH_P_201202_mean, UINTAH_P_201203_mean, UINTAH_P_201204_mean, 
                          UINTAH_P_201205_mean, UINTAH_P_201206_mean, UINTAH_P_201207_mean, UINTAH_P_201208_mean, 
                          UINTAH_P_201209_mean, UINTAH_P_201210_mean, UINTAH_P_201211_mean, UINTAH_P_201212_mean)
UINTAH_2013 <- data.frame(UINTAH_P_201301_mean, UINTAH_P_201302_mean, UINTAH_P_201303_mean, UINTAH_P_201304_mean, 
                          UINTAH_P_201305_mean, UINTAH_P_201306_mean, UINTAH_P_201307_mean, UINTAH_P_201308_mean, 
                          UINTAH_P_201309_mean, UINTAH_P_201310_mean, UINTAH_P_201311_mean, UINTAH_P_201312_mean)
UINTAH_2014 <- data.frame(UINTAH_P_201401_mean, UINTAH_P_201402_mean, UINTAH_P_201403_mean, UINTAH_P_201404_mean, 
                          UINTAH_P_201405_mean, UINTAH_P_201406_mean, UINTAH_P_201407_mean, UINTAH_P_201408_mean, 
                          UINTAH_P_201409_mean, UINTAH_P_201410_mean, UINTAH_P_201411_mean, UINTAH_P_201412_mean)
UINTAH_2015 <- data.frame(UINTAH_P_201501_mean, UINTAH_P_201502_mean, UINTAH_P_201503_mean, UINTAH_P_201504_mean, 
                          UINTAH_P_201505_mean, UINTAH_P_201506_mean, UINTAH_P_201507_mean, UINTAH_P_201508_mean, 
                          UINTAH_P_201509_mean, UINTAH_P_201510_mean, UINTAH_P_201511_mean, UINTAH_P_201512_mean)
UINTAH_2016 <- data.frame(UINTAH_P_201601_mean, UINTAH_P_201602_mean, UINTAH_P_201603_mean, UINTAH_P_201604_mean, 
                          UINTAH_P_201605_mean, UINTAH_P_201606_mean, UINTAH_P_201607_mean, UINTAH_P_201608_mean, 
                          UINTAH_P_201609_mean, UINTAH_P_201610_mean, UINTAH_P_201611_mean, UINTAH_P_201612_mean)
UINTAH_2017 <- data.frame(UINTAH_P_201701_mean, UINTAH_P_201702_mean, UINTAH_P_201703_mean, UINTAH_P_201704_mean, 
                          UINTAH_P_201705_mean, UINTAH_P_201706_mean, UINTAH_P_201707_mean, UINTAH_P_201708_mean, 
                          UINTAH_P_201709_mean, UINTAH_P_201710_mean, UINTAH_P_201711_mean, UINTAH_P_201712_mean)
UINTAH_2018 <- data.frame(UINTAH_P_201801_mean, UINTAH_P_201802_mean, UINTAH_P_201803_mean, UINTAH_P_201804_mean, 
                          UINTAH_P_201805_mean, UINTAH_P_201806_mean, UINTAH_P_201807_mean, UINTAH_P_201808_mean, 
                          UINTAH_P_201809_mean)
#WAYNE
WAYNE_2000 <- data.frame(WAYNE_P_200001_mean, WAYNE_P_200002_mean, WAYNE_P_200003_mean, WAYNE_P_200004_mean, 
                         WAYNE_P_200005_mean, WAYNE_P_200006_mean, WAYNE_P_200007_mean, WAYNE_P_200008_mean, 
                         WAYNE_P_200009_mean, WAYNE_P_200010_mean, WAYNE_P_200011_mean, WAYNE_P_200012_mean)
WAYNE_2001 <- data.frame(WAYNE_P_200101_mean, WAYNE_P_200102_mean, WAYNE_P_200103_mean, WAYNE_P_200104_mean, 
                         WAYNE_P_200105_mean, WAYNE_P_200106_mean, WAYNE_P_200107_mean, WAYNE_P_200108_mean, 
                         WAYNE_P_200109_mean, WAYNE_P_200110_mean, WAYNE_P_200111_mean, WAYNE_P_200112_mean)
WAYNE_2002 <- data.frame(WAYNE_P_200201_mean, WAYNE_P_200202_mean, WAYNE_P_200203_mean, WAYNE_P_200204_mean, 
                         WAYNE_P_200205_mean, WAYNE_P_200206_mean, WAYNE_P_200207_mean, WAYNE_P_200208_mean, 
                         WAYNE_P_200209_mean, WAYNE_P_200210_mean, WAYNE_P_200211_mean, WAYNE_P_200212_mean)
WAYNE_2003 <- data.frame(WAYNE_P_200301_mean, WAYNE_P_200302_mean, WAYNE_P_200303_mean, WAYNE_P_200304_mean, 
                         WAYNE_P_200305_mean, WAYNE_P_200306_mean, WAYNE_P_200307_mean, WAYNE_P_200308_mean, 
                         WAYNE_P_200309_mean, WAYNE_P_200310_mean, WAYNE_P_200311_mean, WAYNE_P_200312_mean)
WAYNE_2004 <- data.frame(WAYNE_P_200401_mean, WAYNE_P_200402_mean, WAYNE_P_200403_mean, WAYNE_P_200404_mean, 
                         WAYNE_P_200405_mean, WAYNE_P_200406_mean, WAYNE_P_200407_mean, WAYNE_P_200408_mean, 
                         WAYNE_P_200409_mean, WAYNE_P_200410_mean, WAYNE_P_200411_mean, WAYNE_P_200412_mean)
WAYNE_2005 <- data.frame(WAYNE_P_200501_mean, WAYNE_P_200502_mean, WAYNE_P_200503_mean, WAYNE_P_200504_mean, 
                         WAYNE_P_200505_mean, WAYNE_P_200506_mean, WAYNE_P_200507_mean, WAYNE_P_200508_mean, 
                         WAYNE_P_200509_mean, WAYNE_P_200510_mean, WAYNE_P_200511_mean, WAYNE_P_200512_mean)
WAYNE_2006 <- data.frame(WAYNE_P_200601_mean, WAYNE_P_200602_mean, WAYNE_P_200603_mean, WAYNE_P_200604_mean, 
                         WAYNE_P_200605_mean, WAYNE_P_200606_mean, WAYNE_P_200607_mean, WAYNE_P_200608_mean, 
                         WAYNE_P_200609_mean, WAYNE_P_200610_mean, WAYNE_P_200611_mean, WAYNE_P_200612_mean)
WAYNE_2007 <- data.frame(WAYNE_P_200701_mean, WAYNE_P_200702_mean, WAYNE_P_200703_mean, WAYNE_P_200704_mean, 
                         WAYNE_P_200705_mean, WAYNE_P_200706_mean, WAYNE_P_200707_mean, WAYNE_P_200708_mean, 
                         WAYNE_P_200709_mean, WAYNE_P_200710_mean, WAYNE_P_200711_mean, WAYNE_P_200712_mean)
WAYNE_2008 <- data.frame(WAYNE_P_200801_mean, WAYNE_P_200802_mean, WAYNE_P_200803_mean, WAYNE_P_200804_mean, 
                         WAYNE_P_200805_mean, WAYNE_P_200806_mean, WAYNE_P_200807_mean, WAYNE_P_200808_mean, 
                         WAYNE_P_200809_mean, WAYNE_P_200810_mean, WAYNE_P_200811_mean, WAYNE_P_200812_mean)
WAYNE_2009 <- data.frame(WAYNE_P_200901_mean, WAYNE_P_200902_mean, WAYNE_P_200903_mean, WAYNE_P_200904_mean, 
                         WAYNE_P_200905_mean, WAYNE_P_200906_mean, WAYNE_P_200907_mean, WAYNE_P_200908_mean, 
                         WAYNE_P_200909_mean, WAYNE_P_200910_mean, WAYNE_P_200911_mean, WAYNE_P_200912_mean)
WAYNE_2010 <- data.frame(WAYNE_P_201001_mean, WAYNE_P_201002_mean, WAYNE_P_201003_mean, WAYNE_P_201004_mean, 
                         WAYNE_P_201005_mean, WAYNE_P_201006_mean, WAYNE_P_201007_mean, WAYNE_P_201008_mean, 
                         WAYNE_P_201009_mean, WAYNE_P_201010_mean, WAYNE_P_201011_mean, WAYNE_P_201012_mean)
WAYNE_2011 <- data.frame(WAYNE_P_201101_mean, WAYNE_P_201102_mean, WAYNE_P_201103_mean, WAYNE_P_201104_mean, 
                         WAYNE_P_201105_mean, WAYNE_P_201106_mean, WAYNE_P_201107_mean, WAYNE_P_201108_mean, 
                         WAYNE_P_201109_mean, WAYNE_P_201110_mean, WAYNE_P_201111_mean, WAYNE_P_201112_mean)
WAYNE_2012 <- data.frame(WAYNE_P_201201_mean, WAYNE_P_201202_mean, WAYNE_P_201203_mean, WAYNE_P_201204_mean, 
                         WAYNE_P_201205_mean, WAYNE_P_201206_mean, WAYNE_P_201207_mean, WAYNE_P_201208_mean, 
                         WAYNE_P_201209_mean, WAYNE_P_201210_mean, WAYNE_P_201211_mean, WAYNE_P_201212_mean)
WAYNE_2013 <- data.frame(WAYNE_P_201301_mean, WAYNE_P_201302_mean, WAYNE_P_201303_mean, WAYNE_P_201304_mean, 
                         WAYNE_P_201305_mean, WAYNE_P_201306_mean, WAYNE_P_201307_mean, WAYNE_P_201308_mean, 
                         WAYNE_P_201309_mean, WAYNE_P_201310_mean, WAYNE_P_201311_mean, WAYNE_P_201312_mean)
WAYNE_2014 <- data.frame(WAYNE_P_201401_mean, WAYNE_P_201402_mean, WAYNE_P_201403_mean, WAYNE_P_201404_mean, 
                         WAYNE_P_201405_mean, WAYNE_P_201406_mean, WAYNE_P_201407_mean, WAYNE_P_201408_mean, 
                         WAYNE_P_201409_mean, WAYNE_P_201410_mean, WAYNE_P_201411_mean, WAYNE_P_201412_mean)
WAYNE_2015 <- data.frame(WAYNE_P_201501_mean, WAYNE_P_201502_mean, WAYNE_P_201503_mean, WAYNE_P_201504_mean, 
                         WAYNE_P_201505_mean, WAYNE_P_201506_mean, WAYNE_P_201507_mean, WAYNE_P_201508_mean, 
                         WAYNE_P_201509_mean, WAYNE_P_201510_mean, WAYNE_P_201511_mean, WAYNE_P_201512_mean)
WAYNE_2016 <- data.frame(WAYNE_P_201601_mean, WAYNE_P_201602_mean, WAYNE_P_201603_mean, WAYNE_P_201604_mean, 
                         WAYNE_P_201605_mean, WAYNE_P_201606_mean, WAYNE_P_201607_mean, WAYNE_P_201608_mean, 
                         WAYNE_P_201609_mean, WAYNE_P_201610_mean, WAYNE_P_201611_mean, WAYNE_P_201612_mean)
WAYNE_2017 <- data.frame(WAYNE_P_201701_mean, WAYNE_P_201702_mean, WAYNE_P_201703_mean, WAYNE_P_201704_mean, 
                         WAYNE_P_201705_mean, WAYNE_P_201706_mean, WAYNE_P_201707_mean, WAYNE_P_201708_mean, 
                         WAYNE_P_201709_mean, WAYNE_P_201710_mean, WAYNE_P_201711_mean, WAYNE_P_201712_mean)
WAYNE_2018 <- data.frame(WAYNE_P_201801_mean, WAYNE_P_201802_mean, WAYNE_P_201803_mean, WAYNE_P_201804_mean, 
                         WAYNE_P_201805_mean, WAYNE_P_201806_mean, WAYNE_P_201807_mean, WAYNE_P_201808_mean, 
                         WAYNE_P_201809_mean)

#WASATCH
WASATCH_2000 <- data.frame(WASATCH_P_200001_mean, WASATCH_P_200002_mean, WASATCH_P_200003_mean, WASATCH_P_200004_mean, 
                           WASATCH_P_200005_mean, WASATCH_P_200006_mean, WASATCH_P_200007_mean, WASATCH_P_200008_mean, 
                           WASATCH_P_200009_mean, WASATCH_P_200010_mean, WASATCH_P_200011_mean, WASATCH_P_200012_mean)
WASATCH_2001 <- data.frame(WASATCH_P_200101_mean, WASATCH_P_200102_mean, WASATCH_P_200103_mean, WASATCH_P_200104_mean, 
                           WASATCH_P_200105_mean, WASATCH_P_200106_mean, WASATCH_P_200107_mean, WASATCH_P_200108_mean, 
                           WASATCH_P_200109_mean, WASATCH_P_200110_mean, WASATCH_P_200111_mean, WASATCH_P_200112_mean)
WASATCH_2002 <- data.frame(WASATCH_P_200201_mean, WASATCH_P_200202_mean, WASATCH_P_200203_mean, WASATCH_P_200204_mean, 
                           WASATCH_P_200205_mean, WASATCH_P_200206_mean, WASATCH_P_200207_mean, WASATCH_P_200208_mean, 
                           WASATCH_P_200209_mean, WASATCH_P_200210_mean, WASATCH_P_200211_mean, WASATCH_P_200212_mean)
WASATCH_2003 <- data.frame(WASATCH_P_200301_mean, WASATCH_P_200302_mean, WASATCH_P_200303_mean, WASATCH_P_200304_mean, 
                           WASATCH_P_200305_mean, WASATCH_P_200306_mean, WASATCH_P_200307_mean, WASATCH_P_200308_mean, 
                           WASATCH_P_200309_mean, WASATCH_P_200310_mean, WASATCH_P_200311_mean, WASATCH_P_200312_mean)
WASATCH_2004 <- data.frame(WASATCH_P_200401_mean, WASATCH_P_200402_mean, WASATCH_P_200403_mean, WASATCH_P_200404_mean, 
                           WASATCH_P_200405_mean, WASATCH_P_200406_mean, WASATCH_P_200407_mean, WASATCH_P_200408_mean, 
                           WASATCH_P_200409_mean, WASATCH_P_200410_mean, WASATCH_P_200411_mean, WASATCH_P_200412_mean)
WASATCH_2005 <- data.frame(WASATCH_P_200501_mean, WASATCH_P_200502_mean, WASATCH_P_200503_mean, WASATCH_P_200504_mean, 
                           WASATCH_P_200505_mean, WASATCH_P_200506_mean, WASATCH_P_200507_mean, WASATCH_P_200508_mean, 
                           WASATCH_P_200509_mean, WASATCH_P_200510_mean, WASATCH_P_200511_mean, WASATCH_P_200512_mean)
WASATCH_2006 <- data.frame(WASATCH_P_200601_mean, WASATCH_P_200602_mean, WASATCH_P_200603_mean, WASATCH_P_200604_mean, 
                           WASATCH_P_200605_mean, WASATCH_P_200606_mean, WASATCH_P_200607_mean, WASATCH_P_200608_mean, 
                           WASATCH_P_200609_mean, WASATCH_P_200610_mean, WASATCH_P_200611_mean, WASATCH_P_200612_mean)
WASATCH_2007 <- data.frame(WASATCH_P_200701_mean, WASATCH_P_200702_mean, WASATCH_P_200703_mean, WASATCH_P_200704_mean, 
                           WASATCH_P_200705_mean, WASATCH_P_200706_mean, WASATCH_P_200707_mean, WASATCH_P_200708_mean, 
                           WASATCH_P_200709_mean, WASATCH_P_200710_mean, WASATCH_P_200711_mean, WASATCH_P_200712_mean)
WASATCH_2008 <- data.frame(WASATCH_P_200801_mean, WASATCH_P_200802_mean, WASATCH_P_200803_mean, WASATCH_P_200804_mean, 
                           WASATCH_P_200805_mean, WASATCH_P_200806_mean, WASATCH_P_200807_mean, WASATCH_P_200808_mean, 
                           WASATCH_P_200809_mean, WASATCH_P_200810_mean, WASATCH_P_200811_mean, WASATCH_P_200812_mean)
WASATCH_2009 <- data.frame(WASATCH_P_200901_mean, WASATCH_P_200902_mean, WASATCH_P_200903_mean, WASATCH_P_200904_mean, 
                           WASATCH_P_200905_mean, WASATCH_P_200906_mean, WASATCH_P_200907_mean, WASATCH_P_200908_mean, 
                           WASATCH_P_200909_mean, WASATCH_P_200910_mean, WASATCH_P_200911_mean, WASATCH_P_200912_mean)
WASATCH_2010 <- data.frame(WASATCH_P_201001_mean, WASATCH_P_201002_mean, WASATCH_P_201003_mean, WASATCH_P_201004_mean, 
                           WASATCH_P_201005_mean, WASATCH_P_201006_mean, WASATCH_P_201007_mean, WASATCH_P_201008_mean, 
                           WASATCH_P_201009_mean, WASATCH_P_201010_mean, WASATCH_P_201011_mean, WASATCH_P_201012_mean)
WASATCH_2011 <- data.frame(WASATCH_P_201101_mean, WASATCH_P_201102_mean, WASATCH_P_201103_mean, WASATCH_P_201104_mean, 
                           WASATCH_P_201105_mean, WASATCH_P_201106_mean, WASATCH_P_201107_mean, WASATCH_P_201108_mean, 
                           WASATCH_P_201109_mean, WASATCH_P_201110_mean, WASATCH_P_201111_mean, WASATCH_P_201112_mean)
WASATCH_2012 <- data.frame(WASATCH_P_201201_mean, WASATCH_P_201202_mean, WASATCH_P_201203_mean, WASATCH_P_201204_mean, 
                           WASATCH_P_201205_mean, WASATCH_P_201206_mean, WASATCH_P_201207_mean, WASATCH_P_201208_mean, 
                           WASATCH_P_201209_mean, WASATCH_P_201210_mean, WASATCH_P_201211_mean, WASATCH_P_201212_mean)
WASATCH_2013 <- data.frame(WASATCH_P_201301_mean, WASATCH_P_201302_mean, WASATCH_P_201303_mean, WASATCH_P_201304_mean, 
                           WASATCH_P_201305_mean, WASATCH_P_201306_mean, WASATCH_P_201307_mean, WASATCH_P_201308_mean, 
                           WASATCH_P_201309_mean, WASATCH_P_201310_mean, WASATCH_P_201311_mean, WASATCH_P_201312_mean)
WASATCH_2014 <- data.frame(WASATCH_P_201401_mean, WASATCH_P_201402_mean, WASATCH_P_201403_mean, WASATCH_P_201404_mean, 
                           WASATCH_P_201405_mean, WASATCH_P_201406_mean, WASATCH_P_201407_mean, WASATCH_P_201408_mean, 
                           WASATCH_P_201409_mean, WASATCH_P_201410_mean, WASATCH_P_201411_mean, WASATCH_P_201412_mean)
WASATCH_2015 <- data.frame(WASATCH_P_201501_mean, WASATCH_P_201502_mean, WASATCH_P_201503_mean, WASATCH_P_201504_mean, 
                           WASATCH_P_201505_mean, WASATCH_P_201506_mean, WASATCH_P_201507_mean, WASATCH_P_201508_mean, 
                           WASATCH_P_201509_mean, WASATCH_P_201510_mean, WASATCH_P_201511_mean, WASATCH_P_201512_mean)
WASATCH_2016 <- data.frame(WASATCH_P_201601_mean, WASATCH_P_201602_mean, WASATCH_P_201603_mean, WASATCH_P_201604_mean, 
                           WASATCH_P_201605_mean, WASATCH_P_201606_mean, WASATCH_P_201607_mean, WASATCH_P_201608_mean, 
                           WASATCH_P_201609_mean, WASATCH_P_201610_mean, WASATCH_P_201611_mean, WASATCH_P_201612_mean)
WASATCH_2017 <- data.frame(WASATCH_P_201701_mean, WASATCH_P_201702_mean, WASATCH_P_201703_mean, WASATCH_P_201704_mean, 
                           WASATCH_P_201705_mean, WASATCH_P_201706_mean, WASATCH_P_201707_mean, WASATCH_P_201708_mean, 
                           WASATCH_P_201709_mean, WASATCH_P_201710_mean, WASATCH_P_201711_mean, WASATCH_P_201712_mean)
WASATCH_2018 <- data.frame(WASATCH_P_201801_mean, WASATCH_P_201802_mean, WASATCH_P_201803_mean, WASATCH_P_201804_mean, 
                           WASATCH_P_201805_mean, WASATCH_P_201806_mean, WASATCH_P_201807_mean, WASATCH_P_201808_mean, 
                           WASATCH_P_201809_mean)

#WASHINGTON
WASHINGTON_2000 <- data.frame(WASHINGTON_P_200001_mean, WASHINGTON_P_200002_mean, WASHINGTON_P_200003_mean, WASHINGTON_P_200004_mean, 
                              WASHINGTON_P_200005_mean, WASHINGTON_P_200006_mean, WASHINGTON_P_200007_mean, WASHINGTON_P_200008_mean, 
                              WASHINGTON_P_200009_mean, WASHINGTON_P_200010_mean, WASHINGTON_P_200011_mean, WASHINGTON_P_200012_mean)
WASHINGTON_2001 <- data.frame(WASHINGTON_P_200101_mean, WASHINGTON_P_200102_mean, WASHINGTON_P_200103_mean, WASHINGTON_P_200104_mean, 
                              WASHINGTON_P_200105_mean, WASHINGTON_P_200106_mean, WASHINGTON_P_200107_mean, WASHINGTON_P_200108_mean, 
                              WASHINGTON_P_200109_mean, WASHINGTON_P_200110_mean, WASHINGTON_P_200111_mean, WASHINGTON_P_200112_mean)
WASHINGTON_2002 <- data.frame(WASHINGTON_P_200201_mean, WASHINGTON_P_200202_mean, WASHINGTON_P_200203_mean, WASHINGTON_P_200204_mean, 
                              WASHINGTON_P_200205_mean, WASHINGTON_P_200206_mean, WASHINGTON_P_200207_mean, WASHINGTON_P_200208_mean, 
                              WASHINGTON_P_200209_mean, WASHINGTON_P_200210_mean, WASHINGTON_P_200211_mean, WASHINGTON_P_200212_mean)
WASHINGTON_2003 <- data.frame(WASHINGTON_P_200301_mean, WASHINGTON_P_200302_mean, WASHINGTON_P_200303_mean, WASHINGTON_P_200304_mean, 
                              WASHINGTON_P_200305_mean, WASHINGTON_P_200306_mean, WASHINGTON_P_200307_mean, WASHINGTON_P_200308_mean, 
                              WASHINGTON_P_200309_mean, WASHINGTON_P_200310_mean, WASHINGTON_P_200311_mean, WASHINGTON_P_200312_mean)
WASHINGTON_2004 <- data.frame(WASHINGTON_P_200401_mean, WASHINGTON_P_200402_mean, WASHINGTON_P_200403_mean, WASHINGTON_P_200404_mean, 
                              WASHINGTON_P_200405_mean, WASHINGTON_P_200406_mean, WASHINGTON_P_200407_mean, WASHINGTON_P_200408_mean, 
                              WASHINGTON_P_200409_mean, WASHINGTON_P_200410_mean, WASHINGTON_P_200411_mean, WASHINGTON_P_200412_mean)
WASHINGTON_2005 <- data.frame(WASHINGTON_P_200501_mean, WASHINGTON_P_200502_mean, WASHINGTON_P_200503_mean, WASHINGTON_P_200504_mean, 
                              WASHINGTON_P_200505_mean, WASHINGTON_P_200506_mean, WASHINGTON_P_200507_mean, WASHINGTON_P_200508_mean, 
                              WASHINGTON_P_200509_mean, WASHINGTON_P_200510_mean, WASHINGTON_P_200511_mean, WASHINGTON_P_200512_mean)
WASHINGTON_2006 <- data.frame(WASHINGTON_P_200601_mean, WASHINGTON_P_200602_mean, WASHINGTON_P_200603_mean, WASHINGTON_P_200604_mean, 
                              WASHINGTON_P_200605_mean, WASHINGTON_P_200606_mean, WASHINGTON_P_200607_mean, WASHINGTON_P_200608_mean, 
                              WASHINGTON_P_200609_mean, WASHINGTON_P_200610_mean, WASHINGTON_P_200611_mean, WASHINGTON_P_200612_mean)
WASHINGTON_2007 <- data.frame(WASHINGTON_P_200701_mean, WASHINGTON_P_200702_mean, WASHINGTON_P_200703_mean, WASHINGTON_P_200704_mean, 
                              WASHINGTON_P_200705_mean, WASHINGTON_P_200706_mean, WASHINGTON_P_200707_mean, WASHINGTON_P_200708_mean, 
                              WASHINGTON_P_200709_mean, WASHINGTON_P_200710_mean, WASHINGTON_P_200711_mean, WASHINGTON_P_200712_mean)
WASHINGTON_2008 <- data.frame(WASHINGTON_P_200801_mean, WASHINGTON_P_200802_mean, WASHINGTON_P_200803_mean, WASHINGTON_P_200804_mean, 
                              WASHINGTON_P_200805_mean, WASHINGTON_P_200806_mean, WASHINGTON_P_200807_mean, WASHINGTON_P_200808_mean, 
                              WASHINGTON_P_200809_mean, WASHINGTON_P_200810_mean, WASHINGTON_P_200811_mean, WASHINGTON_P_200812_mean)
WASHINGTON_2009 <- data.frame(WASHINGTON_P_200901_mean, WASHINGTON_P_200902_mean, WASHINGTON_P_200903_mean, WASHINGTON_P_200904_mean, 
                              WASHINGTON_P_200905_mean, WASHINGTON_P_200906_mean, WASHINGTON_P_200907_mean, WASHINGTON_P_200908_mean, 
                              WASHINGTON_P_200909_mean, WASHINGTON_P_200910_mean, WASHINGTON_P_200911_mean, WASHINGTON_P_200912_mean)
WASHINGTON_2010 <- data.frame(WASHINGTON_P_201001_mean, WASHINGTON_P_201002_mean, WASHINGTON_P_201003_mean, WASHINGTON_P_201004_mean, 
                              WASHINGTON_P_201005_mean, WASHINGTON_P_201006_mean, WASHINGTON_P_201007_mean, WASHINGTON_P_201008_mean, 
                              WASHINGTON_P_201009_mean, WASHINGTON_P_201010_mean, WASHINGTON_P_201011_mean, WASHINGTON_P_201012_mean)
WASHINGTON_2011 <- data.frame(WASHINGTON_P_201101_mean, WASHINGTON_P_201102_mean, WASHINGTON_P_201103_mean, WASHINGTON_P_201104_mean, 
                              WASHINGTON_P_201105_mean, WASHINGTON_P_201106_mean, WASHINGTON_P_201107_mean, WASHINGTON_P_201108_mean, 
                              WASHINGTON_P_201109_mean, WASHINGTON_P_201110_mean, WASHINGTON_P_201111_mean, WASHINGTON_P_201112_mean)
WASHINGTON_2012 <- data.frame(WASHINGTON_P_201201_mean, WASHINGTON_P_201202_mean, WASHINGTON_P_201203_mean, WASHINGTON_P_201204_mean, 
                              WASHINGTON_P_201205_mean, WASHINGTON_P_201206_mean, WASHINGTON_P_201207_mean, WASHINGTON_P_201208_mean, 
                              WASHINGTON_P_201209_mean, WASHINGTON_P_201210_mean, WASHINGTON_P_201211_mean, WASHINGTON_P_201212_mean)
WASHINGTON_2013 <- data.frame(WASHINGTON_P_201301_mean, WASHINGTON_P_201302_mean, WASHINGTON_P_201303_mean, WASHINGTON_P_201304_mean, 
                              WASHINGTON_P_201305_mean, WASHINGTON_P_201306_mean, WASHINGTON_P_201307_mean, WASHINGTON_P_201308_mean, 
                              WASHINGTON_P_201309_mean, WASHINGTON_P_201310_mean, WASHINGTON_P_201311_mean, WASHINGTON_P_201312_mean)
WASHINGTON_2014 <- data.frame(WASHINGTON_P_201401_mean, WASHINGTON_P_201402_mean, WASHINGTON_P_201403_mean, WASHINGTON_P_201404_mean, 
                              WASHINGTON_P_201405_mean, WASHINGTON_P_201406_mean, WASHINGTON_P_201407_mean, WASHINGTON_P_201408_mean, 
                              WASHINGTON_P_201409_mean, WASHINGTON_P_201410_mean, WASHINGTON_P_201411_mean, WASHINGTON_P_201412_mean)
WASHINGTON_2015 <- data.frame(WASHINGTON_P_201501_mean, WASHINGTON_P_201502_mean, WASHINGTON_P_201503_mean, WASHINGTON_P_201504_mean, 
                              WASHINGTON_P_201505_mean, WASHINGTON_P_201506_mean, WASHINGTON_P_201507_mean, WASHINGTON_P_201508_mean, 
                              WASHINGTON_P_201509_mean, WASHINGTON_P_201510_mean, WASHINGTON_P_201511_mean, WASHINGTON_P_201512_mean)
WASHINGTON_2016 <- data.frame(WASHINGTON_P_201601_mean, WASHINGTON_P_201602_mean, WASHINGTON_P_201603_mean, WASHINGTON_P_201604_mean, 
                              WASHINGTON_P_201605_mean, WASHINGTON_P_201606_mean, WASHINGTON_P_201607_mean, WASHINGTON_P_201608_mean, 
                              WASHINGTON_P_201609_mean, WASHINGTON_P_201610_mean, WASHINGTON_P_201611_mean, WASHINGTON_P_201612_mean)
WASHINGTON_2017 <- data.frame(WASHINGTON_P_201701_mean, WASHINGTON_P_201702_mean, WASHINGTON_P_201703_mean, WASHINGTON_P_201704_mean, 
                              WASHINGTON_P_201705_mean, WASHINGTON_P_201706_mean, WASHINGTON_P_201707_mean, WASHINGTON_P_201708_mean, 
                              WASHINGTON_P_201709_mean, WASHINGTON_P_201710_mean, WASHINGTON_P_201711_mean, WASHINGTON_P_201712_mean)
WASHINGTON_2018 <- data.frame(WASHINGTON_P_201801_mean, WASHINGTON_P_201802_mean, WASHINGTON_P_201803_mean, WASHINGTON_P_201804_mean, 
                              WASHINGTON_P_201805_mean, WASHINGTON_P_201806_mean, WASHINGTON_P_201807_mean, WASHINGTON_P_201808_mean, 
                              WASHINGTON_P_201809_mean)
#WEBER
WEBER_2000 <- data.frame(WEBER_P_200001_mean, WEBER_P_200002_mean, WEBER_P_200003_mean, WEBER_P_200004_mean, 
                         WEBER_P_200005_mean, WEBER_P_200006_mean, WEBER_P_200007_mean, WEBER_P_200008_mean, 
                         WEBER_P_200009_mean, WEBER_P_200010_mean, WEBER_P_200011_mean, WEBER_P_200012_mean)
WEBER_2001 <- data.frame(WEBER_P_200101_mean, WEBER_P_200102_mean, WEBER_P_200103_mean, WEBER_P_200104_mean, 
                         WEBER_P_200105_mean, WEBER_P_200106_mean, WEBER_P_200107_mean, WEBER_P_200108_mean, 
                         WEBER_P_200109_mean, WEBER_P_200110_mean, WEBER_P_200111_mean, WEBER_P_200112_mean)
WEBER_2002 <- data.frame(WEBER_P_200201_mean, WEBER_P_200202_mean, WEBER_P_200203_mean, WEBER_P_200204_mean, 
                         WEBER_P_200205_mean, WEBER_P_200206_mean, WEBER_P_200207_mean, WEBER_P_200208_mean, 
                         WEBER_P_200209_mean, WEBER_P_200210_mean, WEBER_P_200211_mean, WEBER_P_200212_mean)
WEBER_2003 <- data.frame(WEBER_P_200301_mean, WEBER_P_200302_mean, WEBER_P_200303_mean, WEBER_P_200304_mean, 
                         WEBER_P_200305_mean, WEBER_P_200306_mean, WEBER_P_200307_mean, WEBER_P_200308_mean, 
                         WEBER_P_200309_mean, WEBER_P_200310_mean, WEBER_P_200311_mean, WEBER_P_200312_mean)
WEBER_2004 <- data.frame(WEBER_P_200401_mean, WEBER_P_200402_mean, WEBER_P_200403_mean, WEBER_P_200404_mean, 
                         WEBER_P_200405_mean, WEBER_P_200406_mean, WEBER_P_200407_mean, WEBER_P_200408_mean, 
                         WEBER_P_200409_mean, WEBER_P_200410_mean, WEBER_P_200411_mean, WEBER_P_200412_mean)
WEBER_2005 <- data.frame(WEBER_P_200501_mean, WEBER_P_200502_mean, WEBER_P_200503_mean, WEBER_P_200504_mean, 
                         WEBER_P_200505_mean, WEBER_P_200506_mean, WEBER_P_200507_mean, WEBER_P_200508_mean, 
                         WEBER_P_200509_mean, WEBER_P_200510_mean, WEBER_P_200511_mean, WEBER_P_200512_mean)
WEBER_2006 <- data.frame(WEBER_P_200601_mean, WEBER_P_200602_mean, WEBER_P_200603_mean, WEBER_P_200604_mean, 
                         WEBER_P_200605_mean, WEBER_P_200606_mean, WEBER_P_200607_mean, WEBER_P_200608_mean, 
                         WEBER_P_200609_mean, WEBER_P_200610_mean, WEBER_P_200611_mean, WEBER_P_200612_mean)
WEBER_2007 <- data.frame(WEBER_P_200701_mean, WEBER_P_200702_mean, WEBER_P_200703_mean, WEBER_P_200704_mean, 
                         WEBER_P_200705_mean, WEBER_P_200706_mean, WEBER_P_200707_mean, WEBER_P_200708_mean, 
                         WEBER_P_200709_mean, WEBER_P_200710_mean, WEBER_P_200711_mean, WEBER_P_200712_mean)
WEBER_2008 <- data.frame(WEBER_P_200801_mean, WEBER_P_200802_mean, WEBER_P_200803_mean, WEBER_P_200804_mean, 
                         WEBER_P_200805_mean, WEBER_P_200806_mean, WEBER_P_200807_mean, WEBER_P_200808_mean, 
                         WEBER_P_200809_mean, WEBER_P_200810_mean, WEBER_P_200811_mean, WEBER_P_200812_mean)
WEBER_2009 <- data.frame(WEBER_P_200901_mean, WEBER_P_200902_mean, WEBER_P_200903_mean, WEBER_P_200904_mean, 
                         WEBER_P_200905_mean, WEBER_P_200906_mean, WEBER_P_200907_mean, WEBER_P_200908_mean, 
                         WEBER_P_200909_mean, WEBER_P_200910_mean, WEBER_P_200911_mean, WEBER_P_200912_mean)
WEBER_2010 <- data.frame(WEBER_P_201001_mean, WEBER_P_201002_mean, WEBER_P_201003_mean, WEBER_P_201004_mean, 
                         WEBER_P_201005_mean, WEBER_P_201006_mean, WEBER_P_201007_mean, WEBER_P_201008_mean, 
                         WEBER_P_201009_mean, WEBER_P_201010_mean, WEBER_P_201011_mean, WEBER_P_201012_mean)
WEBER_2011 <- data.frame(WEBER_P_201101_mean, WEBER_P_201102_mean, WEBER_P_201103_mean, WEBER_P_201104_mean, 
                         WEBER_P_201105_mean, WEBER_P_201106_mean, WEBER_P_201107_mean, WEBER_P_201108_mean, 
                         WEBER_P_201109_mean, WEBER_P_201110_mean, WEBER_P_201111_mean, WEBER_P_201112_mean)
WEBER_2012 <- data.frame(WEBER_P_201201_mean, WEBER_P_201202_mean, WEBER_P_201203_mean, WEBER_P_201204_mean, 
                         WEBER_P_201205_mean, WEBER_P_201206_mean, WEBER_P_201207_mean, WEBER_P_201208_mean, 
                         WEBER_P_201209_mean, WEBER_P_201210_mean, WEBER_P_201211_mean, WEBER_P_201212_mean)
WEBER_2013 <- data.frame(WEBER_P_201301_mean, WEBER_P_201302_mean, WEBER_P_201303_mean, WEBER_P_201304_mean, 
                         WEBER_P_201305_mean, WEBER_P_201306_mean, WEBER_P_201307_mean, WEBER_P_201308_mean, 
                         WEBER_P_201309_mean, WEBER_P_201310_mean, WEBER_P_201311_mean, WEBER_P_201312_mean)
WEBER_2014 <- data.frame(WEBER_P_201401_mean, WEBER_P_201402_mean, WEBER_P_201403_mean, WEBER_P_201404_mean, 
                         WEBER_P_201405_mean, WEBER_P_201406_mean, WEBER_P_201407_mean, WEBER_P_201408_mean, 
                         WEBER_P_201409_mean, WEBER_P_201410_mean, WEBER_P_201411_mean, WEBER_P_201412_mean)
WEBER_2015 <- data.frame(WEBER_P_201501_mean, WEBER_P_201502_mean, WEBER_P_201503_mean, WEBER_P_201504_mean, 
                         WEBER_P_201505_mean, WEBER_P_201506_mean, WEBER_P_201507_mean, WEBER_P_201508_mean, 
                         WEBER_P_201509_mean, WEBER_P_201510_mean, WEBER_P_201511_mean, WEBER_P_201512_mean)
WEBER_2016 <- data.frame(WEBER_P_201601_mean, WEBER_P_201602_mean, WEBER_P_201603_mean, WEBER_P_201604_mean, 
                         WEBER_P_201605_mean, WEBER_P_201606_mean, WEBER_P_201607_mean, WEBER_P_201608_mean, 
                         WEBER_P_201609_mean, WEBER_P_201610_mean, WEBER_P_201611_mean, WEBER_P_201612_mean)
WEBER_2017 <- data.frame(WEBER_P_201701_mean, WEBER_P_201702_mean, WEBER_P_201703_mean, WEBER_P_201704_mean, 
                         WEBER_P_201705_mean, WEBER_P_201706_mean, WEBER_P_201707_mean, WEBER_P_201708_mean, 
                         WEBER_P_201709_mean, WEBER_P_201710_mean, WEBER_P_201711_mean, WEBER_P_201712_mean)
WEBER_2018 <- data.frame(WEBER_P_201801_mean, WEBER_P_201802_mean, WEBER_P_201803_mean, WEBER_P_201804_mean, 
                         WEBER_P_201805_mean, WEBER_P_201806_mean, WEBER_P_201807_mean, WEBER_P_201808_mean, 
                         WEBER_P_201809_mean)

# Writing dataframes
BOX_ELDER <- data.frame(Year, BOX_ELDER_2000, BOX_ELDER_2001, BOX_ELDER_2002, BOX_ELDER_2003, BOX_ELDER_2004,
                        BOX_ELDER_2005, BOX_ELDER_2006, BOX_ELDER_2007, BOX_ELDER_2008, BOX_ELDER_2009,
                        BOX_ELDER_2010, BOX_ELDER_2011, BOX_ELDER_2012, BOX_ELDER_2013, BOX_ELDER_2014, 
                        BOX_ELDER_2015, BOX_ELDER_2016, BOX_ELDER_2017, BOX_ELDER_2018)
BEAVER<- data.frame(Year, BEAVER_2000, BEAVER_2001, BEAVER_2002, BEAVER_2003, BEAVER_2004,
                    BEAVER_2005, BEAVER_2006, BEAVER_2007, BEAVER_2008, BEAVER_2009,
                    BEAVER_2010, BEAVER_2011, BEAVER_2012, BEAVER_2013, BEAVER_2014, 
                    BEAVER_2015, BEAVER_2016, BEAVER_2017, BEAVER_2018)
CACHE<- data.frame(Year, CACHE_2000, CACHE_2001, CACHE_2002, CACHE_2003, CACHE_2004,
                   CACHE_2005, CACHE_2006, CACHE_2007, CACHE_2008, CACHE_2009,
                   CACHE_2010, CACHE_2011, CACHE_2012, CACHE_2013, CACHE_2014, 
                   CACHE_2015, CACHE_2016, CACHE_2017, CACHE_2018)
CARBON<- data.frame(Year, CARBON_2000, CARBON_2001, CARBON_2002, CARBON_2003, CARBON_2004,
                    CARBON_2005, CARBON_2006, CARBON_2007, CARBON_2008, CARBON_2009,
                    CARBON_2010, CARBON_2011, CARBON_2012, CARBON_2013, CARBON_2014, 
                    CARBON_2015, CARBON_2016, CARBON_2017, CARBON_2018)
DAVIS<- data.frame(Year, DAVIS_2000, DAVIS_2001, DAVIS_2002, DAVIS_2003, DAVIS_2004,
                   DAVIS_2005, DAVIS_2006, DAVIS_2007, DAVIS_2008, DAVIS_2009,
                   DAVIS_2010, DAVIS_2011, DAVIS_2012, DAVIS_2013, DAVIS_2014, 
                   DAVIS_2015, DAVIS_2016, DAVIS_2017, DAVIS_2018)
DAGGETT<- data.frame(Year, DAGGETT_2000, DAGGETT_2001, DAGGETT_2002, DAGGETT_2003, DAGGETT_2004,
                     DAGGETT_2005, DAGGETT_2006, DAGGETT_2007, DAGGETT_2008, DAGGETT_2009,
                     DAGGETT_2010, DAGGETT_2011, DAGGETT_2012, DAGGETT_2013, DAGGETT_2014, 
                     DAGGETT_2015, DAGGETT_2016, DAGGETT_2017, DAGGETT_2018)
DUCHESNE<- data.frame(Year, DUCHESNE_2000, DUCHESNE_2001, DUCHESNE_2002, DUCHESNE_2003, DUCHESNE_2004,
                      DUCHESNE_2005, DUCHESNE_2006, DUCHESNE_2007, DUCHESNE_2008, DUCHESNE_2009,
                      DUCHESNE_2010, DUCHESNE_2011, DUCHESNE_2012, DUCHESNE_2013, DUCHESNE_2014, 
                      DUCHESNE_2015, DUCHESNE_2016, DUCHESNE_2017, DUCHESNE_2018)
EMERY<- data.frame(Year, EMERY_2000, EMERY_2001, EMERY_2002, EMERY_2003, EMERY_2004,
                   EMERY_2005, EMERY_2006, EMERY_2007, EMERY_2008, EMERY_2009,
                   EMERY_2010, EMERY_2011, EMERY_2012, EMERY_2013, EMERY_2014, 
                   EMERY_2015, EMERY_2016, EMERY_2017, EMERY_2018)
GARFIELD<- data.frame(Year, GARFIELD_2000, GARFIELD_2001, GARFIELD_2002, GARFIELD_2003, GARFIELD_2004,
                      GARFIELD_2005, GARFIELD_2006, GARFIELD_2007, GARFIELD_2008, GARFIELD_2009,
                      GARFIELD_2010, GARFIELD_2011, GARFIELD_2012, GARFIELD_2013, GARFIELD_2014, 
                      GARFIELD_2015, GARFIELD_2016, GARFIELD_2017, GARFIELD_2018)
GRAND<- data.frame(Year, GRAND_2000, GRAND_2001, GRAND_2002, GRAND_2003, GRAND_2004,
                   GRAND_2005, GRAND_2006, GRAND_2007, GRAND_2008, GRAND_2009,
                   GRAND_2010, GRAND_2011, GRAND_2012, GRAND_2013, GRAND_2014, 
                   GRAND_2015, GRAND_2016, GRAND_2017, GRAND_2018)
IRON<- data.frame(Year, IRON_2000, IRON_2001, IRON_2002, IRON_2003, IRON_2004,
                  IRON_2005, IRON_2006, IRON_2007, IRON_2008, IRON_2009,
                  IRON_2010, IRON_2011, IRON_2012, IRON_2013, IRON_2014, 
                  IRON_2015, IRON_2016, IRON_2017, IRON_2018)
JUAB<- data.frame(Year, JUAB_2000, JUAB_2001, JUAB_2002, JUAB_2003, JUAB_2004,
                  JUAB_2005, JUAB_2006, JUAB_2007, JUAB_2008, JUAB_2009,
                  JUAB_2010, JUAB_2011, JUAB_2012, JUAB_2013, JUAB_2014, 
                  JUAB_2015, JUAB_2016, JUAB_2017, JUAB_2018)
KANE<- data.frame(Year, KANE_2000, KANE_2001, KANE_2002, KANE_2003, KANE_2004,
                  KANE_2005, KANE_2006, KANE_2007, KANE_2008, KANE_2009,
                  KANE_2010, KANE_2011, KANE_2012, KANE_2013, KANE_2014, 
                  KANE_2015, KANE_2016, KANE_2017, KANE_2018)
MORGAN<- data.frame(Year, MORGAN_2000, MORGAN_2001, MORGAN_2002, MORGAN_2003, MORGAN_2004,
                    MORGAN_2005, MORGAN_2006, MORGAN_2007, MORGAN_2008, MORGAN_2009,
                    MORGAN_2010, MORGAN_2011, MORGAN_2012, MORGAN_2013, MORGAN_2014, 
                    MORGAN_2015, MORGAN_2016, MORGAN_2017, MORGAN_2018)
MILLARD<- data.frame(Year, MILLARD_2000, MILLARD_2001, MILLARD_2002, MILLARD_2003, MILLARD_2004,
                     MILLARD_2005, MILLARD_2006, MILLARD_2007, MILLARD_2008, MILLARD_2009,
                     MILLARD_2010, MILLARD_2011, MILLARD_2012, MILLARD_2013, MILLARD_2014, 
                     MILLARD_2015, MILLARD_2016, MILLARD_2017, MILLARD_2018)
PIUTE<- data.frame(Year, PIUTE_2000, PIUTE_2001, PIUTE_2002, PIUTE_2003, PIUTE_2004,
                   PIUTE_2005, PIUTE_2006, PIUTE_2007, PIUTE_2008, PIUTE_2009,
                   PIUTE_2010, PIUTE_2011, PIUTE_2012, PIUTE_2013, PIUTE_2014, 
                   PIUTE_2015, PIUTE_2016, PIUTE_2017, PIUTE_2018)
RICH<- data.frame(Year, RICH_2000, RICH_2001, RICH_2002, RICH_2003, RICH_2004,
                  RICH_2005, RICH_2006, RICH_2007, RICH_2008, RICH_2009,
                  RICH_2010, RICH_2011, RICH_2012, RICH_2013, RICH_2014, 
                  RICH_2015, RICH_2016, RICH_2017, RICH_2018)
SANPETE<- data.frame(Year, SANPETE_2000, SANPETE_2001, SANPETE_2002, SANPETE_2003, SANPETE_2004,
                     SANPETE_2005, SANPETE_2006, SANPETE_2007, SANPETE_2008, SANPETE_2009,
                     SANPETE_2010, SANPETE_2011, SANPETE_2012, SANPETE_2013, SANPETE_2014, 
                     SANPETE_2015, SANPETE_2016, SANPETE_2017, SANPETE_2018)
SALTLAKE<- data.frame(Year, SALTLAKE_2000, SALTLAKE_2001, SALTLAKE_2002, SALTLAKE_2003, SALTLAKE_2004,
                      SALTLAKE_2005, SALTLAKE_2006, SALTLAKE_2007, SALTLAKE_2008, SALTLAKE_2009,
                      SALTLAKE_2010, SALTLAKE_2011, SALTLAKE_2012, SALTLAKE_2013, SALTLAKE_2014, 
                      SALTLAKE_2015, SALTLAKE_2016, SALTLAKE_2017, SALTLAKE_2018)
SUMMIT<- data.frame(Year, SUMMIT_2000, SUMMIT_2001, SUMMIT_2002, SUMMIT_2003, SUMMIT_2004,
                    SUMMIT_2005, SUMMIT_2006, SUMMIT_2007, SUMMIT_2008, SUMMIT_2009,
                    SUMMIT_2010, SUMMIT_2011, SUMMIT_2012, SUMMIT_2013, SUMMIT_2014, 
                    SUMMIT_2015, SUMMIT_2016, SUMMIT_2017, SUMMIT_2018)
SEVIER<- data.frame(Year, SEVIER_2000, SEVIER_2001, SEVIER_2002, SEVIER_2003, SEVIER_2004,
                    SEVIER_2005, SEVIER_2006, SEVIER_2007, SEVIER_2008, SEVIER_2009,
                    SEVIER_2010, SEVIER_2011, SEVIER_2012, SEVIER_2013, SEVIER_2014, 
                    SEVIER_2015, SEVIER_2016, SEVIER_2017, SEVIER_2018)
SAN_JUAN<- data.frame(Year, SAN_JUAN_2000, SAN_JUAN_2001, SAN_JUAN_2002, SAN_JUAN_2003, SAN_JUAN_2004,
                      SAN_JUAN_2005, SAN_JUAN_2006, SAN_JUAN_2007, SAN_JUAN_2008, SAN_JUAN_2009,
                      SAN_JUAN_2010, SAN_JUAN_2011, SAN_JUAN_2012, SAN_JUAN_2013, SAN_JUAN_2014, 
                      SAN_JUAN_2015, SAN_JUAN_2016, SAN_JUAN_2017, SAN_JUAN_2018)
TOOELE<- data.frame(Year, TOOELE_2000, TOOELE_2001, TOOELE_2002, TOOELE_2003, TOOELE_2004,
                    TOOELE_2005, TOOELE_2006, TOOELE_2007, TOOELE_2008, TOOELE_2009,
                    TOOELE_2010, TOOELE_2011, TOOELE_2012, TOOELE_2013, TOOELE_2014, 
                    TOOELE_2015, TOOELE_2016, TOOELE_2017, TOOELE_2018)
UTAH<- data.frame(Year, UTAH_2000, UTAH_2001, UTAH_2002, UTAH_2003, UTAH_2004,
                  UTAH_2005, UTAH_2006, UTAH_2007, UTAH_2008, UTAH_2009,
                  UTAH_2010, UTAH_2011, UTAH_2012, UTAH_2013, UTAH_2014, 
                  UTAH_2015, UTAH_2016, UTAH_2017, UTAH_2018)
UINTAH<- data.frame(Year, UINTAH_2000, UINTAH_2001, UINTAH_2002, UINTAH_2003, UINTAH_2004,
                    UINTAH_2005, UINTAH_2006, UINTAH_2007, UINTAH_2008, UINTAH_2009,
                    UINTAH_2010, UINTAH_2011, UINTAH_2012, UINTAH_2013, UINTAH_2014, 
                    UINTAH_2015, UINTAH_2016, UINTAH_2017, UINTAH_2018)
WAYNE<- data.frame(Year, WAYNE_2000, WAYNE_2001, WAYNE_2002, WAYNE_2003, WAYNE_2004,
                   WAYNE_2005, WAYNE_2006, WAYNE_2007, WAYNE_2008, WAYNE_2009,
                   WAYNE_2010, WAYNE_2011, WAYNE_2012, WAYNE_2013, WAYNE_2014, 
                   WAYNE_2015, WAYNE_2016, WAYNE_2017, WAYNE_2018)
WASATCH<- data.frame(Year, WASATCH_2000, WASATCH_2001, WASATCH_2002, WASATCH_2003, WASATCH_2004,
                     WASATCH_2005, WASATCH_2006, WASATCH_2007, WASATCH_2008, WASATCH_2009,
                     WASATCH_2010, WASATCH_2011, WASATCH_2012, WASATCH_2013, WASATCH_2014, 
                     WASATCH_2015, WASATCH_2016, WASATCH_2017, WASATCH_2018)
WASHINGTON<- data.frame(Year, WASHINGTON_2000, WASHINGTON_2001, WASHINGTON_2002, WASHINGTON_2003, WASHINGTON_2004,
                        WASHINGTON_2005, WASHINGTON_2006, WASHINGTON_2007, WASHINGTON_2008, WASHINGTON_2009,
                        WASHINGTON_2010, WASHINGTON_2011, WASHINGTON_2012, WASHINGTON_2013, WASHINGTON_2014, 
                        WASHINGTON_2015, WASHINGTON_2016, WASHINGTON_2017, WASHINGTON_2018)
WEBER<- data.frame(Year, WEBER_2000, WEBER_2001, WEBER_2002, WEBER_2003, WEBER_2004,
                   WEBER_2005, WEBER_2006, WEBER_2007, WEBER_2008, WEBER_2009,
                   WEBER_2010, WEBER_2011, WEBER_2012, WEBER_2013, WEBER_2014, 
                   WEBER_2015, WEBER_2016, WEBER_2017, WEBER_2018)
# Exporting the precipitation
library(WriteXLS)

write.csv(BOX_ELDER*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/BOX_ELDER.csv")
write.csv(BEAVER*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/BEAVER.csv")
write.csv(CACHE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/CACHE.csv")
write.csv(CARBON*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/CARBON.csv")
write.csv(DAVIS*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/DAVIS.csv")
write.csv(DAGGETT*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/DAGGETT.csv")
write.csv(DUCHESNE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/DUCHESNE.csv")
write.csv(EMERY*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/EMERY.csv")
write.csv(GARFIELD*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/GARFIELD.csv")
write.csv(GRAND*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/GRAND.csv")
write.csv(IRON*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/IRON.csv")
write.csv(JUAB*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/JUAB.csv")
write.csv(KANE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/KANE.csv")
write.csv(MORGAN*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/MORGAN.csv")
write.csv(MILLARD*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/MILLARD.csv")
write.csv(PIUTE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/PIUTE.csv")
write.csv(RICH*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/RICH.csv")
write.csv(SANPETE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/SANPETE.csv")
write.csv(SALTLAKE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/SALTLAKE.csv")
write.csv(SUMMIT*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/SUMMIT.csv")
write.csv(SEVIER*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/SEVIER.csv")
write.csv(SAN_JUAN*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/SAN_JUAN.csv")
write.csv(TOOELE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/TOOELE.csv")
write.csv(UTAH*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/UTAH.csv")
write.csv(UINTAH*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/UINTAH.csv")
write.csv(WAYNE*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/WAYNE.csv")
write.csv(WASATCH*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/WASATCH.csv")
write.csv(WASHINGTON*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/WASHINGTON.csv")
write.csv(WEBER*1000, "C:/Users/daniyal/Desktop/UOU_PhD/CourseWork/Hydroinformatics/ClassProject/R_Data/Precipitation/WEBER.csv")



# Write Raster 

P_2000 <- sum(P_200001, P_200002, P_200003, P_200004, P_200005, P_200006, P_200007, P_200008, P_200009, P_200010, P_200011, P_200011)
P_2001 <- sum(P_200101, P_200102, P_200103, P_200104, P_200105, P_200106, P_200107, P_200108, P_200109, P_200110, P_200111, P_200111)
P_2002 <- sum(P_200201, P_200202, P_200203, P_200204, P_200205, P_200206, P_200207, P_200208, P_200209, P_200210, P_200211, P_200211)
P_2003 <- sum(P_200301, P_200302, P_200303, P_200304, P_200305, P_200306, P_200307, P_200308, P_200309, P_200310, P_200311, P_200311)
P_2004 <- sum(P_200401, P_200402, P_200403, P_200404, P_200405, P_200406, P_200407, P_200408, P_200409, P_200410, P_200411, P_200411)
P_2005 <- sum(P_200501, P_200502, P_200503, P_200504, P_200505, P_200506, P_200507, P_200508, P_200509, P_200510, P_200511, P_200511)
P_2006 <- sum(P_200601, P_200602, P_200603, P_200604, P_200605, P_200606, P_200607, P_200608, P_200609, P_200610, P_200611, P_200611)
P_2007 <- sum(P_200701, P_200702, P_200703, P_200704, P_200705, P_200706, P_200707, P_200708, P_200709, P_200710, P_200711, P_200711)
P_2008 <- sum(P_200801, P_200802, P_200803, P_200804, P_200805, P_200806, P_200807, P_200808, P_200809, P_200810, P_200811, P_200811)
P_2009 <- sum(P_200901, P_200902, P_200903, P_200904, P_200905, P_200906, P_200907, P_200908, P_200909, P_200910, P_200911, P_200911)
P_2010 <- sum(P_201001, P_201002, P_201003, P_201004, P_201005, P_201006, P_201007, P_201008, P_201009, P_201010, P_201011, P_201011)
P_2011 <- sum(P_201101, P_201102, P_201103, P_201104, P_201105, P_201106, P_201107, P_201108, P_201109, P_201110, P_201111, P_201111)
P_2012 <- sum(P_201201, P_201202, P_201203, P_201204, P_201205, P_201206, P_201207, P_201208, P_201209, P_201210, P_201211, P_201211)
P_2013 <- sum(P_201301, P_201302, P_201303, P_201304, P_201305, P_201306, P_201307, P_201308, P_201309, P_201310, P_201311, P_201311)
P_2014 <- sum(P_201401, P_201402, P_201403, P_201404, P_201405, P_201406, P_201407, P_201408, P_201409, P_201410, P_201411, P_201411)
P_2015 <- sum(P_201501, P_201502, P_201503, P_201504, P_201505, P_201506, P_201507, P_201508, P_201509, P_201510, P_201511, P_201511)
P_2016 <- sum(P_201601, P_201602, P_201603, P_201604, P_201605, P_201606, P_201607, P_201608, P_201609, P_201610, P_201611, P_201611)
P_2017 <- sum(P_201701, P_201702, P_201703, P_201704, P_201705, P_201706, P_201707, P_201708, P_201709, P_201710, P_201711, P_201711)
P_2018 <- sum(P_201801, P_201802, P_201803, P_201804, P_201805, P_201806, P_201807, P_201808, P_201809)

#Extract to the Utah

P_2018_UT <- crop(P_2018, SANPETE, filename="", snap='near', datatype=NULL)
P_2018_UT <- crop(P_2018, SANPETE, filename="SANPETT_Pre", snap='alignExtent', datatype=NULL, package="raster")
