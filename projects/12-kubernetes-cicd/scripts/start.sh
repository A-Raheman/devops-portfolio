#!/bin/bash
set -e

cd "$(dirname "$0")/../app"

eval $(minikube docker-env)
docker build -t k8s-cicd-app:v1 .

cd ../k8s
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

echo "Kubernetes CI/CD demo app deployed successfully."
kubectl get pods
kubectl get svc
