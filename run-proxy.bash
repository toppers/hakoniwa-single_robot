#!/bin/bash

if [ $# -gt 2 ]
then
	echo "Usage: $0 <aplname> [bt]"
	exit 1
fi

export APLNAME=${1}
if [ -d ./sdk/workspace/${APLNAME} ]
then
	:
else
	echo "ERROR: can not found ${APLNAME} on ./sdk/workspace/"
	exit 1
fi

if [ $# -eq 2 ]
then
	if [ ${2} = "bt" ]
	then
		bash utils/config/mo utils/config/start_proxy_bt_bash.mo > proxy/start_proxy.bash
	else
		echo "ERROR: option \"${2}\" is invalid"
		exit 1
	fi
else
	bash utils/config/mo utils/config/start_proxy_bash.mo > proxy/start_proxy.bash
fi
bash utils/config/mo utils/config/proxy_param_json.mo > proxy/proxy_param.json


DOCKER_IMAGE=`cat docker/docker_image.txt`
WORKSPACE_DIR=$(pwd)

sudo docker run \
	-v ${WORKSPACE_DIR}/sdk:/root/workspace/sdk \
	-v ${WORKSPACE_DIR}/utils/config:/root/workspace/config \
	-v ${WORKSPACE_DIR}/proxy:/root/workspace/proxy \
	-v ${WORKSPACE_DIR}/utils:/root/workspace/utils \
	-v ${WORKSPACE_DIR}/clean_build.bash:/root/workspace/clean_build.bash \
	-v ${WORKSPACE_DIR}/rebuild.bash:/root/workspace/rebuild.bash \
	-it --rm --net host --name hakoniwa_single-robot ${DOCKER_IMAGE}
