#!/bin/bash
set -e

docker build -t load-balancer-app:v1 ./app

docker run -d --name app1 -p 8082:8080 load-balancer-app:v1
docker run -d --name app2 -p 8083:8080 load-balancer-app:v1
docker run -d --name app3 -p 8084:8080 load-balancer-app:v1

docker run -d \
  --name nginx-lb \
  -p 8081:8081 \
  -v $(pwd)/nginx/nginx.conf:/etc/nginx/nginx.conf \
  nginx

echo "Load balancer started on port 8081"

