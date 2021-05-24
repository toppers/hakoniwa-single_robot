#/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage: $0 <unity-proj> <eth>"
	exit 1
fi

UNITY_PRJ=${1}
ETH=${2}
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

UNITY_CFG_TMPL=utils/config/config_udp_json.mo
bash utils/config/mo ${UNITY_CFG_TMPL} > config.json
mv config.json ${UNITY_PRJ_PATH}/

