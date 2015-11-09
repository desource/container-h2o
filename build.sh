#!/bin/bash

# TODO add sha checks
H2O_VERSION=${H2O_VERSION:-1.5.2}

function build() {
    rm -rf bin;

    cat <<EOF | docker build --pull -t "build-h2o" -
FROM gliderlabs/alpine:edge

RUN apk add --update \
  curl \
  tar \
  gcc \
  make \
  git \
  autoconf \
  automake \
  cmake \
  libtool \
  perl \
  linux-headers \
  libc-dev \
  xz-dev \
  zlib-dev \
  libuv-dev \
  pcre-dev

RUN \
  mkdir -p /h2o && \
  curl -sL https://github.com/h2o/h2o/archive/v$H2O_VERSION.tar.gz | \
  tar xz -C /h2o --strip-components 1 && \
  cd /h2o && \
  cmake -DWITH_BUNDLED_SSL=on -DCMAKE_C_FLAGS="-static -lm" . && \
  make

EOF
    ID=`docker inspect -f '{{ .Id }}' build-h2o`

    mkdir -p bin

    docker save $ID | \
        tar -xOf - "$ID/layer.tar" | \
        tar -xf - -C bin --strip-components=1 "h2o/h2o" "h2o/share"
}

build
