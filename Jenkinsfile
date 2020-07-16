pipeline {
agent{
    any
    environment {
       NULL="nothing"
    }
    stages {
    stage("verify pre requs installed on jenkins") {
        steps {
            sh 'docker version'
            sh 'packer version'
            sh 'inspec version'
        }
    }
    stage("packer validate") {
        steps {
            sh 'packer validate packer.json'
        }
    }
    stage("packer build") {
        steps {
            sh 'packer build -var-file=variables.json packer.json'
        }
    }
    }
    post {
            always {
                sh 'rm -r -f *'
            }
        }
}