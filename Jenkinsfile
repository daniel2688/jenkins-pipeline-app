pipeline {
    agent any
    
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                        dir('2-terraform-eks-deployment') {
                            sh "terraform init"
                            sh "terraform apply -auto-approve"
                        }
                    }
                }
            }
        }
        
        stage("Deploy to EKS") {
            steps {
                script {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials']]) {
                        sh "aws eks update-kubeconfig --name eks-cluster"
                        sh "kubectl apply -f nginx-deployment.yaml"
                        sh "kubectl apply -f nginx-service.yaml"
                    }
                }
            }
        }
        
        stage("Print Environment Variables") {
            steps {
                script {
                    echo "AWS_DEFAULT_REGION: ${env.AWS_DEFAULT_REGION}"
                }
            }
        }
    }
}
