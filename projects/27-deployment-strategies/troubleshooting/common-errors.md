# Common Errors & Troubleshooting — Project 27

This document covers common issues encountered while implementing Blue-Green and Canary deployment strategies in Kubernetes.

---

# Error 1 — Service Still Routing to Old Environment

## Problem

Traffic continues reaching Blue pods after switching to Green.

## Cause

Service selector still points to:

```yaml
version: blue
```

instead of:

```yaml
version: green
```

## Resolution

Verify:

```bash
kubectl describe svc nginx-service -n deployment-lab
```

Expected:

```text
Selector: app=nginx,version=green
```

---

# Error 2 — Green Deployment Not Receiving Traffic

## Problem

Green pods are running but traffic is not reaching them.

## Cause

Label mismatch.

Example:

Deployment:

```yaml
version: green
```

Service:

```yaml
version: green-v2
```

Labels must match exactly.

## Resolution

Verify:

```bash
kubectl get pods --show-labels -n deployment-lab
```

---

# Error 3 — Rollback Not Working

## Problem

Traffic remains on Green after rollback.

## Cause

Service selector not updated.

## Resolution

Update:

```yaml
version: blue
```

Apply:

```bash
kubectl apply -f manifests/nginx-service.yaml
```

---

# Error 4 — Canary Traffic Distribution Incorrect

## Problem

Canary receives too much or too little traffic.

## Cause

Replica counts not configured correctly.

Example:

```text
Stable: 4
Canary: 1
```

Approximate split:

```text
80 / 20
```

---

# Error 5 — Pods Not Starting

## Problem

Deployment created but pods remain Pending or CrashLoopBackOff.

## Resolution

Check:

```bash
kubectl get pods -n deployment-lab

kubectl describe pod <pod-name> -n deployment-lab

kubectl logs <pod-name> -n deployment-lab
```

---

# Useful Commands

View deployments:

```bash
kubectl get deployment -n deployment-lab
```

View services:

```bash
kubectl get svc -n deployment-lab
```

View endpoints:

```bash
kubectl get endpoints -n deployment-lab
```

View pod labels:

```bash
kubectl get pods --show-labels -n deployment-lab
```

---

# Key Lesson

Most deployment failures are caused by:

```text
Label mismatch
Service selector mismatch
Incorrect rollout strategy
Insufficient validation
```

Always verify:

```text
Pods
Services
Endpoints
Labels
Traffic Routing
```
