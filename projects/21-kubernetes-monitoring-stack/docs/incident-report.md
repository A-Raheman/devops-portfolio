# Incident Report - High CPU Usage in Kubernetes Cluster

## Incident Summary

A simulated production incident was created to test Kubernetes monitoring and alerting capabilites.

A CPU-intensive pod was intentionally deployed to generate excessive CPU utilization inside the Kubernetes cluster.

Prometheus detected the abnormal CPU usage, Grafana visualized the spike, and a custom Prometheus alert rule triggered successfully.

The incident was investigated using Kubernetes metrics and remediated by deleting the problematic pod.

---

## Incident Timeline

### Step 1 - Incident Creation

A CPU stress pod was deployed:

```bash
kubectl run cpu-stress \
 --image=busybox \
 --restart=Never \
 -- /bin/sh -c "while true; do yes > /dev/null; done"
```

Purpose:

- Simulate production CPU spike
- Test monitoring effectiveness
- Validate alerting system

---

### Step 2 - Detection

Grafana dashboard detected increased CPU utilization.

Observed symptoms:

- CPU utilization increased 
- Resource consumption abnormal
- Monitoring dashboard reflected spike

---

### Step 3 - Investigation

Resource consumption was investigated:

```bash
kubectl top pods
```

Findings:

```text
cpu-stress → ~999m CPU
```

The CPU-intensive pod was identified as the root cause.

---

### Step 4 - Alert Trigger

Custom Prometheus alert rule triggered:

```text
HighClusterCPUUsage
```

State:

```text
Pending → Firing
```

---

### Step 5 - Remediation

Problematic pod removed:

```bash
kubectl delete pod cpu-stress
```

---

### Step 6 - Resolution

Results:

- CPU usage normalized
- Alert resolved
- Cluster stabilized

---

## Root Cause Analysis

### Root Cause

Intentional CPU-intensive workload.

### Impact 

Temporary increase in cluster CPU utilization.

### Resolution

CPU-consuming pod removed.

---

## Learning Outcome

This incident simulation provided hands-on experience with:

- Kubernetes monitoring
- Incident detection
- Resource investigation
- Prometheus alerting
- Incident remediation
- Production troubleshooting workflow



