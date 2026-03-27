#!/bin/bash
set -e

cd "$(dirname "$0")/../k8s"

kubectl delete -f service.yaml --ignore-not-found
kubectl delete -f deployment.yaml --ignore-not-found

echo "Kubernetes resources cleaned up."
kubectl get pods
kubectl get svc

