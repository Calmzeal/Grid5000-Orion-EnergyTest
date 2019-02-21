



tm-dgemm-CPU(){
    output="dgemm_N=$3-blocksize=$4_CPU-ThreadN=$2.txt"
    timeout="dgemm_N=$3-blocksize=$4_CPU-ThreadN=$2_time.txt"
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dgemm_tile_batch --n=$3 --m=$3 --nb=$4 --gpus=0 --threads=$2 --nowarmup --profile > temp 2>&1  
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        cat temp >> $output
        echo $(($FINISH-$DURING)) " " $FINISH >> $timeout
    done
    echo "teststarPU $timeout log$timeout" >> getWatt.sh
}

tm-dpotrf-CPU(){
    output="dpotrf_N=$3-blocksize=$4_CPU-ThreadN=$2.txt"
    timeout="dpotrf_N=$3-blocksize=$4_CPU-ThreadN=$2_time.txt"
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dpotrf_tile_batch --n=$3 --m=$3 --nb=$4 --gpus=0 --threads=$2 --nowarmup --profile > temp 2>&1  
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        cat temp >> $output
        echo $(($FINISH-$DURING)) " " $FINISH >> $timeout
    done
    echo "teststarPU $timeout log$timeout" >> getWatt.sh
}

tm-dtrsm-CPU(){
    output="dtrsm_N=$3-blocksize=$4_CPU-ThreadN=$2.txt"
    timeout="dtrsm_N=$3-blocksize=$4_CPU-ThreadN=$2_time.txt"
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dtrsm_tile_batch --n=$3 --m=$3 --nb=$4 --gpus=0 --threads=$2 --nowarmup --profile > temp 2>&1  
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        cat temp >> $output
        echo $(($FINISH-$DURING)) " " $FINISH >> $timeout
    done
    echo "teststarPU $timeout log$timeout" >> getWatt.sh
}

tm-dsyrk-CPU(){
    output="dsyrk_N=$3-blocksize=$4_CPU-ThreadN=$2.txt"
    timeout="dsyrk_N=$3-blocksize=$4_CPU-ThreadN=$2_time.txt"
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dsyrk_tile_batch --n=$3 --m=$3 --nb=$4 --gpus=0 --threads=$2 --nowarmup --profile > temp 2>&1  
        DURING=$(cat temp|grep "CPU 0.*total"|awk {'print int($4)'})  
        FINISH=$(date +%s)
        cat temp >> $output
        echo $(($FINISH-$DURING)) " " $FINISH >> $timeout
    done
    echo "teststarPU $timeout log$timeout" >> getWatt.sh
}


tm-dgemm-GPU(){
    output="dgemm_N=$3-blocksize=$4_GPU-DeviceN=$2.txt"
    timeout="dgemm_N=$3-blocksize=$4_GPU-DeviceN=$2_time.txt"
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dgemm_tile_batch --n=$3 --m=$3 --nb=$4 --gpus=1 --nowarmup --profile > temp 2>&1  
        DURING=$(cat temp|grep "CUDA.*total"|awk {'print int($12)'})  
        FINISH=$(date +%s)
        cat temp >> $output
        echo $(($FINISH-$DURING)) " " $FINISH >> $timeout
    done
    echo "teststarPU $timeout log$timeout" >> getWatt.sh
}

tm-dtrsm-GPU(){
    output="dtrsm_N=$3-blocksize=$4_GPU-DeviceN=$2.txt"
    timeout="dtrsm_N=$3-blocksize=$4_GPU-DeviceN=$2_time.txt"
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dtrsm_tile_batch --n=$3 --m=$3 --nb=$4 --gpus=1 --nowarmup --profile > temp 2>&1  
        DURING=$(cat temp|grep "CUDA.*total"|awk {'print int($12)'})  
        FINISH=$(date +%s)
        cat temp >> $output
        echo $(($FINISH-$DURING)) " " $FINISH >> $timeout
    done
    echo "teststarPU $timeout log$timeout" >> getWatt.sh
}

tm-dsyrk-GPU(){
    output="dsyrk_N=$3-blocksize=$4_GPU-DeviceN=$2.txt"
    timeout="dsyrk_N=$3-blocksize=$4_GPU-DeviceN=$2_time.txt"
    for I in `seq 1 $1`
    do
        /root/chameleon/build/timing/time_dsyrk_tile_batch --n=$3 --m=$3 --nb=$4 --gpus=1 --nowarmup --profile > temp 2>&1  
        DURING=$(cat temp|grep "CUDA.*total"|awk {'print int($12)'})  
        FINISH=$(date +%s)
        cat temp >> $output
        echo $(($FINISH-$DURING)) " " $FINISH >> $timeout
    done
    echo "teststarPU $timeout log$timeout" >> getWatt.sh
}


export STARPU_SCHED=ws
export STARPU_CALIBRATE=0

cp -f CPUversion/time_zpotrf_tile.c /root/chameleon/timing
cp -f CPUversion/time_zgemm_tile_batch.c /root/chameleon/timing

cd /root/chameleon/build/timing
make
cd /root/HPC-research

tm-dgemm-CPU 3 6 9600 9600
tm-dgemm-CPU 3 6 12800 6400

tm-dpotrf-CPU 3 6 9600 9600
tm-dpotrf-CPU 3 6 12800 6400

tm-dtrsm-CPU 3 6 9600 9600
tm-dtrsm-CPU 3 6 12800 6400

tm-dsyrk-CPU 3 6 9600 9600
tm-dsyrk-CPU 3 6 12800 6400

cp -f CPUversion/time_zpotrf_tile.c /root/chameleon/timing
cp -f CPUversion/time_zgemm_tile_batch.c /root/chameleon/timing

cd /root/chameleon/build/timing
make
cd /root/HPC-research

tm-dgemm-GPU 3 1 9600 9600
tm-dgemm-GPU 3 1 12800 6400

tm-dtrsm-GPU 3 1 9600 9600
tm-dtrsm-GPU 3 1 12800 6400

tm-dsyrk-GPU 3 1 9600 9600
tm-dsyrk-GPU 3 1 12800 6400

