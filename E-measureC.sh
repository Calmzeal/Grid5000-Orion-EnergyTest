timemeasureC(){
    # date +%s >> $2
    for I in `seq 1 $1`
    do
        #echo $I >> $3
        /root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --threads=$5 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}
timemeasureC1(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dpotrf_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --threads=$5 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}
timemeasureC2(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dtrsm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --threads=$5 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}
timemeasureC3(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dsyrk_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --threads=$5 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}
export STARPU_SCHED=ws

timemeasureC 3 CN9600S1.txt 1 9600 6
timemeasureC 3 CN6400S2.txt 2 6400 6

timemeasureC1 3 C1N9600S1.txt 1 9600 6
timemeasureC1 3 C1N6400S2.txt 2 6400 6

timemeasureC2 3 C2N9600S1.txt 1 9600 6
timemeasureC2 3 C2N6400S2.txt 2 6400 6

timemeasureC3 3 C3N9600S1.txt 1 9600 6
timemeasureC3 3 C3N6400S2.txt 2 6400 6
