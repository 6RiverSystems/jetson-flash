FROM balenalib/amd64-ubuntu:focal-run-20221210

WORKDIR /usr/src/app/jetson-flash

ARG DEBIAN_FRONTEND=noninteractive
RUN \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
RUN \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    apt-get update && \
    apt-get -yqq install python2                                               \
                         python3                                               \
                         python3-pip                                           \
                         usbutils                                              \
                         lbzip2                                                \
                         locales                                               \
                         git                                                   \
                         wget                                                  \
                         unzip                                                 \
                         e2fsprogs                                             \
                         dosfstools                                            \
                         libxml2-utils                                         \
                         nodejs                                                \
                         xxd                                                   \
                         lz4                                                && \
    update-alternatives --install /usr/bin/python python /usr/bin/python2 1 && \
    pip3 install pyyaml && \
    locale-gen en_US.UTF-8 es_MX.UTF-8

ARG bsp_url
ARG device_type
COPY .  /usr/src/app/jetson-flash

RUN npm install

# 6rs fork: work around https://github.com/balena-os/jetson-flash/issues/195
# RUN wget "$bsp_url" -O "/tmp/Linux_for_Tegra.tbz2"  && tar -xvf "/tmp/Linux_for_Tegra.tbz2" -C "/tmp/" && rm /tmp/Linux_for_Tegra.tbz2

# CMD ["./run_http_server.sh"]
