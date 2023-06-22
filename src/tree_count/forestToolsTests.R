# Attach the 'ForestTools' and 'raster' libraries
library(ForestTools)
library(raster)
library(lidR)

args = commandArgs(trailingOnly=TRUE)

# Default algorithm for reading .las
las_alg = "p2r"

if(length(args) > 0) {
  las_alg = args[0]
}

# TODO: Make Path relative, or change path to /src
las <- readLAS("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las", filter = "-keep_first -drop_z_below 5 -drop_z_above 40")

switch(las_alg, 
  "pitfree" = {
    ### pitfree
    thr <- c(0,2,5,10,15)
    edg <- c(0, 1.5)
    chm <- rasterize_canopy(las, 1, pitfree(thr, edg), pkg = "raster")
  },
  "p2r" = {
    ### p2r
    chm <- rasterize_canopy(las, 1, p2r(0.2), pkg = "raster")
  },
  "dsmtin" = {
    ### dsmtin
    chm <- rasterize_canopy(las, 1, dsmtin(), pkg = "raster")
  },
  stop("Error: LAS Algorithm not selected!")
)


chm
kootenayCHM
#plot(chm)

#las <- segment_trees(las, li2012())
#col <- random.colors(200)
#plot(las, color = "treeID", pal = "auto")



lin <- function(x){x * 0.04 + 0.5}

ttops <- vwf(CHM = chm, winFun = lin, minHeight = 3.5)

plot(chm, xlab = "", ylab = "", xaxt = 'n', yaxt = 'n')
plot(ttops, col = "green", pch = 20, cex = 0.5, add = TRUE)

mean(ttops$height)

# Create crown map
crowns <- mcws(treetops = ttops, CHM = chm, minHeight = 3.5, verbose = FALSE)

# Plot crowns
plot(crowns, col = sample(rainbow(50), length(unique(crowns[])), replace = TRUE), legend = FALSE, xlab = "", ylab = "", xaxt='n', yaxt = 'n')

sp_summarise(ttops)