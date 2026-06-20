pipeline {
    agent any

    tools {
        maven 'Maven-3.9.6'
        jdk 'JDK-17'
    }

    environment {
        SONARQUBE_ENV = "SonarQubeServer"
        REGISTRY      = "ghcr.io/hariprasad2404"
        IMAGE_NAME    = "lab-nodejs-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Unit Tests') {
            steps {
                sh 'mvn test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv("${SONARQUBE_ENV}") {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    sh """
                        docker build -t ${REGISTRY}/${IMAGE_NAME}:latest .

                        echo "Hariprasad@100" | docker login ${REGISTRY} \
                        -u hariprasad2404 --password-stdin

                        docker push ${REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh """
                        kubectl set image deployment/nodejs-deployment \
                        nodejs-container=${REGISTRY}/${IMAGE_NAME}:latest

                        kubectl rollout status deployment/nodejs-deployment
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline completed successfully (Build + Sonar + Docker + K8s Deploy)'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}
