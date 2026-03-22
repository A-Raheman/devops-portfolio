# Incident Case 3 - Container Running but Application Not Reachable

## Issue Description 

A Docker container was running successfully, but the application was not accessible from the broswer or external requests.
Even though `docker ps` showed the container as running, the application could not be reached.

---

## Root Cause

The issue was caused by incorrect port exposure and/or network configuration.
Possible causes included:
- incorrect port mapping
- application not listening on expected port
- EC2 security group blocking traffic
- container misconfiguration

---

## Diagnosis Steps

### Step 1 - Check container status

```
docker ps
```
Observation:
Container was running.

---

### Step 2 - Test inside the host

```
curl http://localhost:8081
```
Case 1:
If this fails -> issue inside container

Case 2:
If this works -> issue is external (network/security)

---

### Step 3 - Check Logs

```
docker logs <container-name>
```
---

### Step 4 - Verify port mapping

```
docker inspect <container-name>
```

```JSON
"Ports": {
  "8080/tcp": [
    {
      "HostPort": "8081"
    }
  ]
}
```
---

### Step 5 - Check EC2 security group (if using cloud)

Verified that inbound rule allows:

```
Custom TCP -> Port 8081 -> 0.0.0.0/0
```
---

## Resolution 

Corrected port mapping and ensured application was listening on the correct port.

## Correct command

```
docker run -d -p 8081:8080 <image-name>
```
Ensured:
- container listens on 8080
- host exposes 8081

---

## Fix Applied 
- Verified application port inside container
- corrected Docker run command
- updated EC2 security group rules

---

## Verification 

### Inside EC2
```
curl http://localhost:8081
```
Successful response received.

---

## From browser
```
http://<EC2-PUBLIC-IP>:8081
```
Application was accessible externally.

---

## Prevention Strategy
- Always verify port mapping during deployment
- test locally before exposing publicly
- ensure application listens on correct internal port
- validate security group rules for cloud deployments

---

## Key Learning

A running container does not guarantee a working application. Network configuration, port mapping, and security rules must all be validated.

---

