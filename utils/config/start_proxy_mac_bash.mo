#!/bin/bash

export PATH=/root/hakoniwa-core/impl/asset/client/build/cpp:${PATH}
cd /root/workspace 

bash config/create_config-mac.bash {{APLNAME}}  {{RESOLVE_IPADDR}}

cd proxy

bash hakoniwa_proxy-mac.bash {{RESOLVE_IPADDR}}
