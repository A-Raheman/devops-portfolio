# 14 - Grafana Dashboard (Kubernetes Monitoring Visualization)

## Objective

Visualize application metrics by integrating Grafana with Prometheus and building real-time dashboards for a containerized application running on Kubernetes.

---

## Tools Used

- Grafana
- Prometheus
- Kubernetes
- Minikube
- Kubectl
- Docker
- Node.js
- Linux

---

## Project Structure

```text
14-grafana-dashboard/
├── README.md
├── k8s/
│   ├── grafana-deployment.yaml
│   └── grafana-service.yaml
└── screenshots/
```

---

## Monitoring Architecture
```
Application -> Prometheus -> Grafana Dashboard
```
---

## Overview

Grafana is used to visualize metrics collected by Prometheus.

Prometheus:

- Collects metrics
- Stores time-series data

Grafana:

- Queries Prometheus
- Displays data as dashboard

---

## Deployment Steps

### Start Minikube
```
minikube start
```
---
### Deploy Grafana
```
kubectl apply -f grafana-deployment.yaml
kubectl apply -f grafana-service.yaml
```
---
### Verify Resources
```
kubectl get pods
kubectl get svc
```
---
## Access Grafana
```
kubectl port-forward service/grafana-service 3000:3000
```
Open:
```
http://localhost:3000
```
---

## Login Credentials
```
Username: admin
Password: admin
```
---

## Connect Prometheus as Data Source

### Navigate:
```
Connections -> Data Sources -> Add data source -> Prometheus
```

### Set URL:
```
http://prometheus-service:9090
```

### Click:
```
Save & Test
```
Expected:
```
Data source is working
```
---

## Dashboard Creation

### Steps

1. Go to Dashboard -> New -> Add visualization
2. Select Prometheus data source
3. Enter query
4. Run query
5. Save dashboard

---

## Queries Used

### 1. Request Rate (RPS)
```
rate(app_http_requests_total[1m])
```
---
### 2. Requests per Route
```
sum by (route) (rate(app_http_requests_total[1m]))
```
---
### 3. Requests per Pod 
```
sum by (instance) (rate(app_http_requests_total[1m]))
```
---
### 4. Total Requests
```
sum(app_http_requests_total)
```
---

## Verification

### Generate traffic
```
for i in {1..20}; do curl -s http://localhost:8085 > /dev/null; done
```
---

### Observe in Grafana

- Dashboard updates in real-time
- Metrics increase dynamically
- Traffic spikes visible

---

## Screenshots

---

## Learning Outcome

This project demonstrates:
- Grafana deployment on Kubernetes
- Integration of Grafana with Prometheus
- Creating real-time dashboards 
- Writing PromQL queries
- Visualizing application metrics
- Understanding observability pipeline

---

## Interview Questions

### 1. What is Grafana?
Grafana is a visualization tool used to create dashboards from metrics collected by systems like Prometheus.

---
### 2. How does Grafana get data?
Grafana connects to data sources like Prometheus and queries them using PromQL.

---
### 3. What is PromQL?
PromQL is the query language used by Prometheus to retrieve and analyze metrics.

---
### 4. Why use `rate()` in queries?
`rate()` calculates the per-second change of a counter, making it useful for monitoring request traffic.

---
### 5. What is the difference between Prometheus and Grafana?
- Prometheus -> collects and stores metrics
- Grafana -> visualizes metrics

---
### 6. What challenges did you face?
- Ensure Prometheus was reachable from Grafana
- Understanding PromQL queries
- Generating meaningful traffic for visualization

---
### 7. How did you solve them?
- Used Kubernetes service DNS (`prometheus-service`)
- Tested queries in Prometheus first
- Generated traffic using curl

---

## Conclusion 

This project completes the observability stack:

Application -> Metrics -> Prometheus -> Grafana

and demonstrates real-time monitoring and visualization in a Kubernetes environment.

---

