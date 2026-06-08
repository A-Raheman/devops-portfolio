# Common Errors & Troubleshooting — Project 28

## Error 1 — HPA Shows <unknown>

### Problem

```text
TARGETS <unknown>/50%
```

### Cause

Metrics Server unavailable.

### Resolution

Verify:

```bash
kubectl get pods -n kube-system
```

Check:

```bash
kubectl top nodes
kubectl top pods
```

If metrics are unavailable:

```bash
minikube addons enable metrics-server
```

---

# Error 2 — HPA Not Scaling

## Problem

Pods do not scale despite load.

## Causes

- Metrics Server not working
- CPU requests not configured
- Load too low

## Resolution

Verify:

```bash
kubectl describe deployment autoscaling-nginx \
-n autoscaling-lab
```

Confirm:

```text
requests:
  cpu: 100m
```

---

# Error 3 — Metrics Not Available

## Problem

```bash
kubectl top pods
```

returns error.

## Cause

Metrics API unavailable.

## Resolution

Verify:

```bash
kubectl get apiservices
```

Check Metrics Server status.

---

# Error 4 — Pods Not Recreated

## Problem

Deleted pod not recreated.

## Cause

Deployment missing.

Verify:

```bash
kubectl get deployment -n autoscaling-lab
```

Without a Deployment controller:

```text
No self-healing
```

---

# Error 5 — Pod Stuck Pending

## Problem

Pod remains Pending.

## Cause

Insufficient cluster resources.

## Resolution

Check:

```bash
kubectl describe pod <pod-name>
```

Review Events section.

---

# Error 6 — OOMKilled

## Problem

Container terminated unexpectedly.

## Cause

Memory limit exceeded.

Example:

```text
Limit = 256Mi
Usage = 400Mi
```

Result:

```text
OOMKilled
```

---

# Error 7 — HPA Scales Too Aggressively

## Cause

CPU threshold too low.

Example:

```yaml
averageUtilization: 10
```

This causes frequent scaling.

## Resolution

Use realistic thresholds.

Example:

```yaml
averageUtilization: 50
```

---

# Useful Commands

View HPA:

```bash
kubectl get hpa -n autoscaling-lab
```

View Metrics:

```bash
kubectl top nodes

kubectl top pods
```

View Deployments:

```bash
kubectl get deployment -n autoscaling-lab
```

View Pods:

```bash
kubectl get pods -n autoscaling-lab
```

Describe Pod:

```bash
kubectl describe pod <pod-name>
```

---

# Key Lesson

Autoscaling depends on:

```text
Metrics Server
Resource Requests
CPU Utilization
Deployment Controller
```

When troubleshooting:

```text
Metrics
Pods
Deployments
HPA
Events
```

should always be checked first.
