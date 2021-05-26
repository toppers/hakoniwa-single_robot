FROM ubuntu:20.04 as hakoniwa-single_robot

ARG DEBIAN_FRONTEND=noninteractive

ENV CMAKE_INSTALL_DIR /usr/local/cmake
ENV PATH $PATH:$CMAKE_INSTALL_DIR/bin

RUN apt-get update && apt-get install -y \
	git	\
	build-essential	\
	wget	\
	gcc	\
	g++	\
	ruby	\
	vim	\
	gem \
	libssl-dev libreadline-dev zlib1g-dev \
	make	\
	autoconf \
	automake \
	pkg-config \
	curl \
	net-tools \
	netcat \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN	wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0-Linux-x86_64.sh && \
	mkdir -p $CMAKE_INSTALL_DIR && \
	sh cmake-linux.sh --skip-license --prefix=$CMAKE_INSTALL_DIR && \
	rm cmake-linux.sh

# Install grpc
RUN mkdir -p /root/grpc-build && \
	cd /root/grpc-build && \
	git clone --recurse-submodules -b v1.35.0 https://github.com/grpc/grpc && \
	cd grpc && \
	git submodule update --init && \
	mkdir -p cmake/build && \
	cd cmake/build && \
	cmake ../.. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local/grpc -DgRPC_BUILD_CSHARP_EXT=OFF -DOPENSSL_ROOT_DIR=/usr/local/boringssl -DCMAKE_PREFIX_PATH="/usr/local/cares;/usr/local/protobuf;/usr/local/zlib" && \
	make -j4 && \
	make install && \
	cd /root && \
	rm -rf grpc-build
ENV PATH /usr/local/grpc/bin:${PATH}

RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
RUN echo 'export PATH=${HOME}/.rbenv/bin:${PATH}' >> ~/.bashrc
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN ${HOME}/.rbenv/bin/rbenv install  2.6.5
RUN ${HOME}/.rbenv/bin/rbenv global  2.6.5
RUN echo 'export PATH=${HOME}/.rbenv/versions/2.6.5/bin:${PATH}' >> ~/.bashrc

WORKDIR /root
RUN wget https://github.com/toppers/athrill-gcc-v850e2m/releases/download/v1.1/athrill-gcc-package.tar.gz 
RUN tar xzvf athrill-gcc-package.tar.gz && \
	rm -f athrill-gcc-package.tar.gz
WORKDIR /root/athrill-gcc-package
RUN	tar xzvf athrill-gcc.tar.gz && \
	rm -f athrill-gcc-package.tar.gz && \
	rm -f *.tar.gz
RUN echo 'export PATH=/root/athrill-gcc-package/usr/local/athrill-gcc/bin/:${PATH}' >> /root/.bashrc

WORKDIR /root
RUN git clone --depth 1 https://github.com/toppers/athrill.git && \
	cd athrill && \
	git pull
RUN echo 'export PATH=/root/athrill/bin/linux:${PATH}' >> ~/.bashrc

WORKDIR /root
RUN git clone --depth 1 https://github.com/toppers/athrill-target-v850e2m.git && \
	cd athrill-target-v850e2m && \
	git pull
WORKDIR /root/athrill-target-v850e2m/build_linux
RUN make clean && \
	make timer32=true serial_fifo_enable=true vdev_disable=true enable_bt_serial=true skip_clock_bugfix=true supress_detect_error=true etrobo_optimize=true reuse_port=true

WORKDIR /root
RUN git clone --depth 1 https://github.com/toppers/ev3rt-athrill-v850e2m.git && \
	cd ev3rt-athrill-v850e2m && \
	git pull

WORKDIR /root
RUN git clone --recursive https://github.com/toppers/hakoniwa-core.git && \
	cd hakoniwa-core && \
	git pull
WORKDIR /root/hakoniwa-core/impl/asset/client/build
RUN bash build.bash cpp clean && \
	bash build.bash cpp
RUN echo 'export PATH=/root/hakoniwa-core/impl/asset/client/build/cpp:${PATH}' >> ~/.bashrc

WORKDIR /root
RUN git clone --depth 1 https://github.com/toppers/athrill-device.git && \
	cd athrill-device && \
	git pull
WORKDIR /root/athrill-device/device/ev3com
RUN make clean && make
WORKDIR /root/athrill-device/device/ev3com/build
RUN bash build.bash all

RUN mkdir -p /root/workspace
WORKDIR /root/workspace
ENV RUBYOPT -EUTF-8
CMD ["/root/workspace/proxy/start_proxy.bash"]
