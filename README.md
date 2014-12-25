Allgemein
=========
Oftmals wird mit Python über den Tileindex (`gdaltindex`) geloopt.

ortho07
=======
Das Orthofoto 2006 und 2007 hat *nicht* komplett ausgefüllte Kacheln. Beim Hochladen habe ich es (damit es schneller geht) nach JPEG umgewandelt. Aus diesem Grund kann es jetzt an den Kanten zu hässlichen Artefakten kommen.

* Mit `nearblack` bearbeiten, um die Artefakte loszuwerden.
* Gleichzeitig wird alles transparent gemacht, was nicht Orthofoto ist. 
* Achtung: Sämtliche Kacheln (also auch komplett ausgefüllte) bekommen jetzt einen Alpha-Kanal.

ortho02
=======
Beim Orthofoto 2002 wird versucht die Farben bisschen aufzupimpen und analog Orthofoto 2006/7 die halbvollen Kacheln mit Transparenz zu füllen.

Upsi, das ist hässlich und hat Lücken -> nochmals über die Bücher: Version 2 analog 2006/7.

ortho93
=======
Hier müssen nur die nicht komplett gefüllten Kacheln transparent gemacht werden. Da der Perimeter der Kantonsgrenze entspricht, wird diese als "cutline" verwendet. Wird mit `nodata`-Werten gearbeiten (255) gibts relativ viele leere Pixel innerhalb des Perimeters.

Die einzelnen Kacheln haben einen Alpha-Kanal. Das VRT wurde nicht mit `-dstalpha` erzeugt. (ändert eventuell nocht)


GPKG
====

/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2011.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2011/rgb/12_5cm/ortho2011rgb_alpha.vrt /home/stefan/tmp/orthofoto_2011.gpkg
/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2011.rgb -r average /home/stefan/tmp/orthofoto_2011.gpkg 2 4 8 16 32 64 128 256 512

/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2011.cir -co TILE_FORMAT=PNG_JPEG -of GPKG /home/stefan/Geodaten/ch/so/kva/orthofoto/2011/cir/12_5cm/ortho2011cir_alpha.vrt /home/stefan/tmp/orthofoto_2011.gpkg
/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2011.cir -r average /home/stefan/tmp/orthofoto_2011.gpkg 2 4 8 16 32 64 128 256 512





/usr/local/gdal/gdal-dev/bin/gdal_translate --config OGR_SQLITE_SYNCHRONOUS OFF -co APPEND_SUBDATASET=YES -co RASTER_TABLE=ch.so.agi.orthofoto.2012.rgb -co TILE_FORMAT=PNG_JPEG -of GPKG /opt/Geodaten/ch/so/kva/orthofoto/2012/rgb/12_5cm/ortho2012rgb_alpha.vrt /home/stefan/tmp/orthofoto_2012.gpkg
/usr/local/gdal/gdal-dev/bin/gdaladdo --config OGR_SQLITE_SYNCHRONOUS OFF -oo TABLE=ch.so.agi.orthofoto.2012.rgb -r average /home/stefan/tmp/orthofoto_2012.gpkg 2 4 8 16 32 64 128 256 512
