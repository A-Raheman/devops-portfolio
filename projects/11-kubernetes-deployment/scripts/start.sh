#!/bin/bash
set -e

cd "$(dirname "$0")/../app"

eval $(minikube docker-env)
docker build -t k8s-app:v1 .

cd ../k8s
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "Kubernetes deployment and service created successfully."
kubectl get pods
kubectl get svc

