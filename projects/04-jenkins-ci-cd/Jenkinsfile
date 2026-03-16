pipeline {
  agent any
  
  options {
    timestamps()
    disableConcurrentBuilds()
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  parameters {
    choice(name: 'APP_ENV', choices: ['dev', 'staging', 'prod'], description: 'App environment')
    string(name: 'TAG_OVERRIDE', defaultValue: '', description: 'Optional tag (e.g., v1.0.0). Leave empty to use build-${BUILD_NUMBER}.')
  }

  environment {
    LOCAL_IMAGE    = "jenkins-cicd-lab"
    DOCKERHUB_REPO = "araheman/jenkins-cicd-lab"
  }

  stages {

    stage('System Info') {
      steps {
        sh 'whoami'
        sh 'docker --version'
        sh 'git --version'
      }
    }

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Decide Tag') {
      steps {
        script {
          env.IMAGE_TAG = params.TAG_OVERRIDE?.trim()
          if (!env.IMAGE_TAG) {
            env.IMAGE_TAG = "build-${env.BUILD_NUMBER}"
          }
          echo "Using tag: ${env.IMAGE_TAG}"
        }
      }
    }

    stage('Build Image') {
      steps {
        sh """
          docker build -t ${LOCAL_IMAGE}:${IMAGE_TAG} .
        """
      }
    }

    stage('Run Smoke Test') {
      steps {
        sh '''
	  set -e
	  
	  IMAGE="${LOCAL_IMAGE}:${IMAGE_TAG}"
	  echo "APP_ENV=${APP_ENV}"
	  echo "IMAGE=${IMAGE}"

          cid=$(docker run -d -e APP_ENV="${APP_ENV}" -p 5050:5000 "${IMAGE}")
          sleep 2

          curl -s http://localhost:5050 | grep -q '"service":"jenkins-cicd-lab"' || {
	    docker logs "$cid"
            docker rm -f "$cid"
	    exit 1
	  }

	 docker rm -f "$cid"
        '''
      }
    }

    stage('Login & Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh """
            echo "\$DOCKER_PASS" | docker login -u "\$DOCKER_USER" --password-stdin

            docker tag ${LOCAL_IMAGE}:${IMAGE_TAG} ${DOCKERHUB_REPO}:${IMAGE_TAG}
            docker push ${DOCKERHUB_REPO}:${IMAGE_TAG}

            docker tag ${LOCAL_IMAGE}:${IMAGE_TAG} ${DOCKERHUB_REPO}:latest
            docker push ${DOCKERHUB_REPO}:latest
          """
        }
      }
    }

    stage('Cleanup') {
      steps {
        sh """
          docker logout || true
          docker rmi ${LOCAL_IMAGE}:${IMAGE_TAG} || true
          docker rmi ${DOCKERHUB_REPO}:${IMAGE_TAG} || true
          docker rmi ${DOCKERHUB_REPO}:latest || true
          docker system prune -f || true
        """
      }
    }
  }

  post {
    success {
      echo "✅ Pushed ${DOCKERHUB_REPO}:${IMAGE_TAG} and :latest (APP_ENV=${params.APP_ENV})"
    }
    always {
      echo "Pipeline finished."
    }
  }
}

