# Interview Questions — Project 27

## Beginner Questions

### What is a deployment strategy?

A deployment strategy defines how a new application version is released to users.

---

### What is a Rolling Update?

Pods are gradually replaced with new versions without taking the application offline.

---

### What is Blue-Green Deployment?

Two identical environments exist:

```text
Blue → Current Version
Green → New Version
```

Traffic switches from Blue to Green after validation.

---

### What is Canary Deployment?

A small percentage of users receive the new version first.

If healthy:

```text
10% → 25% → 50% → 100%
```

---

## Intermediate Questions

### What is the biggest advantage of Blue-Green Deployment?

```text
Instant rollback
```

---

### What is the biggest advantage of Canary Deployment?

```text
Reduced deployment risk
```

---

### Which strategy requires more infrastructure?

```text
Blue-Green
```

because two environments run simultaneously.

---

### Which strategy is safest?

```text
Canary
```

because only a small percentage of users are exposed initially.

---

## Advanced Questions

### Explain your Blue-Green Deployment project.

Answer:

> I created separate Blue and Green deployments in Kubernetes, routed traffic using a service selector, switched traffic to Green, and validated rollback by returning traffic to Blue.

---

### Explain your Canary Deployment project.

Answer:

> I deployed a stable version with four replicas and a new version with one replica to simulate an 80/20 traffic split. After validation, I promoted the new version to production by scaling it up and scaling down the stable version.

---

### How do you achieve zero downtime deployments?

Methods:

```text
Rolling Updates
Blue-Green Deployment
Canary Deployment
```

---

### How would you rollback a failed deployment?

Blue-Green:

```text
Switch service back
```

Canary:

```text
Stop rollout
Scale down canary
```

---

## Scenario Questions

### Scenario 1

A release causes errors for users.

What do you do?

Answer:

```text
Rollback
Check logs
Check monitoring
Validate previous version
```

---

### Scenario 2

Business requires instant rollback capability.

Which strategy?

Answer:

```text
Blue-Green Deployment
```

---

### Scenario 3

Business wants to test a new version with minimal user impact.

Which strategy?

Answer:

```text
Canary Deployment
```

---

## Rapid Fire

Blue-Green?

```text
Traffic switch between environments
```

Canary?

```text
Progressive rollout
```

Fastest rollback?

```text
Blue-Green
```

Safest deployment?

```text
Canary
```

Default Kubernetes strategy?

```text
Rolling Update
```
