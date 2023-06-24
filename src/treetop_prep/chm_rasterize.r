library(lidR)
library(raster)

ctg <- readLAScatalog("/home/nibe/PROJECTS/golm_tree_analysis/data")

#dtm <- rasterize_terrain(ctg, 2, tin(), pkg = "terra")
#dtm_prod <- terra::terrain(dtm, v = c("slope", "aspect"), unit = "radians")
#dtm_hillshade <- terra::shade(slope = dtm_prod$slope, aspect = dtm_prod$aspect)
#ctg_norm <- normalize_height(ctg, dtm)

opt_output_files(ctg) <- "/home/nibe/PROJECTS/golm_tree_analysis/results/CHM_v1"
chm = grid_canopy(ctg, 0.25, pitfree(c(0,2,5,10,15), c(0,1), subcircle = 0.2))