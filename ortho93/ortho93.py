#!/usr/bin/python
# -*- coding: utf-8 -*-

from osgeo import ogr, osr
import os
import sys

ogr.UseExceptions()

BASEPATH = "/home/stefan/tmp/ortho93/"
OUTPATH = "/home/stefan/tmp/ortho93/out/"
CUTSHAPE = "/home/stefan/Projekte/av_orthofoto_produkte/ortho93/kantonsgrenze.shp"

shp = ogr.Open(os.path.join(BASEPATH,"ortho93tindex.shp"))
layer = shp.GetLayer(0)


for feature in layer:
    infileName = feature.GetField('location')
    print "**********************: " + infileName
        
    infile = os.path.join(BASEPATH, infileName)
    outfile = os.path.join(OUTPATH, infileName)
    
    cmd = "/usr/local/gdal/gdal-dev/bin/gdalwarp -of GTiff"
    cmd += " -dstalpha -cutline " + CUTSHAPE + " -cl kantonsgrenze"
    cmd += " -co 'TILED=YES' -co 'COMPRESS=DEFLATE'"
    cmd += " -co 'BLOCKXSIZE=512' -co 'BLOCKYSIZE=512'"
    cmd += " -co 'PROFILE=GeoTIFF'"
    cmd += " " + infile + " " + outfile
    print cmd
    os.system(cmd)
    
    cmd = "/usr/local/gdal/gdal-dev/bin/gdaladdo -r average "
    cmd += "--config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512 " 
    cmd += outfile + " 2 4 8 16 32 64 128"
    os.system(cmd)    
    
infiles = os.path.join(OUTPATH, "*.tif")
outfile = os.path.join(OUTPATH, "ortho1993rgb.vrt")
cmd = "/usr/local/gdal/gdal-dev/bin/gdalbuildvrt " + outfile + " " + infiles 
os.system(cmd)




