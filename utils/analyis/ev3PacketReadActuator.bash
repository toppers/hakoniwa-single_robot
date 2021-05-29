#1/bin/bash

HAKONIWA_CORE_PATH=../../../../hakoniwa-core

while [ 1 ]
do
	./packet_reader 54004 | protoc --decode=hakoniwa.Ev3PduActuator -I${HAKONIWA_CORE_PATH}/spec/ev3 hakoniwa_ev3.proto
done
