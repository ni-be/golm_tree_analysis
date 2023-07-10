#!/bin/bash

pdal pipeline dsm_pipeline.json &&
pdal pipeline dtm_pipeline.json &&
gdal_calc.py -A dtm.tif -B dsm.tif --calc="B-A" --outfile chm2.tif