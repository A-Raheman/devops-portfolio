# Project Title

## Objective
Describe the goal of the project.

Example:
Build a CI/CD pipeline using Jenkins to automatically build and deploy a Dockerized application to AWS EC2.

---

## Tools Used 
- Linux
- Git
- Docker
- Jenkins
- AWS EC2

---

## Architecture 

Explain the workflow of the system.

Example flow:

Developer -> Github -> Webhook -> Jenkins Pipeline
-> Docker Build -> DockerHub Push
-> EC2 Pull Image -> Run Container

---

## Project Setup

### CLone repository

git clone <repo-url>

### Build Docker image

docker build-t app-image

### Run container

docker run -p 8080:8080 app-image

---

## Screenshots

Add screenshots of:

- Jenkins pipeline
- Docker container running
- EC2 deployment

---

## Key DevOps Concepts Demonstrated

- CI/CD pipeline
- Docker containerization
- Cloud deployment
- Automation

---

## Lessons Learned

Write what you learned from the project.

Example:
- Jenkins pipelines automate deployments
- Docker ensures consistent environments
- CI/CD reduces manual errors
