#!/bin/bash

set -ex

docker build --network=host -t ccr.ccs.tencentyun.com/cube-studio/dataset:20240501 -f job/dataset/Dockerfile .
docker push ccr.ccs.tencentyun.com/cube-studio/dataset:20240501

# docker buildx build --platform linux/amd64,linux/arm64 -t ccr.ccs.tencentyun.com/cube-studio/dataset:20240501 -f job/dataset/Dockerfile . --push

