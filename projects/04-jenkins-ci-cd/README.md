# Jenkins CI/CD Lab (Pipeline-as-Code)

A minimal repo to showcase Jenkins **advanced CI/CD**:
- Jenkinsfile in Git (Pipeline-as-Code)
- Parameterized builds (dev/staging/prod + optional tag)
- Docker build + smoke test
- Push to Docker Hub with build tag + `latest`
- Credentials handled via Jenkins Credentials ID: `dockerhub-creds`

## Tech
- Jenkins (Declarative Pipeline)
- Docker
- Python Flask (tiny app)

## Run locally
```bash
docker build -t jenkins-cicd-lab:local .
docker run --rm -p 5050:5000 -e APP_ENV=dev jenkins-cicd-lab:local
curl http://localhost:5050

