#!/bin/bash
set -e

IMAGE_NAME="a.raheeman7/dockerhub-pipeline-app"
IMAGE_NAME="v1"

docker tag dockerhub-pipeline-app:${IMAGE_TAG} ${IMAGE_NAME}:${IMAGE_TAG}
docker push ${IMAGE_NAME}:${IMAGE_TAG}

echo "Push completed: ${IMAGE_NAME}:${IMAGE_TAG}"
