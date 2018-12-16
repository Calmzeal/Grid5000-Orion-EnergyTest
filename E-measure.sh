timemeasureC(){
    # date +%s >> $2
    for I in `seq 1 $1`
    do
        #echo $I >> $3
        DURING=$(/root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --nowarmup --profile | grep "+-" | awk '{print int($4)}')  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
    
}
export STARPU_SCHED=ws
timemeasureC 5 CN200S160.txt 160 200
timemeasureC 5 CN400S80.txt 80 400
timemeasureC 5 CN800S40.txt 40 800
timemeasureC 5 CN1600S20.txt 20 1600
timemeasureC 5 CN3200S10.txt 10 3200
scp getWatt.sh ezhu@lyon:~/
scp ./*.txt ezhu@lyon:~/
