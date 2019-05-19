FROM debian:stretch

# Install build dependencies
RUN apt-get update && apt-get install -y \
  bc \
  build-essential \
  curl \
  git-core \
  libncurses5-dev \
  module-init-tools \
  bison \
  flex \
  kmod \
  libssl-dev

# Install crosscompile toolchain for ARM64/aarch64
RUN mkdir -p /opt/linaro && \
    curl -sSL https://releases.linaro.org/components/toolchain/binaries/latest-7/aarch64-linux-gnu/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu.tar.xz | tar xfJ - -C /opt/linaro
ENV CROSS_COMPILE=/opt/linaro/gcc-linaro-7.4.1-2019.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
ENV ARCH=arm

# Create working directory
RUN mkdir -p /workdir
WORKDIR /workdir
ENV WORKDIR /workdir
ENV BUILD_DEST /workdir/build

# Add the build script and set it as default command
COPY build-rpi3-kernel /opt/bin/build-rpi3-kernel
CMD ["/opt/bin/build-rpi3-kernel"]
