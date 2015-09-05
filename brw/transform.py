#!/usr/bin/python
# -*- coding: utf-8 -*-
import os.path

from osgeo import ogr, osr
import os

S_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=600000 +y_0=200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +nadgrids=./chenyx06/chenyx06a.gsb"
T_SRS = "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=2600000 +y_0=1200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +nadgrids=@null"

ogr.UseExceptions()

shp = ogr.Open("mosaic/ortho2014.shp")
layer = shp.GetLayer(0)

for feature in layer:
    infileName = feature.GetField("location")
    baseName = os.path.basename(infileName)
    print "*** " + baseName + " ***"

    if baseName != "611233_12_5cm.tif":
        continue


    print "found"

    geom = feature.GetGeometryRef()
    env = geom.GetEnvelope()

    minX = int(env[0] + 0.001 + 2000000)
    minY = int(env[2] + 0.001 + 1000000)
    maxX = int(env[1] + 0.001 + 2000000)
    maxY = int(env[3] + 0.001 + 1000000)
