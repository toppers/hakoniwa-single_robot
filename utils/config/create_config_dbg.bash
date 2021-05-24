#!/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <apl> <eth>"
	exit 1
fi

export APL=${1}
ETH=${2}

export EV3RT_PRJ_PATH=ev3rt-athrill-v850e2m/sdk/workspace/${APL}

if [ -d ${EV3RT_PRJ_PATH} ]
then
	:
else
	echo "ERROR: not found ${EV3RT_PRJ_PATH}"
	exit 1
fi


export IFCONFIG_IPADDR=`ifconfig | grep -A 1 ${ETH} | grep inet | awk '{print $2}'`
export RESOLVE_IPADDR=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`

DEV_CFG_TMPL=config/device_config_udp_dbg_txt.mo
DEV_CFG_FILE=device_config.txt

bash config/mo ${DEV_CFG_TMPL} > ${DEV_CFG_FILE}

mv ${DEV_CFG_FILE} ${EV3RT_PRJ_PATH}/
cp config/memory.txt ${EV3RT_PRJ_PATH}/

exit 0
