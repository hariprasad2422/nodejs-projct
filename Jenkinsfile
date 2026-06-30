pipeline {
    agent any

    tools {
        maven 'Maven-3.9.6'
        jdk 'JDK-17'
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
    }

    post {
        success {
            echo '✅ Pipeline completed successfully (Checkout + Build + Unit Tests)'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}
