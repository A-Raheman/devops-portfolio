# common Errors & Troubleshooting

## 1. Grafana Login Failed

### Problem

Unable to login using default credentials.

### Cause

Helm-generated password differed from expected default password.

### Fix

Retrieve Grafana password:

```bash
kubectl get secret monitoring-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode && echo
```

Username:

```text
admin
```

---

## 2. Dashboard Showing N/A

### Problem

Grafana dashboard showed:

```text
N/A
```

instead of metrics.

### Cause

Dashboard version mismatch.

Older dashboard IDs were incompatible with kube-prometheus-stack metrics.

### Fix

Imported dashboard:

```text
15757
```

---

## 3. Metrics API Not Available

### Problem

```bash
kubectl top pods
```

returned:

```text
error: Metrics API not available
```

### Cause

Metrics Server not installed.

### Fix

Enable Metrics Server:

```bash
minikube addons enable metrics-server
```

Verify:

```bash
kubectl top pods
```

---

## 4. Custom Alert Not Triggering

### Problem

Prometheus alert remained inactive.

### Cause

CPU threshold not reached.

### Fix

Generate CPU load:

```bash
kubectl run cpu-stress \
 --image=busybox \
 --restart=Never \
 -- /bin/sh -c "while true; do yes > /dev/null; done"
```

Wait for:

```text
Pending → Firing
```

---

## 5. Grafana Not Accessible After Restart

### Problem

Grafana stopped opening after system/Minikube restart.

### Cause

Port-forward session stopped.

### Fix

Restart port-forward:

```bash
kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring
```

Access:

```text
http://localhost:3000
```

