# Interview Questions — Project 26 (Velero Backup & Disaster Recovery)

This document contains beginner to advanced interview questions based on Kubernetes Backup and Disaster Recovery concepts.

---

# Beginner Questions

## 1. What is Velero?

Velero is an open-source Kubernetes backup and disaster recovery tool.

It is used to:

- backup Kubernetes resources
- restore deleted workloads
- migrate clusters
- recover from failures

---

## 2. Why is Velero needed?

Without backups:

```text
Namespace Deleted
      ↓
Permanent Loss
```

With Velero:

```text
Namespace Deleted
      ↓
Restore Backup
      ↓
Application Recovered
```

---

## 3. What resources can Velero backup?

Examples:

```text
Namespaces
Deployments
Services
ConfigMaps
Secrets
Persistent Volumes
```

---

## 4. Where are Velero backups stored?

Common storage locations:

```text
AWS S3
Azure Blob Storage
Google Cloud Storage
MinIO
```

In this project:

```text
MinIO
```

was used.

---

## 5. What is Disaster Recovery?

Disaster Recovery (DR) is the process of restoring services after a failure or outage.

Goal:

```text
Minimize downtime
Restore operations
```

---

# Intermediate Questions

## 6. What is RPO?

RPO:

```text
Recovery Point Objective
```

Definition:

Maximum acceptable amount of data loss.

Example:

```text
Backup every 1 hour
```

Maximum loss:

```text
1 hour
```

---

## 7. What is RTO?

RTO:

```text
Recovery Time Objective
```

Definition:

Maximum acceptable time required to recover services.

Example:

```text
Restore application within 15 minutes
```

---

## 8. What is the difference between Backup and Disaster Recovery?

Backup:

```text
Create recoverable copy
```

Disaster Recovery:

```text
Use backup to recover services
```

---

## 9. How did you test Velero?

Workflow:

```text
Deploy Application
       ↓
Create Backup
       ↓
Delete Namespace
       ↓
Restore Backup
       ↓
Validate Recovery
```

---

## 10. How do you verify a Velero backup?

Commands:

```bash
velero backup get
```

and

```bash
velero backup describe <backup-name>
```

Expected:

```text
Completed
```

---

# Advanced Questions

## 11. Explain your Velero project.

Answer:

> I implemented Kubernetes Backup and Disaster Recovery using Velero and MinIO. I deployed a sample application, created a namespace backup, simulated a disaster by deleting the namespace, restored the backup, and validated successful recovery of deployments, services, and pods.

---

## 12. How did you validate the restore?

Commands:

```bash
kubectl get ns

kubectl get all -n backup-demo
```

Verified:

```text
Namespace restored
Deployment restored
Service restored
Pods restored
```

---

## 13. What happened when backup logs failed?

Issue:

```text
lookup minio.velero.svc
```

Cause:

```text
Kubernetes internal DNS
not resolvable from WSL host
```

Impact:

```text
Backup still succeeded
```

---

## 14. What production storage is typically used?

Common options:

```text
AWS S3
Azure Blob
Google Cloud Storage
```

MinIO is often used for:

```text
local labs
on-premises environments
```

---

## 15. What would you backup in production?

Examples:

```text
Namespaces
Persistent Volumes
Databases
Secrets
ConfigMaps
```

---

# Scenario Questions

## Scenario 1

A namespace is accidentally deleted.

What do you do?

Answer:

```text
Locate backup
Restore namespace
Validate workloads
Verify service recovery
```

---

## Scenario 2

Backup completed but application still unavailable after restore.

What do you check?

Answer:

```text
Pods
Services
Events
Ingress
Restore status
```

---

## Scenario 3

Business requires recovery within 10 minutes.

Which metric is relevant?

Answer:

```text
RTO
```

---

## Scenario 4

Business accepts losing at most 30 minutes of data.

Which metric is relevant?

Answer:

```text
RPO
```

---

# Rapid Fire

### Velero purpose?

```text
Backup and restore Kubernetes
```

### RPO?

```text
Recovery Point Objective
```

### RTO?

```text
Recovery Time Objective
```

### Backup status command?

```bash
velero backup get
```

### Restore status command?

```bash
velero restore get
```

### Local backup storage used?

```text
MinIO
```

### Production backup storage?

```text
AWS S3
```

---

# Most Important Interview Answer

If interviewer asks:

> What happens if a Kubernetes namespace is accidentally deleted?

Answer:

> I can recover it using Velero backups. In my project, I backed up a namespace, deleted it completely, restored it using Velero, and verified successful recovery of deployments, services, and running pods.
