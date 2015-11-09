#!/bin/bash
set -e

# TODO fold into one build script
H2O_VERSION=${H2O_VERSION:-1.5.2}
ACBUILD=${ACBUILD:-acbuild}

mkdir -p build

$ACBUILD begin
$ACBUILD set-name desource.net/nginx
$ACBUILD copy bin/h2o         /bin/h2o
$ACBUILD copy bin/share/h2o   /usr/local/share/h2o
$ACBUILD copy etc/            /etc/
$ACBUILD port add http tcp 80
$ACBUILD set-exec /bin/h2o -- -m worker -c /etc/h2o/h2o.conf
$ACBUILD write --overwrite build/nginx-$H2O_VERSION.aci
$ACBUILD end
