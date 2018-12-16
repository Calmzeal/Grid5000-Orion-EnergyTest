measure (){
    curl "http://kwapi.lyon.grid5000.fr:12000/power/timeseries/?from=$1&to=$2&only=orion-1" |jq '.["items"][0]["values"]' >>$3
}
teststarPU (){
    while read line
    do
        s=$(echo $line | awk '{print $1}')
        f=$(echo $line | awk '{print $2}')
        measure $s $f $2
    done<$1
}

