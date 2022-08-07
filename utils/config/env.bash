#!/bin/bash

####### Hakoniwa config ##########################
#available values: wsl1 or wsl2 or linux or mac
if [[ "$(uname -r)" == *microsoft* ]];
then
	export OS_TYPE=wsl2
else
	export OS_TYPE=linux
fi

#available values: native or docker
export RUNTIME_TYPE=docker

#available values: udp or mmap
export COMM_TYPE=udp

#available values: Raw or Protobuf
export PACKET_TYPE=Protobuf

#available values: "None" or "bt"
export OPT_BT="None"

if [ -d utils ]
then
	source utils/config/default_env.bash
else
	source config/default_env.bash
fi
###################################################

#### available pattern ############################
# OS_TYPE RUNTIME_TYPE COMM_TYPE PACKET_TYPE
# wsl2    docker       udp       Raw
# wsl2    docker       udp       Protobuf
# wsl1    native       udp       Raw
# wsl1    native       udp       Protobuf
# wsl1    native       mmap      Raw
###################################################

