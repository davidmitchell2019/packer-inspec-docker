pipeline {
    
    agent any
    
    stages {
    stage("verify pre requs installed on jenkins") {
        steps {
            sh 'docker version'
            sh 'packer version'
            sh 'inspec version'
        }
    }
    stage ("Generate AWS Credentials") {
        //Need to call access-token python script here passing in username+password+role
        //May need to create virtualenv for running and install python requirements
        steps {
        withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'AWS-credentials',usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
            sh 'python access_token.py -u $USERNAME -p $PASSWORD'
            sh 'echo "to-do"'
        }
        }
    }
    stage("packer validate") {
        steps {
            sh 'packer validate -var-file=variables.json packer.json'
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
