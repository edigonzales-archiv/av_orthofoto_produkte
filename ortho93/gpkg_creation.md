/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF  -co RASTER_TABLE=ch.so.agi.orthofoto.1993.sw -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/tmp/ortho93/out/ortho1993sw.vrt /home/stefan/tmp/orthofoto_1993.gpkg

/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.1993.sw -r average /home/stefan/tmp/orthofoto_1993.gpkg 2 4 8 16 32 64 128 
