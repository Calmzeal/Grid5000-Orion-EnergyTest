timemeasureC(){
    for I in `seq 1 $1`
    do
        DURING=$(/root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=1 --nowarmup --profile | grep "+-" | awk '{print int($4)}')  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
    scp $2 ezhu@lyon:~/
}

export STARPU_SCHED=ws
timemeasureC 5 GN1600S20.txt 20 1600
scp getWatt.sh ezhu@lyon:~/
