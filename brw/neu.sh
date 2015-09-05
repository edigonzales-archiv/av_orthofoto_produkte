#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib

method='near'

# Buffer in LV03 ausschneiden
gdalwarp -tr 0.125 0.125 -te 610998 232998 612002 234002 -wo NUM_THREADS=ALL_CPUS -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -r $method ortho2014.vrt /home/stefan/Downloads/lv03_611233_12_5cm_vrt_$method.tif

# Transformieren (immer noch gebuffert)
gdalwarp -s_srs "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=600000 +y_0=200000 +towgs84=674.374,15.056,405.346 +units=m +units=m +k_0=1 +nadgrids=./chenyx06a.gsb" -t_srs "+proj=somerc +lat_0=46.952405555555555N +lon_0=7.439583333333333E +ellps=bessel +x_0=2600000 +y_0=1200000 +towgs84=674.374,15.056,405.346 +units=m +k_0=1 +nadgrids=@null" -tr 0.125 0.125 -wo NUM_THREADS=ALL_CPUS -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -r $method /home/stefan/Downloads/lv03_611233_12_5cm_vrt_$method.tif /home/stefan/Downloads/lv95_buffer_611233_12_5cm_vrt_$method.tif

# Zurückschneiden auf schöne Koordinaten.
gdalwarp -co 'PHOTOMETRIC=RGB' -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -tr 0.125 0.125 -te 2611000 1233000 2612000 1234000 /home/stefan/Downloads/lv95_buffer_611233_12_5cm_vrt_$method.tif /home/stefan/Downloads/lv95_611233_12_5cm_vrt_$method.tif


gdal_edit.py -a_srs EPSG:2056 /home/stefan/Downloads/611233_12_5cm_vrt_$method.tif

gdaladdo -r nearest --config COMPRESS_OVERVIEW DEFLATE /home/stefan/Downloads/611233_12_5cm_vrt_$method.tif  2 4 8 16 32 64 128
