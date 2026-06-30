# Common Errors — Mini Project 31B

## Error 1 — Rolling Update Stuck

### Symptoms

```text
kubectl rollout status waits indefinitely
```

### Possible Causes

- Image does not exist
- Pods failing readiness checks
- Container crash
- Resource constraints

### Troubleshooting

```bash
kubectl get pods -n rollout-demo

kubectl describe pod <pod-name> -n rollout-demo

kubectl logs <pod-name> -n rollout-demo
```

---

## Error 2 — Rollback Does Not Restore Application

### Possible Causes

- No previous revision exists
- Incorrect deployment name
- Deployment was recreated instead of updated

### Verify

```bash
kubectl rollout history deployment/nginx-app -n rollout-demo
```

Rollback:

```bash
kubectl rollout undo deployment/nginx-app -n rollout-demo
```

---

## Useful Commands

```bash
kubectl rollout status deployment/nginx-app -n rollout-demo

kubectl rollout history deployment/nginx-app -n rollout-demo

kubectl rollout undo deployment/nginx-app -n rollout-demo

kubectl describe deployment nginx-app -n rollout-demo
```
