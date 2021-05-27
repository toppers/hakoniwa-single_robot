# 箱庭プロトタイプモデルA：単体ロボット向けシミュレータ

[TOPPERSプロジェクト箱庭WG](https://toppers.github.io/hakoniwa)では，IoT／クラウドロボティクス時代の仮想シミュレーション環境である『箱庭』の研究開発を進めています．本活動での狙いやコンセプトを実証するために，プロトタイプモデルを実装してひろく公開しています．

本リポジトリでは，プロトタイプモデルのひとつである[「単体ロボット向けシミュレータ」](https://toppers.github.io/hakoniwa/prototypes/single-robot/)について，WSL 2/Dockerを用いて最小の構成と手順で試行できる実行環境を提供しています．本プロトタイプモデルでは，[ETロボコン](https://www.etrobo.jp/)を題材としており，組込みマイコンシミュレータ[athrill](https://github.com/toppers/athrill)上での制御プログラムの振る舞いを，Unity上でのロボット上の挙動と連携させて検証を進めることができます．

![](https://toppers.github.io/hakoniwa/img/prototypes/modelA.png)

## 想定するPC環境

* WSL 2/Ubuntu 20.04 LTS（以降，WSL2）の動作するWindows 10 PC
  * WSL2のインストール方法は「[Windows 10 に WSL をインストールする | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install-win10)」などを参考にしてください．
  * 本手順の操作は，すべてWSL2のターミナル上（またはdocker container内）で行います．

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

### ifconfigのインストール

WSL2に `ifconfig` をインストールしてください．

```
$ sudo apt install net-tools 
```

## シミュレータの導入手順

### Dockerイメージの展開

シミュレータの実行環境は，ビルド済みのDocker imageをDocker Hubにて公開しています．

https://hub.docker.com/r/toppersjp/hakoniwa-single_robot

現在の最新版は **v1.0.0** です．
「[バージョン情報・更新履歴](/appendix/version.md)」も参照してください（バージョン番号は[Git/GitHubのtag/release](https://github.com/toppers/hakoniwa-single_robot/releases)および[Docker Hubのtag番号](https://hub.docker.com/r/toppersjp/hakoniwa-single_robot/tags)に対応しています）

次のようにDockerを立ち上げて，imageをpullして展開してください．

```
$ sudo service docker start 
$ sudo docker pull toppersjp/hakoniwa-single_robot:v1.0.0
```

\[開発者向け情報\] 手元でDocker imageを作成する場合は，下記のように実行してください．

```
$ bash docker/create-image.bash
```

### Unityバイナリのダウンロード

以下のコマンドを実行して，single-robotのUnityシミュレータ(Unityバイナリ)をダウンロードしてください．

```
$ bash unity/download.bash single-robot WindowsBinary.zip
```

## シミュレータの実行手順

`base_practice_1` を例題として実行手順を説明します．開発対象のアプリケーション名は `proxy/proxy_param.json` の `target_options:` で設定できます．

単体ロボット向けシミュレータの実行には，３台のターミナルを利用します．全てのターミナルで本リポジトリのディレクトリ（`hakoniwa-single_robot/`）に移動してください．

* ターミナルA：箱庭アセット・プロキシ起動用
* ターミナルB：マイコン側のプログラム開発・実行用
* ターミナルC：Unity側のシミュレーション実行用

### ターミナルAでの操作

athrillとUnityの通信と時間同期を行うためのプロキシサーバを設定し，Dockerコンテナを立ち上げます．

```
$ sudo service docker start
$ bash run-proxy.bash base_practice_1
```

bluetooth 通信を有効化する場合は，第二引数に `bt` を追加してください．

起動後にはターミナル上に `14: failed to connect to all addresses` 等のエラーログが連続出力されますが，無視してください（シミュレータの接続待ちに関するもので，他ターミナル上での各シミュレータの実行後に正常になります）．

### ターミナルBでの操作

ターミナルAで起動したDockerコンテナに入ります．

```
$ bash attach.bash
```

Docker内でEV3RTのサンプルアプリ(base_practice_1)をビルドします．

```
~/workspace# bash clean_build.bash base_practice_1
```

### ターミナルCでの操作

Unity側のシミュレータを起動してください(利用しているETHERがeth0, アプリケーション名が base_practice_1の場合)．

```
$ bash start-unity.bash single-robot eth0
```

初回の起動時には，Windows Defenderのファイアウォールに関する警告が表示されます．シミュレータ間の通信のために「アクセスを許可する」をクリックしてください．Windows Defender の[詳細設定]⇒[受信規則]に存在する "single-robot" に対する操作を「許可」にして設定することもできます．

### シミュレータの実行

ターミナルB（Dockerコンテナ内）で，EV3RTのサンプルアプリを実行します．

```
~/workspace# bash start-athrill.bash base_practice_1
```

ターミナルCで起動したUnityアプリのウィンドウの「開始」をクリックしてください．

以下の動作例は，左上が箱庭アセット・プロキシの起動しているターミナルA，左下がAthrillの実行ログ出力と操作を行えるターミナルB，右上がUnityを実行するターミナルCで右下がUnityアプリのウィンドウです．

![動作例](https://toppers.github.io/hakoniwa/img/prototypes/modelAdemo.gif)

## Contributing

本リポジトリで公開している「箱庭プロトタイプモデルA：単体ロボット向けシミュレータ」について，ご意見や改善の提案などをぜひ [Issues](https://github.com/toppers/hakoniwa-single_robot/issues) でお知らせください．[Pull Requests](https://github.com/toppers/hakoniwa-single_robot/pulls) も歓迎いたします．

## TODO

- [ ] mrubyアプリ向けの環境構築＆使用方法 [#6](https://github.com/toppers/hakoniwa-single_robot/issues/6)
- [ ] macOS, Ubuntuネイティブ環境向けの環境構築＆使用方法 [#7](https://github.com/toppers/hakoniwa-single_robot/issues/7)
- [ ] mmap版の使用方法 [#8](https://github.com/toppers/hakoniwa-single_robot/issues/8)
- [ ] 「Athrillとロボット間の通信パケットのビジュアライズ」の動作確認 [#14](https://github.com/toppers/hakoniwa-single_robot/issues/14)
- [ ] ロボットやコース環境のカスタマイズ方法の説明の追加 [#15](https://github.com/toppers/hakoniwa-single_robot/issues/15)
- [ ] READMEの英語化 [#16](https://github.com/toppers/hakoniwa-single_robot/issues/16)

## ライセンス

[TOPPERSライセンス](https://www.toppers.jp/license.html)で公開しています．  
著作権者はTOPPERSプロジェクト箱庭ワーキンググループです．詳細は[LICENSE.md](./LICENSE.md)をご参照ください．
