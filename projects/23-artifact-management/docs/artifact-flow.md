# Artifact Flow Documentation — Project 23

## Overview

This document explains the lifecycle of artifacts in a production-grade DevOps workflow.

Instead of deploying raw source code directly into production, organizations first create, version, validate, and store artifacts inside an artifact repository.

This project demonstrates that workflow using:

- Nexus Repository Manager
- Docker artifacts
- Helm artifacts

---

# What is an Artifact?

An artifact is:

> A deployable build output generated from source code.

Examples:

| Technology | Artifact |
|------------|----------|
| Java | `.jar`, `.war` |
| Python | Package / Docker image |
| NodeJS | Build package |
| Docker | Container image |
| Kubernetes | Helm chart |

In this project, the artifacts are:

```text
Docker image
Helm package
```

---

# Production Artifact Lifecycle

Traditional beginner workflow:

```text
GitHub
 ↓
Build
 ↓
Deploy
```

Production workflow:

```text
GitHub
 ↓
Build
 ↓
Artifact Creation
 ↓
Versioning
 ↓
Store in Nexus
 ↓
Validation
 ↓
Deployment
```

Why?

Because companies need:

- rollback capability
- traceability
- reproducibility
- version management
- deployment safety

---

# Docker Artifact Flow

## Step 1 — Build Image

Created Docker artifact:

```bash
docker build -t localhost:8082/docker-hosted/nginx-demo:v1.0 .
```

Generated artifact:

```text
nginx-demo:v1.0
```

---

## Step 2 — Push to Nexus

Pushed image:

```bash
docker push localhost:8082/docker-hosted/nginx-demo:v1.0
```

Artifact stored in:

```text
docker-hosted repository
```

---

## Step 3 — Validate Artifact

Local image removed:

```bash
docker rmi localhost:8082/docker-hosted/nginx-demo:v1.0
```

Pulled back from Nexus:

```bash
docker pull localhost:8082/docker-hosted/nginx-demo:v1.0
```

Purpose:

```text
Rollback validation
Deployment readiness
Version retrieval
```

---

# Helm Artifact Flow

## Step 1 — Generate Helm Chart

Created chart:

```bash
helm create nginx-chart
```

---

## Step 2 — Package Chart

Packaged chart:

```bash
helm package nginx-chart
```

Generated:

```text
nginx-chart-0.1.0.tgz
```

---

## Step 3 — Upload to Nexus

Uploaded package to:

```text
helm-hosted
```

repository.

Purpose:

```text
Reusable deployment package
Versioned infrastructure
Centralized deployment storage
```

---

# Why Nexus?

Nexus acts as:

> Central artifact storage

Benefits:

- version control
- immutable builds
- rollback support
- CI/CD integration
- artifact traceability

---

# Real Enterprise Workflow

Production CI/CD pipeline:

```text
Developer Push
       ↓
GitHub
       ↓
Jenkins Build
       ↓
Artifact Creation
       ↓
Nexus Repository
       ↓
Validation
       ↓
Kubernetes Deployment
```

---

# Key Takeaway

The biggest learning from this project:

> Applications should not be deployed directly after build.

Instead:

```text
Build
 ↓
Store Artifact
 ↓
Version
 ↓
Validate
 ↓
Deploy
```

This ensures safer and production-ready deployments.
