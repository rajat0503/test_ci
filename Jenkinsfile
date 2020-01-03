pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        bat(returnStatus: true, returnStdout: true, script: 'matlab_run.bat')
      }
    }
    stage('report') {
      steps {
        echo 'Completeted Execution '
      }
    }
    stage('Mail') {
      steps {
        emailext(subject: 'Jenkins Result', body: 'Execution Done', attachLog: true)
      }
    }
  }
}