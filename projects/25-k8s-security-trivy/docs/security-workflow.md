# Security Workflow - Project 25

## Overview

This document explains the DevSecOps workflow implemented using Trivy.

Goal.

> Detect vulnerabilities and security risks before deployment.

This project demonstrates:

- Container vulnerability scanning
- Kubernetes manifest scanning
- Security remediation
- Deployment blocking
- Shift Left Security

---

# Traditional Deployment Model

Old approach:

```text
Build
 ↓
Deploy
```

Problems:

- Vulnerable containers
- Insecure manifests
- Security issues discovered late

---

# DevSecOps Workflow

Implemented worflow:

```text
Docker Build
      ↓
Trivy Scan
      ↓
Detect Vulnerabilities
      ↓
Security Analysis
      ↓
Fix Findings
      ↓
Validate
      ↓
Deploy
```

---


# Container Security


Scanned:

```text
nginx:latest
```

Result:

```
HIGH: 34
CRITICAL: 2
```

Examples:

```text
curl
perl-base
```

Lesson:

Official images may still contain vulnerabilities.

---

# Image Hardening

Compared:

```text
nginx:latest
```

vs

```text
nginx:alpine
```

Result:

| Image | HIGH | CRITICAL |
|--------|------|----------|
| nginx:latest | 34 | 2 |
| nginx:alpine | 0 | 0 |


Reason:

```text
smaller image
	↓
smaller attack surface
```

---

# Kubernetes Security

Created insecure deployment.

Issues introduced:

```text
privileged=true
latest tag
root execution
missing limits
```

Scan:

```bash
trivy config manifests/
```

Result:

```text
19 findings
```

---

Implemented:

```text
allowPrivilegeEscalation=False
readOnlyRootFilesystem=true
runAsNonRoot=true
drop ALL capabilities
resource limits
```

Result:

```text
0 findings
```

---

# Security Gate

Created:

```text
security-gate.sh
```

Purpose:

Prevent vulnerable deployment.

Workflow:

```text
Build
 ↓
Scan
 ↓
Critical?
 ↓ YES
Fail
```

Example:

```text
BUILD FAILED
Critical vulnerabilities detected
```

---

# Real Production Workflow

```text
Developer
    ↓
Git Push
    ↓
CI Pipeline
    ↓
Trivy Scan
    ↓
Security Gate
    ↓
Deploy
```

---

# Key Learning

Security should happen:

```text
before deployment
```

not after incidents.

This is called:

```text
Shift Left Security
```
