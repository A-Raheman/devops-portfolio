# Interview Questions — Project 28

## Beginner Questions

### What is Horizontal Pod Autoscaler (HPA)?

HPA automatically scales pod replicas based on resource utilization.

---

### What metrics can HPA use?

Examples:

```text
CPU
Memory
Custom Metrics
External Metrics
```

---

### What is Metrics Server?

Metrics Server collects CPU and memory utilization data used by HPA.

---

### What is self-healing?

Self-healing is Kubernetes' ability to automatically recover failed workloads.

---

## Intermediate Questions

### What is the difference between requests and limits?

Requests:

```text
Minimum guaranteed resources
```

Limits:

```text
Maximum allowed resources
```

---

### Why are requests important for HPA?

HPA calculates utilization relative to CPU requests.

Without requests:

```text
Scaling may not behave correctly
```

---

### What happens when CPU exceeds HPA threshold?

Example:

```text
Target = 50%
Current = 80%
```

HPA increases replicas.

---

### What happens when traffic decreases?

HPA gradually reduces replicas.

---

## Advanced Questions

### Explain your autoscaling project.

Answer:

> I deployed a Kubernetes application with resource requests and limits, configured Metrics Server and HPA, generated load to trigger automatic scaling, validated scale-down after removing load, and demonstrated self-healing by deleting a pod and observing Kubernetes recreate it automatically.

---

### How does Kubernetes provide self-healing?

Answer:

> Deployments use ReplicaSets to maintain the desired number of replicas. When a pod fails or is deleted, Kubernetes detects the difference between desired and actual state and automatically creates a replacement pod.

---

### How does HPA work?

Answer:

> HPA continuously reads metrics from Metrics Server. If resource utilization exceeds configured thresholds, HPA increases replica count. When utilization decreases, HPA reduces replicas.

---

### What is resilience?

Answer:

> Resilience is the ability of a system to continue operating and recover automatically when failures occur.

---

## Scenario Questions

### Scenario 1

Application receives 10x traffic.

What happens?

Answer:

```text
HPA scales pods
Application capacity increases
```

---

### Scenario 2

A pod crashes.

What happens?

Answer:

```text
ReplicaSet creates replacement pod
```

---

### Scenario 3

Container exceeds memory limit.

What happens?

Answer:

```text
OOMKilled
```

---

### Scenario 4

Metrics Server fails.

Impact?

Answer:

```text
HPA cannot make scaling decisions
```

---

## Rapid Fire

HPA?

```text
Horizontal Pod Autoscaler
```

Metrics Provider?

```text
Metrics Server
```

Self-Healing?

```text
Automatic Recovery
```

Requests?

```text
Guaranteed Resources
```

Limits?

```text
Maximum Resources
```

Pod Crash?

```text
ReplicaSet Recreates Pod
```

Scaling Out?

```text
Increase Replicas
```

Scaling In?

```text
Decrease Replicas
```
