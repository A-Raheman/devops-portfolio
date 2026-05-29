# 🎯 Interview Questions — Project 23

# Beginner Level

## 1. What is an artifact in DevOps?

An artifact is:

> A deployable build output generated from source code.

Examples:

| Technology | Artifact |
|------------|----------|
| Java | `.jar`, `.war` |
| Python | package |
| Docker | container image |
| Kubernetes | Helm chart |

Examples from this project:

```text
Docker image
Helm chart package
```

---

## 2. Why do we need artifacts?

Artifacts help with:

- versioning
- rollback
- reproducibility
- centralized storage
- deployment consistency

Without artifacts:

```text
Build → Deploy
```

With artifacts:

```text
Build
 ↓
Store Artifact
 ↓
Validate
 ↓
Deploy
```

---

## 3. What is Nexus Repository?

Nexus is an artifact repository manager.

It stores:

- Docker images
- Helm charts
- JAR/WAR files
- packages

Purpose:

> Centralized artifact storage.

---

## 4. What is the difference between source code and artifact?

### Source Code

Human-readable code.

Example:

```text
Java files
Python files
Dockerfile
Helm templates
```

---

### Artifact

Deployable build output.

Example:

```text
Docker image
Helm package
```

---

## 5. Why not deploy directly after build?

Because production systems need:

- rollback capability
- version tracking
- validation
- safer deployment

Instead of:

```text
Build → Deploy
```

companies use:

```text
Build
 ↓
Artifact Repository
 ↓
Deployment
```

---

# Intermediate Level

## 6. What is artifact versioning?

Artifact versioning means storing deployable packages with unique versions.

Example:

```text
v1.0
v1.0.1
v2.0
stable
rollback
```

In this project:

```text
nginx-demo:v1.0
```

---

## 7. Why did we use Docker hosted repository?

To store:

> Versioned Docker container images.

Example:

```text
localhost:8082/docker-hosted/nginx-demo:v1.0
```

This allows:

- image reuse
- rollback
- centralized storage

---

## 8. Why did we package Helm charts?

Helm charts are deployment artifacts.

Instead of manually writing Kubernetes YAML repeatedly:

```text
Helm package
```

creates reusable deployments.

Example:

```text
nginx-chart-0.1.0.tgz
```

---

## 9. What is rollback in DevOps?

Rollback means:

> Reverting to a previously working version.

Example:

Bad deployment:

```text
v2.0
```

Rollback:

```text
v1.0
```

Because artifacts are versioned.

---

## 10. Why validate artifact pull?

We removed the local image:

```bash
docker rmi
```

Then pulled it again.

Purpose:

```text
Verify repository storage
Verify deployment readiness
Validate rollback support
```

---

# Advanced Level

## 11. How would Jenkins integrate with Nexus?

Pipeline:

```text
GitHub
 ↓
Jenkins
 ↓
Build Docker Image
 ↓
Tag Version
 ↓
Push to Nexus
 ↓
Deploy
```

Jenkins automates:

- build
- tagging
- pushing artifacts

---

## 12. What is immutable deployment?

Immutable deployment means:

> Once an artifact is built, it should not change.

Instead:

```text
Rebuild new version
```

rather than editing old deployment.

---

## 13. Why use Nexus instead of local Docker images?

Local images are:

```text
temporary
machine-specific
unsafe
```

Nexus provides:

```text
centralized storage
version control
artifact sharing
rollback
```

---

## 14. Nexus vs Docker Hub?

### Docker Hub

- public registry
- image storage only

---

### Nexus

- private repository
- multiple artifact types
- enterprise control
- CI/CD integration

---

## 15. Nexus vs Artifactory?

### Nexus

- lightweight
- easier setup
- open source

---

### Artifactory

- enterprise-heavy
- advanced package management
- expensive

---

# Scenario-Based Questions

## Scenario 1

Deployment failed in production.

How would you rollback?

Answer:

```text
1. Identify last stable artifact
2. Pull old version
3. Redeploy stable artifact
```

Example:

```text
v2.0 failed
rollback → v1.0
```

---

## Scenario 2

Docker image missing in deployment.

What would you check?

Answer:

```text
1. Nexus repository
2. Artifact version
3. Jenkins push logs
4. Docker login
5. Repository URL
```

---

## Scenario 3

Helm deployment failing.

What would you verify?

Answer:

```text
1. Chart package version
2. helm package output
3. Nexus upload
4. values.yaml
5. Kubernetes manifests
```

---

# Key Takeaway

This project provided hands-on experience with:

```text
Artifact lifecycle
Docker artifact storage
Helm artifact management
Versioning
Rollback strategy
Nexus Repository
CI/CD maturity
```
