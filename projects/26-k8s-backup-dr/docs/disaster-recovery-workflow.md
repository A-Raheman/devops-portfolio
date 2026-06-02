# Disaster Recovery Workflow - Project 26

## Overview 

This document explains the backup and disaster recovery workflow implemented using Velero.

The objective was to protect Kubernetes workflows from accidental deletion and recover them quickly.

---

# Why Disaster Recovery Matters

Production failures can occur because of:

- accidental namespace deletion
- failed deployments
- cluster corruption
- infrastruture failures
- human error

Without backups:

```text
Application Deleted
       ↓
Permanent Loss
```

With backups:

```text
Application Deleted
       ↓
Restore Backup
       ↓
Application Recovered
```

---

# Project Architecture

```text
Kubernetes Application
         ↓
Velero Backup
         ↓
MinIO Storage
         ↓
Disaster Simulation
         ↓
Namespace Deleted
         ↓
Velero Restore
         ↓
Application Recovered
```

---

# Backup Workflow

## Step 1

Application deployed:

```text
backup-demo namespace
```

Resources:

```text
Deployment
Service
Pods
```

---

## Step 2

Backup created:

```bash
velero backup create nginx-backup \
--include-namespaces backup-demo
```

Result:

```text
Backup Completed
```

---

## Step 3

Backup verified:

```bash
velero backup get 
```

Output:

```text
Completed
```

---

# Disaster Simulation

Namespace removed:

```bash
kubectl delete namespace backup-demo
```

Result:

```text
Application deleted
Pods deleted
Services deleted
```

This simulates a real production disaster.

---

# Recovery Workflow

Restore executed:

```bash
velero restore create \
--from-backup nginx-backup
```

Verification:

```bash
velero restore get 
```

Result:

```text
Completed
```

---

# Recovery Validation 

Verified:

```bash
kubectl get all -n backup-demo
```

Recovered:

```text
Namespace 
Deployment
ReplicaSet
Pods
Service
```

Result:

```text
2/2 Pods Running
```

---

# RPO

Recovery Point Objective:

Maximum acceptable data loss.

Examples:

```text
Last successful backup
```

If backup runs every hour:

```text
Maximum loss = 1 hour
```

---

# RTO

Recovery Time Objective:

Maximum acceptable recovery duration.

Example:

```text
Backup Restore Time
```

In this project:

```text
Recovery completed within seconds
```

---

# Production Workflow

```text
Scheduled Backup
        ↓
Failure Occurs
        ↓
Restore Initiated
        ↓
Application Recovered
        ↓
Business Operations Continue
```

---


# Key Learning

Backup alone is not enough.

Production readiness requires:

```text
Backup
Restore
Validation
```

All three were successfully demonstrated in this project.

