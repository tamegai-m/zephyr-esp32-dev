# zephyr-esp32-dev: Dockerfile for Zephyr + ESP32 development
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages
RUN apt-get update && apt-get install -y \
    git cmake ninja-build gperf ccache dfu-util \
    device-tree-compiler wget python3-pip python3-setuptools \
    python3-wheel python3-dev python3-venv xz-utils file \
    make gcc g++ unzip curl udev \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install west (Zephyr meta-tool)
RUN pip3 install west

# Install ESP32 toolchain (Xtensa)
RUN mkdir -p /opt/toolchains && \
    cd /opt/toolchains && \
    wget https://dl.espressif.com/dl/xtensa-esp32-elf-gcc8_4_0-esp-2021r2-patch5-linux-amd64.tar.gz && \
    tar -xvzf xtensa-esp32-elf-gcc8_4_0-esp-2021r2-patch5-linux-amd64.tar.gz && \
    rm xtensa-esp32-elf-gcc8_4_0-esp-2021r2-patch5-linux-amd64.tar.gz

# Environment variables for Zephyr + ESP32
ENV ZEPHYR_TOOLCHAIN_VARIANT=xtensa
ENV XTENSA_TOOLCHAIN_PATH=/opt/toolchains/xtensa-esp32-elf
ENV PATH="${XTENSA_TOOLCHAIN_PATH}/bin:${PATH}"

# Default workspace
WORKDIR /work

CMD ["/bin/bash"]
