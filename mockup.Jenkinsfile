pipeline {
    agent any

    stages {
        stage('Code scan - SAST') {
            // Blackduck for SAST, SonarQube for linters (optional)
            sh 'echo Code scanning...'
        }

        stage('Build') {
            sh 'echo "Building project..."'
        }

        stage('Test') {
            // can be skipped if the code does not have automated tests
            sh 'echo "Unit/Integration/E2E Testing..."'
        }

        stage('DAST') {
            // Cluster with ZAP and others
            sh 'echo "Dynamic security testing..."'
        }

        stage('Deploy') {
            // Possible unnecessary due to previous step
            sh 'echo "Deploying the app..."'
        }
    }
}
