#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/GDAL-2.0.0-py2.6-linux-x86_64.egg

GPKG=orthofoto.gpkg

echo "rgb"
#/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2015.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2015/rgb/12_5cm/ortho2015rgb.vrt /opt/Geodaten/ch/so/kva/orthofoto/$GPKG

#/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2015.rgb -r average /opt/Geodaten/ch/so/kva/orthofoto/$GPKG 2 4 8 16 32 64 128 256 512

echo "cir"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2015.cir -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2015/cir/12_5cm/ortho2015cir.vrt /opt/Geodaten/ch/so/kva/orthofoto/orthofoto.gpkg
#/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2015.cir -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2015/cir/12_5cm/ortho2015cir.vrt /home/stefan/tmp/orthofoto.gpkg
/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2015.cir -r average /opt/Geodaten/ch/so/kva/orthofoto/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "ndvi"
#/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2015.ndvi -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2015/ndvi/12_5cm/ortho2015ndvi.vrt /opt/Geodaten/ch/so/kva/orthofoto/$GPGK

#/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2015.ndvi -r average /opt/Geodaten/ch/so/kva/orthofoto/$GPGK 2 4 8 16 32 64 128 256 512


