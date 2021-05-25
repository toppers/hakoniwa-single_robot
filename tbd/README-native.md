# native版単体ロボットシミュレータのシミュレーション方法
## 想定環境
 * OS
   * WSL1
   * Mac
   * Linux

## native版単体ロボットシミュレータ適用手順
* gRPC/C++ をインストールしてください．
   * https://grpc.io/docs/languages/cpp/quickstart/
   * 補足1：third_party/abseil-cpp　のインストールは不要
   * 補足2：cmake でエラー(CMake Error: Could not find CMAKE_ROOT !!!)発生する場合があります．この場合は，以下を参照・ご対応ください．
   * https://qiita.com/gorou/items/747493ffa15a30b29f5c
* 以下を同一フォルダ上で clone してください．
   * https://github.com/toppers/athrill-target-v850e2m
   * https://github.com/toppers/athrill
   * https://github.com/toppers/athrill-device
   * https://github.com/toppers/hakoniwa-core
   * https://github.com/toppers/ev3rt-athrill-v850e2m
   * コマンド実行方法：
      ```
      git clone https://github.com/toppers/athrill-target-v850e2m.git
      git clone https://github.com/toppers/athrill.git
      git clone https://github.com/toppers/athrill-device.git
      git clone --recursive https://github.com/toppers/hakoniwa-core.git
      git clone https://github.com/toppers/ev3rt-athrill-v850e2m.git
      ```
* athrill をインストールしてください．
   * 以下のフォルダに移動します．
     * athrill-target-v850e2m/build_linux
   * ビルドします．
     * make clean; make timer32=true serial_fifo_enable=true vdev_disable=true enable_bt_serial=true skip_clock_bugfix=true supress_detect_error=true etrobo_optimize=true reuse_port=true
   * 環境変数 PATH に athrill2 のバイナリ格納フォルダを追加してください．
     * athrill/bin/linux
* ev3ロボットとの通信用athrill-deviceをビルドしてください．
   * 以下のフォルダに移動します．
     * athrill-device/device/ev3com/build
   * ビルドします．
     * bash build.bash clean;bash build.bash all
* hakoniwa-core をインストールしてください．
   * 以下のファイルを編集します．
     * ファイル：hakoniwa-core/impl/asset/client/cpp/CMakeLists.txt
     * 変更箇所：
       * get_filename_component(hakoniwa_proto "/root/hakoniwa-core/spec/hakoniwa_core.proto" ABSOLUTE)
     * 変更内容：
       * get_flename_compoent の第二引数の `/root/hakoniwa-core` 部分をhakoniwa-core をインストールしたパスにあわせてください．
   * 以下のフォルダに移動します．
     * hakoniwa-core/impl/asset/client/build
   * ビルドします．
     * bash build.bash cpp clean; bash build.bash cpp
   * 環境変数 PATH に hakoniwa-core のバイナリ格納フォルダを追加してください．
     * hakoniwa-core/impl/asset/client/build/cpp
* 単体ロボットシミュレータ用のUnity プロジェクトを作成してください．
   * Unity上で single-robot という名前のプロジェクトを，以下のフォルダ直下に新規作成してください．
     * ev3rt-athrill-v850e2m/docker/unity
   * 以下の `single-robot-HackEV-hakoniwa-core.unitypackage` をインポートしてください．
     * https://github.com/toppers/hakoniwa-Unity-HackEV/releases/tag/v3.0

## シミュレーション環境の準備
* 端末を2個起動して，ev3rt-athrill-v850e2m/docker　に移動してください．
   * 端末A：箱庭アセット・プロキシ起動用
   * 端末B：マイコン側のプログラム開発用
* 端末Aで，以下のように箱庭コアのコンフィグ設定をしてください．
   * bash unity/config-proxy-linux.bash single-robot mmap base_practice_1
* 端末Aで，以下のように箱庭プロキシを起動してください．(現状はMMAPのみ対応)
   * $ bash run-proxy-linux.bash base_practice_1 native mmap
* 端末B(docker)で，EV3RTのサンプルアプリ(base_practice_1)をビルドしてください．
   * T.B.D

## シミュレーション実行
* Unity上でシミュレーションを実行してください．
  * Unity UI 上でシミュレーションの実行・停止を操作できます．
