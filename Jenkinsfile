pipeline {
  agent any
  tools {
    nodejs '20.6.1'
  }
  environment {
    registry = "narendra7306/sr-node:${BUILD_NUMBER}"
    dockerImage = ""
    dockerhub_Creden = credentials('Sr-Dockerhub-Creds')
  }
  stages {
    stage('Git checkout') {
      steps {
        checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'Sr-Github-Creds', url: 'https://github.com/narendra7306/Nodejs-Github-Actions.git']])
      }
    }

    stage('Node build') {
      steps {
        sh 'npm install'
      }
    }

    stage('Docker build') {
      steps {
        script {
          dockerImage = docker.build registry
        }
      }
    }
    
    stage('Image push') {
      steps {
        sh 'docker login -u $dockerhub_Creden_USR -p $dockerhub_Creden_PSW'
        sh 'docker push ${registry}'
      }
    }

  }
}



