#!/bin/bash

while [ 1 ]
do
        echo "############ START CONNECT #################"
        hakoniwa_proxy proxy/proxy_param.json ${RESOLVE_IPADDR}  ${CORE_PORTNO}
        echo "############ SERVER DOWN #################"
        sleep 1
done
