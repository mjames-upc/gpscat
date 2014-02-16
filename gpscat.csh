#!/bin/csh -f
source /home/gempak/NAWIPS/Gemenviron
setenv DISPLAY :0.0

set SCAT=${1}
set SCTMIN=${2}
#set OSCT="${1}|last|6;12;18;24;30;36;42;48;54;60|30;6;26;24;21;23;5;17;8;14|31;31;31;31;31;31;31;31;31;31|.2;.4;1;5|0|0|1|1|Y|Y|Y|Y"
#set OSCT="${1}|last|6;12;18;24;30;36;42;48;54;60|30;6;26;24;21;23;5;17;8;14|31;31;31;31;31;31;31;31;31;31|.2;.4;1;5|0|0|0|0|n|n|n"
#set SGWH="${1}|last|3;6;9;12;15;18;21;24;27;30;33;36;39;45;70|31;6;26;24;21;22;23;20;19;17;16;15;14;28;7|31;31;31;31;31;31;31;31;31;31|0|0|1"
# SGWH = data type | end time | height intervals | colors | skip | time stamp interval | time stamp color
if ( ${1} == "OSCT_HI") then
  set MAP="0"
else
  set MAP="8=112:112:112/1/2"
endif
set gifname=${1}-mercator_3.gif
rm -rf ${gifname}
gpscat_gf << EOF
 \$mapfil = hipowo.nws + histus.nws
 \$mapfil = hipowo.nws 
 MAP      = 7=38:38:38+8=112:112:112
 MAP      = 8=112:112:112/10/1
 MAP	  = $MAP
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
 DEVICE   = gf|${gifname}|4096;3072
 LINE     = 
 BND      =  
 SCAT     = $SCAT
 SCTTIM   = last
 SCTMIN   = $SCTMIN
 COLR1    = 30;6;26;24;21;23;5;17;8;14
 COLR2    = 31;31;31;31;31;31;31;31;31;31
 SPDINT   = 6;12;18;24;30;36;42;48;54;60
 MARKER   = .2;.4;1;5
 SCTTYP   = 0|0|0|0|n|n|n
 save gpscat-${1}.nts
r 

e
EOF

scp ${gifname} conan:/content/software/gempak/scatterometer/


#
# med res
#

set gifname=${1}-mercator_2.gif
rm -rf ${gifname}
gpscat_gf << 1EOF
 DEVICE   = gf|${gifname}|2048;1536
 r

 e
1EOF
scp ${gifname} conan:/content/software/gempak/scatterometer/


#
## Low res
#

set gifname=${1}-mercator_1.gif
rm -rf ${gifname}
gpscat_gf << E2OF
 DEVICE = gf|${gifname}|1024;768
 r

 e
E2OF

scp ${gifname} conan:/content/software/gempak/scatterometer/

#ls -la giftile_*
#convert -crop 256x256 +repage ${gifname} giftile_%02d.gif
