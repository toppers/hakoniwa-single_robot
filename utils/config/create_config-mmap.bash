#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <apl>"
	exit 1
fi

export APL=${1}

EV3RT_PRJ_PATH=../sdk/workspace/${APL}

if [ -d ${EV3RT_PRJ_PATH} ]
then
	:
else
	echo "ERROR: not found ${EV3RT_PRJ_PATH}"
	exit 1
fi

DEV_CFG_TMPL=utils/config/device_config_mmap_txt.mo
DEV_CFG_FILE=device_config.txt

bash utils/config/mo ${DEV_CFG_TMPL} > ${DEV_CFG_FILE}

mv ${DEV_CFG_FILE} ${EV3RT_PRJ_PATH}/

export ATHRILL_DEVICE_PATH=`cd ../../athrill-device && pwd`
bash utils/config/mo utils/config/memory_mmap_txt.mo > ${EV3RT_PRJ_PATH}/memory.txt

exit 0
