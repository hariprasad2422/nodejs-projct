pipeline {
    agent any

    tools {
        maven 'Maven-3.9.6'   // Name from Global Tool Configuration
        jdk 'JDK-17'          // Optional: configure JDK if needed
    }

    environment {
        SONARQUBE_ENV = "SonarQubeServer"
        REGISTRY      = "ghcr.io/your-org-or-username"
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
                    // Build Docker image
                    sh """
                        docker build -t ${REGISTRY}/${IMAGE_NAME}:latest .
                        echo $DOCKER_PASSWORD | docker login ${REGISTRY} -u $DOCKER_USERNAME --password-stdin
                        docker push ${REGISTRY}/${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Build, SonarQube analysis, and Docker image push completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for details.'
        }
    }
}
