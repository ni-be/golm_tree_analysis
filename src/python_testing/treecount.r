library(ForestTools)
library(raster)
library(tiff)

CHM = raster("/home/nibe/PROJECTS/golm_tree_analysis/src/python_testing/chm2.tif")

lin <-  function(x){x*0.06 +0.5} 
ttops <- vwf(CHM, lin, minHeight = 2)
plot(CHM, xlab = "", ylab = "", xaxt = 'n', yaxt = 'n')
plot(ttops, col = "red", pch = 20, cex = 0.5, add = TRUE)
sp_summarise(ttops)
