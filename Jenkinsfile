pipeline {
  
  environment {
    registry = "sanduni/knote"
    dockerImage = ""
  }

  agent any
  tools { 
        maven 'Maven 3.0' 
  }
  stages {
    stage('Initialize') {
      steps {
        sh '''echo "PATH = ${PATH}"
              echo "M2_HOME = ${M2_HOME}"
            '''
      }
    }
    stage('Checkout Source') {
      steps {
        git 'https://github.com/Sanduni1990/cloud-test.git'
      }
    }
    stage('Build Source') {
      steps {
        sh 'mvn clean package'
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
          docker.withRegistry('https://registry.hub.docker.com', 'docker_id' ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Deploy App') {
      steps {
          sh 'kubectl apply -f kube/knote.yaml'
      }
    }

  }

}
