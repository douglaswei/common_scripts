# !/bin/sh

# $1:run for $2 seconds

if [ $# -lt 2 ]
then
  echo "no enough param"
  exit -1
fi


CMD=$1
echo "cmd:$CMD"

SECONDS=$2
echo "seconds:$SECONDS"

BEGINTIME=`date +%Y%M%d`
echo "begin at $BEGINTIME"
BEGINTIME=`date +%s`

ENDTIME=`expr $BEGINTIME + $SECONDS`

CURTIME=`date +%s`
while [ $CURTIME -lt $ENDTIME ]
do
  MEM_TOTAL=`less /proc/meminfo | grep MemTotal | awk '{print $2}'`
  MEM_USED=`less /proc/meminfo | grep Mapped | awk '{print $2}'`
  MEM_USED_PERCENT=`expr 100 \* $MEM_USED \/ $MEM_TOTAL`
  if [ $MEM_USED_PERCENT -lt 50 ]
  then
    $CMD
  else
    sleep 60
  fi
  CURTIME=`date +%s`
done

ENDTIME=`date +%Y%M%d`
echo "end at $ENDTIME"
