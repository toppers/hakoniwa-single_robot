#!/bin/bash

CPU_MODE=CPU
if [ $# -eq 2 ]
then
    CPU_MODE=DEBUG
fi
APL_NAME=${1}

EV3RT_DIR=ev3rt-athrill-v850e2m

if [ -d ${EV3RT_DIR}/sdk/workspace/${APL_NAME} ]
then
    :
else
    echo "ERROR: not found directory: ${EV3RT_DIR}/sdk/workspace/${APL_NAME}"
    exit 1
fi

cd ${EV3RT_DIR}/sdk/workspace/${APL_NAME}

if [ -f ../asp ]
then
    :
else
    echo "ERROR: not found asp binary. please build app."
    exit 1
fi

if [ ${CPU_MODE} = "CPU" ]
then
    athrill2 -c1 -t -1 -m memory.txt -d device_config.txt ../asp
else
    athrill2 -c1 -i -m memory.txt -d device_config.txt ../asp
fi

