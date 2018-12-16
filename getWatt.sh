measure (){
    curl "http://kwapi.lyon.grid5000.fr:12000/power/timeseries/?from=$1&to=$2&only=orion-1" >>$3
}



teststarPU (){
    read START<$1
    while read f
    do
        echo $START $f
        measure $START $f $2
        START=$f
    done<$1
}
teststarPU record1206GPU.txt test1206GPU.txt
