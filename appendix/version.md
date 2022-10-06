[English](version.md) | [日本語](version_jp.md) 


# Version & Updates

## Rules of version numbering

A version number is assigned, such as `vX.Y.Z`.
This number is managed in `appendix/latest_version.txt`.
In addition, [Git/GitHub tag/release](https://github.com/toppers/hakoniwa-single_robot/releases) and [Docker Hub tag number](https://hub.docker.com/r/toppersjp/hakoniwa-single_robot/tags).

Each version number is updated according to the following rules.

- Major version (`X`): 
    - Introduction of new features in the core technology of Hakoniwa
    - Major changes in usage, etc.
- Minor version (`Y`): 
    - Update of Hakoniwa asset technology (repositories)
    - Major feature fixes
    - New features in the simulator core, etc.
- Revision (`Z`): 
    - Minor fixes, bug fixes, etc.
    - Documentation updates, etc.

## Update History

You can check the version information of Hakoniwa assets in `utils/check_assets_version.bash`.

### v1.4.0 @ 2022/10/06

* Readme in english by @urashima0429 in https://github.com/toppers/hakoniwa-single_robot/pull/37
* enable the operation on linux/docker env with Unity Editor by @takasehideki in https://github.com/toppers/hakoniwa-single_robot/pull/38
* follow the latest instruction to install docker by @takasehideki in https://github.com/toppers/hakoniwa-single_robot/pull/39

- Hakoniwa asset and version (commit hash) information: updated from v1.3.0
    - [athrill](https://github.com/toppers/athrill) / sha: [f09d7d551ef947538667bdef7da2d4d48e181112](https://github.com/toppers/athrill/tree/f09d7d551ef947538667bdef7da2d4d48e181112)
    - [athrill-device](https://github.com/toppers/athrill-device) / sha: [680533b0cad8c691f7435c33d5e03edd59bb3da9](https://github.com/toppers/athrill-device/tree/680533b0cad8c691f7435c33d5e03edd59bb3da9)
    - [athrill-target-v850e2m](https://github.com/toppers/athrill-target-v850e2m) / sha: [88008188920ae63f601df84d005e0e9616176080](https://github.com/toppers/athrill-target-v850e2m/tree/88008188920ae63f601df84d005e0e9616176080)
    - [hakoniwa-core](https://github.com/toppers/hakoniwa-core) / sha: [c60ec37e95e3b33e4f09881525cd3eabbea1f781](https://github.com/toppers/hakoniwa-core/tree/c60ec37e95e3b33e4f09881525cd3eabbea1f781)

**Full Changelog**: https://github.com/toppers/hakoniwa-single_robot/compare/v1.3.1...v1.4.0

### v1.3.1 @ 2022/05/14

* improve README to make it easier to copy command by @takasehideki in https://github.com/toppers/hakoniwa-single_robot/pull/36

- No change in Hakoniwa assets and version (commit hash) from v1.3.0

**Full Changelog**: https://github.com/toppers/hakoniwa-single_robot/compare/v1.3.0...v1.3.1

### v1.3.0 @ 2022/05/09

* add troubleshooting. by @s-hosoai in https://github.com/toppers/hakoniwa-single_robot/pull/31
* change operation for Docker containers by @takasehideki in https://github.com/toppers/hakoniwa-single_robot/pull/32
* change Dockerfile for athrill-target-v850e2m sub-module by @mitsut in https://github.com/toppers/hakoniwa-single_robot/pull/33
* specify version on `git clone` by @takasehideki in https://github.com/toppers/hakoniwa-single_robot/pull/34
* change PATH to `athrill2` command to follow the latest changes of athrill-target-v850e2m by @takasehideki in https://github.com/toppers/hakoniwa-single_robot/pull/35

- Hakoniwa asset and version (commit hash) information: updated from v1.2.1
    - [athrill](https://github.com/toppers/athrill) / sha: [056a7aa761ef48f67f2c1f6effef104c66fa3b8c](https://github.com/toppers/athrill/tree/056a7aa761ef48f67f2c1f6effef104c66fa3b8c)
    - [athrill-target-v850e2m](https://github.com/toppers/athrill-target-v850e2m) / sha: [8b9f3acba3293755d8bf551b91c524c9d1046364](https://github.com/toppers/athrill-target-v850e2m/tree/8b9f3acba3293755d8bf551b91c524c9d1046364)
    - [ev3rt-athrill-v850e2m](https://github.com/toppers/ev3rt-athrill-v850e2m) / sha: [eaa870b4e68413649d50e1b6d09d832b7de3af78](https://github.com/toppers/ev3rt-athrill-v850e2m/tree/eaa870b4e68413649d50e1b6d09d832b7de3af78)
    - [hakoniwa-core](https://github.com/toppers/hakoniwa-core) / sha: [35c47fe42af58f37a4843e5e789e5f749acfbf0b](https://github.com/toppers/hakoniwa-core/tree/35c47fe42af58f37a4843e5e789e5f749acfbf0b)

**Full Changelog**: https://github.com/toppers/hakoniwa-single_robot/compare/v1.2.1...v1.3.0

### v1.2.1 @ 2021/10/18

- Support of robots for educational use #29 
- Add button sensor function for EV3COM [hakoniwa-core#33](https://github.com/toppers/hakoniwa-core/issues/33)
- Hakoniwa asset and version (commit hash) information: updated from v1.2.0
    - [athrill-device](https://github.com/toppers/athrill-device) / sha: [93eeb22871ed6a24dfac6f376e826f27ee5f7c40](https://github.com/toppers/athrill-device/tree/93eeb22871ed6a24dfac6f376e826f27ee5f7c40)
    - [hakoniwa-core](https://github.com/toppers/hakoniwa-core) / sha: [a77918715cac333866ef7f611fc4a6683c016b1b](https://github.com/toppers/hakoniwa-core/tree/a77918715cac333866ef7f611fc4a6683c016b1b)

### v1.2.0 @ 2021/09/09

- Update Hakoniwa core functions to ROS-compatible version #23 #24
- Improve usability #27
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
