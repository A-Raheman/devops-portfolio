# Interview Questions — Project 25 (DevSecOps with Trivy)

This document contains interview questions from beginner to advanced level based on Project 25.

---

# Beginner Questions

## 1. What is Trivy?

Trivy is an open-source vulnerability and misconfiguration scanner.

It scans:

- Docker images
- Kubernetes manifests
- filesystems
- IaC
- secrets

Purpose:

> Detect security issues before deployment.

---

## 2. What is a vulnerability?

A vulnerability is:

> A weakness that can be exploited.

Examples:

```text
Outdated packages
Privilege escalation
Root execution
```

---

## 3. What is CVE?

CVE means:

```text
Common Vulnerabilities and Exposures
```

It uniquely identifies publicly known vulnerabilities.

Example:

```text
CVE-2026-42496
```

---

## 4. What are severity levels?

Severity categories:

```text
CRITICAL
HIGH
MEDIUM
LOW
UNKNOWN
```

Priority:

```text
CRITICAL > HIGH > MEDIUM > LOW
```

---

## 5. Why scan Docker images?

To detect:

```text
OS vulnerabilities
library vulnerabilities
outdated packages
```

before deployment.

---

# Intermediate Questions

## 6. Why was nginx:latest vulnerable?

Because:

```text
larger package surface
Debian packages
more dependencies
```

Scan result:

```text
HIGH: 34
CRITICAL: 2
```

---

## 7. Why was nginx:alpine safer?

Because:

```text
minimal packages
smaller attack surface
```

Result:

```text
0 findings
```

---

## 8. What is attack surface?

Attack surface means:

> Number of exposed components that attackers can exploit.

Smaller image:

```text
Lower attack surface
```

---

## 9. What is Shift Left Security?

Security performed:

```text
before deployment
```

instead of after incidents.

Workflow:

```text
Build
↓
Scan
↓
Deploy
```

---

## 10. What is a Security Gate?

Security Gate:

> Blocks deployment if security conditions fail.

Example:

```text
CRITICAL > 0
```

Result:

```text
BUILD FAILED
```

---

# Advanced Questions

## 11. Explain your DevSecOps project.

Answer:

> I implemented a container and Kubernetes security workflow using Trivy. I scanned Docker images for vulnerabilities, compared vulnerable and hardened images, scanned Kubernetes manifests for misconfigurations, remediated security issues, validated zero findings, and implemented a security gate to block vulnerable deployments.

---

## 12. What Kubernetes security issues did you find?

Examples:

```text
privileged container
root privileges
missing resource limits
missing seccomp profile
```

---

## 13. How did you harden the manifest?

Implemented:

```text
runAsNonRoot
allowPrivilegeEscalation=false
readOnlyRootFilesystem=true
capabilities drop ALL
resource limits
```

Result:

```text
0 findings
```

---

## 14. Why should privileged containers be avoided?

Because:

```text
host access
container escape
privilege escalation
```

Risk increases significantly.

---

## 15. Explain resource limits.

Resource limits prevent:

```text
resource exhaustion
DoS
unstable workloads
```

Example:

```yaml
resources:
  requests:
  limits:
```

---

# Scenario Questions

## Scenario 1

Pipeline fails due to CRITICAL findings.

What do you do?

Answer:

```text
Analyze
Fix
Rescan
Deploy
```

---

## Scenario 2

Image has many HIGH findings.

What do you do?

Answer:

```text
Use alpine
Update packages
Reduce dependencies
```

---

## Scenario 3

Manifest contains privileged=true.

What do you do?

Answer:

```text
privileged=false
runAsNonRoot=true
drop capabilities
```

---

# Rapid Fire

### Trivy used for?

```text
Security scanning
```

### CVE full form?

```text
Common Vulnerabilities and Exposures
```

### Security gate purpose?

```text
Block insecure deployment
```

### Shift Left means?

```text
Security earlier
```

### Better image?

```text
alpine
```

### privileged=true risk?

```text
Container escape
```

---

# Most Important Interview Answer

If interviewer asks:

> Why perform security scanning?

Answer:

> Security scanning helps detect vulnerabilities and misconfigurations early, reducing production risk and enabling safer automated deployments.
