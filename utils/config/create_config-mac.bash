#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <apl> <host-ipaddr>"
	exit 1
fi

export APL=${1}
export RESOLVE_IPADDR=${2}
export IFCONFIG_IPADDR=`ifconfig eth0 | grep inet | awk '{print $2}'`

EV3RT_PRJ_PATH=ev3rt-athrill-v850e2m/sdk/workspace/${APL}

if [ -d ${EV3RT_PRJ_PATH} ]
then
	:
else
	echo "ERROR: not found ${EV3RT_PRJ_PATH}"
	exit 1
fi



DEV_CFG_TMPL=config/device_config_udp_txt.mo
DEV_CFG_FILE=device_config.txt

bash config/mo ${DEV_CFG_TMPL} > ${DEV_CFG_FILE}

mv ${DEV_CFG_FILE} ${EV3RT_PRJ_PATH}/
cp config/memory.txt ${EV3RT_PRJ_PATH}/

exit 0
