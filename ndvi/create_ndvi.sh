#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/GDAL-2.0.0-py2.6-linux-x86_64.egg

BASEPATH=/home/stefan/Geodaten/ch/so/kva/orthofoto/2011/cir/12_5cm/
OUTPATH=/home/stefan/Geodaten/ch/so/kva/orthofoto/2011/ndvi/12_5cm/

for FILE in ${BASEPATH}*.tif
do
  echo $FILE
  BASENAME=$(basename $FILE .tif)
  OUTFILE_TMP1=${OUTPATH}/tmp1_${BASENAME}.tif
  OUTFILE_TMP2=${OUTPATH}/tmp2_${BASENAME}.tif
  OUTFILE=${OUTPATH}/${BASENAME}.tif
  
  echo "Processing: ${BASENAME}.tif"
  if [ -f $OUTFILE ] #skip if exists
  then
    echo "Skipping: $OUTFILE"
  else
    # Funktioniert nicht mit den vorher erstellen CIR? Mit RGB gehts...
    #listgeo -tfw $FILE 
    #cp ${BASEPATH}/${BASENAME}.tfw ${OUTPATH}
    #rm ${BASEPATH}/${BASENAME}.tfw
    
    convert ${BASEPATH}/${BASENAME}.tif $OUTFILE_TMP1
    convert -monitor $OUTFILE_TMP1 -fx '(u.r - u.g) / (u.r + u.g + 0.001)' $OUTFILE_TMP2
    
    /usr/local/gdal/gdal-dev/bin/gdal_edit.py -a_srs EPSG:21781 $OUTFILE_TMP2
    
    /usr/local/gdal/gdal-dev/bin/gdal_translate -of GTiff -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'BLOCKXSIZE=512' -co 'BLOCKYSIZE=512' -a_srs epsg:21781 $OUTFILE_TMP2 $OUTFILE
    /usr/local/gdal/gdal-dev/bin/gdaladdo -r average --config COMPRESS_OVERVIEW DEFLATE --config BLOCKXSIZE 512 --config BLOCKXSIZE 512 $OUTFILE 2 4 8 16 32 64 128
    
    
    rm $OUTFILE_TMP1
    rm $OUTFILE_TMP2
  fi
done

/usr/local/gdal/gdal-dev/bin/gdalbuildvrt -addalpha ${OUTPATH}.vrt ${OUTPATH}*.tif
/usr/local/gdal/gdal-dev/bin/gdalwarp -tr 5.0 5.0 -of GTiff -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -co 'COMPRESS=DEFLATE' -co 'BLOCKXSIZE=512' -co 'BLOCKYSIZE=512' -wo NUM_THREADS=ALL_CPUS -s_srs epsg:21781 -t_srs epsg:21781 ${OUTPATH}.vrt ${OUTPATH}/ortho2011ndvi_alpha.tif
/usr/local/gdal/gdal-dev/bin/gdaladdo -r nearest --config COMPRESS_OVERVIEW DEFLATE --config GDAL_TIFF_OVR_BLOCKSIZE 512 ${OUTPATH}/ortho2011ndvi_alpha.tif 2 4 8 16 32 64 128"
