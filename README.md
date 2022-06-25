[English](README.md) | [日本語](README_jp.md) 

# Hakoniwa Prototype Model A: Simulator for a single robot

The [TOPPERS Project Hokoniwa WG](https://toppers.github.io/hakoniwa/en) is working on the R&D of "Hakoniwa," a virtual simulation environment for the age of IoT/Cloud Robotics. To demonstrate the goals and concepts of this activity, we have implemented a prototype model and made it widely available to the public.

This repository provides an execution environment for one of the prototype models, ["simulator for stand-alone robots"](https://toppers.github.io/hakoniwa/prototypes/single-robot/), using WSL 2 and Docker with minimal configuration and procedures.
This prototype model is designed with [ET Robocon](https://www.etrobo.jp/) and allows the user to verify the collaboration between the operation of the control program on the embedded microcomputer simulator [athrill](https://github.com/toppers/athrill) and the robot control operation on Unity. 

![](https://toppers.github.io/hakoniwa/img/prototypes/modelA.en.png)

## Requirements

* Windows 10 PC running WSL 2/Ubuntu 20.04 LTS (after this, referred to as "WSL2")
  * For details on how to install WSL2, please refer to "[Installing WSL on Windows 10 | Microsoft Docs](https://docs.microsoft.com/windows/wsl/install-win10)" etc.
  * All operations in this procedure are performed on the WSL2 terminal (or in the docker container).

## Preparations

### Clone this repository

The latest version is **v1.3.1**.  
See also "[version information / update history](/appendix/version.md)" (the version number corresponds to [tag/release in Git/GitHub](https://github.com/toppers/hakoniwa-single_robot/releases) and [Docker Hub tag number](https://hub.docker.com/r/toppersjp/hakoniwa-single_robot/tags).

Clone this repository using the following command in the terminal of WSL2.

```
git clone -b v1.3.1 https://github.com/toppers/hakoniwa-single_robot.git
```
Note: that the WSL2 file system can be accessed from Windows Explorer as `\\wsl$\Ubuntu-20.04` 

### Install Docker Engine

The simulator requires the Docker Engine to be installed on WSL2.
If the following command outputs the same result in the terminal of WSL2, it has already been installed (the line starting with `$` indicates the command to be executed).

```
$ which docker
/usr/bin/docker
$ service --status-all |& grep docker
 [ + ]  docker   # or " [ - ]  docker "
$ service docker status
 * Docker is running   # or " * Docker is not running "
```

Since the Docker Engine installation procedure is a bit complicated, we summarized it in [`docker/install-docker.bash`](/docker/install-docker.bash) in this repository (see [Install Docker Engine on Ubuntu | Docker Documentation](https://docs.docker.com/engine/install/ubuntu/)").  
Execute as follows.

```
bash docker/install-docker.bash
```

If the `service docker status` is ` * Docker is not running `, start Docker.

```
sudo service docker start
```

If the output is as follows, Docker is running.

```
 * Starting Docker: docker                           [ OK ] 
```

This procedure requires the user to be a member of the `docker` group. Otherwise, execute the following command.

```
sudo gpasswd -a $USER docker
sudo chgrp docker /var/run/docker.sock
sudo service docker restart
```

The results of the above command execution will take effect after you re-login to the terminal.

### Install ifconfig

Install `ifconfig` on WSL2.

```
sudo apt install net-tools 
```

## Simulator Installation Procedure

### Deploy Docker images

The simulator execution environment is available as a pre-built Docker image on the Docker Hub.

https://hub.docker.com/r/toppersjp/hakoniwa-single_robot

Execute the following command to launch Docker, pull and deploy the image.

```
bash docker/pull-image.bash
```

\[Tips for Developer\] There is a `docker/create-image.bash` for creating Docker images.

### Download Unity Binaries

Download the single-robot Unity simulator (Unity binary) with the following command

```
bash unity/download.bash single-robot hackev-v1.0.0/WindowsBinary.zip
```

## Simulator Running Procedure

I will illustrate the procedure with the following example.

* Control program of microcontroller: `base_practice_1`
* Unity Application: `single-robot`

We recommend using three terminals to run this simulator.
Please change to the directory of this repository (`hakoniwa-single_robot/`) on all terminals.

* Terminal A: For activating Hakoniwa assets and proxies
* Terminal B: For building control programs on the microcontroller
* Terminal C: For executing simulation on Unity

### Operations on Terminal A

Execute the following command.

```
bash run-proxy.bash base_practice_1
```

This command sets up a proxy server for communication and time synchronization between athrill and Unity and launches a Docker container.

If you want to enable Bluetooth communication, add `bt` as the second argument.

Make sure that the application name `base_practice_1` is set in `target_options:` in `proxy/proxy_param.json`.

After startup, error logs such as `14: failed to connect to all addresses` will appear continuously on the terminal. Still, please ignore them (they are related to waiting for simulator contacts and will disappear after the operation on another terminal).

### Operations on Terminal B

Execute the following command

```
bash build-app.bash base_practice_1
```

Enter the Docker container started in Terminal A and build the EV3RT sample app (`base_practice_1`) in Docker.

### Operations on Terminal C

Start the simulator on the Unity

```
bash start-unity.bash single-robot
```

A warning about the Windows Defender firewall will appear at the first startup.
Click on "Allow access" for communication between simulators; you can also set the operation to "Allow" for "single-robot" that exists in [Advanced] ⇒ [Receiving Rules] of Windows Defender.

Now you are ready to start the simulator!

### Running

Click "Start" in the upper left corner of the Unity app window.
You should see a log of athrill automatically starting and the control program executing in Terminal A.
You will also see the robot's behavior and the external environment displayed visually in the Unity app.

![example](https://github.com/toppers/hakoniwa/raw/web/static/img/prototypes/modelAdemo.gif)

Each window in this video corresponds to the following.

- Top left: Terminal A
  - Launching Docker containers and the Hakoniwa Asset Proxy
  - Automatic startup of athrill and log output
- Bottom left: Terminal B
  - Build microcontroller control program
- Top right: Terminal C
  - Launching Unity app
- Bottom right: Unity app window

## Edit control program and re-run simulation

The example `base_practice_1` implements a scenario where the robot traces a black line course, grabs blue blocks on the trail with its forward arm, and carries them to the blue zone.

The source code of the control program is in `. /sdk/workspace/base_practice_1`.You can access and edit it using Windows Explorer at `\\wsl$\Ubuntu-20.04\<the git clone location of this repository in WSL2>\sdk\workspace\base_practice_1`.

Recompile the control program in Terminal B with the following command (if you specify the argument `clean` instead of the control program name, the so-called `make clean` will be executed).

```
bash build-app.bash base_practice_1
```

You can stop the simulation by pressing "Stop" and restart by pressing "Reset" in the Unity app window.
After that, you can start the simulation again by pressing "Start" to check the results of your control program edits.

## Troubleshooting
### Unity simulator is stuck in gray.
Check unity/assets/single-robot/Build/hakoniwa_core.log.
If you see connection errors in the log, the WSL network settings may be a problem with WSL's network settings.
If you have manually set up WSL's resolve.conf and fixed DNS, Hakoniwa cannot read the gateway address.
Please revert to the automatic settings and rerun the operation from Terminal A.

### Cannot connect to Unity after starting it from Terminal C
FW may be interfering.
Check Firewall settings o(Control Panel/System and Security/Windows Defender Firewall/Allowed Apps) and make sure single-robot.exe is private and public.

## Contributing

Please let us know your comments and suggestions for improvement of "Hakoniwa Prototype Model A: Simulator for Single Robot" in this repository [GitHub Discussions](https://github.com/toppers/hakoniwa/discussions/categories/idea-request). We also welcome [Pull Requests](https://github.com/toppers/hakoniwa-single_robot/pulls) for improvement suggestions.

## TODO

- [ ] How to build & use the environment for mruby applications [#6](https://github.com/toppers/hakoniwa-single_robot/issues/6)
- [ ] How to build & use environment for macOS, Ubuntu native environment [#7](https://github.com/toppers/hakoniwa-single_robot/issues/7)
- [ ] How to use the mmap version [#8](https://github.com/toppers/hakoniwa-single_robot/issues/8)
- [ ] Confirming the operation of "visualization of communication packets between athrill and robots" [#14](https://github.com/toppers/hakoniwa-single_robot/issues/14)
- [ ] Add description of how to customize robots and course environment [#15](https://github.com/toppers/hakoniwa-single_robot/issues/15)
- [ ] Englishization of README [#16](https://github.com/toppers/hakoniwa-single_robot/issues/16)

## Acknowledgments
We thank Associate Professor Akio YOSHIOKA and undergraduate students Ryoji SUGISAKI, Akemi KIMURA, and Jumpei CHIBA of Takarazuka University school of media art in Tokyo for their cooperation in designing the Unity package for LEGO Mindstorms EV3.

Unity assets of HackEV are based on data provided by the ET Robocon Executive Committee. We want to express our deepest gratitude to the Executive Committee.
However, please note that this asset is different from the production environment of the ET Robocon. Please use this asset only for personal or educational use.

## Licenses

It is released under [TOPPERS license](https://www.toppers.jp/license.html).  
The copyright holder is TOPPERS Project Hakoniwa Working Group. 
Please refer to [LICENSE.md](./LICENSE.md) for details.
