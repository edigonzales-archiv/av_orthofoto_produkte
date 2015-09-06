#!/usr/bin/python
# -*- coding: utf-8 -*-
import os.path

from osgeo import ogr, osr
import os
import sys

# NTv2 PROJ4-Strings
S_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=600000 +y_0=200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +nadgrids=./chenyx06/chenyx06a.gsb"
T_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=2600000 +y_0=1200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +nadgrids=@null"

# Translation only for verifiying our tests.
#S_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=600000 +y_0=200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1"
#T_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=2600000 +y_0=1200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1"

#OUTPUT_DIR = "/Users/stefan/tmp/"
INPUT_DIR = "/Volumes/mr_candie_nas/Geodaten/ch/so/agi/orthofoto/2014/rgb/12_5cm"
OUTPUT_DIR = "/Volumes/mr_candie_nas/Geodaten/ch/so/agi/orthofoto/2014/rgb_lv95/12_5cm"
TILEINDEX = "/Volumes/mr_candie_nas/Geodaten/ch/so/agi/orthofoto/2014/rgb/12_5cm/ortho2014.shp"

# Since we cannot use 'nearest neighbour', see: http://lists.osgeo.org/pipermail/gdal-dev/2015-September/042531.html
# 'lanczos' seems best, see http://gis.stackexchange.com/questions/10931/what-is-lanczos-resampling-useful-for-in-a-spatial-context
METHOD = "lanczos"
#METHOD = "near"

# Resolution
RES_M = 0.125
OVERVIEW_RES_M = 5

def main():
    ogr.UseExceptions()

    shp = ogr.Open(TILEINDEX)
    layer = shp.GetLayer(0)

    for feature in layer:
        infileName = feature.GetField("location")
        baseName = os.path.basename(infileName)

        if baseName != "611233_12_5cm.tif":
            continue

        print "*** " + baseName + " ***"

        geom = feature.GetGeometryRef()
        env = geom.GetEnvelope()

        minX = int(env[0] + 0.001 + 2000000)
        minY = int(env[2] + 0.001 + 1000000)
        maxX = int(env[1] + 0.001 + 2000000)
        maxY = int(env[3] + 0.001 + 1000000)

        #outFileName = METHOD + "_" + str(minX)[0:4] + "_" + str(minY)[0:4] + "_12_5cm.tif"
        outFileName = str(minX)[0:4] + "_" + str(minY)[0:4] + "_12_5cm.tif"
        outFileName = os.path.join(OUTPUT_DIR, outFileName)

        # 1) Create the new tile with a nice bounding box.
        vrt = os.path.join(INPUT_DIR, "ortho2014rgb.vrt")
        cmd = "gdalwarp -overwrite -s_srs \"" + S_SRS + "\" -t_srs \"" + T_SRS + "\" -te "  + str(minX) + " " +  str(minY) + " " +  str(maxX) + " " +  str(maxY)
        cmd += " -tr " + str(RES_M) + " " + str(RES_M) + " -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF'"
        cmd += " -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256'"
        cmd += " -r " + METHOD + " " + vrt + " " + outFileName
        #print cmd
        os.system(cmd)

        cmd = "gdal_edit.py -a_srs EPSG:2056 " + outFileName
        #print cmd
        os.system(cmd)

        # Resampling method does not really matter here.
        cmd = "gdaladdo -r average --config COMPRESS_OVERVIEW DEFLATE " + outFileName + " 2 4 8 16 32 64 128"
        #print cmd
        os.system(cmd)

    # 2) Create VRT and the 5m overview image.
    # The resampling method do not really matter here.
    # At least it should look nice.
    vrt =  os.path.join(OUTPUT_DIR, "ortho2014rgb.vrt")
    cmd = "gdalbuildvrt -addalpha " + vrt + " " + os.path.join(OUTPUT_DIR, "*.tif")
    print cmd
    os.system(cmd)

    outFileName500cm = os.path.join(OUTPUT_DIR, "../500cm/ortho2014rgb_500.tif")
    cmd = "gdalwarp -overwrite -tr " + str(OVERVIEW_RES_M) + " " + str(OVERVIEW_RES_M) + " -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF'"
    cmd += " -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256'"
    cmd += " -r bilinear " + vrt + " " + outFileName500cm
    print cmd
    os.system(cmd)

    cmd = "gdaladdo -r average --config COMPRESS_OVERVIEW DEFLATE "  + outFileName500cm + " 2 4 8 16 32 64 128"
    print cmd
    os.system(cmd)

if __name__ == '__main__':
    sys.exit(main())
