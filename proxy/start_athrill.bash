#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: $0 apl"
	exit 1
fi

IS_EXIT="FALSE"
ATHRILL_PID="NONE"
signal_handler () {
	if [ ${ATHRILL_PID} = "NONE" ]
	then
		echo "NONE"
	else
		kill -s TERM ${ATHRILL_PID}
		echo "Terminated!! ${ATHRILL_PID}"
		IS_EXIT="TRUE"
	fi
}

trap signal_handler INT TERM

APL_NAME=${1}

ATHRILL_PATH=/root/athrill/bin/linux//athrill2
WORK_DIR=/root/workspace/ev3rt-athrill-v850e2m/sdk/workspace/${APL_NAME}

cd ${WORK_DIR}
${ATHRILL_PATH} -t -1 -c1 -m memory.txt -d device_config.txt ../asp &
ATHRILL_PID=$!
echo "ATHRILL_PID=$ATHRILL_PID"

while [ 1 ]
do
	if [ ${IS_EXIT} = "TRUE" ]
	then
		exit 0
	fi
	sleep 1
done
