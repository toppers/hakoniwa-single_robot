#!/bin/bash

export CORE_PORTNO=50051
export MMAP_IO_PATH=mmap

if [ -z ${UNITY_APLNAME} ]
then
	if [ -f unity/assets/mmap_io_path.txt ]
	then
		export MMAP_ABS_IO_PATH=`cat unity/assets/mmap_io_path.txt`
	elif [ ${COMM_TYPE} = "mmap" ]
	then
		echo "ERROR: can not found unity/assets/mmap_io_path.txt"
		exit 1
	fi
else
	export MMAP_ABS_IO_PATH=$(cd unity/assets/${UNITY_APLNAME}/Build/mmap && pwd)
	echo ${MMAP_ABS_IO_PATH} > unity/assets/mmap_io_path.txt
fi

if [ -z ${APLNAME} ]
then
	:
else
	echo ${APLNAME} > unity/assets/aplname.txt
fi

if [ ${RUNTIME_TYPE} = "docker" ]
then
	export PATH=/root/hakoniwa-core/impl/asset/client/build/cpp:${PATH}
	export WORKDIR=/root/workspace
	export TEMPLATE_PATH=config/template
	export ATHRILL_DEVICE_PATH=/root/athrill-device/device
	export BASH_TPL_ENGINE=config/mo
	if [ ${OS_TYPE} = "wsl2" ]
	then
		export ETHRER_ID=eth0
		export IFCONFIG_IPADDR=`ifconfig | grep -A 1 ${ETHRER_ID} | grep inet | awk '{print $2}'`
		export RESOLVE_IPADDR=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`
	fi
else
	export IFCONFIG_IPADDR=127.0.0.1
	export RESOLVE_IPADDR=127.0.0.1
	export TEMPLATE_PATH=utils/config/template
	export ATHRILL_DEVICE_PATH=$(cd ../athrill-device/device && pwd)
	export WORKDIR=`pwd`
	export BASH_TPL_ENGINE=utils/config/mo
	export CORE_PORTNO=50051
	export MMAP_IO_PATH=mmap
fi
