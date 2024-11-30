#! /bin/bash

# Silly script that calculates the actual CPU load with respect to the number of available cores

output_size=0

while [ ${#} -gt 0 ]; do
    case "${1}" in
        -s|--small)
        shift
        ;;
        -m|--medium)
        output_size=1
        shift
        ;;
        -l|--large)
        output_size=2
        shift
        ;;
    esac
done

cpu_cores=$(cat /proc/cpuinfo | grep -c processor)
load_info=$(uptime)

if [ ${output_size} -eq 0 ];then
    load_5_min=$(printf "${load_info}" | cut -d " " -f 12 | tr -d ",")
    realload_5_min=$(printf "scale=4;${load_5_min}/${cpu_cores}\n" | bc -l | sed "s/^\./0./")
    printf "${realload_5_min}\n"
elif [ ${output_size} -eq 1 ];then
    load_10_min=$(printf "${load_info}" | cut -d " " -f 13 | tr -d ",")
    realload_10_min=$(printf "scale=4;${load_10_min}/${cpu_cores}\n" | bc -l | sed "s/^\./0./")
    printf "${realload_10_min}\n"
elif [ ${output_size} -eq 2 ];then
    load_15_min=$(printf "${load_info}" | cut -d " " -f 14)
    realload_15_min=$(printf "scale=4;${load_15_min}/${cpu_cores}\n" | bc -l | sed "s/^\./0./")
    printf "${realload_15_min}\n"
fi