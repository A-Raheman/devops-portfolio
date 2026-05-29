# Common Errors & Troubleshooting — Project 24

This document covers issues encountered during implementation of GitOps with ArgoCD and Kubernetes and how they were resolved.

---

# Error 1 — Port 8080 Already in Use

## Problem

ArgoCD port-forward failed:

```text
Unable to listen on port 8080
bind: address already in use
```

Cause:

```text
Port 8080 already occupied
(Jenkins service running)
```

---

## Fix

Changed local port:

```bash
kubectl port-forward svc/argocd-server \
-n argocd 8085:443
```

Accessed:

```text
https://localhost:8085
```

---

# Error 2 — ArgoCD Sync Failed

## Problem

Application showed:

```text
Sync Failed
```

Error:

```text
json: cannot unmarshal string into Go struct field
```

Cause:

```text
Invalid YAML formatting
in deployment.yaml
```

Problematic section:

```yaml
ports:
  - "80"
```

Kubernetes expected:

```yaml
ports:
  - containerPort: 80
```

---

## Fix

Corrected deployment manifest:

```yaml
ports:
  - containerPort: 80
```

Committed and pushed:

```bash
git add .
git commit -m "Fixed deployment YAML for ArgoCD sync"
git push origin main
```

ArgoCD automatically synchronized.

---

# Error 3 — Application OutOfSync

## Problem

Application status:

```text
OutOfSync
Healthy
```

Cause:

```text
GitHub changes not synchronized
```

---

## Fix

Performed:

```text
Refresh → Hard Refresh
```

Then:

```text
Sync → Synchronize
```

Application became:

```text
Synced
Healthy
```

---

# Error 4 — Deployment Missing

## Problem

Service created but deployment absent.

Observed:

```bash
kubectl get svc
```

Service existed.

But:

```bash
kubectl get deployment
```

showed:

```text
No resources found
```

Cause:

```text
deployment.yaml invalid
```

---

## Fix

Validated manifest:

```bash
kubectl apply \
--dry-run=client \
-f deployment.yaml
```

Fixed YAML syntax.

---

# Error 5 — Self-Healing Too Fast

## Problem

Manual scaling:

```bash
kubectl scale deployment gitops-nginx --replicas=1
```

Expected:

```text
1 replica
```

Observed:

```text
3 replicas immediately
```

Cause:

```text
ArgoCD selfHeal=true
```

Drift corrected instantly.

---

## Fix

No fix needed.

This validated:

```text
desired state reconciliation
automatic remediation
GitOps enforcement
```

---

# Error 6 — Port Forward Session Closed

## Problem

ArgoCD UI stopped working.

Cause:

```text
kubectl port-forward stopped
```

Browser inaccessible.

---

## Fix

Restarted:

```bash
kubectl port-forward svc/argocd-server \
-n argocd 8085:443
```

ArgoCD UI restored.

---

# Debugging Commands Used

Check application:

```bash
kubectl get applications -n argocd
```

Describe application:

```bash
kubectl describe application gitops-nginx-app -n argocd
```

Check pods:

```bash
kubectl get pods
```

Check deployment:

```bash
kubectl get deployment
```

Watch deployment:

```bash
kubectl get deployment -w
```

Check services:

```bash
kubectl get svc
```

Verify namespace:

```bash
kubectl get ns
```

---

# Key Troubleshooting Lesson

Biggest lesson:

> GitOps failures are usually caused by:

```text
bad YAML
wrong repo path
sync issues
port conflicts
misconfigured manifests
```

Always debug:

```text
ArgoCD status
kubectl output
application describe
events
logs
```
