#!/bin/bash

# This is ment to run inside this build container

GOPATH=/go
REPO_PATH=$GOPATH/src/github.com/grafana/grafana

mkdir -p /go/src/github.com/grafana
cd /go/src/github.com/grafana
git clone https://github.com/grafana/grafana.git

# go get -u -v github.com/grafana/grafana

cd $REPO_PATH

go get github.com/tools/godep
go run build.go build

npm install --unsafe-perm

source /etc/profile.d/rvm.sh
rvm use 2.1.9 --default

gem install fpm -v 1.4

go run build.go package latest

cp dist/* /tmp/dist/


