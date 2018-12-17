#CUDA 0.0 (Tesla M2075 4.7 GiB 42:00.0)  total 36.82 s   exec 24.67 s    overhead 32.99%


timemeasureG(){
    # date +%s >> $2
    for I in `seq 1 $1`
    do
        #echo $I >> $3
        /root/chameleon/build/timing/time_dgemm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=1 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CUDA.*total"|awk {'print int($12)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}

timemeasureG1(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dpotrf_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=1 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}

timemeasureG2(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dtrsm_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=1 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}



timemeasureG3(){
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dsyrk_tile_batch --n=$(($3*$4)) --m=$(($3*$4)) --nb=$4 --gpus=1 --nowarmup --profile 2> temp
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        echo $(($FINISH-$DURING)) " " $FINISH >> $2
    done
    echo "teststarPU $2 log$2" >> getWatt.sh
}

export STARPU_SCHED=ws
timemeasureG 3 GN4800S2.txt 4800 2
timemeasureG 3 GN6400S2.txt 6400 2

# timemeasureG 5 GN200S160.txt 160 200
# timemeasureG 5 GN400S80.txt 80 400
# timemeasureG 5 GN800S40.txt 40 800
# timemeasureG 5 GN1600S20.txt 20 1600
# timemeasureG 5 GN3200S10.txt 10 3200
# timemeasureG 5 GN1000S20.txt 20 1000
# timemeasureG 5 GN1200S20.txt 20 1200
# timemeasureG 5 GN1400S20.txt 20 1400
# timemeasureG 5 GN1800S20.txt 20 1800


# timemeasureG2 5 G2N2400S10.txt 10 2400
# timemeasureG2 5 G2N3000S8.txt 8 3000
# timemeasureG2 5 G2N4000S6.txt 6 4000
# timemeasureG2 5 G2N4800S5.txt 5 4800
# timemeasureG2 5 G2N6000S4.txt 4 6000

# timemeasureG2 5 G2N3600S5.txt 5 3600
# timemeasureG2 5 G2N3900S5.txt 5 3900 
# timemeasureG2 5 G2N4200S5.txt 5 4200
# timemeasureG2 5 G2N5400S5.txt 5 5400

# timemeasureG3 5 G3N2400S10.txt 10 2400
# timemeasureG3 5 G3N3000S8.txt 8 3000
# timemeasureG3 5 G3N4000S6.txt 6 4000
# timemeasureG3 5 G3N4800S5.txt 5 4800
# timemeasureG3 5 G3N6000S4.txt 4 6000

# timemeasureG3 5 G3N3600S5.txt 5 3600
# timemeasureG3 5 G3N3900S5.txt 5 3900 
# timemeasureG3 5 G3N4200S5.txt 5 4200
# timemeasureG3 5 G3N5400S5.txt 5 5400




scp getWatt.sh ezhu@lyon:~/

scp ./*.txt ezhu@lyon:~/
