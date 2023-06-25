# 0 - load packages
#-----------------------------
library("lidR")
library("future")


# 1 - source files
#-----------------

#---- source setup file
#source(file.path(envimaR::alternativeEnvi(root_folder = "~/edu/mpg-envinsys-plygrnd",
#                                          alt_env_id = "COMPUTERNAME",
#                                          alt_env_value = "PCRZP",
#                                          alt_env_root_folder = "F:/BEN/edu"),
#                 "src/mpg_course_basic_setup.R"))


# 2 - define variables
#---------------------

## define current projection (It is not magic you need to check the meta data or ask your instructor) 
## ETRS89 / UTM zone 32N
proj4 = "+proj=utm +zone=33 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"


## get viridris color palette
pal<-mapview::mapviewPalette("mapviewTopoColors")

# 3 - start code 
#-----------------

  
 #---- NOTE file size is about 12MB
# utils::download.file(url="https://github.com/gisma/gismaData/raw/master/uavRst/data/lidR_data.zip",
#                     destfile=paste0(envrmt$path_tmp,"chm.zip"))
# unzip(paste0(envrmt$path_tmp,"chm.zip"),
#      exdir = envrmt$path_tmp,  
#      overwrite = TRUE)
 
 #---- Get all *.las files of a folder into a list
# las_files = list.files(envrmt$path_tmp,
#                       pattern = glob2rx("*.las"),
#                       full.names = TRUE)
 

 #---- create CHM as provided by
 # https://github.com/Jean-Romain/lidR/wiki/Rasterizing-perfect-canopy-height-models
 las = readLAS("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las")
 las = lidR::lasnormalize(las, knnidw())
 
 # reassign the projection
 sp::proj4string(las) <- sp::CRS(proj4)
 
 # calculate the chm with the pitfree algorithm
 chm = lidR::grid_canopy(las, 0.25, pitfree(c(0,2,5,10,15), c(0,1), subcircle = 0.2))
 
 # write it to tif
# raster::writeRaster(chm,file.path(envrmt$path_data_mof,"mof_chm_one_tile.tif"),overwrite=TRUE) 
 

# 4 - visualize 
-------------------

# call mapview with some additional arguments
mapview(raster::raster(file.path(envrmt$path_data_mof,"mof_chm_one_tile.tif")),
         legend=TRUE, 
         layer.name = "canopy height model",
         col = pal(256),
         alpha.regions = 0.7)
