# docker版単体ロボットシミュレータのシミュレーション方法
## 想定環境
 * OS
   * Windows 10/home
 * 利用する端末
   * WSL2 および WSL2/docker
    * WSL2/Ubuntuにdocker をインストールしてください．
      * sudo apt-get update 
      * sudo apt-get install docker-ce
    * WSL2環境に ifconfig をインストールしてください．
      * sudo apt install net-tools 
  * mruby を利用する方も基本的には同じ方法でインストール/シミュレーションできます．
    * 一部，操作が異なるところについては，[mruby]という表記で説明追記しております． 

## docker版単体ロボットシミュレータ適用手順
* docker を WSL2(Ubuntu 20.04.1 LTS) にインストールしてください．
* ev3rt-athrill-v850e2m を WSL2 上の任意のフォルダで clone してください．
   * 例. $ git clone https://github.com/toppers/ev3rt-athrill-v850e2m.git
* ev3rt-athrill-v850e2m/docker　に移動してください．
   * 例．$ cd ev3rt-athrill-v850e2m/docker
* 以下のコマンド実行して，docker image を作成してください．
   * $ sudo service docker start 
   * $ bash create-image-bt.bash
   * [mruby] $ bash create-image-mruby.bash
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
   * [mruby] base_practice_1_mruby

* 端末Aで，以下のように docker コンテナを起動してください．
   * $ bash run-proxy.bash base_practice_1
    * bluetooth 通信を有効化する場合は，第二引数に `bt` を追加してください．
    * 起動するとdocker コンテナ内でエラーログが連続出力されますが，無視してください(シミュレーション実行時に正常になります)．
* 端末Bで，以下のように 端末Aで起動したdocker コンテナに入ります．
   * $ bash attach.bash
   * [mruby] $ bash attach-mruby.bash
   * [mruby] dockerの初回起動時のみ，mrubyのインストールコマンドを以下のように実行してください．
   * [mruby] # bash mruby/install.bash
* 端末B(docker)で，EV3RTのサンプルアプリ(base_practice_1)をビルドしてください．
   * \# bash clean_build.bash base_practice_1
   * [mruby] \# bash clean_build.bash base_practice_1_mruby.bash

## シミュレーション実行
* 端末C(WSL2)で，Unity側のシミュレータを起動してください(利用しているETHERがeth0, アプリケーション名が base_practice_1の場合)．
   * $ bash unity/start-proxy.bash single-robot eth0
* 初回起動時は，single-robot は起動できますが，通信ができない状態になっている可能性があります．
* そのため，Windows Defender の[詳細設定]⇒[受信規則]に存在するsingle-robotに対する操作を「許可」にしてください．

## Athrillとロボット間の通信パケットのビジュアライズ
箱庭環境では，Athrillとロボット間の通信仕様は，[プロトコルバッファ](https://ja.wikipedia.org/wiki/Protocol_Buffers)で定義しています．
定義の実体はこちらを参照ください．

* https://github.com/toppers/hakoniwa-core/blob/main/spec/ev3/hakoniwa_ev3.proto

また，ここで定義されているパケットは，以下のような構成で配信されます．

![ネットワークコンフィグ](https://github.com/toppers/ev3rt-athrill-v850e2m/blob/master/docker/design/network-config.png)

なお，本コンフィグは [astahプラグイン](https://astah.change-vision.com/ja/plugins.html)で実現しておりますので，そのまま箱庭コアのコンフィグファイルとして利用可能です．
* 詳細は，[こちら](https://github.com/s-hosoai/hakoniwa-config-astahplugin/tree/4683876a4b24f034ed0c2842ca61a2f37419473a)を参照ください．

赤色の部分が，ビジュアライズ用の設定です．
ロボットがAthrillから受信するUDPパケット(Ev3ActuatorPdu)は，UDPポート番号54004で参照できます．
ロボットがAthrillに送信するUDPパケット(Ev3SensorPdu)は，UDPポート番号54003で参照できます．

先述の通り，これらのパケットは，プロトコルバッファですので，protocコマンドの decode オプションでビジュアライズ可能です．
以下，ビジュアライズするための準備と実行手順です．

* 準備
  * WSL2 上で，以下のフォルダに移動します．
    *  docker/utils/analyis
  * UDPパケット参照ツールをビルドします．
    * make clean;make
* 参照手順
  * Ev3ActuatorPduの場合
    * $ bash ev3PacketReadActuator.bash
    * シミュレーション実行すると以下のように出力されます．

```
header {
  name: "ETTX"
  version: 1
  asset_time: 12630200
  ext_off: 512
  ext_size: 512
}
body {
  leds: "\003"
  motors {
    power: 5
    stop: 1
  }
  motors {
    power: 5
    stop: 1
  }
  motors {
    power: -5
  }
}
```

  * Ev3SensorPduの場合
    * $  bash ev3PacketReadSensor.bash
    * シミュレーション実行すると以下のように出力されます．

```
header {
  name: "ETRX"
  version: 1
  hakoniwa_time: 151614838
  ext_off: 512
  ext_size: 512
}
body {
  buttons: "\000"
  color_sensors {
    color: 2
    reflect: 38
    rgb_r: 77
    rgb_g: 77
    rgb_b: 255
  }
  color_sensors {
  }
  touch_sensors {
  }
  touch_sensors {
  }
  gyro_degree: 93
  sensor_ultrasonic: 478
  motor_angle_a: 1441
  motor_angle_b: 1274
  gps_lat: 46.629032135009766
  gps_lon: -29.996162414550781
}
```
