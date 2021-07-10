#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <apl>"
	exit 1
fi

export APL=${1}

export EV3RT_PRJ_PATH=sdk/workspace/${APL}

if [ -d ${EV3RT_PRJ_PATH} ]
then
	:
else
	echo "ERROR: not found ${EV3RT_PRJ_PATH}"
	exit 1
fi


DEV_CFG_TMPL=${TEMPLATE_PATH}/athrill/device_config/device_config_${COMM_TYPE}_${PACKET_TYPE}_txt.mo
DEV_CFG_FILE=device_config.txt

bash ${BASH_TPL_ENGINE} ${DEV_CFG_TMPL} > ${DEV_CFG_FILE}

mv ${DEV_CFG_FILE} ${EV3RT_PRJ_PATH}/

DEV_CFG_TMPL=${TEMPLATE_PATH}/athrill/memory_config/memory_${COMM_TYPE}_txt.mo
DEV_CFG_FILE=memory.txt

bash ${BASH_TPL_ENGINE} ${DEV_CFG_TMPL} > ${DEV_CFG_FILE}

mv ${DEV_CFG_FILE} ${EV3RT_PRJ_PATH}/

if [ ${OPT_BT} = "_bt" ]
then
	touch ${EV3RT_PRJ_PATH}/__ev3rt_bt_in
	touch ${EV3RT_PRJ_PATH}/__ev3rt_bt_out
fi


exit 0
