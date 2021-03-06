# Instructions from http://docs.grafana.org/project/building_from_source/

FROM golang:1.11.5-alpine3.9
RUN apk add --update git nodejs npm build-base make python2
RUN npm i -g node-gyp

# Building Backend
RUN mkdir /data && cd /data && export GOPATH=`pwd` && \
    (go get github.com/grafana/grafana || $True) && \
    cd $GOPATH/src/github.com/grafana/grafana && \
    go run build.go setup && \
    go run build.go build

WORKDIR /data/src/github.com/grafana/grafana

# Building Frontend
RUN npm install -g yarn && \
    yarn install --pure-lockfile