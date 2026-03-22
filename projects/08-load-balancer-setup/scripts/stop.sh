#!/bin/bash

docker stop nginx-lb app1 app2 app3 2>/dev/null || true
docker rm nginx-lb app1 app2 app3 2>/dev/null || true

echo "All containers stopped"

