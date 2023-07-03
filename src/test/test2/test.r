library(lidR)
library(ForestTools)
library(raster)
library(sp)

las <- readLAS("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las", select = "xyzr", filter = "-drop_z_below 0 -drop_z_above 50")
chm <- rasterize_canopy(las, 1, pitfree(subcircle = 0.2))
plot(las, bg = "white", size = 4)

#ttops <- locate_trees(las, lmf(ws = 5))

#x <- plot(las, bg = "white", size = 4)
#add_treetops3d(x, ttops)

#ttops_3m <- locate_trees(las, lmf(ws = 3))
#ttops_11m <- locate_trees(las, lmf(ws = 11))

#par(mfrow=c(1,2))
#plot(chm, col = height.colors(50))
#plot(sf::st_geometry(ttops_3m), add = TRUE, pch = 3)
#plot(chm, col = height.colors(50))
#plot(sf::st_geometry(ttops_11m), add = TRUE, pch = 3)

#print("treecount 3m")
#nrow(ttops_3m)
#print("treecount 11m")
#nrow(ttops_11m)

f <- function(x) {x * 0.1 + 3}
heights <- seq(0,30,5)
ws <- f(heights)
plot(heights, ws, type = "l", ylim = c(0,6))

ttops <- locate_trees(las, lmf(f))

plot(chm, col = height.colors(50))
plot(sf::st_geometry(ttops), add = TRUE, pch = 3)

nrow(ttops)