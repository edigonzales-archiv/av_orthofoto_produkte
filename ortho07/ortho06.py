#!/usr/bin/python
# -*- coding: utf-8 -*-

from osgeo import ogr, osr
import os
import sys

ogr.UseExceptions()

BASEPATH = "/home/stefan/tmp/ortho06/"
OUTPATH = "/home/stefan/tmp/ortho06/out/"

shp = ogr.Open(os.path.join(BASEPATH,"ortho06tindex.shp"))
layer = shp.GetLayer(0)


for feature in layer:
    infileName = feature.GetField('location')
    print "**********************: " + infileName
        
    infile = os.path.join(BASEPATH, infileName)
    outfile = os.path.join(OUTPATH, infileName)
    
    cmd = "/usr/local/gdal/gdal-dev/bin/nearblack -of GTiff"
    cmd += " -co 'TILED=YES' -co 'COMPRESS=JPEG'"
    cmd += " -co 'BLOCKXSIZE=512' -co 'BLOCKYSIZE=512'"
    cmd += " -co 'PROFILE=GeoTIFF' -setalpha"
    cmd += " -nb 0 -white -near 15 -o " + outfile
    cmd += " " + infile
    #print cmd
    os.system(cmd)
    
    cmd = "/usr/local/gdal/gdal-dev/bin/gdaladdo -r average "
    cmd += "--config COMPRESS_OVERVIEW JPEG --config GDAL_TIFF_OVR_BLOCKSIZE 512 " 
    cmd += outfile + " 2 4 8 16 32 64 128"
    os.system(cmd)    
    
infiles = os.path.join(OUTPATH, "*.tif")
outfile = os.path.join(OUTPATH, "ortho2006rgb.vrt")
cmd = "/usr/local/gdal/gdal-dev/bin/gdalbuildvrt " + outfile + " " + infiles 
os.system(cmd)

infile = os.path.join(OUTPATH, "ortho2006rgb.vrt")
outfile = os.path.join(OUTPATH, "ortho2006rgb_5m.tif")
cmd = "/usr/local/gdal/gdal-dev/bin/gdalwarp -tr 5.0 5.0 -of GTiff"
cmd += " -co 'TILED=YES' -co 'PROFILE=GeoTIFF'"
cmd += " -co 'COMPRESS=DEFLATE' -co 'BLOCKXSIZE=512' -co 'BLOCKYSIZE=512'" 
cmd += " -wo NUM_THREADS=ALL_CPUS -s_srs epsg:21781 -t_srs epsg:21781"
cmd += " " + infile + " " + outfile
print cmd
os.system(cmd)

cmd  = "/usr/local/gdal/gdal-dev/bin/gdaladdo -r nearest"
cmd += " --config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512"
cmd += " " + outfile + " 2 4 8 16 32 64 128"
print cmd
os.system(cmd)




