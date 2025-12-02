FROM eclipse-temurin:8u472-b08-jdk-noble AS build


ENV FFMEG_VERSION=n4.4.6

# we need ffmpeg for streams contribution. This is the most expensive step. Do it first.
RUN apt-get -y update && apt-get -y install git make gcc nasm pkg-config libx264-dev libxext-dev libxfixes-dev zlib1g-dev && \
    git clone  --branch ${FFMEG_VERSION}  https://github.com/FFmpeg/FFmpeg.git  --single-branch && \
    cd FFmpeg/ && ./configure --enable-nonfree --enable-gpl --enable-libx264 --enable-zlib  && \
    make install && \
    echo ffmpeg version=${FFMEG_VERSION} >> /DOCKER.BUILD

FROM eclipse-temurin:8u472-b08-jdk-noble

ARG NAME=ffmpeg
ARG CI_COMMIT_REF_NAME
ARG CI_COMMIT_SHA
ARG CI_COMMIT_TITLE
ARG CI_COMMIT_TIMESTAMP

COPY --from=build /DOCKER.BUILD /DOCKER.BUILD
COPY --from=build /usr/local/ffmpeg /usr/local/ffmpeg


SHELL [ "/bin/bash", "-c" ]
ENV SHELL=/bin/bash
RUN (echo -e "${NAME} git version=${CI_COMMIT_SHA}\t${CI_COMMIT_REF_NAME}\t${CI_COMMIT_TIMESTAMP}\t${CI_COMMIT_TITLE}") >> /DOCKER.BUILD