# Incident Case 1 - Port Already Allocated Error

## Issue Description

While running a Docker container during deployment, the container failed to start with the following error:
docker: Error response from daemon:
Bind for 0.0.0.0:8081 failed: port is already allocated

---

## Root Cause

The host port `8081` was already in use by another running container or process.

Docker cannot bind multiple containers to the same host port.

---

## Diagnosis Steps

### Step 1 - Check running containers

```
docker ps
```
Observation:
Another container was already using port `8081`.

---

### Step 2 - Identify conflicting container

```
docker ps | grep 8081
```
---

### Step 3 - Check container details

```
docker inspect <container-id>
```
Confirmed that port `8081` was already bound.

---

## Resolution 

### Option 1 - Stop conflicting container

```
docker run -d -p 8082:8080 <image-name>
```
---

## Fix Applied

Stopped the existing container using port `8081` and restarted the new container successfully.

---

## Verification

```
docker ps
```
Confirmed container is running.

```
curl http://localhost:8081
```
Application responded successfully. 

---

## Prevention Strategy
- Always check running containers before deployment
- Use dynamic or environment-specific ports
- Implemented container cleanup in deployment scripts

---

## Key Learning
Port conflicts are common in containerized environments. Proper container lifecycle management is essential to avoid deployment failures.

---

