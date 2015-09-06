#!/usr/bin/python
# -*- coding: utf-8 -*-
import os.path

from osgeo import ogr, osr
import os
import sys
import math

# NTv2 PROJ4-Strings
S_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=600000 +y_0=200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +nadgrids=./chenyx06/chenyx06a.gsb"
T_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=2600000 +y_0=1200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +nadgrids=@null"

# Translation only for verifiying our tests.
#S_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=600000 +y_0=200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1"
#T_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=2600000 +y_0=1200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1"


INPUT_DIR = "/Volumes/mr_candie_nas/Geodaten/ch/so/agi/orthofoto/2014/rgb/12_5cm"
#OUTPUT_DIR = "/Users/stefan/tmp/"
OUTPUT_DIR = "/Volumes/mr_candie_nas/Geodaten/ch/so/agi/orthofoto/2014/rgb_lv95/12_5cm"

# Since we cannot use 'neares neighbour', see: http://lists.osgeo.org/pipermail/gdal-dev/2015-September/042531.html
# 'lanczos' seems best, see http://gis.stackexchange.com/questions/10931/what-is-lanczos-resampling-useful-for-in-a-spatial-context
METHOD = "lanczos"
#METHOD = "near"

# Reduction Buffer for subimage
BUFFER_M = 10

# Resolution
RES_M = 0.125

# Original size
SIZE_P = 8000

# Compare fuzz tolerance
FUZZ_TOLERANCE = 10

def lv03_to_lv95(easting, northing):
    source = osr.SpatialReference()
    source.ImportFromProj4(S_SRS)

    target = osr.SpatialReference()
    target.ImportFromProj4(T_SRS)

    transform = osr.CoordinateTransformation(source, target)

    point = ogr.CreateGeometryFromWkt("POINT ("+str(easting)+ " "+str(northing)+")")
    point.Transform(transform)

    return (point.GetX(), point.GetY())

def main():
    ogr.UseExceptions()

    shp = ogr.Open("mosaic/ortho2014.shp")
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

        verification = False
        if verification == True:
            # 2) Create two subimages: one from the original tile and one from the new one.
            # These subimages are slightly smaller (see BUFFER) than the original tiles.
            # The subimage is created around a center point.
            # For a real verification it's better to create the same LV03 region
            # from the LV95 vrt image since we compare one tile with a subimage
            # from multiple tiles.

            # WE SHOULD try n error: downample to 0.25 -> we should still see
            # a complete wrong transfromation but reduce the noise from resampling?
            # But this must be respected in the calculation of the crop LV95
            # bounding box.

            # LV03
            xLV03 = minX + (maxX - minX)/2 - 2000000
            yLV03 = minY + (maxY - minY)/2 - 1000000

            # LV95
            xLV95, yLV95 = lv03_to_lv95(xLV03, yLV03)
            print xLV95, yLV95

            # The center coordinates of LV95 must be multiple of 0.125
            # RUNDED int() IMMER AB????
            xLV95 = round(xLV95, 0) + round((xLV95  - int(xLV95)) / RES_M, 0) * RES_M
            yLV95 = round(yLV95, 0) + round((yLV95  - int(yLV95)) / RES_M, 0) * RES_M

            # LV03 subimage
            # Resampling method does nothing here since there is no resizing and/or
            # reprojection involved.
            llxLV03 = minX - 2000000 + BUFFER_M
            llyLV03 = minY - 1000000 + BUFFER_M
            urxLV03 = maxX - 2000000 - BUFFER_M
            uryLV03 = maxY - 1000000 - BUFFER_M
            print llxLV03, llyLV03, urxLV03, uryLV03
            cmd = "gdalwarp -overwrite -te " + str(llxLV03) + " " + str(llyLV03) + " " + str(urxLV03) + " " + str(uryLV03)
            cmd += " -tr " + str(RES_M) + " " + str(RES_M) + " -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF'"
            cmd += " -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256'"
            cmd += " -r near " + os.path.join(INPUT_DIR, baseName) + " " + os.path.join(OUTPUT_DIR, "crop_lv03.tif")
            print cmd
            os.system(cmd)

            # LV95 subimage
            # NOT SURE if this is the best approach.
            # Transform all four bbox points from LV03 and then calculate
            # rectangular bounding box?
            llxLV95 = xLV95 - SIZE_P/2 * RES_M + BUFFER_M
            llyLV95 = yLV95 - SIZE_P/2 * RES_M + BUFFER_M
            urxLV95 = xLV95 + SIZE_P/2 * RES_M - BUFFER_M
            uryLV95 = yLV95 + SIZE_P/2 * RES_M - BUFFER_M
            print llxLV95, llyLV95, urxLV95, uryLV95
            cmd = "gdalwarp -overwrite -te " + str(llxLV95) + " " + str(llyLV95) + " " + str(urxLV95) + " " + str(uryLV95)
            cmd += " -tr " + str(RES_M) + " " + str(RES_M) + " -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF'"
            cmd += " -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256'"
            cmd += " -r near " + outFileName + " " + os.path.join(OUTPUT_DIR, "crop_lv95.tif")
            print cmd
            os.system(cmd)

            # Now compare the two subimages.
            cmd = "compare -fuzz " + str(FUZZ_TOLERANCE) + "% " + os.path.join(OUTPUT_DIR, "crop_lv03.tif") + " " +  os.path.join(OUTPUT_DIR, "crop_lv95.tif") + " " + os.path.join(OUTPUT_DIR, "diff.tif")
            print cmd
            os.system(cmd)

    # 2) Create VRT and the 5m overview image.
    vrt =  os.path.join(OUTPUT_DIR, "ortho2014rgb.vrt")
    cmd = "gdalbuildvrt -addalpha " + vrt + " " + os.path.join(OUTPUT_DIR, "*.tif")
    print cmd
    os.system(cmd)

    outFileName500cm = os.path.join(OUTPUT_DIR, "../500cm/ortho2014rgb_500.tif")
    cmd = "gdalwarp -overwrite -tr 5 5 -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF'"
    cmd += " -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'PREDICTOR=2' -co 'BLOCKXSIZE=256' -co 'BLOCKYSIZE=256'"
    cmd += " -r bilinear " + vrt + " " + outFileName500cm
    print cmd
    os.system(cmd)

    cmd = "gdaladdo -r average --config COMPRESS_OVERVIEW DEFLATE "  + outFileName500cm + " 2 4 8 16 32 64 128"
    print cmd
    os.system(cmd)

if __name__ == '__main__':
    sys.exit(main())
