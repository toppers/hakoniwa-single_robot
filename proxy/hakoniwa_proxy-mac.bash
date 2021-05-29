#!/bin/bash

RESOLVE_IPADDR=${1}
while [ 1 ]
do
        echo "############ START CONNECT #################"
        hakoniwa_proxy ./proxy_param-mac.json ${RESOLVE_IPADDR}  50051
        echo "############ SERVER DOWN #################"
        sleep 1
done
