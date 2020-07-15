pipeline {
agent{
    any
    environment {
       NULL="nothing"
    }
    stages {
     stage("packer validate") {
        steps {
            sh 'packer validate packer.json'
        }
    }
    stage("packer build") {
        steps {
            sh 'packer build packer.json'
        }
    }
    }
    post {
            always {
                sh 'rm -r -f *'
            }
        }
}