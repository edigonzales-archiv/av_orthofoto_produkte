/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF  -co RASTER_TABLE=ch.so.agi.orthofoto.2006.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/tmp/ortho06/out/ortho2006rgb.vrt /home/stefan/tmp/orthofoto_2006.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2006.rgb -r average /home/stefan/tmp/orthofoto_2006.gpkg 2 4 8 16 32 64 128 256 512
