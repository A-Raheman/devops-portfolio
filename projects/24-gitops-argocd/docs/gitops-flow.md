# GitOps Workflow Documentation — Project 24

## Overview

This document explains how GitOps works using ArgoCD and Kubernetes.

In a GitOps workflow:

> Git becomes the single source of truth.

Instead of manually deploying applications using:

```text
kubectl apply
```

Kubernetes continuously synchronizes infrastructure from Git repositories.

This project demonstrates:

- Git-driven deployments
- Auto synchronization
- Drift detection
- Self-healing infrastructure
- Desired state management

---

# Traditional Deployment Model

Traditional workflow:

```text
Developer
    ↓
kubectl apply
    ↓
Kubernetes Deployment
```

Problems:

- manual deployments
- human error
- inconsistent environments
- drift issues
- difficult rollback

---

# GitOps Workflow

Modern GitOps model:

```text
Developer Push
       ↓
GitHub Repository
       ↓
ArgoCD watches repository
       ↓
Configuration change detected
       ↓
Kubernetes synchronized
       ↓
Desired state maintained
```

Benefits:

```text
automation
consistency
auditability
rollback
self-healing
```

---

# Desired State Concept

Git stores:

> Desired infrastructure state.

Example:

```yaml
replicas: 3
```

If Kubernetes changes manually:

```bash
kubectl scale deployment gitops-nginx --replicas=1
```

ArgoCD detects drift and restores:

```text
replicas: 3
```

This is called:

```text
Reconciliation
```

---

# ArgoCD Architecture

Main components used:

## argocd-server

Provides:

```text
UI
API
authentication
```

---

## argocd-repo-server

Responsible for:

```text
reading Git repositories
processing manifests
```

---

## application-controller

Responsible for:

```text
cluster reconciliation
desired state management
```

---

## redis

Provides:

```text
caching
performance optimization
```

---

# Project Workflow

## Step 1 — Install ArgoCD

Installed into:

```text
argocd namespace
```

Purpose:

```text
isolated platform deployment
```

---

## Step 2 — Create Kubernetes Manifests

Created:

```text
deployment.yaml
service.yaml
```

Purpose:

```text
application deployment
service exposure
```

---

## Step 3 — Configure ArgoCD Application

Connected:

```text
GitHub Repository
```

to:

```text
Kubernetes Cluster
```

Configured:

```yaml
syncPolicy:
  automated:
    prune: true
    selfHeal: true
```

---

## Step 4 — Automatic Synchronization

GitHub commit:

```text
replicas: 2 → 3
```

Result:

```text
ArgoCD detected change
↓
Kubernetes synchronized
↓
3 pods running
```

---

## Step 5 — Self-Healing Test

Manual deletion:

```bash
kubectl delete deployment gitops-nginx
```

Result:

```text
Deployment recreated automatically
```

This validated:

```text
drift detection
auto remediation
desired state enforcement
```

---

## Step 6 — Drift Correction

Manual scaling:

```bash
kubectl scale deployment gitops-nginx --replicas=1
```

Expected drift:

```text
1 replica
```

Actual result:

```text
ArgoCD restored deployment to 3 replicas
```

Meaning:

> Git remained the source of truth.

---

# Real Enterprise Workflow

Production systems:

```text
Developer Push
       ↓
GitHub
       ↓
Pull Request Review
       ↓
Merge to Main
       ↓
ArgoCD Auto Sync
       ↓
Production Deployment
```

This improves:

- deployment reliability
- auditability
- rollback capability
- infrastructure consistency

---

# Key Takeaway

Biggest learning from this project:

> Kubernetes should not be manually controlled.

Instead:

```text
Git controls Kubernetes.
```

This enables:

```text
automation
consistency
self-healing
drift prevention
```
