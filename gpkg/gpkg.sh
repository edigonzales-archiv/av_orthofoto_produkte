#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/GDAL-2.0.0-py2.6-linux-x86_64.egg

# 1993
echo "1993"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.sw.1993 -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/1993/sw/70cm/ortho1993sw.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.sw.1993 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256

# 2002
echo "2002"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.rgb.2002 -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2002/rgb/50cm/ortho2002rgb.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.rgb.2002 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

# 2006
echo "2006"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.rgb.2006 -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2006/rgb/12_5cm/ortho2006rgb.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.rgb.2006 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

# 2007
echo "2007"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.rgb.2007 -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2007/rgb/12_5cm/ortho2007rgb.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.rgb.2007 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

# 2011
echo "2011"
echo "rgb"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.rgb.2011 -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2011/rgb/12_5cm/ortho2011rgb_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.rgb.2011 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "cir"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.cir.2011 -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2011/cir/12_5cm/ortho2011cir_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.cir.2011 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "ndvi"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.ndvi.2011 -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2011/ndvi/12_5cm/ortho2011ndvi_alpha.vrt /home/stefan/tmp/orthofoto.gpkg
/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.ndvi.2011 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512


# 2012
echo "2012"
echo "rgb"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.rgb.2012 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2012/rgb/12_5cm/ortho2012rgb_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.rgb.2012 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "cir"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.cir.2012 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2012/cir/12_5cm/ortho2012cir_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.cir.2012 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "ndvi"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.ndvi.2012 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2012/ndvi/12_5cm/ortho2012ndvi_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.ndvi.2012 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

# 2013
echo "2013"
echo "rgb"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.rgb.2013 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2013/rgb/12_5cm/ortho2013rgb_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.rgb.2013 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "cir"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.cir.2013 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2013/cir/12_5cm/ortho2013cir_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.cir.2013 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "ndvi"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.ndvi.2013 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2013/ndvi/12_5cm/ortho2013ndvi_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.ndvi.2013 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

# 2014
echo "2014"
echo "rgb"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.rgb.2014 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2014/rgb/12_5cm/ortho2014rgb_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.rgb.2014 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "cir"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.cir.2014 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2014/cir/12_5cm/ortho2014cir_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.cir.2014 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512

echo "ndvi"
/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.ndvi.2014 -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2014/ndvi/12_5cm/ortho2014ndvi_alpha.vrt /home/stefan/tmp/orthofoto.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.ndvi.2014 -r average /home/stefan/tmp/orthofoto.gpkg 2 4 8 16 32 64 128 256 512





