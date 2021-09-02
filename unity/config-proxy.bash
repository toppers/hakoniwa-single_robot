#/bin/bash


if [ $# -ne 1 ]
then
	echo "Usage: $0 <unity-proj>"
	exit 1
fi

export UNITY_APLNAME=${1}
UNITY_PRJ_PATH=unity/assets/${UNITY_APLNAME}

if [ -d unity/assets/${UNITY_APLNAME}/Build/mmap ]
then
	:
else
	mkdir -p unity/assets/${UNITY_APLNAME}/Build/mmap
	dd if=/dev/zero of=unity/assets/${UNITY_APLNAME}/Build/mmap/athrill_mmap.bin bs=1k count=8
	dd if=/dev/zero of=unity/assets/${UNITY_APLNAME}/Build/mmap/unity_mmap.bin bs=1k count=8
fi

source utils/config/env.bash

if [ -d ${UNITY_PRJ_PATH} ]
then
	:
else
	echo "ERROR: not found ${UNITY_PRJ_PATH}"
	exit 1
fi

UNITY_CFG_TMPL=utils/config/template/hakoniwa/core/config_proxy_${COMM_TYPE}_json.mo
bash utils/config/mo ${UNITY_CFG_TMPL} > core_config.json
mv core_config.json ${UNITY_PRJ_PATH}/

cp -rp utils/config/pdu ${UNITY_PRJ_PATH}/
cp -rp utils/config/pdu ${UNITY_PRJ_PATH}/Build/
cp ${UNITY_PRJ_PATH}/core_config.json ${UNITY_PRJ_PATH}/Build/

