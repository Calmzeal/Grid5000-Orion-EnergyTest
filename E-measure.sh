timemeasureC(){
    date +%s >> $2
    for I in `seq 1 $1`
    do
        echo $I >> $3
        /root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($4*$5)) --m=$(($4*$5)) --nb=$4 --gpus=0 --nowarmup --profile >> $3
        date +%s >> $2
    done
}

export STARPU_SCHED=ws
timemeasureC 5 CN1600S20.txt logCN1600S20.txt 20 1600

