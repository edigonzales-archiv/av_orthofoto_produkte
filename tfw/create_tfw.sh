#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gdal/gdal-dev/lib
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.6/dist-packages/GDAL-2.0.0-py2.6-linux-x86_64.egg

BASEPATH=/home/stefan/Geodaten/ch/so/kva/orthofoto/2011/rgb/12_5cm/
OUTPATH=/home/stefan/tmp/tfw/

for FILE in ${BASEPATH}*.tif
do
  BASENAME=$(basename $FILE .tif)
  
  echo "Processing: ${BASENAME}.tif"
  listgeo -tfw $FILE
  cp ${BASEPATH}/${BASENAME}.tfw ${OUTPATH}
done



