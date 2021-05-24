#/bin/bash

if [ $# -ne 3 -a $# -ne 4 ]
then
	echo "Usage: $0 <unity-proj> {udp|mmap} <aplname> [simtime_filepath]"
	exit 1
fi

UNITY_PRJ=${1}
COMM_TYPE=${2}
APL_NAME=${3}
export APL_PROJECT_PATH=`cd ../sdk/workspace/ && pwd`/${APL_NAME}
which wslpath > /dev/null
if [ $? -eq 0 ]
then
	export APL_PROJECT_PATH=`wslpath -m ${APL_PROJECT_PATH}`
fi

if [ $# -eq 4 ]
then
	TMPDIR=$(cd ${4} && pwd)
	DIR=${TMPDIR}/unity.csv
	export SYMTIME_MEASURE_FILEPATH=${DIR}
fi
UNITY_PRJ_PATH=unity/${UNITY_PRJ}

if [ -d ${UNITY_PRJ_PATH} ]
then
	:
else
	echo "ERROR: not found ${UNITY_PRJ_PATH}"
	exit 1
fi

export IFCONFIG_IPADDR=127.0.0.1
export RESOLVE_IPADDR=127.0.0.1

if [ ${COMM_TYPE} = "UDP" ]
then
	UNITY_CFG_TMPL=utils/config/config_proxy_udp_json.mo
else
	UNITY_CFG_TMPL=utils/config/config_proxy_mmap_json.mo
fi
bash utils/config/mo ${UNITY_CFG_TMPL} > core_config.json
mv core_config.json ${UNITY_PRJ_PATH}/

