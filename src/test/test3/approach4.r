library(lidR)
library(raster)
library(sp)

las <- readLAS("/home/nibe/PROJECTS/golm_tree_analysis/data/Golm_May06_2018_Milan_UTM33N_WGS84_6digit_cl.las", select = "xyzr", filter = "-keep_first, -drop_z_below 20, -drop_z-above 40")
las <- segment_trees(las, li2012(dt1 = 1.5, dt2 = 2, R = 2, Zu = 15, hmin = 2, speed_up = 2))


# Point-to-raster 2 resolutions
chm_p2r_05 <- rasterize_canopy(las, 3, p2r(subcircle = 0.2), pkg = "terra")
chm_p2r_1 <- rasterize_canopy(las, 3, p2r(subcircle = 0.2), pkg = "terra")

# Pitfree with and without subcircle tweak
#chm_pitfree_05_1 <- rasterize_canopy(las, 2, pitfree(), pkg = "terra")
#chm_pitfree_05_2 <- rasterize_canopy(las, 2, pitfree(subcircle = 0.2), pkg = "terra")

# Post-processing median filter
kernel <- matrix(1,3,3)
chm_p2r_05_smoothed <- terra::focal(chm_p2r_05, w = kernel, fun = median, na.rm = TRUE)
chm_p2r_1_smoothed <- terra::focal(chm_p2r_1, w = kernel, fun = median, na.rm = TRUE)


f <- function(x) {
  y <- 2.6 * (-(exp(-0.05*(x-2)) - 1)) + 3
  y[x < 3] <- 2
  y[x <10] <- 2.5
  y[x > 12] <- 9
  return(y)
}

heights <- seq(-2,20,0.5)
ws <- f(heights)
plot(heights, ws, type = "l",  ylim = c(0,5))


#ttops_chm_p2r_05 <- locate_trees(chm_p2r_05, lmf(f))
#ttops_chm_p2r_1 <- locate_trees(chm_p2r_1, lmf(f))
#ttops_chm_pitfree_05_1 <- locate_trees(chm_pitfree_05_1, lmf(f))
#ttops_chm_pitfree_05_2 <- locate_trees(chm_pitfree_05_2, lmf(f))
ttops_chm_p2r_05_smoothed <- locate_trees(chm_p2r_05_smoothed, lmf(f))
ttops_chm_p2r_1_smoothed <- locate_trees(chm_p2r_1_smoothed, lmf(f))
#print("p2r")
#print(nrow(ttops_chm_p2r_05))
#print(nrow(ttops_chm_p2r_1))
print("p2r smoothed")
print(nrow(ttops_chm_p2r_05_smoothed))
print(nrow(ttops_chm_p2r_1_smoothed))
#print("pitfree")
#print(nrow(ttops_chm_pitfree_05_1))
#print(nrow(ttops_chm_pitfree_05_2 ))

par(mfrow=c(3,2))
col <- height.colors(50)
#plot(chm_p2r_05, main = "CHM P2R 0.5", col = col); plot(sf::st_geometry(ttops_chm_p2r_05), add = T, pch =3)
#plot(chm_p2r_1, main = "CHM P2R 1", col = col); plot(sf::st_geometry(ttops_chm_p2r_1), add = T, pch = 3)
plot(chm_p2r_05_smoothed, main = "CHM P2R 0.5 smoothed", col = col); plot(sf::st_geometry(ttops_chm_p2r_05_smoothed), add = T, pch =3)
plot(chm_p2r_1_smoothed, main = "CHM P2R 1 smoothed", col = col); plot(sf::st_geometry(ttops_chm_p2r_1_smoothed), add = T, pch =3)
#plot(chm_pitfree_05_1, main = "CHM PITFREE 1", col = col); plot(sf::st_geometry(ttops_chm_pitfree_05_1), add = T, pch =3)
#plot(chm_pitfree_05_2, main = "CHM PITFREE 2", col = col); plot(sf::st_geometry(ttops_chm_pitfree_05_2), add = T, pch =3)