# !/bin/sh

FILE_MACHINES="conf/machine.list"

PASSWD="Pamt1bw!"

echo `date`"---process begin" >> log/main.log

for MACHINE in `cat $FILE_MACHINES`
do
    echo `date`"---process "$MACHINE >> log/main.log
    ./scripts/sshpass -p $PASSWD scp -r -o StrictHostKeyChecking=no scripts work@${MACHINE}:~/ > log/${MACHINE}.log 
    nohup ./scripts/sshpass -p $PASSWD ssh -o StrictHostKeyChecking=no work@${MACHINE} "sh ~/scripts/consume.sh ~/scripts/pa_mem_ocp 14400 " > log/${MACHINE}.log &
done

echo -e `date`"---process end\n" >> log/main.log
