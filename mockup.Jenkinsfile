pipeline {
    agent any

    stages {
        stage('Code scan - SAST') {
            // Blackduck for SAST, SonarQube for linters (optional)
            steps {
                script {
                    sh 'echo Code scanning...'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    sh 'echo "Building project..."'
                }
            }
        }

        stage('Test') {
            // can be skipped if the code does not have automated tests
            steps {
                script {
                    sh 'echo "Unit/Integration/E2E Testing..."'
                }
            }
        }

        stage('DAST') {
            // Cluster with ZAP and others
            steps {
                script {
                    sh 'echo "Dynamic security testing..."'
                }
            }
        }

        stage('Deploy') {
            // Possible unnecessary due to previous step
            steps {
                script {
                    sh 'echo "Deploying the app..."'
                }
            }
        }
    }
}
