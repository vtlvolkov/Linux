#/!bin/bash

function get_cpu_info() {
        vcgencmd measure_temp
        vcgencmd measure_clock arm
        vcgencmd get_throttled
        echo
}

get_cpu_info

for ((i=1; i<=10; i++))
do
        sysbench --num-threads=4 --test=cpu --cpu-max-prime=20000 run > /dev/null 2>&1
        get_cpu_info
done