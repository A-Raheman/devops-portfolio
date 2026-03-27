# 11 - Kubernetes Deployment

## Objective 

Deploy a containerized Node.js application on Kubernetes using a Deployment and a Service, then demonstrate scaling and self-healing.

---

## Tools Used

- Kubernetes 
- Minikube
- Kubectl
- Docker
- Node.js
- Linux

---

## Project Structure

```text
11-kubernetes-deployment/
├── README.md
├── app/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── scripts/
│   ├── start.sh
│   └── cleanup.sh
└── screenshots/
```

---

## Application Workflow

Docker Image -> Kubernetes Deployment -> Pods -> Service -> Port Forward/Access

---

## Kubernetes Concepts Used

### Deployment
Used to manage application pods and ensure the desired number of replicas are always running.

### Service
Used to expose the application and provide a stable access point to the pods.

### Scaling 
Increased the number of replicas to demonstrate horizontal scaling.

### Self-healing
Deleted a running pod and observed Kubernetes automatically create a replacement pod.

---

## Build and Deploy

### Start Minikube

```bash
minikube start
```

### Build image inside Minikube Docker environment

```bash
eval $(minikube docker-env)
docker build -t k8s-app:v1 ./app
```

### Apply Kubernetes manifests

```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

---

## Verification

### Check pods

```bash
kubectl get pods
```

### Check service

```bash
kubectl get svc
```

### Access application using port-forward

```bash
kubectl port-forward service/k8s-app-service 8081:80
curl http://localhost:8081
```

Expected output:

```
Kubernetes App is running | served-by=<pod-name>
```

---

## Scaling Test

```bash
kubectl scale deployment k8s-app-deployment --replicas=5
kubectl get pods
```
---

## Self-Healing Test

```bash
kubectl delete pod <pod-name>
kubectl get pods
```
Kubernetes automatically recreates the deleted pod to maintain the desired state.

---

## Learning Outcome

This project demonstrates:
- Kubernetes Deployment management
- Service-based applcation exposure
- Pod scaling
- Self-healing behavior
- Container orchestration fundamentals

---

## Interview Questions

### 1. What is a Pod?
A Pod is the samllest deployable unit in Kubernetes and usually runs one containerized application.

### 2. What is a Deployment?
A Deployment manages Pods and ensures the desired number of replicas are running.

### 3. What is a Service in Kubernetes?
A Service provides stable network access to a set of Pods.

### 4. How do you scale an application in Kubernetes?
By increasing the replica count in the Deployment or  by using the `kubectl scale` command.

### 5. What does self-healing mean in Kubernetes?
If a Pod fails or in deleted, Kubernetes automatically creates a replacement to maintain the desired state.


