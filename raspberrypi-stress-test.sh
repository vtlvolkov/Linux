#/!bin/bash

function get_cpu_info() {
        cpu=$(</sys/class/thermal/thermal_zone0/temp)
	echo "$((cpu/1000)) c"
}

get_cpu_info

for ((i=1; i<=10; i++))
do
        sysbench --num-threads=4 --test=cpu --cpu-max-prime=20000 run > /dev/null 2>&1
        get_cpu_info
done
