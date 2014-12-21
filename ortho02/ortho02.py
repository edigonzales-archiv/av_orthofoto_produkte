#!/usr/bin/python
# -*- coding: utf-8 -*-

from osgeo import ogr, osr
import os
import sys

ogr.UseExceptions()

BASEPATH = "/home/stefan/tmp/ortho02/"
OUTPATH = "/home/stefan/tmp/ortho02/out/"

shp = ogr.Open(os.path.join(BASEPATH,"ortho02tindex.shp"))
layer = shp.GetLayer(0)


for feature in layer:
    infileName = feature.GetField('location')
    print "**********************: " + infileName
        
    infile = os.path.join(BASEPATH, infileName)
    outfileA = os.path.join(BASEPATH, infileName[:-4] + ".tfw")
    outfileB = os.path.join(OUTPATH, infileName[:-4] + ".tfw")
    cmd = "listgeo -tfw " + infile
    os.system(cmd)
    os.system("mv " + outfileA + " " + outfileB)

    infile = os.path.join(BASEPATH, infileName)
    outfile = os.path.join(OUTPATH, "tmp1.tif")
    cmd = "convert " + infile + " " + outfile
    print cmd
    os.system(cmd)
    
    infile = os.path.join(OUTPATH, "tmp1.tif")
    outfile = os.path.join(OUTPATH, "tmp2.tif")
    cmd = "convert -level 13%,83% " + infile + " " + outfile 
    print cmd
    os.system(cmd)

    infile = os.path.join(OUTPATH, "tmp2.tif")
    outfile = os.path.join(OUTPATH, "tmp3.tif")
    cmd = "convert -channel G -gamma 0.95 " + infile + " " + outfile 
    print cmd
    os.system(cmd)

    infile = os.path.join(OUTPATH, "tmp2.tif")
    outfile = os.path.join(OUTPATH, infileName)
    cmd = "/usr/local/gdal/gdal-dev/bin/nearblack -of GTiff"
    cmd += " -co 'TILED=YES' -co 'COMPRESS=JPEG'"
    cmd += " -co 'BLOCKXSIZE=512' -co 'BLOCKYSIZE=512'"
    cmd += " -co 'PROFILE=GeoTIFF' -setalpha"
    cmd += " -near 15 -o " + outfile
    cmd += " " + infile
    print cmd
    os.system(cmd)
    
    cmd = "/usr/local/gdal/gdal-dev/bin/gdaladdo -r average "
    cmd += "--config COMPRESS_OVERVIEW JPEG --config GDAL_TIFF_OVR_BLOCKSIZE 512 " 
    cmd += outfile + " 2 4 8 16 32 64 128"
    os.system(cmd)    
    
    outfile = os.path.join(OUTPATH, infileName)
    cmd = "/usr/local/gdal/gdal-dev/bin/gdal_edit.py -a_srs EPSG:21781 " + outfile
    print cmd
    os.system(cmd)

    cmd = "rm " + os.path.join(OUTPATH, "tmp*.tif")
    os.system(cmd)
    

infiles = os.path.join(OUTPATH, "*.tif")
outfile = os.path.join(OUTPATH, "ortho2002rgb.vrt")
cmd = "/usr/local/gdal/gdal-dev/bin/gdalbuildvrt " + outfile + " " + infiles 
os.system(cmd)




