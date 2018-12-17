timemeasureC(){
    # date +%s >> $2
    for I in `seq 1 $1`
    do
        #echo $I >> $3
        /root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print $4'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}

timemeasureC1(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dpotrf_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print $4'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}

timemeasureC2(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dtrsm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print $4'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}

timemeasureC3(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dsyrk_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=0 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print $4'})  
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

timemeasureC 5 CN1000S20.txt 20 1000
timemeasureC 5 CN1200S20.txt 20 1200
timemeasureC 5 CN1400S20.txt 20 1400
timemeasureC 5 CN1800S20.txt 20 1800

timemeasureC1 5 C1N2000S20.txt 24 2000
timemeasureC1 5 C1N2400S20.txt 20 2400
timemeasureC1 5 C1N3200S15.txt 15 3200
timemeasureC1 5 C1N4800S10.txt 10 4800
timemeasureC1 5 C1N8000S6.txt 6 8000

timemeasureC1 5 C1N3600S10.txt 10 3600
timemeasureC1 5 C1N3900S10.txt 10 3900 
timemeasureC1 5 C1N4200S10.txt 10 4200
timemeasureC1 5 C1N5400S10.txt 10 5400

timemeasureC2 5 C2N2400S10.txt 10 2400
timemeasureC2 5 C2N3000S8.txt 8 3000
timemeasureC2 5 C2N4000S6.txt 6 4000
timemeasureC2 5 C2N4800S5.txt 5 4800
timemeasureC2 5 C2N6000S4.txt 4 6000

timemeasureC2 5 C2N3600S5.txt 5 3600
timemeasureC2 5 C2N3900S5.txt 5 3900 
timemeasureC2 5 C2N4200S5.txt 5 4200
timemeasureC2 5 C2N5400S5.txt 5 5400

timemeasureC3 5 C3N2400S10.txt 10 2400
timemeasureC3 5 C3N3000S8.txt 8 3000
timemeasureC3 5 C3N4000S6.txt 6 4000
timemeasureC3 5 C3N4800S5.txt 5 4800
timemeasureC3 5 C3N6000S4.txt 4 6000

timemeasureC3 5 C3N3600S5.txt 5 3600
timemeasureC3 5 C3N3900S5.txt 5 3900 
timemeasureC3 5 C3N4200S5.txt 5 4200
timemeasureC3 5 C3N5400S5.txt 5 5400


scp getWatt.sh ezhu@lyon:~/
scp ./*.txt ezhu@lyon:~/
