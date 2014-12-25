#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/GDAL-2.0.0-py2.6-linux-x86_64.egg

BASEPATH=/home/stefan/Geodaten/ch/so/kva/orthofoto/2011/cir/12_5cm/
OUTPATH=/home/stefan/Geodaten/ch/so/kva/orthofoto/2011/cir/12_5cm/pimp/

for FILE in ${BASEPATH}*.tif
do
  BASENAME=$(basename $FILE .tif)
  OUTFILE_TMP=${OUTPATH}/tmp_${BASENAME}.tif
  OUTFILE=${OUTPATH}/${BASENAME}.tif
  # for testing
  OUTFILE_V2=${OUTPATH}/v2_${BASENAME}.tif
  OUTFILE_V3=${OUTPATH}/v3_${BASENAME}.tif
  OUTFILE_V4=${OUTPATH}/v4_${BASENAME}.tif
  OUTFILE_V5=${OUTPATH}/v5_${BASENAME}.tif
  
  echo "Processing: ${BASENAME}.tif"
  if [ -f $OUTFILE ] #skip if exists
  then
    echo "Skipping: $OUTFILE"
  else
    listgeo -tfw $FILE
    cp ${BASEPATH}/${BASENAME}.tfw ${OUTPATH}
    rm ${BASEPATH}/${BASENAME}.tfw
    
    convert -channel R -gamma 2 -channel B -gamma 0.95 ${BASEPATH}/${BASENAME}.tif $OUTFILE_TMP
    
    /usr/local/gdal/gdal-dev/bin/gdal_edit.py -a_srs EPSG:21781 $OUTFILE_TMP
    
    /usr/local/gdal/gdal-dev/bin/gdal_translate -of GTiff -co 'TILED=YES' -co 'PROFILE=GeoTIFF' -co 'PHOTOMETRIC=RGB' -co 'INTERLEAVE=PIXEL' -co 'COMPRESS=DEFLATE' -co 'BLOCKXSIZE=512' -co 'BLOCKYSIZE=512' -a_srs epsg:21781 $OUTFILE_TMP $OUTFILE
    /usr/local/gdal/gdal-dev/bin/gdaladdo -r average --config COMPRESS_OVERVIEW DEFLATE --config BLOCKXSIZE 512 --config BLOCKXSIZE 512 $OUTFILE 2 4 8 16 32 64 128
    
    
    rm $OUTFILE_TMP
    rm ${OUTPATH}/${BASENAME}.tfw
  fi
done



