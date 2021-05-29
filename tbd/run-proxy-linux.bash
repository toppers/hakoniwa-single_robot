#!/bin/bash

if [ $# -ne 2 -a $# -ne 3 ]
then
	echo "Usage: $0 <aplname> {native|docker} [mmap]"
	exit 1
fi

export APLNAME=${1}
EXEC_ENV=${2}
export RESOLVE_IPADDR=127.0.0.1
if [ -d ../sdk/workspace/${APLNAME} ]
then
	:
else
	echo "ERROR: can not found ${APLNAME} on ../sdk/workspace/"
	exit 1
fi

if [ $# -eq 2 ]
then
	bash utils/config/mo utils/config/start_proxy_mac_bash.mo > proxy/start_proxy.bash
else
	bash utils/config/mo utils/config/start_proxy_mmap_bash.mo > proxy/start_proxy.bash
fi
chmod +x proxy/start_proxy.bash
chmod +x proxy/start_athrill-mac.bash
bash utils/config/mo utils/config/proxy_param-mac_json.mo > proxy/proxy_param-mac.json


function run_docker()
{
	WORKSPACE_DIR=$(cd .. && pwd)
	DOCKER_IMAGE=single-robot/ev3rt-v850:v1.0.0

	docker run \
		-v ${WORKSPACE_DIR}:/root/workspace/ev3rt-athrill-v850e2m \
		-v ${WORKSPACE_DIR}/docker/utils/config:/root/workspace/config \
		-v ${WORKSPACE_DIR}/docker/utils/make:/root/workspace/make \
		-v ${WORKSPACE_DIR}/docker/unity:/root/workspace/unity \
		-v ${WORKSPACE_DIR}/docker/proxy:/root/workspace/proxy \
		--add-host=localhost:192.168.11.58 \
		-P -p 54002:54002/udp \
		-it --rm  --name ev3rt-v850 ${DOCKER_IMAGE} 
}

if [ ${EXEC_ENV} = "native" ]
then
	if [ -d ../../athrill-device ]
	then
		bash proxy/start_proxy.bash
	else
		echo "ERROR: can not found ../../athrill-device" ]
		exit 1
	fi
else
	run_docker
fi

