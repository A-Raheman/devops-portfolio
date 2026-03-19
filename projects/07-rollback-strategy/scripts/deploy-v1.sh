#!/bin/bash
set -e

IMAGE="araheman/dockerhub-pipeline-app:v1"
CONTAINER="rollback-app"

echo "Pulling $IMAGE ..."
docker pull $IMAGE

echo "Stopping old conatiner if it exists..."
docker stop $CONTAINER 2>/dev/null || true
docker rm $CONTAINER 2>/dev/null || true

echo "Starting v1 on port 8081:8080 ..."
docker run -d --name $CONTAINER -p 8081:8080 $IMAGE

echo "Deployment complete."
docker ps
