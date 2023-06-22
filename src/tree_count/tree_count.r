# Attach the 'ForestTools' and 'raster' libraries
library(ForestTools)
library(raster)
library(lidR)

las <- readLAS("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.copc.laz", filter = "-keep_first")

#las <- segment_trees(las, li2012())
#CHM <- rasterize_canopy(las, res=4, p2r(0.2), pkg = "raster")

CHM <- rasterize_canopy(las, res=5, p2r(subcircle = 0.15), pkg = "raster")


#las <- segment_trees(las, li2012())
#col <- random.colors(200)
#plot(las, color = "treeID", pal = "auto")



lin <- function(x){x * 0.06 + 0.5}

ttops <- vwf(CHM, winFun = lin, minHeight = 2)
png("my_plot.png")
plot(CHM, xlab = "", ylab = "", xaxt = 'n', yaxt = 'n')
plot(ttops, col = "red", pch = 20, cex = 0.5, add = TRUE)
#plot(las, size = 3, bg = "white")

#mean(ttops$height)

# Create crown map
#crowns <- mcws(treetops = ttops, CHM , minHeight = 4, verbose = FALSE)

# Plot crowns
#:plot(crowns, col = sample(rainbow(50), length(unique(crowns[])), replace = TRUE), legend = FALSE, xlab = "", ylab = "", xaxt='n', yaxt = 'n')
dev.off()
sp_summarise(ttops)

