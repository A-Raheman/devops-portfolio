# Project 20 - AWS ECR + EKS Deployment with Helm

## Overview
This project demonstrates deploying a containerized application to **AWS Kubernetes (EKS)** using a production-style workflow. 

The pipeline includes:
- Building Docker image
- Pushing image to **Amazon ECR (private registry)**
- Deploying application on **Amazon EKS**
- Managing deployment using **Helm** 
- Exposing application using **AWS LoadBalancer**

---

## Project Structure
```
20-aws-eks/
├── app/
│   ├── Dockerfile
│   └── html/index.html
├── helm/
│   └── app/
│       ├── Chart.yaml
│       ├── values.yaml
│       └── templates/
├── docs/
├── outputs/
└── screenshots/
```

---

## Tech Stack
``` 
| Tool    | Purpose                         |
| ------- | ------------------------------- |
| Docker  | Containerization                |
| AWS ECR | Private image registry          |
| AWS EKS | Managed Kubernetes              |
| Helm    | Deployment & release management |
| kubectl | Kubernetes CLI                  |
| eksctl  | EKS cluster provisioning        |
```

---

## Architecture Flow
```
Local App → Docker → ECR → EKS → Helm → LoadBalancer → Public Access
```

---

## Implementation Steps

### 1. AWS Authentication
```bash
aws configure
aws sts get-caller-identity
```
---
### 2. Create ECR Repository
```bash
aws ecr create-repository \
--repository-name helm-cicd-app \
--region ap-south-1
```
---
### 3. Build & Push Image to ECR
```bash
docker build -t helm-cicd-app:eks-v1 .

aws ecr get-login-password --region ap-south-1 \
| docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com

docker tag helm-cicd-app:eks-v1 \
<ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/helm-cicd-app:eks-v1

docker push <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/helm-cicd-app:eks-v1
```
---
### 4. Create EKS Cluster
```bash
eksctl create cluster \
--name helm-cicd-cluster \
--region ap-south-1 \
--node-type t3.small \
--nodes 1 \
--managed
```
---
### 5. Deploy using Helm
```bash
helm install helm-cicd-eks ./helm/app -n default
```
Override image:
```bash
helm upgrade helm-cicd-eks ./helm/app \
-n default \
--set image.repository=<ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com/helm-cicd-app \
--set image.tag=eks-v1
---
### 6. Expose Application
```bash
kubectl patch svc helm-cicd-eks-app \
-p '{"spec":{"type":"LoadBalancer"}}'
```
---
### 7. Access Application
```bash
kubectl get svc
curl http://<ELB-DNS>
```
---

## Key Learnings
- Difference between **DockerHub vs ECR**
- Importance of **IAM permissions for ECR access**
- Node capacity limits in Kubernetes
- Difference between:
   - NodePort ❌
   - LoadBalancer ✅ (AWS standard)
- Helm value override vs static configuration
- Debugging: 
   - ImagePullBackOff
   - Pod Pending
   - LoadBalancer not responding

---

## Troubleshooting Highlights

### ImagePullBackOff

Cause:
- Helm using DockerHub image

Fix:
```bash
helm upgrade --set image.repository=<ECR_URL>
```
---
### Pod Pending (Too Many Pods)

Cause:
- Node capacity (t3.micro)

Fix:
- Use t3.small
---
### LoadBalancer Empty Response

Cause:
- Pod not running → no endpoints

Fix:
```bash
kubectl get pods
kubectl get endpoints
```
---
### NodePort not accessible

Cause:
- AWS Security Group restrictions

Fix:
- Use LoadBalancer instead
---

## Screenshots

### 🚀 Final Application Output
![Final App Access](screenshots/01-final-app-access-eks.png)

---

### ☁️ EKS Cluster Setup

#### Cluster Creation (eksctl)
![EKS Cluster Creation Start](screenshots/13-eks-cluster-creation-start.png)
![EKS Cluster Creation Complete](screenshots/13-eks-cluster-creation-complete.png)

#### Update kubeconfig & Connect
![Update Kubeconfig](screenshots/06-aws-eks-update-kubeconfig.png)

#### Verify Nodes
![Kubectl Nodes](screenshots/02-kubectl-get-nodes-eks.png)
![Kubectl Nodes Confirm](screenshots/08-kubectl-get-nodes-confirm.png)

#### System Pods Running
![System Pods](screenshots/07-k8s-system-pods-running.png)

---

### 📦 ECR (Elastic Container Registry)

#### Repository Created
![ECR Repository](screenshots/12-ecr-repository-console.png)

#### Login to ECR
![ECR Login](screenshots/09-ecr-login-success.png)

---

### 🐳 Docker Build & Push

#### Build Docker Image
![Docker Build](screenshots/10-docker-build-image.png)

#### Push to ECR
![ECR Push Start](screenshots/11-ecr-push-start.png)
![ECR Push Success](screenshots/11-ecr-push-success.png)

---

### ⚙️ Helm Deployment

#### Install Helm Release
![Helm Install](screenshots/05-helm-install-release.png)

---

### 🐞 Troubleshooting & Debugging

#### Pod Pending Issue
![Pod Pending](screenshots/04-pod-pending-initial-error.png)

#### Initial Service (NodePort)
![NodePort Service](screenshots/03-k8s-service-nodeport-initial.png)

---

## Cost Optimization
- Used minimal cluster configuration
- Deleted cluster immediately after testing:
```bash
eksctl delete cluster --name helm-cicd-cluster --region ap-south-1
```
---

## Key Achievement
✅ Successfully deployed application to AWS Kubernetes
✅ Used private container registry (ECR)
✅ Implemented Helm-based deployment
✅ Debugged real production issues
✅ Managed cloud resources efficiently

---

## Author

**Abdul Raheman**

DevOps | Cloud | Kubernetes | CI/CD

---


