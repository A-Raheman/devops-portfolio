#!/bin/bash
set -e

IMAGE_NAME="dockerhub-pipeline-app"
IMAGE_TAG="v1"

docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ./app
echo "Build completed: ${IMAGE_NAME}:${IMAGE_TAG}"
