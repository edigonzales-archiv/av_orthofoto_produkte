/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF  -co RASTER_TABLE=ch.so.agi.orthofoto.2002.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/tmp/ortho02/out_v2/ortho2002rgb.vrt /home/stefan/tmp/orthofoto_2002.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2002.rgb -r average /home/stefan/tmp/orthofoto_2002.gpkg 2 4 8 16 32 64 128 256
