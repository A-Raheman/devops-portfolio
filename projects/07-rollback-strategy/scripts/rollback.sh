#!/bin/bash 
set -e

IMAGE="araheman/dockerhub-pipeline-app:v1"
CONTAINER="rollback-app"

echo "Rolling back to $IMAGE ..."
docker pull $IMAGE

echo "Stopping current container..."
docker stop $CONTAINER 2>/dev/null || true
docker rm $CONTAINER 2>/dev/null || true

echo "Starting previous stable version..."
docker run -d --name $CONTAINER -p 8081:8080 $IMAGE

echo "Rollback complete."
docker ps

