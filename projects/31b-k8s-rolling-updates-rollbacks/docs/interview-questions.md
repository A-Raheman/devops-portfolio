# Interview Questions — Mini Project 31B

## What is a Rolling Update?

A Rolling Update gradually replaces old Pods with new Pods, ensuring the application remains available during deployment.

---

## What is a Rollback?

A Rollback restores a Deployment to a previous stable revision if a new release causes issues.

---

## Difference between Rolling Update and Recreate strategy?

**Rolling Update**
- Replaces Pods gradually
- Minimal or no downtime

**Recreate**
- Terminates all old Pods first
- Starts new Pods afterward
- Causes downtime

---

## How do you monitor a deployment?

```bash
kubectl rollout status deployment/nginx-app
```

---

## How do you view deployment history?

```bash
kubectl rollout history deployment/nginx-app
```

---

## How do you roll back a failed deployment?

```bash
kubectl rollout undo deployment/nginx-app
```

---

## Explain your project.

I deployed an NGINX application, performed a rolling update to a newer image version, monitored the rollout, reviewed deployment history, and then rolled back to the previous version to validate Kubernetes' rollback capability.
