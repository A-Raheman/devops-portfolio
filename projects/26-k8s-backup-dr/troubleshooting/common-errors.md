# Common Errors & Troubleshooting - Project 26

This documents covers issues encountered while implementing Kubernetes Backup and Disaster Recovery using Velero.

---

# Error 1 - Velero Backup Logs Failed

## Problem

Command:

```bash
velero backup logs nginx-backup
```

Error:

```text
lookup minio.velero.svc: no such host
```

---

## Cause

MinIO was running inside Kubernetes.

The DNS name:

```text
minio.velero.svc
```

is only resolvable inside the cluster.

WSL host cannot directly resolve Kubernetes internal service DNS name.

---

# Impact 

Only backup log retrieval failed.

Actual backup status:

```text
Completed
```

was unaffected.

---

## Resolution

Verified backup using:

```bash
velero backup get
```

and:

```bash
velero backup describe nginx-backup
```

instead of backup logs.

---

# Error 2 - Velero Restore Warning Retrieval Failed

## Problem

Command:

```bash
velero restore describe
```

showed:

```text
error getting warnings
error getting errors
```

---

## Cause

Same MinIO DNS resolution issue:

```text
minio.velero.svc
```

---

## Impact

Restore operation still succeeded.

Observed:

```text
Phase: Completed
Items restored: 10
```

---

## Resolution

Validated restore using:

```bash
kubectl get ns

kubectl get all -n backup-demo
```

Recovery confirmed.

---

## Error 3 - Namespace Terminating State

## Problem 

After deletion:

```bash
kubectl delete namespace backup-demo
```

namespace remained:

```text
Terminating
```

for a short time.

---

## Cause 

Kubernetes performs graceful cleanup of resources before removing namespace.

---

## Resolution 

Waited for namespace deletion to complete.

Verification:

```bash
kubectl get sns
```

Expected:

```text
backup-demo removed
```

---

# Error 4 - Backup Verification Confusion

## Problem 

Backup created successfully but uncertainty remained regarding backup validity.

---

## Resolution

Verified:

```bash
velero backup get
```

Expected:

```text
Completed
```

Additional validation:

```bash
velero backup describe nginx-backup
```

---

# Error 5 - Restore Validation

## Problem

Need to confirm restore actually recovered resources.

---

## Resolution

Checked:

```bash
kubectl get all -n backup-demo
```

Verified:

```text
Deployment restored
Service restored
Pods restored
```

Result:

```text
2/2 Running
```

---

# Useful Commands

Check backups:

```bash
velero backup get
```

Describe backup:

```bash
velero backup describe nginx-backup
```

Create backup:

```bash
velero backup create nginx-backup \
--include-namespaces backup-demo
```

Restore backup:

```bash
velero restore create \
--from-backup nginx-backup
```

Check restores:

```bash
velero restore get
```

Check namespace:

```bash
kubectl get ns
```

Check application:

```bash
kubectl get all -n backup-demo
```

---

# Key Lesson

Disaster Recovery is not:

```text
Backup only
```

It is:

```text
Backup
↓
Restore
↓
Validation
```

All three steps must be tested regularly.
