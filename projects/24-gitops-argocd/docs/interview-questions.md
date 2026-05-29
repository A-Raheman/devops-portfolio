# Interview Questions — Project 24 (GitOps with ArgoCD)

This document contains interview questions from beginner to advanced level based on this project.

---

# Beginner Level Questions

## 1. What is GitOps?

GitOps is a deployment methodology where:

> Git becomes the single source of truth for infrastructure and application deployment.

Instead of manually deploying applications, tools like ArgoCD continuously synchronize Kubernetes with Git.

Workflow:

```text
GitHub
   ↓
ArgoCD
   ↓
Kubernetes
```

---

## 2. What is ArgoCD?

ArgoCD is a:

```text
Declarative GitOps Continuous Delivery tool
```

used for Kubernetes.

It watches Git repositories and automatically synchronizes Kubernetes resources.

---

## 3. Why do companies use ArgoCD?

Benefits:

- automated deployments
- drift detection
- self-healing
- rollback capability
- version-controlled infrastructure
- reduced manual work

---

## 4. What problem does GitOps solve?

Traditional deployments involve:

```bash
kubectl apply
```

Problems:

- manual errors
- inconsistent deployments
- configuration drift
- poor traceability

GitOps solves this through:

```text
automation + version control
```

---

## 5. What is meant by "Git is source of truth"?

It means:

> Kubernetes should always match the configuration stored in Git.

Even if someone manually changes the cluster:

```bash
kubectl scale deployment
```

ArgoCD restores the desired state from Git.

---

# Intermediate Questions

## 6. What are the main components of ArgoCD?

### argocd-server

Provides:

```text
UI
API
authentication
```

### argocd-repo-server

Responsible for:

```text
reading Git repositories
rendering manifests
```

### application-controller

Responsible for:

```text
reconciliation
syncing desired state
```

### redis

Used for:

```text
caching
```

---

## 7. What is reconciliation in Kubernetes?

Reconciliation means:

> Continuously matching actual state with desired state.

Example:

Git says:

```yaml
replicas: 3
```

Cluster changed manually:

```bash
kubectl scale deployment app --replicas=1
```

ArgoCD reconciles:

```text
1 → 3
```

---

## 8. What is drift detection?

Drift means:

> Cluster state differs from Git desired state.

Example:

Manual deletion:

```bash
kubectl delete deployment
```

ArgoCD detects this and restores resources.

---

## 9. What is self-healing in ArgoCD?

When:

```yaml
selfHeal: true
```

is enabled, ArgoCD automatically restores Kubernetes resources if manual drift occurs.

Example from project:

```bash
kubectl scale deployment gitops-nginx --replicas=1
```

ArgoCD restored:

```text
3 replicas
```

---

## 10. What does prune: true do?

```yaml
prune: true
```

removes resources from Kubernetes if deleted from Git.

Example:

Delete manifest from Git:

```text
deployment.yaml removed
```

ArgoCD removes deployment from cluster.

---

# Advanced Questions

## 11. Explain your GitOps project architecture.

Architecture:

```text
GitHub Repository
        ↓
ArgoCD watches repository
        ↓
Detects changes
        ↓
Synchronizes Kubernetes cluster
        ↓
Maintains desired state
```

Implemented:

- automated sync
- self-healing
- drift correction
- Git-driven scaling

---

## 12. How did you test self-healing?

Manually deleted deployment:

```bash
kubectl delete deployment gitops-nginx
```

ArgoCD automatically recreated it.

Then tested drift:

```bash
kubectl scale deployment gitops-nginx --replicas=1
```

ArgoCD restored:

```text
3 replicas
```

---

## 13. How did you simulate GitOps deployment?

Updated:

```yaml
replicas: 2
```

to:

```yaml
replicas: 3
```

Committed:

```bash
git push origin main
```

ArgoCD automatically synchronized Kubernetes.

---

## 14. What issues did you face?

Issues encountered:

### Port conflict

Port 8080 occupied by Jenkins.

Fix:

```text
Used 8085
```

---

### YAML parsing issue

Wrong deployment YAML formatting.

Fix:

```yaml
containerPort: 80
```

---

### OutOfSync application

Resolved using:

```text
Refresh
Hard Refresh
Sync
```

---

## 15. Difference between Jenkins and ArgoCD?

### Jenkins

Used for:

```text
CI
building
testing
artifact generation
```

### ArgoCD

Used for:

```text
CD
Kubernetes deployment
GitOps
reconciliation
```

Modern workflow:

```text
Jenkins → Build Artifact
        ↓
Git Update
        ↓
ArgoCD Deploy
```

---

# Scenario-Based Questions

## Scenario 1

Developer manually changes deployment replicas in production.

What happens?

Answer:

ArgoCD detects drift and restores replicas defined in Git.

---

## Scenario 2

Deployment deleted accidentally.

What happens?

Answer:

ArgoCD recreates deployment automatically if selfHeal is enabled.

---

## Scenario 3

GitHub repository updated.

What happens?

Answer:

ArgoCD detects commit and synchronizes Kubernetes automatically.

---

# Rapid Fire Questions

### GitOps full form?

```text
Git Operations
```

### ArgoCD used for?

```text
Kubernetes Continuous Delivery
```

### GitOps source of truth?

```text
Git repository
```

### What is drift?

```text
Mismatch between Git and cluster state
```

### What restores drift?

```text
ArgoCD reconciliation
```

### selfHeal purpose?

```text
Automatic correction
```

### prune purpose?

```text
Delete removed resources
```

### ArgoCD namespace?

```text
argocd
```

---

# Most Important Interview Answer

If interviewer asks:

> Explain your GitOps project.

Answer confidently:

> “I implemented a GitOps workflow using ArgoCD and Kubernetes where GitHub acted as the source of truth. ArgoCD continuously monitored the repository and automatically synchronized Kubernetes resources. I tested self-healing by manually deleting deployments and creating drift through scaling changes, which ArgoCD automatically corrected. I also implemented Git-driven scaling updates where Kubernetes automatically scaled based on Git commits.”
