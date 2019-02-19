pipeline {
    agent any
    parameters {
      choice choices: ['KraQA', 'PTaQ', 'DebatQA'], description: 'What meetup are you on?', name: 'meetup'
    }
    stages {
        stage('Setup') {
            steps {
                git url: 'https://github.com/mkrzyzanowski/kraqa-37.git'
            }
        }
        stage('Build') {
            parallel {
            stage('Build KraQA module') {
                when {
                    equals expected: 'KraQA', actual: params.meetup
                }
                steps {
                    echo 'Building KraQA module'
                }
            }
            stage('Build PTaQ module') {
                when {
                    equals expected: 'PTaQ', actual: params.meetup
                }
                steps {
                    echo 'Building ptaq module'
                }
            }
            stage('Build All-meetups-united module') {
                steps {
                    echo 'Building AMU module'
                }
            }
        }
        }
        stage('Deploy') {
            steps {
                echo "Deploying"
            }
        }
        stage('Test') {
            steps {
                sh "./gradlew test -Dbobcat.config.contexts=zalenium-ci"
            }
        }
        stage('Release') {
            steps {
                echo 'Releasing'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'build/logs/*.log, build/allure-results/**.*, build/reports/**/**.*'
            junit 'build/test-results/**/*.xml'
            deleteDir()
        }
    }
}
