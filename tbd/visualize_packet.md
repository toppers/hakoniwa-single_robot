## Athrillとロボット間の通信パケットのビジュアライズ
箱庭環境では，Athrillとロボット間の通信仕様は，[プロトコルバッファ](https://ja.wikipedia.org/wiki/Protocol_Buffers)で定義しています．
定義の実体はこちらを参照ください．

* https://github.com/toppers/hakoniwa-core/blob/main/spec/ev3/hakoniwa_ev3.proto

また，ここで定義されているパケットは，以下のような構成で配信されます．

![ネットワークコンフィグ](/appendix/network-config.png)

なお，本コンフィグは [astahプラグイン](https://astah.change-vision.com/ja/plugins.html)で実現しておりますので，そのまま箱庭コアのコンフィグファイルとして利用可能です．
* 詳細は，[こちら](https://github.com/s-hosoai/hakoniwa-config-astahplugin/tree/4683876a4b24f034ed0c2842ca61a2f37419473a)を参照ください．

赤色の部分が，ビジュアライズ用の設定です．
ロボットがAthrillから受信するUDPパケット(Ev3ActuatorPdu)は，UDPポート番号54004で参照できます．
ロボットがAthrillに送信するUDPパケット(Ev3SensorPdu)は，UDPポート番号54003で参照できます．

先述の通り，これらのパケットは，プロトコルバッファですので，protocコマンドの decode オプションでビジュアライズ可能です．
以下，ビジュアライズするための準備と実行手順です．

* 準備
  * WSL2 上で，以下のフォルダに移動します．
    *  utils/analyis
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
