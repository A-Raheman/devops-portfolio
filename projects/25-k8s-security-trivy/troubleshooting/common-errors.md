# Common Errors & Troubleshooting - Project 25

This document covers issues encountered during vulnerability scanning and security validation.

---

# Error 1 - Trivy Scan Timeout

## Problem 

Intitial image scan failed:

```text
context deadline executed
```

Cause:

```text
Deep scanning + secret scanning increased scan duration.
```

Observed:

```text
failed analysis
walk error
context deadline executed
```

--- 

## Fix

Disabled unnecessary scanners and increased timeout.

Command:

```bash
trivy image \
--scanners vuln \
--timeout 10m \
nginx:latest
```

Result: 

```text
Scan completed successfully.
```

---

# Error 2 — Large Database Download Time

## Problem

Initial Trivy scan took several minutes.

Observed:

```text
Downloading vulnerability DB
Downloading Java DB
```

Cause:

```text
First-time cache initialization.
```

---

## Fix

No action required.

Future scans automatically use cache.

Optional cleanup:

```bash
trivy clean --java-db
```

---

# Error 3 — Too Many Vulnerabilities Found

## Problem

Image:

```text
nginx:latest
```

produced:

```text
HIGH: 34
CRITICAL: 2
```

Cause:

```text
Full OS image
larger package surface
```

---

## Fix

Switched image:

```text
nginx:alpine
```

Result:

```text
0 vulnerabilities
```

---

# Error 4 — Manifest Security Findings

## Problem

Manifest scan reported:

```text
19 findings
```

Examples:

```text
privileged=true
root execution
missing resource limits
```

---

## Fix

Implemented:

```text
runAsNonRoot
drop capabilities
resource limits
readOnlyRootFilesystem
```

Result:

```text
0 findings
```

---

# Error 5 — Security Gate Failed

## Problem

Security gate blocked deployment.

Output:

```text
BUILD FAILED
Critical vulnerabilities detected
```

Cause:

```text
CRITICAL findings existed
```

---

## Fix

Options:

```text
Fix packages
Use safer image
Rescan
```

Pipeline passed after remediation.

---

# Useful Debug Commands

Check image:

```bash
docker images
```

Scan image:

```bash
trivy image nginx:latest
```

Scan only vulnerabilities:

```bash
trivy image --scanners vuln nginx:latest
```

Filter severity:

```bash
trivy image \
--severity HIGH,CRITICAL \
nginx:latest
```

Scan Kubernetes manifests:

```bash
trivy config manifests/
```

Generate report:

```bash
trivy image nginx:latest > report.txt
```

---

# Biggest Lesson

Security should be:

```text
continuous
automated
enforced
```

not:

```text
manual
reactive
post-deployment
```
