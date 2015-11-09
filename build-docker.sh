#!/bin/bash
set -e

H2O_VERSION=${H2O_VERSION:-1.5.2}

docker build -t desource/h2o:$H2O_VERSION -f Dockerfile .
docker tag -f desource/h2o:$H2O_VERSION quay.io/desource/h2o:$H2O_VERSION
