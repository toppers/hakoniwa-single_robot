#!/bin/bash

RESOLVE_IPADDR=`cat /etc/resolv.conf | grep nameserver | awk '{print $2}'`
while [ 1 ]
do
        echo "############ START CONNECT #################"
        hakoniwa_proxy ./proxy_param.json ${RESOLVE_IPADDR}  50051
        echo "############ SERVER DOWN #################"
        sleep 1
done
