library(lidR)
library(raster)
library(ForestTools)

#LASfile <- system.file("extdata", "/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las", package="lidR")
las <- readLAS("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las", filter = "-keep_first")
col <- height.colors(15)


# Points-to-raster algorithm with a resolution of 1 meter
CHM <- rasterize_canopy(las, res = 5, p2r(), pkg = "raster")
lin <- function(x){x * 0.06 + 0.5}
ttops <- vwf(CHM, winFun = lin, minHeight = 2)

plot(CHM, xlab = "", ylab = "", xaxt = 'n', yaxt = 'n')
#plot(ttops, col = "red", pch = 20, cex = 0.5, add = TRUE)
#plot(CHM, col = col)
sp_summarise(ttops)


# Points-to-raster algorithm with a resolution of 0.5 meters replacing each
# point by a 20-cm radius circle of 8 points
CHM <- rasterize_canopy(las, res = 5, p2r(0.2), pkg="raster")
lin <- function(x){x * 0.06 + 0.5}
ttops <- vwf(CHM, winFun = lin, minHeight = 2)

plot(CHM, xlab = "", ylab = "", xaxt = 'n', yaxt = 'n')
plot(ttops, col = "red", pch = 20, cex = 0.5, add = TRUE)
plot(CHM, col = col)
sp_summarise(ttops)

# Basic triangulation and rasterization of first returns
CHM <- rasterize_canopy(las, res = 5, dsmtin(), pkg = "raster")
lin <- function(x){x * 0.06 + 0.5}
ttops <- vwf(CHM, winFun = lin, minHeight = 2)

plot(CHM, xlab = "", ylab = "", xaxt = 'n', yaxt = 'n')
plot(ttops, col = "red", pch = 20, cex = 0.5, add = TRUE)
plot(CHM, col = col)
sp_summarise(ttops)








# Khosravipour et al. pitfree algorithm
CHM <- rasterize_canopy(las, res = 5, pitfree(c(0,2,5,10,15), c(0, 1.5)), pkg = "raster")
lin <- function(x){x * 0.06 + 0.5}
ttops <- vwf(CHM, winFun = lin, minHeight = 2)

plot(CHM, xlab = "", ylab = "", xaxt = 'n', yaxt = 'n')
plot(ttops, col = "red", pch = 20, cex = 0.5, add = TRUE)
plot(CHM, col = col)
sp_summarise(ttops)
writeRaster(CHM,paste0(wd,"test.tif"),"GTiff")








#CHM <- rasterize_canopy(las, res=5, p2r(subcircle = 0.15), pkg="raster")

#ctg <- readLAScatalog(("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las")

#dtm <- rasterize_canopy(ctg, 2, tin(), pkg = "terrain")
#dtm_prod <- terra::terrain(dtm, v = c("slope", "aspect"), unit = "radians")
#dtm_hillshade <- terra::shade(slope = dtm_prod$slope, aspect = dtm_prod$aspect)
#ctg_norm <- normalize_height(ctg, dtm)

#opt_output_files(ctg) <- "/home/nibe/PROJECTS/golm_tree_analysis/results/CHM_v1-1"
#chm = grid_canopy(ctg, 0.25, pitfree(c(0,2,5,10,15), c(0,1), subcircle = 0.2))
