library(ForestTools)
library(raster)
library(lidR)

# create CHM 
las <- readLAS(../../data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las)

las <- segment_trees(las, li2012())
col <- random.colors(200)
plot(las, color = "treeID", colorPalette = col)