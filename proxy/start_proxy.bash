#!/bin/bash

bash utils/config/create_config-mmap.bash base_practice_1 

cd proxy

bash hakoniwa_proxy-mac.bash 127.0.0.1
