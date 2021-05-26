# バージョン情報・更新履歴

## バージョン番号の付与規則

`vX.Y.Z` のようにバージョン番号を付与します．この番号は `docker/docker_image.txt` で管理しています．また，[Git/GitHubのtag/release](https://github.com/toppers/hakoniwa-single_robot/releases)および[Docker Hubのtag番号](https://hub.docker.com/r/toppersjp/hakoniwa-single_robot/tags)に対応しています．

各バージョン番号の更新は，次の規則で行います．

- Major version (`X`): 
    - 箱庭コア技術の新機能の導入時
    - 使用方法の大きな変更　など
- Minor version (`Y`): 
    - 箱庭アセット技術（各リポジトリ）の更新時
    - シミュレータ本体の新たな機能の追加時　など
- Revison (`Z`): 
    - ドキュメントの更新　など

## 更新履歴

箱庭アセットのバージョン情報は `utils/check_assets_version.bash` で確認できます．

### v1.0.0 @ 2021/05/26

- 最初のリリース
- 箱庭アセットとバージョン(commit hash)情報
    - [athrill](https://github.com/toppers/athrill) / sha: [70bc17fa2915d5bde544779424d4eb7149b5da3b](https://github.com/toppers/athrill/tree/70bc17fa2915d5bde544779424d4eb7149b5da3b)
    - [athrill-device](https://github.com/toppers/athrill-device) / sha: [b331956414dbe2ecd3adf9bd7e38f7e86c460b05](https://github.com/toppers/athrill-device/tree/b331956414dbe2ecd3adf9bd7e38f7e86c460b05)
    - [athrill-target-v850e2m](https://github.com/toppers/athrill-target-v850e2m) / sha: [84e8586336b7a1514fa152a4c0091bb13533b323](https://github.com/toppers/athrill-target-v850e2m/tree/84e8586336b7a1514fa152a4c0091bb13533b323)
    - [ev3rt-athrill-v850e2m](https://github.com/toppers/ev3rt-athrill-v850e2m) / sha: [26983b25742c01b65dfba9b23325fce7cb22da50](https://github.com/toppers/ev3rt-athrill-v850e2m/tree/26983b25742c01b65dfba9b23325fce7cb22da50)
    - [hakoniwa-core](https://github.com/toppers/hakoniwa-core) / sha: [449c5866f045c1f21281f770e919f5c7bffe9631](https://github.com/toppers/hakoniwa-core/tree/449c5866f045c1f21281f770e919f5c7bffe9631)
    - [athrill-gcc-v850e2m](https://github.com/toppers/athrill-gcc-v850e2m) / release [v1.1](https://github.com/toppers/athrill-gcc-v850e2m/releases/v1.1)
