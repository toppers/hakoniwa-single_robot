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

IMAGE_NAME=`cat docker/image_name.txt`
IMAGE_TAG=`cat appendix/latest_version.txt`
DOCKER_IMAGE=${IMAGE_NAME}:${IMAGE_TAG}
WORKSPACE_DIR=$(pwd)

docker run \
	-v ${WORKSPACE_DIR}/sdk:/root/workspace/sdk \
	-v ${WORKSPACE_DIR}/utils/config:/root/workspace/config \
	-v ${WORKSPACE_DIR}/proxy:/root/workspace/proxy \
	-v ${WORKSPACE_DIR}/utils:/root/workspace/utils \
	-it --rm --net host --name hakoniwa_single-robot ${DOCKER_IMAGE}
