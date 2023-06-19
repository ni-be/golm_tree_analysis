library(ForestTools)
library(raster)
library(lidR)

las <- readLAS("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las")

las <- segment_trees(las, li2012())
col <- random.colors(200)

plot(las, color = "treeID", pal = "auto")
#CREATE CHM

#USE LIDR tool to filter trees better: 

#USE FORESTTOOLS TO COUNT TREES


