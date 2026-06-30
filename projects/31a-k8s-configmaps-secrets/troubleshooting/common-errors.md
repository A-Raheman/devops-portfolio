# Common Errors — Mini Project 31A

## Error

```text
CreateContainerConfigError
```

### Cause

Deployment referenced a ConfigMap key that did not exist.

Example:

```yaml
APP_VERSION
```

was missing from the ConfigMap.

### Symptoms

- Pod stuck in `CreateContainerConfigError`
- Container never starts
- Logs unavailable

### Diagnosis

```bash
kubectl describe pod <pod-name> -n config-demo
```

Observed:

```text
couldn't find key APP_VERSION in ConfigMap
```

### Resolution

1. Update ConfigMap
2. Apply changes

```bash
kubectl apply -f manifests/app-configmap.yaml
```

3. Restart Deployment

```bash
kubectl rollout restart deployment config-secret-app -n config-demo
```

4. Verify

```bash
kubectl logs -n config-demo deploy/config-secret-app
```

---

## Useful Commands

```bash
kubectl get configmap -n config-demo

kubectl get secret -n config-demo

kubectl describe pod <pod-name> -n config-demo

kubectl exec -it <pod-name> -n config-demo -- env

kubectl rollout restart deployment config-secret-app -n config-demo
```
