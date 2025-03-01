FROM jlesage/baseimage-gui:ubuntu-22.04-v4.7.1

RUN apt update && \
    echo "安装基础依赖" && \
    apt install -y libfuse2 libgl-dev libglib2.0-dev libpango1.0-dev libxcrypt-source && \
    echo "安装中文环境" && \
    apt install -y language-pack-zh-hans fonts-noto-cjk && \
    localedef -i zh_CN -f UTF-8 zh_CN.UTF-8

ENV LANG=zh_CN.utf8

ARG APP_NAME="Navicat Premium"
ARG APP_VERSION="17"
ARG DOCKER_IMAGE_VERSION="v1.0.0"
ARG DOCKER_IMAGE_PLATFORM="x86_64"
ARG PRODUCT="navicat17-premium-cs"

COPY Navicat/${PRODUCT}-${DOCKER_IMAGE_PLATFORM}.AppImage /opt/${PRODUCT}-${DOCKER_IMAGE_PLATFORM}.AppImage

RUN echo "配置镜像信息，启动脚本" && \
    set-cont-env APP_NAME "${APP_NAME}" && \
    set-cont-env APP_VERSION "${APP_VERSION}" && \
    set-cont-env DOCKER_IMAGE_VERSION "${DOCKER_IMAGE_VERSION}" && \
    set-cont-env DOCKER_IMAGE_PLATFORM "${DOCKER_IMAGE_PLATFORM}" && \
    echo "/opt/${PRODUCT}-${DOCKER_IMAGE_PLATFORM}.AppImage --appimage-extract-and-run" > /startapp.sh && chmod +x /startapp.sh