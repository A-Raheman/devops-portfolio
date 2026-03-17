#!/bin/bash
set -e

IMAGE="araheman/dockerhub-pipeline-app:latest"
CONTAINER="ec2-app"

echo "Pulling latest image from Dockerhub..."
docker pull $IMAGE

echo "Stopping old container if it exists..."
docker stop $CONTAINER 2>/dev/null || true
docker rm $CONTAINER 2>/dev/null || true

echo "Starting new container on port 8081:8080..."
docker run -d --name $CONTAINER -p 8081:8080 $IMAGE

echo "Deployment complete."
docker ps
