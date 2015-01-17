for BAND in {4,3,2}; do
  gdalwarp -overwrite -r cubic -t_srs EPSG:21781 -co TFW=YES /home/stefan/Downloads/landsat/LC81950272014159LGN00/LC81950272014159LGN00_B$BAND.TIF /home/stefan/Downloads/landsat/LC81950272014159LGN00/$BAND-projected.tif
done


