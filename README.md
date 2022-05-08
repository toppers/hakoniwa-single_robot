# 箱庭プロトタイプモデルA：単体ロボット向けシミュレータ

[TOPPERSプロジェクト箱庭WG](https://toppers.github.io/hakoniwa)では，IoT／クラウドロボティクス時代の仮想シミュレーション環境である『箱庭』の研究開発を進めています．本活動での狙いやコンセプトを実証するために，プロトタイプモデルを実装してひろく公開しています．

本リポジトリでは，プロトタイプモデルのひとつである[「単体ロボット向けシミュレータ」](https://toppers.github.io/hakoniwa/prototypes/single-robot/)について，WSL 2とDockerを用いて最小の構成と手順で試行できる実行環境を提供しています．本プロトタイプモデルでは，[ETロボコン](https://www.etrobo.jp/)を題材としており，組込みマイコンシミュレータ[athrill](https://github.com/toppers/athrill)上での制御プログラムの振る舞いを，Unity上でのロボット上の挙動と連携させて検証を進めることができます．

![](https://toppers.github.io/hakoniwa/img/prototypes/modelA.png)

## 想定するPC環境

* WSL 2/Ubuntu 20.04 LTS（以降，WSL2）の動作するWindows 10 PC
  * WSL2のインストール方法は「[Windows 10 に WSL をインストールする | Microsoft Docs](https://docs.microsoft.com/ja-jp/windows/wsl/install-win10)」などを参考にしてください．
  * 本手順の操作は，すべてWSL2のターミナル上（またはdocker container内）で行います．

## PC環境の準備

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

`$ service docker status` の結果が " * Docker is not running " の場合は，Dockerを起動してください．

```
$ sudo service docker start
 * Starting Docker: docker                           [ OK ] 
```

また，ユーザが `docker` のグループに所属していることを想定しています．そうでない場合は，次のコマンドを実行してください．

```
$ sudo gpasswd -a $USER docker
$ sudo service docker restart
```

上記のコマンド実行結果は，ターミナルに再ログインしてから有効となります．

### ifconfigのインストール

WSL2に `ifconfig` をインストールしてください．

```
$ sudo apt install net-tools 
```

## シミュレータの導入手順

現在の最新版は **v1.2.1** です．  
「[バージョン情報・更新履歴](/appendix/version.md)」も参照してください（バージョン番号は[Git/GitHubのtag/release](https://github.com/toppers/hakoniwa-single_robot/releases)および[Docker Hubのtag番号](https://hub.docker.com/r/toppersjp/hakoniwa-single_robot/tags)に対応しています）

### 本リポジトリのclone

WSL2のターミナルで下記を実行して本リポジトリをcloneしてください．

```
$ git clone -b v1.2.1 https://github.com/toppers/hakoniwa-single_robot.git
```

なおWSL2のファイルシステムはWindowsエクスプローラーからは `\\wsl$\Ubuntu-20.04` にてアクセス可能です．

### Dockerイメージの展開

シミュレータの実行環境は，ビルド済みのDocker imageをDocker Hubにて公開しています．

https://hub.docker.com/r/toppersjp/hakoniwa-single_robot

次のコマンドを実行してください．Dockerを立ち上げて，imageのpullと展開を行います．

```
$ bash docker/pull-image.bash
```

\[補足：開発者向け情報\] Dockerイメージの作成用に `docker/create-image.bash` があります．

### Unityバイナリのダウンロード

次のコマンドを実行して，single-robotのUnityシミュレータ(Unityバイナリ)をダウンロードしてください．

```
$ bash unity/download.bash single-robot  hackev-v1.0.0/WindowsBinary.zip
```

## シミュレータの実行手順

次の対象を例題として実行手順を説明します．

* マイコン側の制御プログラム：`base_practice_1`
* Unityアプリ：`single-robot`

単体ロボット向けシミュレータの実行には，3台のターミナルを利用します．全てのターミナルで本リポジトリのディレクトリ（`hakoniwa-single_robot/`）に移動してください．

* ターミナルA：箱庭アセット・プロキシ起動用
* ターミナルB：マイコン側の制御プログラムのビルド用
* ターミナルC：Unity側のシミュレーション実行用

### ターミナルAでの操作

次のコマンドを実行します．

```
$ sudo service docker start
$ bash run-proxy.bash base_practice_1
```

athrillとUnityの通信と時間同期を行うためのプロキシサーバを設定し，Dockerコンテナを立ち上げています．

bluetooth 通信を有効化する場合は，第二引数に `bt` を追加してください．

開発対象のアプリケーション名 `base_practice_1` が `proxy/proxy_param.json` の `target_options:` で設定されていることを確認してください．

起動後にはターミナル上に `14: failed to connect to all addresses` 等のエラーログが連続出力されますが，無視してください（シミュレータの接続待ちに関するもので，他ターミナル上での各シミュレータの実行後に正常になります）．

### ターミナルBでの操作

次のコマンドを実行します．

```
$ bash build-app.bash base_practice_1
```

ターミナルAで起動したDockerコンテナに入り，Docker内でEV3RTのサンプルアプリ(`base_practice_1`)をビルドしています．

### ターミナルCでの操作

Unity側のシミュレータを起動します．

```
$ bash start-unity.bash single-robot
```

初回の起動時には，Windows Defenderのファイアウォールに関する警告が表示されます．シミュレータ間の通信のために「アクセスを許可する」をクリックしてください．Windows Defender の[詳細設定]⇒[受信規則]に存在する "single-robot" に対する操作を「許可」にして設定することもできます．

これで単体ロボット向けシミュレータを実行する準備が整いました！  

### 動作例

Unityアプリのウィンドウの左上にある「開始」をクリックしてください．ターミナルAではathrillが自動起動されて制御プログラムの実行ログが出力されます．Unityアプリではロボットと外部環境の振る舞いが可視的に表示されます．

![動作例](https://github.com/toppers/hakoniwa/raw/web/static/img/prototypes/modelAdemo.gif)

この動画の各ウィンドウは，それぞれ次の通り対応しています．

- 左上：ターミナルA
  - Dockerコンテナの立ち上げと箱庭アセット・プロキシの起動
  - athrillの自動起動とログの出力
- 左下：ターミナルB
  - マイコン側制御プログラムのビルド
- 右上：ターミナルC
  - Unityアプリの起動
- 右下：Unityアプリのウィンドウ

## 制御プログラムの編集とシミュレーションの再実行

例題の `base_practice_1` では，黒色ラインのコースをトレースしながら，コース上の青色ブロックを前方アームで掴んで青色ゾーンまで運ぶというシナリオが実装されています．

制御プログラムのソースコードは `./sdk/workspace/base_practice_1` にあります．Windowsのエクスプローラーからは `\\wsl$\Ubuntu-20.04\<WSL2内での本リポジトリのgit clone先>\sdk\workspace\base_practice_1` でアクセスして編集することができます．

ターミナルBで次のコマンドを実行し，制御プログラムを再コンパイルしてください（引数を制御プログラム名ではなく `clean` を指定すると，いわゆる `make clean` が実行されます）．

```
$ bash build-app.bash base_practice_1
```

Unityアプリのウィンドウの「停止」でシミュレーションの停止，次の「リセット」で再起動できます．その後，「開始」で改めてシミュレーションを開始して，制御プログラムの編集内容の結果を確認することができます．

## トラブルシューティング
### Unityのシミュレータが灰色のまま動かない
unity/assets/single-robot/Build/hakoniwa_core.logを確認する。
ログに接続エラーがある場合、WSLのネットワークの設定をうまく読み込めていない場合があります。
WSLのresolve.confを手動で設定しDNSを固定している場合、箱庭にゲートウェイのアドレスを読み込めません。
自動設定に戻してターミナルＡの操作から再度実行してください。

### ターミナルCからUnityを起動しても、接続できない
FWが邪魔していることが多いです。ファイアウォールの設定(コントロール パネル/システムとセキュリティ/Windows Defender ファイアウォール/許可されたアプリ)
からsingle-robot.exeを探し、プライベートとパブリックにチェックが入っているか確認してください。

## Contributing

本リポジトリで公開している「箱庭プロトタイプモデルA：単体ロボット向けシミュレータ」について，ご意見や改善の提案などをぜひ [こちらのGitHub Discussions](https://github.com/toppers/hakoniwa/discussions/categories/idea-request) でお知らせください．改修提案の [Pull Requests](https://github.com/toppers/hakoniwa-single_robot/pulls) も歓迎いたします．

## TODO

- [ ] mrubyアプリ向けの環境構築＆使用方法 [#6](https://github.com/toppers/hakoniwa-single_robot/issues/6)
- [ ] macOS, Ubuntuネイティブ環境向けの環境構築＆使用方法 [#7](https://github.com/toppers/hakoniwa-single_robot/issues/7)
- [ ] mmap版の使用方法 [#8](https://github.com/toppers/hakoniwa-single_robot/issues/8)
- [ ] 「athrillとロボット間の通信パケットのビジュアライズ」の動作確認 [#14](https://github.com/toppers/hakoniwa-single_robot/issues/14)
- [ ] ロボットやコース環境のカスタマイズ方法の説明の追加 [#15](https://github.com/toppers/hakoniwa-single_robot/issues/15)
- [ ] READMEの英語化 [#16](https://github.com/toppers/hakoniwa-single_robot/issues/16)

## 謝辞

LEGO Mindstorms EV3のUnityパッケージの設計と作成にあたっては，宝塚大学 東京メディア芸術学部 吉岡章夫准教授および学部生の杉﨑涼志さん，木村明美さん，千葉純平さんにご協力いただきました．

HackEVのUnityアセットは，ETロボコン実行委員会より提供いただいたデータを基に作成しています．実行委員会の皆さまに深く感謝いたします．  
ただし本アセットはETロボコンの本番環境とは異なりますので，大会に参加予定の方はご注意ください．また，本アセットは，個人利用または教育利用に限定してご利用ください．

## ライセンス

[TOPPERSライセンス](https://www.toppers.jp/license.html)で公開しています．  
著作権者はTOPPERSプロジェクト箱庭ワーキンググループです．詳細は[LICENSE.md](./LICENSE.md)をご参照ください．
