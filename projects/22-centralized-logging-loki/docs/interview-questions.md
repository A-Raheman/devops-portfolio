# 🎯 Interview Questions — Project 22

# Beginner Level

## 1. What is centralized logging?

Centralized logging is the process of collecting logs from multiple systems and storing them in one place for easier troubleshooting and monitoring.

Instead of checking logs pod-by-pod:

```bash
kubectl logs
```

logs are aggregated centrally.

---

## 2. Why do companies use centralized logging?

Because distributed systems generate logs from:

- multiple pods
- nodes
- services
- microservices

Checking logs manually becomes difficult.

Centralized logging helps:

- faster debugging
- incident investigation
- real-time visibility

---

## 3. What is Loki?

Loki is a log aggregation system developed by Grafana Labs.

It stores logs efficiently using labels instead of indexing full log content.

---

## 4. What is Promtail?

Promtail is a log collection agent.

It collects logs from Kubernetes nodes and forwards them to Loki.

---

## 5. What is Grafana?

Grafana is an observability platform used to visualize:

- metrics
- logs
- dashboards
- monitoring data

---

## 6. What is LogQL?

LogQL is Loki’s query language.

Example:

```logql
{app="nginx"} |= "ERROR"
```

This filters only error logs.

---

# Intermediate Level

## 7. Why use Loki instead of ELK?

### Loki

Pros:

- lightweight
- cheaper storage
- label-based indexing
- Kubernetes friendly

Cons:

- less powerful full-text search

---

### ELK

Pros:

- powerful search
- deep analytics

Cons:

- high RAM usage
- more operational overhead

---

## 8. How does Loki architecture work?

```text
Pods
 ↓
Promtail
 ↓
Loki
 ↓
Grafana
```

Promtail collects logs.

Loki stores them.

Grafana visualizes them.

---

## 9. How do you troubleshoot missing logs in Grafana?

Checklist:

```text
1. Check pods
2. Check Promtail logs
3. Verify Loki service
4. Validate datasource
5. Run LogQL query
6. Check ingestion
```

Commands:

```bash
kubectl get pods -n logging
kubectl logs -n logging <promtail-pod>
kubectl get svc -n logging
```

---

## 10. What is label-based indexing?

Unlike ELK, Loki indexes only metadata:

Examples:

```text
namespace
pod
container
job
```

This reduces storage costs.

---

# Advanced Level

## 11. How would you debug a production Kubernetes outage?

Steps:

```text
1. Check pod health
2. Check logs in Grafana
3. Filter ERROR logs
4. Identify failing service
5. Correlate events
6. Root cause analysis
```

Example query:

```logql
{namespace="production"} |= "ERROR"
```

---

## 12. Why is Promtail deployed as DaemonSet?

Because:

```text
1 pod per node
```

ensures log collection from every Kubernetes node.

---

## 13. What is the difference between monitoring and logging?

### Monitoring

Tracks:

```text
CPU
Memory
Latency
Metrics
```

Tools:

```text
Prometheus
Grafana
```

---

### Logging

Tracks:

```text
application logs
system logs
errors
events
```

Tools:

```text
Loki
ELK
Splunk
```

---

## 14. How would you reduce Loki resource consumption?

Methods:

- disable cache
- reduce retention
- use filesystem backend
- tune replicas
- avoid unnecessary indexing

---

# Scenario-Based Questions

## Scenario 1

Users report application failure.

How would you debug?

Answer:

```text
1. Open Grafana
2. Query logs
3. Filter ERROR logs
4. Identify failing pod
5. Correlate timestamps
6. Investigate root cause
```

---

## Scenario 2

Logs stopped appearing suddenly.

What would you check?

Answer:

```text
1. Promtail pod
2. Loki pod
3. datasource
4. Kubernetes services
5. Loki API
6. namespace filters
```

---

# Key Takeaway

This project provided hands-on experience in:

```text
Centralized logging
Incident troubleshooting
Log filtering
Kubernetes observability
Production debugging
```
