#!/bin/csh
source /home/gempak/NAWIPS/Gemenviron

cd /home/mjames/scatterometer/oscat_lite/
rm -rf index.html
wget http://manati.star.nesdis.noaa.gov/noaa_oscat_lite/
#
# href="201402142327.oscat">201402142327.oscat</a></td><td
cat index.html | grep oscat | awk '{print $6 }' | sed 's/href=\"//g' | cut -c1-18 |tail -20 
if ( -e $OSCT_HOME/$FILE ) then
  wget $REMOTE_URL/$FILE
  cp $FILE $GEMDATA/osct_hi
exit
