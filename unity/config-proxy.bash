#/bin/bash

if [ $# -ne 2 -a $# -ne 3 ]
then
	echo "Usage: $0 <unity-proj> <eth> [simtime_filepath]"
	exit 1
fi

UNITY_PRJ=${1}
ETH=${2}
if [ $# -eq 3 ]
then
	TMPDIR=$(cd ${3} && pwd)
	DIR=`echo "${TMPDIR}/unity.csv" | sed 's/\/mnt\/c\//C:\\\\\\\\/g' | sed 's/\//\\\\\\\\/g'`
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

export IFCONFIG_IPADDR=`ifconfig | grep -A 1 ${ETH} | grep inet | awk '{print $2}'`
export RESOLVE_IPADDR=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`

UNITY_CFG_TMPL=utils/config/config_proxy_udp_json.mo
bash utils/config/mo ${UNITY_CFG_TMPL} > core_config.json
mv core_config.json ${UNITY_PRJ_PATH}/

