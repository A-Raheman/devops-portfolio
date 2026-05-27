# Incident Report - Loki Logs Not Visible in Grafana

## Incident Summary

During the implementation of a centralized logging system using **Loki + Promtail + Grafana**, logs were not appearing in Grafana despite all Kubernetes pods being in a running state.

The issue impacted the ability to investigate logs centrally and delayed observability setup.

---

# Incident Details

| Field | Information |
|--------|-------------|
| Incident ID | LOG-001 |
| Severity | Medium |
| Environment | Local Kubernetes (Minikube) |
| Monitoring Stack | Loki, Promtail, Grafana |
| Status | Resolved |

---

# Problem Statement

Grafana was unable to display logs from Loki. 

Observed error:

```text
Unable to connect with Loki.
Please check the server logs for more details.
```

Additionally, Promtail logs showed:

```text
connection refused
```

while pushing logs to Loki.

---

# Symptoms Observed

### 1. Grafana Data Source Failure

Loki datasource connection failed.

Observed issue:

```text
Unable to connect with Loki
```

---

### 2. Promtail Retry Errors

Promtail repeatedly failed to push logs.

Observed logs:

```text
error sending batch, will retry
connect: connection refused
```

---

### 3. Loki Endpoint Confusion

Testing readiness endpoint returned:

```bash
curl http://localhost:3100/ready
```

Response:

```text
404 Not Found
```

This created confusion regrading Loki service accessibility.

---

# Investigation Process:

## Step 1 - Verify Kubernetes Pods

Checked logging namespace:

```bash
kubectl get pods -n logging
```

Verified:

- Loki pod running
- Promtail pod running
- Grafana pod running

No crash loops detected.

---

## Step 2 - Verify Loki Service

Checked Kubernetes services:

```bash
kubectl get svc -n logging
```

Confirmed:

```text
loki-gateway
```

service was available.

---

## Step 3 - Verify Loki Readiness

Port-forwaded Loki:

```bash
kubectl port-forward svc/loki-gateway 3100:80 -n logging
```

Validated endpoint:

```bash
curl http://localhost:3100/loki/api/v1/labels
```

Successful response confirmed Loki was functioning.

---

## Step 4 - Test Internal Kubernetes Connectivity

Validated Grafana connectivity to Loki:

```bash
kubectl exec -n logging deploy/grafana -- \
wget -qO- http://loki.logging.svc.cluster.local:3100/ready
```

Response:

```text
ready
```

This confirmed:

```text
Grafana → Loki network path was working.
```

---

## Root Cause Analysis 

### Root Cause

Incorrect Loki datasource URL in Grafana.

Initial datasource configuration pointed to an incorrect endpoint.

Correct endpoint:

```text
http://loki-gateway.logging.svc.cluster.local
```

---

# Resolution Steps

### 1. Reconfigured Grafana Datasource

Updated Loki datasource URL:

```text
http://loki-gateway.logging.svc.cluster.local
```

---

### 2. Validated Data Source

Clicked:

```text
Save & Test
```

Result:

```text
Data source successfully connected
```

---

### 3. Verified Logs

Test Query:

```logql
{namespace="kube-system"}
```

Result:

Live Kubernetes logs appeared in Grafana.

---

### 4. Simulated Production Logs

Deployed:

```text
log-generator
```

application.

Generated logs:

```text
INFO
WARNING
ERROR
```

Validated log filtering:

```logql
{app="log-generator"} |= "ERROR"
```

---

# Final Outcome

Successfully implemented centralized logging for Kubernetes using:

- Loki
- Promtail
- Grafana
- LogQL

Achieved: 

✅ Centralized log visibility

✅ Namespace-level log investigation

✅ Error filtering

✅ Real-time log streaming

✅ Production-style troubleshooting workflow

---

# Lessons Learned

### 1. Always Verify Service Endpoints

Even when pods are running, services may be misconfigured.

---

### 2. Validate Internal Kubernetes Connectivity

Use:

```bash
kubectl exec
```

to test service reachability between pods.

---

### 3. Verify Data Sources Early

Grafana datasource misconfiguration can block observability workflows.

---

### 4. Use LogQL for Faster Troubleshooting

Example:

```logql
|= "ERROR"
```

helps isolate failures quickly.

---

# Prevention Strategy

Future troubleshooting checklist:

```text
1. Check pod status
2. Check service endpoints
3. Validate port-forward
4. Verify datasource configuration
5. Test LogQL query
6. Confirm log ingestion
```

---

# Business Impact

Without centralized logging:

- Troubleshooting becomes slow
- Engineers manually inspect pods
- Incident resolution time increases

With centralized logging:

- Faster debugging
- Better visibility
- Improved incident response
- Easier Kubernetes troubleshooting
