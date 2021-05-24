#!/bin/bash

WORKSPACE_DIR=$(cd .. && pwd)
DOCKER_IMAGE=single-robot/ev3rt-v850-mruby:v1.0.0

sudo docker ps > /dev/null
if [ $? -ne 0 ]
then
	sudo service docker start
	echo "waiting for docker service activation.. "
	sleep 3
fi

sudo docker run \
	-v ${WORKSPACE_DIR}:/root/workspace/ev3rt-athrill-v850e2m \
	-v ${WORKSPACE_DIR}/docker/utils/config:/root/workspace/config \
	-v ${WORKSPACE_DIR}/docker/utils/make:/root/workspace/make \
	-v ${WORKSPACE_DIR}/docker/utils/mruby:/root/workspace/mruby \
	-v ${WORKSPACE_DIR}/docker/unity:/root/workspace/unity \
	-it --rm --net host --name ev3rt-v850 ${DOCKER_IMAGE} 
