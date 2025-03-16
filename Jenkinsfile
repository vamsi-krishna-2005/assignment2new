pipeline {
 agent any
 environment {
 GIT_REPO = 'https://github.com/vamsi-krishna-2005/assignment2new.git'
 BRANCH = 'main'
 SONARQUBE_URL = 'http://localhost:9000' // Update this if needed
 SONARQUBE_TOKEN = credentials('sonar-token-id') // Store in Jenkins credentials
 DOCKER_IMAGE = '2022bcd0022/spring-petclinic'
 }

