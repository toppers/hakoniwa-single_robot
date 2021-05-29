#!/bin/bash

assets=("athrill" "athrill-device" "athrill-target-v850e2m" "ev3rt-athrill-v850e2m" "hakoniwa-core")

for ast in ${assets[@]}; do
    cd /root/${ast}
    sha=`git rev-parse HEAD`
    echo "    - [${ast}](https://github.com/toppers/${ast}) / sha: [${sha}](https://github.com/toppers/${ast}/tree/${sha})"
done

