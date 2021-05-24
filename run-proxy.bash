#!/bin/bash

if [ $# -ne 1 -a $# -ne 2 ]
then
	echo "Usage: $0 <aplname> [bt]"
	exit 1
fi

export APLNAME=${1}
if [ -d ../sdk/workspace/${APLNAME} ]
then
	:
else
	echo "ERROR: can not found ${APLNAME} on ../sdk/workspace/"
	exit 1
fi

if [ $# -eq 1 ]
then
	bash utils/config/mo utils/config/start_proxy_bash.mo > proxy/start_proxy.bash
else
	bash utils/config/mo utils/config/start_proxy_bt_bash.mo > proxy/start_proxy.bash
fi
bash utils/config/mo utils/config/proxy_param_json.mo > proxy/proxy_param.json


WORKSPACE_DIR=$(cd .. && pwd)
DOCKER_IMAGE=single-robot/ev3rt-v850:v1.0.0

sudo docker run \
	-v ${WORKSPACE_DIR}:/root/workspace/ev3rt-athrill-v850e2m \
	-v ${WORKSPACE_DIR}/docker/utils/config:/root/workspace/config \
	-v ${WORKSPACE_DIR}/docker/utils/make:/root/workspace/make \
	-v ${WORKSPACE_DIR}/docker/unity:/root/workspace/unity \
	-v ${WORKSPACE_DIR}/docker/proxy:/root/workspace/proxy \
	-it --rm --net host --name ev3rt-v850 ${DOCKER_IMAGE} 
