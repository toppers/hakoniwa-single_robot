# 箱庭プロトタイプモデルA：単体ロボット向けシミュレータ

[TOPPERSプロジェクト箱庭WG](https://toppers.github.io/hakoniwa)では，IoT／クラウドロボティクス時代の仮想シミュレーション環境である『箱庭』の研究開発を進めています．本活動での狙いやコンセプトを実証するために，プロトタイプモデルを実装してひろく公開しています．

本リポジトリでは，プロトタイプモデルのひとつである[「単体ロボット向けシミュレータ」](https://toppers.github.io/hakoniwa/prototypes/single-robot/)について，WSL 2/Dockerを用いて最小の構成と手順で試行できる実行環境を提供しています．本プロトタイプモデルでは，[ETロボコン](https://www.etrobo.jp/)を題材として，組込みマイコン上のプログラムの振る舞いを，ロボット上の挙動と連携させて検証を進めることができます．

![](https://toppers.github.io/hakoniwa/img/prototypes/modelA.png)

## 想定するPC環境

* WSL 2/Ubuntu 20.04 LTS（以降，WSL2）の動作するWindows 10 PC
  * WSL2インストール方法は「[Windows 10 に WSL をインストールする | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install-win10)」などを参考にしてください．

## PC環境の準備

### 本リポジトリのclone

WSL2のターミナルで下記を実行して本リポジトリをcloneしてください．

```
$ git clone https://github.com/toppers/hakoniwa-single_robot.git
```

なおWSL2のファイルシステムはWindowsエクスプローラーからは `\\wsl$\Ubuntu-20.04` にてアクセス可能です．

### Docker Engineのインストール

本シミュレータは，WSL2にDocker Engineがインストールされている必要があります．WSL2のターミナルで下記のコマンドの結果が同じように出力されていれば，すでにインストール済みです．

```
$ which docker
/usr/bin/docker
$ service --status-all |& grep docker
 [ + ]  docker   # または " [ - ]  docker "
$ service docker status
 * Docker is running   # または " * Docker is not running "
```

Docker Engineのインストールはやや手数が多いため，本リポジトリの [`docker/install-docker.bash`](/docker/install-docker.bash) にまとめてあります（「[Install Docker Engine on Ubuntu | Docker Documentation](https://docs.docker.com/engine/install/ubuntu/)」を参考に作成しました）．  
下記のように実行してください．

```
$ bash docker/install-docker.bash
```


 * 利用する端末
   * WSL2 および WSL2/docker
    * WSL2/Ubuntuにdocker をインストールしてください．
      * sudo apt-get update 
      * sudo apt-get install docker-ce
    * WSL2環境に ifconfig をインストールしてください．
      * sudo apt install net-tools 



## docker版単体ロボットシミュレータ適用手順
* docker を WSL2(Ubuntu 20.04.1 LTS) にインストールしてください．
* ev3rt-athrill-v850e2m を WSL2 上の任意のフォルダで clone してください．
   * 例. $ git clone https://github.com/toppers/ev3rt-athrill-v850e2m.git
* ev3rt-athrill-v850e2m/docker　に移動してください．
   * 例．$ cd ev3rt-athrill-v850e2m/docker
* 以下のコマンド実行して，docker image を作成してください．
   * $ sudo service docker start 
   * $ bash docker/create-image.bash
* 以下のコマンドを実行して，single-robotのUnityシミュレータ(Unityバイナリ)をダウンロードしてください．
   * $ bash unity/download.bash single-robot WindowsBinary.zip

## シミュレーション環境の準備
* WSL2 の端末を3個起動して，ev3rt-athrill-v850e2m/docker　に移動してください．
   * 端末A：箱庭アセット・プロキシ起動用
   * 端末B：マイコン側のプログラム開発用
   * 端末C：Unity側のシミュレーション実行用
* 端末Aでdockerを起動してください．
  * $ sudo service docker start 
* 端末Aで，proxy/proxy_param.jsonの`target_options`を，開発対象のアプリケーション名にしてください．
   * 例：base_practice_1

* 端末Aで，以下のように docker コンテナを起動してください．
   * $ bash run-proxy.bash base_practice_1
    * bluetooth 通信を有効化する場合は，第二引数に `bt` を追加してください．
    * 起動するとdocker コンテナ内でエラーログが連続出力されますが，無視してください(シミュレーション実行時に正常になります)．
* 端末Bで，以下のように 端末Aで起動したdocker コンテナに入ります．
   * $ bash attach.bash
* 端末B(docker)で，EV3RTのサンプルアプリ(base_practice_1)をビルドしてください．
   * \# bash clean_build.bash base_practice_1

## シミュレーション実行
* 端末C(WSL2)で，Unity側のシミュレータを起動してください(利用しているETHERがeth0, アプリケーション名が base_practice_1の場合)．
   * $ bash start-unity.bash single-robot eth0
* 初回起動時は，single-robot は起動できますが，通信ができない状態になっている可能性があります．
* そのため，Windows Defender の[詳細設定]⇒[受信規則]に存在するsingle-robotに対する操作を「許可」にしてください．


## TODO

- [ ] mrubyアプリ向けの環境構築＆使用方法 [#6](https://github.com/toppers/hakoniwa-single_robot/issues/6)
- [ ] macOS, Ubuntuネイティブ環境向けの環境構築＆使用方法 [#7](https://github.com/toppers/hakoniwa-single_robot/issues/7)
- [ ] mmap版の使用方法 [#8](https://github.com/toppers/hakoniwa-single_robot/issues/8)
- [ ] 「Athrillとロボット間の通信パケットのビジュアライズ」の動作確認 [#14](https://github.com/toppers/hakoniwa-single_robot/issues/14)
- [ ] ロボットやコース環境のカスタマイズ方法の説明の追加 [#15](https://github.com/toppers/hakoniwa-single_robot/issues/15)

## ライセンス

[TOPPERSライセンス](https://www.toppers.jp/license.html)で公開しています．  
著作権者はTOPPERSプロジェクト箱庭ワーキンググループです．詳細は[LICENSE.md](./LICENSE.md)をご参照ください．
