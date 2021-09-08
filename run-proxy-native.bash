#!/bin/bash


if [ $# -eq 0 -o $# -gt 1 ]
then
	echo "Usage: $0 <aplname>"
	exit 1
fi

export APLNAME=${1}
source utils/config/env.bash

if [ -d ./sdk/workspace/${APLNAME} ]
then
	:
else
	echo "ERROR: can not found ${APLNAME} on ./sdk/workspace/"
	exit 1
fi

bash utils/config/mo utils/config/template/hakoniwa/proxy/start_proxy_bash.mo > proxy/start_proxy.bash
chmod +x proxy/start_proxy.bash
bash utils/config/mo utils/config/template/hakoniwa/proxy/proxy_param_json.mo > proxy/proxy_param.json

bash proxy/start_proxy.bash
