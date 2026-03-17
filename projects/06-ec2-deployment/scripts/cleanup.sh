#!/bin/bash
set -e

CONTAINER="ec2-app"

echo "Stopping container..."
docker stop $CONTAINER 2>/dev/null || true

echo "Removing container..."
docker rm $CONTAINER 2>/dev/null || true

echo "Cleanup complete."

