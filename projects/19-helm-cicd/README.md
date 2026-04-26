# Project 19 - Helm CI/CD Pipeline

## Overview
This project demonstrates a **complete end-to-to CI/CD pipeline** using:
- Docker (build & containerization)
- Jenkins (automation pipeline)
- Kubernetes (Minikube deployment)
- Helm (application packaging & upgrades)

The pipeline automatically:
1. Builds a Docker image
2. Pushes it to DockerHub
3. Deploys/updates the application in Kubernetes using Helm

---

## Project Structure
```
19-helm-cicd/
├── app/
│   ├── Dockerfile
│   └── html/index.html
├── helm/
│   └── app/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
├── jenkins/
│   └── Jenkinsfile
└── screenshots/
```

---

## Tech Stack

### Tools & Purpose
- Docker : Build container image
- Jenkins : CI/CD Automation
- Kubernetes : Container orchestration
- Helm : Kubernetes package management
- DockerHub : Image registry

---

## CI/CD Pipeline Flow
```
Code → Jenkins → Docker Build → DockerHub Push → Helm Deploy → Kubernetes
```

### Pipeline Stages:
- Checkout Source Code
- Build Docker Image
- Push Image to DockerHub
- Deploy to Kubernetes using Helm

---

## Key Concepts Implemented
- Helm-based deployments
- Dynamic image tagging (`build-${BUILD_NUMBER}`)
- CI/CD automation with Jenkins
- Kubernetes rolling updates via Helm 
- Debugging real-world issues:
  - ImagePullBackOff
  - Kubernetes connection issues
  - Jenkins permission errors

---

## How to Run

### 1. Build Docker Image
```bash
cd app
docker build -t helm-cicd-app:v1 .
```
---
### 2. Deploy using Helm
```bash
cd helm
helm upgrade --install helm-cicd ./app -n helm-lab
```
---
### 3. Verify Deployment
```bash
kubectl get pods -n helm-lab
helm list -n helm-lab
```
---
### 4. Access Application
```bash
minikube service helm-cicd-app -n helm-lab --url
```
OR
```bash
curl http://localhost:<NodePort>
```
---

## Screenshots

### Project Setup

![Project Structure](screenshots/01-project-folder-created.png)
![App Files](screenshots/02-app-files-created.png)

---

### Docker Build & Local Test

![Docker Build](screenshots/03-docker-build-success.png)
![Local App Test](screenshots/04-local-app-test.png)

---

### Helm Configuration & Deployment

![Helm Chart](screenshots/05-helm-chart-created.png)
![Values Configuration](screenshots/06-values-yaml-image-config.png)
![Helm Deployment](screenshots/07-helm-deploy-success.png)

---

### Kubernetes Resources

![Kubernetes Resources](screenshots/08-k8s-resources-helm-cicd.png)
![Debug Fix (ImagePullBackOff)](screenshots/09-imagepullbackoff-debug-fixed.png)

---

### Jenkins CI/CD Pipeline

![Jenkins Pipeline Success](screenshots/10-jenkins-pipeline-success.png)

---

### Helm Upgrade via Jenkins

![Helm Release Updated](screenshots/11-helm-release-upgraded-by-jenkins.png)
![Pods Running](screenshots/12-k8s-pod-running-after-pipeline.png)
![Updated Image Tag](screenshots/13-updated-image-tag-from-jenkins.png)

---

### Final Application Output

![Final App Output](screenshots/14-final-app-access-after-cicd.png)

---

## Key Achievement
- Fully automated CI/CD pipeline using Helm
- Production-style deployment workflow
- Real-world debugging handled successfully
- Clean project structure for portfolio

---

## What's Next
- Helm + AWS EKS deployment
- GitOps with ArgoCD
- Monitoring with Prometheus & Grafana

---

## Author 

**Abdul Raheman**

DevOps | Cloud | CI/CD | Kubernetes

---

**If you found this useful, consider giving a star!**

