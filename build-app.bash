#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 [<apl-name>|clean]"
	exit 1
fi
source utils/config/env.bash

if [ $1 != "clean" ]
then
    docker exec -it -e APLNAME=$1 -w /root/workspace/sdk/workspace \
        hakoniwa_single-robot-${HAKO_ASSET_NAME} /bin/bash -c 'make img=${APLNAME}'
else
    docker exec -it -e APLNAME=$1 -w /root/workspace/sdk/workspace \
        hakoniwa_single-robot-${HAKO_ASSET_NAME} /bin/bash -c 'make clean'
fi
