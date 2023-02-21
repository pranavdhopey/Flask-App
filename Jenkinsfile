pipeline {
  environment {
    registry = "asia-south1-docker.pkg.dev/searce-playground-v1/pranav-repo"
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/pranavdhopey/Flask-App.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
  }
}
