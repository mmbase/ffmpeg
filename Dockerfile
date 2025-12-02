FROM eclipse-temurin:8u472-b08-jdk-noble

ENV FFMEG_VERSION=n4.4.6

# we need ffmpeg for streams contribution. This is the most expensive step. Do it first.
RUN apt-get -y update && apt-get -y install git make gcc nasm pkg-config libx264-dev libxext-dev libxfixes-dev zlib1g-dev && \
    git clone  --branch ${FFMEG_VERSION}  https://github.com/FFmpeg/FFmpeg.git  --single-branch && \
    cd FFmpeg/ && ./configure --enable-nonfree --enable-gpl --enable-libx264 --enable-zlib  && \
    make install && \
    echo ffmpeg_version=${FFMEG_VERSION} >> /DOCKER.BUILD
