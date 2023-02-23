pipeline {
  agent {
    kubernetes{
      label 'kubeagent'
    }  
  }
  environment {
    REGISTRY = "asia-south1-docker.pkg.dev"
    GCP_PROJECT = '<My-Project-ID>'
  }
  
  stages {
    stage('Cloning Git') {
      steps {
        git branch: 'main', url: 'https://github.com/pranavdhopey/Flask-App.git'
      }
    }
    stage('Building image') {
      steps{
        script {
          def SHORT_SHA = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()    
          sh "gcloud auth configure-docker asia-south1-docker.pkg.dev --quiet"    
          sh "docker build -t $REGISTRY/$GCP_PROJECT/pranav-repo/flask-app:$SHORT_SHA -t $REGISTRY/$GCP_PROJECT/pranav-repo/flask-app:latest ."
        }
      }
    }
    stage('Push Image') {
      steps{
        script {
          def SHORT_SHA = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()     
		  sh "docker push $REGISTRY/$GCP_PROJECT/pranav-repo/flask-app:$SHORT_SHA"
		  sh "docker push $REGISTRY/$GCP_PROJECT/pranav-repo/flask-app:latest"
        }
      }
    }
    stage('Update Manifest') {
      steps{
        script {
          def SHORT_SHA = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()     
		  sh "sed -i 's|flask-app-image|$REGISTRY/$GCP_PROJECT/pranav-repo/flask-app:$SHORT_SHA|' manifest/deployment.yaml"
        }
      }
    }
	stage('Deploy Manifest') {
      steps{
        script {    
		  sh "kubectl apply -f manifest/namespace.yaml"
		  sh "kubectl apply -f manifest/deployment.yaml -f manifest/service.yaml"
        }
      }
    }
  }
}
