timemeasureC(){
    # date +%s >> $2
    for I in `seq 1 $1`
    do
        #echo $I >> $3
        DURING=$(/root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --nowarmup --profile | grep "+-" | awk '{print int($4)}')  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) >> $2
        echo $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
    scp $2 ezhu@lyon:~/
}
export STARPU_SCHED=ws
timemeasureC 5 CN1600S20.txt 20 1600
scp getWatt.sh ezhu@lyon:~/
