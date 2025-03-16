pipeline {
 agent any
 environment {
 GIT_REPO = 'https://github.com/vamsi-krishna-2005/assignment2new.git'
 BRANCH = 'main'
 SONARQUBE_TOKEN = credentials('sonar-token-id') // Store in Jenkins credentials
 DOCKER_IMAGE = '2022bcd0022/spring-petclinic'
 DOCKER_CREDENTIALS = 'docker-hub-credentials'
 }

stages {
stage('Checkout') {
    steps {
        retry(3) {
            bat "git config --global http.version HTTP/1.1"
            bat "git config --global http.postBuffer 1073741824"
            bat "git config --global core.compression 0"
            bat "git config --global http.lowSpeedLimit 0"
            bat "git config --global http.lowSpeedTime 999"
            echo "Cloning repository ${GIT_REPO} (branch: ${BRANCH})..."
            git branch: "${BRANCH}", url: "${GIT_REPO}"
        }
    }
}

        
        stage('Build') {
            steps {
                echo 'Building the sample application using Maven...'
                bat 'mvn clean package'
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                echo 'Running SonarQube analysis...'
                withCredentials([string(credentialsId: 'sonar-token-id', variable: 'SONAR_TOKEN')]) {
                    withSonarQubeEnv("SonarQubeServer") {
                        // Ensure the project key is provided either in the pom.xml/sonar-project.properties or here
                        // For example, if needed, add -Dsonar.projectKey=sample-service
                        bat "mvn sonar:sonar -Dsonar.login=%SONAR_TOKEN% -Dsonar.projectKey=assignment2new"
                    }
                }
            }
        }
        
        stage('Docker Build & Deploy') {
            steps {
                script {
                    echo "Building Docker image for sample-service..."
                   bat "docker build -t %DOCKER_IMAGE%:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
           steps {
             withDockerRegistry([credentialsId: "${DOCKER_CREDENTIALS}", url: ""]) {
                bat "docker push ${DOCKER_IMAGE}:latest"
              }
        }
 }
      stage('Deploy Container') {
        steps {
        sh "docker run -d -p 6000:6000 --name petclinic ${DOCKER_IMAGE}:latest"
           }
       }
}

  post {
   success {
   echo "Pipeline execution completed successfully!"
   }
     failure {
    echo "Pipeline failed!"
    }
  }
 }


  


