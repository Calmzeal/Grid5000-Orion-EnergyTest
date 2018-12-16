timemeasureC(){
    # date +%s >> $2
    for I in `seq 1 $1`
    do
        #echo $I >> $3
        DURING=$(/root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --nowarmup --profile | grep "+-" | awk '{print $4}')  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) >> $2
        echo $FINISH >> $2
    done
    scp $2 ezhu@lyon:~/
}
export STARPU_SCHED=ws
timemeasureC 5 CN1600S20.txt 20 1600
scp getWatt.sh ezhu@lyon:~/
