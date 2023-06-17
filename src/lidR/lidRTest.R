library(raster)
library(lidR)

# TODO: Make Path relative
las <- readLAS("C:/Users/Raphael/Desktop/Uni Potsdam/Semester 2/Optical Remote Sensing/Project Tests/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las")

las <- segment_trees(las, li2012())
col <- random.colors(200)
plot(las, color = "treeID", colorPalette = col)