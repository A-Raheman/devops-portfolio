# 🛠️ Common Errors & Fixes — Project 22

## 1️⃣ Docker Socket Error

### Error

```text
failed to connect to the docker API at unix:///var/run/docker.sock
```

---

### Cause

Docker Desktop was not running.

Minikube uses Docker driver:

```text
--driver=docker
```

which requires Docker daemon.

---

### Fix

Start Docker Desktop.

Verify:

```bash
docker ps
```

Then restart Minikube:

```bash
minikube start --driver=docker
```

---

## 2️⃣ Grafana Unable to Connect with Loki

### Error

```text
Unable to connect with Loki
```

---

### Cause

Incorrect Loki datasource URL.

---

### Fix

Use:

```text
http://loki-gateway.logging.svc.cluster.local
```

Then:

```text
Save & Test
```

Expected:

```text
Data source successfully connected
```

---

## 3️⃣ Promtail Connection Refused

### Error

```text
connection refused
```

Observed in Promtail logs.

---

### Cause

Promtail started before Loki became ready.

This happens during startup.

---

### Fix

Wait for Loki pod readiness.

Check:

```bash
kubectl get pods -n logging
```

Verify:

```text
loki-0 Running
```

Promtail retries automatically.

---

## 4️⃣ Loki `/ready` Endpoint Returning 404

### Error

```text
404 Not Found
```

While testing:

```bash
curl http://localhost:3100/ready
```

---

### Cause

Request was sent through:

```text
loki-gateway
```

which exposes Loki API routes but not readiness endpoint.

---

### Fix

Test supported endpoint:

```bash
curl http://localhost:3100/loki/api/v1/labels
```

Expected:

```json
{"status":"success"}
```

---

## 5️⃣ Grafana Loki Health Check Parse Error

### Error

```text
parse error at line 1
syntax error: unexpected IDENTIFIER
```

---

### Cause

Deprecated Helm chart:

```text
grafana/loki-stack
```

caused compatibility issues.

---

### Fix

Migrated to modern chart:

```bash
helm install loki grafana/loki
```

---

## 6️⃣ Promtail Misconfiguration

### Error

Promtail deployed but logs missing.

---

### Cause

Typo during Helm install:

Incorrect:

```bash
config.client[0]
```

Correct:

```bash
config.clients[0]
```

---

### Fix

Reinstalled Promtail:

```bash
helm uninstall promtail -n logging

helm install promtail grafana/promtail \
--namespace logging \
--set config.clients[0].url=http://loki-gateway.logging.svc.cluster.local/loki/api/v1/push
```

---

## 7️⃣ Loki Cache Pods Pending

### Error

```text
loki-chunks-cache Pending
```

---

### Cause

Low laptop RAM.

Cluster resources insufficient.

---

### Fix

Disabled unnecessary cache components:

```bash
helm upgrade loki grafana/loki \
--namespace logging \
--set chunksCache.enabled=false \
--set resultsCache.enabled=false
```

---

## 8️⃣ High RAM Usage (VmmemWSL)

### Problem

RAM usage increased to:

```text
85–90%
```

---

### Cause

Docker + Minikube + Kubernetes workloads running simultaneously.

---

### Fix

Configured WSL memory limit:

File:

```text
C:\Users\Victus\.wslconfig
```

Configuration:

```ini
[wsl2]
memory=4GB
processors=4
swap=2GB
localhostForwarding=true
```

Then:

```powershell
wsl --shutdown
```

---

# 🔥 Troubleshooting Checklist

When logs are not visible:

```text
1. Check pod status
2. Check services
3. Verify Promtail logs
4. Validate Loki API
5. Verify Grafana datasource
6. Test LogQL query
7. Check cluster resources
```

---

# 🎯 Key Learning

Real DevOps work is not only deployment.

Most work happens in:

```text
Debugging
Troubleshooting
Incident resolution
Root cause analysis
```

This project provided hands-on experience with production-style troubleshooting.
