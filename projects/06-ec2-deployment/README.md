# 06 - EC2 Deployment

## Objective 
Deploy a Dockerized application from DockerHub onto AWS EC2 instance and expose it publicly using port mapping `8081:8080`.

---

## Tools Used
- AWS EC2
- Ubuntu
- Docker
- DockerHub

---

## Deployment Flow

DockerHub -> EC2 Instance -> Docker Pull -> Container Run -> Public Access via EC2 IP

---

## Project Structure

```text
06-ec2-deployment/
|-README.md
|-scripts/
| |-deploy.sh
| |-cleanup.sh
|-screenshots/

## Docker Image Used

`araheman/dockerhub-pipeline-app:latest`

## Port Mapping 

`Host:Container = 8081:8080`

This means:
- EC2 listens on port `8081`
- container app listens on port `8080`

---

## Prerequisites 
- AWS EC2 instance running Ubuntu
- Docker installed on EC2
- Security group allows:
	- SSH on port 22
	- Custom TCP on port 8081
- DockerHub image available

---

## Docker Installation on EC2

- `sudo apt update`
- `sudo apt install -y enable docker
- `sudo systemctl enable docker`
- `sudo systemctl start docker`
- `sudo usermod -aG docker ubuntu
- `newgrp docker`

---

## Manual Deployment

`docker pull araheman/dockerhub-pipeline-app:latest`
`docker run -d --name ec2-app -p 8081:8080 araheman/dockerhub-pipeline-app:latest

---

## Verification
## From EC2

`curl http://localhost:8081`

## From Browser

`http://<EC2-PUBLIC-IP>:8081`
`http://3.7.73.202:8081`

Expected output:
`DockerHub pipeline app is running | served-by=b5f33aa63ad1`

---

## Common Errors and Fixes

## Error: site not reachable from browser

Cause:
- Security group does not allow port 8081
Fix: 
- Add inbound rule for Custom TCP port 8081 from `0.0.0.0/0`

## Error: container exits immediately 

Cause:
- app failed to start
Fix:
- `docker logs ec2-app`

## Error :port already allocated 

Cause:
- another container already using port 8081
Fix:
- `docker ps`
- `docker stop <container>
- `docker rm <container>`

## Error: permission denied while using Docker

Cause:
- current user not in docker group
Fix:
- `sudo usermod -aG docker ubuntu`
- `newgrp docker`

---

## Learning Outcome
This Project demonstrates:
- pulling images from DockerHub
- deploying containers on AWS EC2
- exposing applications via port mapping
- validating deployment through public IP

---

## Interview Questions

## 1. Why deploy from DockerHub instead of building directly on EC2?
It ensures the same tested image is deployed everywhere and separates build from deployment.

## 2. Why use `8081:8080`?
Port `8080` is used by the application inside the container, while `8081` is the external host port exposed on the EC2 instance.

## 3. Why is the security group important?
Even if the container is running, the application will not be reachable publicly unless the EC2 security group allows incoming traffic on that port.

## 4. How do you verify whether the issue is in Docker or in AWS networking?
First test locally on EC2 using `curl localhost:8081`. If that works, the issue is likely the security group or firewall. If it fails, the issue is likely container-related.

