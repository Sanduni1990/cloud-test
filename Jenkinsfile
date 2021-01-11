pipeline {

  environment {
    registry = "sanduni/knote"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'https://github.com/Sanduni1990/cloud-test.git'
      }
    }
    stage('Build Source') {
      steps {
        sh 'mvn clean install spring-boot:run'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps{
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'dockerhub' ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "knote.yaml", kubeconfigId: "kubeconfig")
        }
      }
    }

  }

}
