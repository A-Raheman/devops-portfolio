# Common Errors & Fixes — Project 23

## 1. Docker Login Timeout to Nexus

### Error

```text
Error response from daemon:
Get "https://localhost:8082/v2/":
context deadline exceeded
```

---

### Cause

Nexus Docker registry port was not exposed.

Initial Nexus container started with only:

```bash
-p 8081:8081
```

This exposed only the Nexus UI.

Docker registry port:

```text
8082
```

was inaccessible.

---

### Fix

Removed old container:

```bash
docker stop nexus
docker rm nexus
```

Started Nexus with both ports:

```bash
docker run -d \
  --name nexus \
  -p 8081:8081 \
  -p 8082:8082 \
  sonatype/nexus3
```

---

## 2. Nexus Taking Too Long to Start

### Problem

Nexus startup took several minutes.

Logs appeared stuck.

---

### Cause

First-time startup performs:

- repository initialization
- indexing
- internal task setup
- dependency loading

Nexus is resource intensive.

---

### Fix

Waited for:

```text
Started Sonatype Nexus COMMUNITY
```

Verified readiness:

```bash
docker logs nexus --tail=30
```

---

## 3. Docker Login Failing

### Error

```text
connection refused
```

during:

```bash
docker login localhost:8082
```

---

### Cause

Docker hosted repository not reachable.

Port mapping issue.

---

### Fix

Verified:

```bash
docker ps
```

Confirmed:

```text
8081 → Nexus UI
8082 → Docker Registry
```

After fix:

```bash
docker login localhost:8082
```

worked successfully.

---

## 4. WSL Path Not Visible in Browser Upload

### Problem

Helm package located in WSL:

```text
~/devops-portfolio/
```

was not visible in Windows browser file picker.

---

### Cause

Nexus UI runs in Windows browser.

WSL filesystem not directly exposed.

---

### Fix Option 1 (Recommended)

Used:

```bash
explorer.exe .
```

inside WSL.

This opened Linux directory in Windows Explorer.

Uploaded:

```text
nginx-chart-0.1.0.tgz
```

successfully.

---

### Fix Option 2

Used WSL path:

```text
\\wsl$\Ubuntu\home\raheman\
```

inside Windows file picker.

---

## 5. High RAM Usage

### Problem

Nexus consumed:

```text
2+ GB RAM
```

WSL memory became constrained.

---

### Cause

Nexus Repository Manager is resource heavy.

Also:

- Docker Desktop
- WSL
- Kubernetes workloads

consume RAM simultaneously.

---

### Fix

Avoided running:

```text
Minikube + Nexus + Jenkins
```

together.

Followed staged approach:

```text
Nexus only
then
Jenkins + Nexus
then
Kubernetes
```

---

## 6. Docker Artifact Validation Failure Risk

### Problem

Artifact may appear uploaded but remain unverified.

---

### Fix

Validated full lifecycle:

Removed local image:

```bash
docker rmi localhost:8082/docker-hosted/nginx-demo:v1.0
```

Pulled back from Nexus:

```bash
docker pull localhost:8082/docker-hosted/nginx-demo:v1.0
```

This confirmed:

```text
Artifact persistence
Rollback readiness
Deployment validity
```

---

# Troubleshooting Checklist

Before debugging Nexus issues:

```text
1. Check Nexus container status
2. Verify exposed ports
3. Validate docker login
4. Check repository type
5. Confirm artifact upload
6. Verify pull/download
7. Monitor RAM usage
```

---

# Key Learning

Real DevOps pipelines are not only:

```text
Build → Deploy
```

They involve:

```text
Artifact storage
Version control
Validation
Rollback readiness
Troubleshooting
```

This project provided hands-on experience with enterprise artifact lifecycle management.
