#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 <apl-name>"
	exit 1
fi
#EV3RT_DIR=./sdk/workspace
APL_NAME=${1}

#cd ${EV3RT_DIR}

make clean img=${APL_NAME}
make img=${APL_NAME}
