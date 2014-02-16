#!/bin/csh -f

# plot ASCT_HI 
#  ASCT     = ${1}|last  |max_back| 6;12;18;24;30;36;42;48;54;60|30;6;26;24;21;23;5;17;8;14|31;31;31;31;31;31;31;31;31;31|.2;.4;1;5                    |0   |1               |1           |3         |Y       |Y      |Y      |Y      |Y
#         datatype|endtime|speed intervals             | colors1                  | colors2                     |bard size;width;headsize;type|skip|tstamp internval|tstamp color|line width|high sps|low spd|qc fail|redundant|qc fail colors|plot circles
#
#
source /home/gempak/NAWIPS/Gemenviron
setenv DISPLAY :0.0

set ASCT = ""
set QBUF = ""
set QSCT = ""
set OSCT="${1}|last|${2}|6;12;18;24;30;36;42;48;54;60|30;6;26;24;21;23;5;17;8;14|31;31;31;31;31;31;31;31;31;31|.2;.4;1;5|0|0|0|0|n|n|n"
set SGWH = ""

#switch (${1})
#	case asct_hi:
#		set ASCT="${1}|last|${2}|6;12;18;24;30;36;42;48;54;60|30;6;26;24;21;23;5;17;8;14|31;31;31;31;31;31;31;31;31;31|.2;.4;1;5|0|0|1|1|Y|Y|Y|Y"
#		breaksw
#	case osct:
#		set OSCT="${1}|last|6;12;18;24;30;36;42;48;54;60|30;6;26;24;21;23;5;17;8;14|31;31;31;31;31;31;31;31;31;31|.2;.4;1;5|0|0|1|1|Y|Y|Y|Y"
#		breaksw
#       case osct_hi:
#                set OSCT="${1}|last|${2}|6;12;18;24;30;36;42;48;54;60|30;6;26;24;21;23;5;17;8;14|31;31;31;31;31;31;31;31;31;31|.2;.4;1;5|0|0|0|0|n|n|n"
#                breaksw
#
#  Data type | End time | Speed intervals | colors1 | colors2 |
#  Arrow/Barb shaft size;Arrow/Barb width;Arrow head size;
#  Type of wind vector | Skip | Time stamp interval | Time stamp color | 
#  Line Width | Rain | Rain Colors | Rain Circles
#
#       The data type is a selection to plot OSCT or OSCT_HI, or ambiguities
#       OAMBG1_HI, OAMBG2_HI, OAMBG3_HI, or OAMBG4_HI.
#
#	case SGWH2:
#		set SGWH="${1}|last|3;6;9;12;15;18;21;24;27;30;33;36;39;45;70|31;6;26;24;21;22;23;20;19;17;16;15;14;28;7|31;31;31;31;31;31;31;31;31;31|0|0|1"
#		breaksw
#endsw

set gifname=${1}-globe_3.gif
gpmap << EOF
 \$mapfil = hipowo.nws + histus.nws
 \$mapfil = hipowo.nws 
 MAP      = 7=38:38:38+8=112:112:112
 MAP      = 8=112:112:112/1/4
 MSCALE   = 0
 GAREA    = nam
 PROJ     = def
 GAREA    = 0;0;0;0
 PROJ     = ced/0;-105;45
 GAREA    = 20;70;50;70
 PROJ     = mer
 GAREA    = -10;55;30;115
 PROJ 	  = ort/0;50;0
 GAREA    = 20;70;50;70
GAREA = 0;-105;0;-105
PROJ = ort/50;-105;0
PROJ = mer
GAREA = -80;-180;80;180
 SATFIL   =  
 RADFIL   =  
 IMCBAR   = 
 LATLON   =  
 PANEL    = 0
 TITLE    = 31 
 TEXT     = 1
 CLEAR    = YES
 DEVICE   = gif|${gifname}|4096;3072
 LUTFIL   =  
 STNPLT   =  
 VGFILE   =  
 AFOSFL   =  
 AWPSFL   =  
 LINE     = 
 WATCH    =  
 WARN     =  
 HRCN     =  
 ISIG     =  
 LTNG     =  
 ATCF     =  
 AIRM     =  
 GAIRM    =  
 NCON     =  
 CSIG     =  
 SVRL     =  
 BND      =  
 TCMG     =  
 QSCT     = 
 WSTM     =  
 WOU      =  
 WCN      =  
 WCP      =  
 ENCY     =  
 FFA      =  
 WSAT     =  
 QBUF     = $QBUF
 ASCT     = $ASCT
 QSCT     = $QSCT
 OSCT     = $OSCT
 SGWH     = $SGWH
 ASDI     =  
 EDR      =  
 WSPDA    =  
save globe.nts
l
r 

e
EOF

gpend





scp ${gifname} conan:/content/software/gempak/scatterometer/
exit

# med res
#
## Europe
set gifname=${1}-globe_2.gif
gpmap << EOF
 DEVICE   = gif|${gifname}|2048;1536
 r

 e
EOF
gpend
scp ${gifname} conan:/content/software/gempak/scatterometer/

# low res
set gifname=${1}-globe_1.gif
gpmap << EOF
 DEVICE   = gif|${gifname}|1024;768
 r                     

 e                      
EOF                     
gpend                   
gpend

scp ${gifname} conan:/content/software/gempak/scatterometer/

convert -crop 256x256 +repage ${gifname} giftile_%02d.gif
