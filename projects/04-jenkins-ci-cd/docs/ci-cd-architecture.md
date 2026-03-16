# CI/CD Architecture -- DevOps Production Lab

## Overview

This project demonstrates a production-style CI/CD piepline built using:

- Github (Source Control)
- Jenkins (Multibranch Pipeline)
- Docker (Image Build & Push)
- Docker Hub (Image Registry)
- Cloudflare Tunnel (Webhook forwarding for local setup)

---

## Architecture Flow

1. Developer pushes code to GitHub.
2. GitHub Webhook sends a POST request to:

	`/github-webhook/`

3. Cloudflare Tunnel forwards the request to:

	`http://localhost:8080`

4. Jenkins Multibranch Pipeline: 
	- Detects branch
	- Loads Jenkinsfile
	- Executes CI pipeline
5. Pipeline stages:
	- Build Docker image
	- Tag image with build number
	- Push image to Docker Hub
	- Tag `latest`

---

## Image Tagging Strategy

Images are tagged as:

- `build-<number>`
- `latest`

This ensures:
- Version traceability
- Rollback capability
- Stable production tag

---

## Post Conditions

Pipeline includes:

- `post { success {} }`
- `post { always {} }`

Ensures proper logging and cleanup after builds.

---

## Key Production Practices Implemented 

- Multibranch strategy
- Build retention (`buildDiscarder`)
- Secure credentials storage
- Paramenterized environment (APP_ENV)
- Automated webhook trigger

---

## Next Phase

Pipeline is designed to be migrated to AWS EC2 for production deployment.
