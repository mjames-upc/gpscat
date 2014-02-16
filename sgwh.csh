#!/bin/csh -f
source /home/gempak/NAWIPS/Gemenviron
setenv DISPLAY :0.0

set SCAT=${1}
set SCTMIN=${2}

set gifname=${1}-mercator_3.gif
gpscat << EOF0
 \$mapfil = hipowo.nws 
 MAP      = 8=112:112:112/1/2
 MSCALE   = 0
 GAREA    = 0;0;0;0
 PROJ     = ced/0;-105;45
 GAREA    = 20;70;50;70
 PROJ     = mer
 GAREA    = -10;55;30;115
 PROJ 	  = ort/0;50;0
 GAREA    = 20;70;50;70
 GAREA     = 0;-105;0;-105
 PROJ     = ort/50;-105;0
 PROJ     = mer
 GAREA 	  = -80;-180;80;180
 IMCBAR   = 
 LATLON   =  
 PANEL    = 0
 TITLE    = 31 
 TEXT     = 1
 CLEAR    = YES
 DEVICE   = gif|${gifname}|4096;3072
 LINE     = 
 BND      =  
 SCAT     = $SCAT
 SCTTIM   = last
 SCTMIN   = $SCTMIN
 COLR1    = 31;6;26;24;21;22;23;20;19;17;16;15;14;28;7 
 COLR2    = 
 SPDINT   = 3;6;9;12;15;18;21;24;27;30;33;36;39;45;70
 MARKER   = 
 SCTTYP   = 0|0|1
save sgwh.nts
l
r 

e
EOF0


gpend

scp ${gifname} conan:/content/software/gempak/scatterometer/

#
# med res
#
set gifname=${1}-mercator_2.gif
gpscat << EOF1
 restore sgwh.nts
 DEVICE   = gif|${gifname}|2048;1536
 l 
 r

 e
EOF1

gpend

scp ${gifname} conan:/content/software/gempak/scatterometer/

#
# low res
#
set gifname=${1}-mercator_1.gif
gpscat << EOF2
 restore sgwh.nts
 DEVICE   = gif|${gifname}|1024;768
 r                     
 l

 e                      
EOF2 


gpend                   



scp ${gifname} conan:/content/software/gempak/scatterometer/
convert -crop 256x256 +repage ${gifname} giftile_%02d.gif

ls -la giftile_*
