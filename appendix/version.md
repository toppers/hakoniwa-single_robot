# バージョン情報・更新履歴

## バージョン番号の付与規則

`vX.Y.Z` のようにバージョン番号を付与します．この番号は `docker/docker_image.txt` で管理しています．また，[Git/GitHubのtag/release](https://github.com/toppers/hakoniwa-single_robot/releases)および[Docker Hubのtag番号](https://hub.docker.com/r/toppersjp/hakoniwa-single_robot/tags)に対応しています．

各バージョン番号の更新は，次の規則で行います．

- Major version (`X`): 
    - 箱庭コア技術の新機能の導入
    - 使用方法の大きな変更　など
- Minor version (`Y`): 
    - 箱庭アセット技術（各リポジトリ）の更新
    - 大幅な機能の修正
    - シミュレータ本体の新たな機能の追加　など
- Revison (`Z`): 
    - 軽微な機能の修正・バグの対応
    - ドキュメントの更新　など

## 更新履歴

箱庭アセットのバージョン情報は `utils/check_assets_version.bash` で確認できます．

### v1.2.1 @ 2021/10/18

- 教育向けロボット対応追加 #29 
- EV3COMのボタンセンサ機能の追加 [hakoniwa-core#33](https://github.com/toppers/hakoniwa-core/issues/33)
- 箱庭アセットとバージョン(commit hash)情報：v1.2.0からの更新分
    - [athrill-device](https://github.com/toppers/athrill-device) / sha: [93eeb22871ed6a24dfac6f376e826f27ee5f7c40](https://github.com/toppers/athrill-device/tree/93eeb22871ed6a24dfac6f376e826f27ee5f7c40)
    - [hakoniwa-core](https://github.com/toppers/hakoniwa-core) / sha: [a77918715cac333866ef7f611fc4a6683c016b1b](https://github.com/toppers/hakoniwa-core/tree/a77918715cac333866ef7f611fc4a6683c016b1b)


### v1.2.0 @ 2021/09/09

- 箱庭コア機能をROS対応版にアップデート #23 #24
- ユーザ操作性の向上 #27
    - WSL 2シェル上のみ（Dockerコンテナ外）で制御プログラムをビルドできるように変更
- 箱庭アセットとバージョン(commit hash)情報：v1.0.0からの更新分
    - [athrill](https://github.com/toppers/athrill) / sha: [64641d258e6791596f9dcffe4e135cf21dd95d1d](https://github.com/toppers/athrill/tree/64641d258e6791596f9dcffe4e135cf21dd95d1d)
    - [athrill-device](https://github.com/toppers/athrill-device) / sha: [f4713b1c353d2406fe7ce7c87577997730be1c4d](https://github.com/toppers/athrill-device/tree/f4713b1c353d2406fe7ce7c87577997730be1c4d)
    - [hakoniwa-core](https://github.com/toppers/hakoniwa-core) / sha: [73251f562ac328e50f0ba10ce1ab6df2a71af5d7](https://github.com/toppers/hakoniwa-core/tree/73251f562ac328e50f0ba10ce1ab6df2a71af5d7)
    - [athrill-gcc-v850e2m](https://github.com/toppers/athrill-gcc-v850e2m) / release [v1.1](https://github.com/toppers/athrill-gcc-v850e2m/releases/v1.1)

### v1.1.0 @ 2021/05/29

- シミュレーション実行時の操作方法の変更 #18 #19 
    - ターミナルBでは `start-athrill.bash` の実行は不要
    - 制御プログラムの修正方法とシミュレーション再実行の方法の記載 e3dd74b
- `./run-proxy.bash` での `[bt]` オプションの有効化 #20
- 操作時に自動生成されるファイルの除外 #21
- *.bash への実行権限の付与 543dfbe
- 箱庭アセットとバージョン(commit hash)情報：変更なし

### v1.0.0 @ 2021/05/26

- 最初のリリース
- 箱庭アセットとバージョン(commit hash)情報
    - [athrill](https://github.com/toppers/athrill) / sha: [70bc17fa2915d5bde544779424d4eb7149b5da3b](https://github.com/toppers/athrill/tree/70bc17fa2915d5bde544779424d4eb7149b5da3b)
    - [athrill-device](https://github.com/toppers/athrill-device) / sha: [b331956414dbe2ecd3adf9bd7e38f7e86c460b05](https://github.com/toppers/athrill-device/tree/b331956414dbe2ecd3adf9bd7e38f7e86c460b05)
    - [athrill-target-v850e2m](https://github.com/toppers/athrill-target-v850e2m) / sha: [84e8586336b7a1514fa152a4c0091bb13533b323](https://github.com/toppers/athrill-target-v850e2m/tree/84e8586336b7a1514fa152a4c0091bb13533b323)
    - [ev3rt-athrill-v850e2m](https://github.com/toppers/ev3rt-athrill-v850e2m) / sha: [26983b25742c01b65dfba9b23325fce7cb22da50](https://github.com/toppers/ev3rt-athrill-v850e2m/tree/26983b25742c01b65dfba9b23325fce7cb22da50)
    - [hakoniwa-core](https://github.com/toppers/hakoniwa-core) / sha: [449c5866f045c1f21281f770e919f5c7bffe9631](https://github.com/toppers/hakoniwa-core/tree/449c5866f045c1f21281f770e919f5c7bffe9631)
    - [athrill-gcc-v850e2m](https://github.com/toppers/athrill-gcc-v850e2m) / release [v1.1](https://github.com/toppers/athrill-gcc-v850e2m/releases/v1.1)
