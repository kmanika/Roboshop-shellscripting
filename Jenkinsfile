pipeline {
  agent any

  stages {

    stage('Terraform INIT') {
      steps {
        git branch: 'main', url: 'https://github.com/mahithbudida/Roboshop-terraform.git'
        sh 'cd roboshop ; terraform init'
      }
    }

    stage('Terraform Destroy') {
      steps {
        sh '''
          cd roboshop
          terraform destroy -auto-approve
        '''
      }
    }

  }
}
