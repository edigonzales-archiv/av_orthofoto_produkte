#!/bin/bash
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/GDAL-2.0.0-py2.6-linux-x86_64.egg

GPKG=orthofoto_2014.gpkg

echo "rgb"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2014.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2014/rgb/12_5cm/ortho2014rgb_alpha.vrt /home/stefan/tmp/$GPKG

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2014.rgb -r average /home/stefan/tmp/$GPKG 2 4 8 16 32 64 128 256 512

echo "cir"
#/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2014.cir -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2014/cir/12_5cm/ortho2014cir_alpha.vrt /home/stefan/tmp/$GPGK

#/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2014.cir -r average /home/stefan/tmp/$GPGK 2 4 8 16 32 64 128 256 512

echo "ndvi"
#/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2014.ndvi -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2014/ndvi/12_5cm/ortho2014ndvi_alpha.vrt /home/stefan/tmp/$GPGK

#/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2014.ndvi -r average /home/stefan/tmp/$GPGK 2 4 8 16 32 64 128 256 512


