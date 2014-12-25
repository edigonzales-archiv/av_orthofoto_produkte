#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/GDAL-2.0.0-py2.6-linux-x86_64.egg

GPKG=orthofoto_2013.gpkg

echo "rgb"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2013.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2013/rgb/12_5cm/ortho2013rgb_alpha.vrt /home/stefan/tmp/$GPKG

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2013.rgb -r average /home/stefan/tmp/$GPKG 2 4 8 16 32 64 128 256 512

echo "cir"
#/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2013.cir -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2013/cir/12_5cm/ortho2013cir_alpha.vrt /home/stefan/tmp/$GPKG

#/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2013.cir -r average /home/stefan/tmp/$GPKG 2 4 8 16 32 64 128 256 512

echo "ndvi"
#/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2013.ndvi -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2013/ndvi/12_5cm/ortho2013ndvi_alpha.vrt /home/stefan/tmp/$GPKG

#/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2013.ndvi -r average /home/stefan/tmp/$GPKG 2 4 8 16 32 64 128 256 512

