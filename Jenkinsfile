pipeline {
    agent any
    
    environment {
        // Establece las credenciales de AWS usando el ID correcto
        AWS_ACCESS_KEY_ID = credentials('aws-credentials')
        AWS_SECRET_ACCESS_KEY = credentials('aws-credentials')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('2-terraform-eks-deployment') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name eks-cluster"
                        sh "kubectl apply -f nginx-deployment.yaml"
                        sh "kubectl apply -f nginx-service.yaml"
                    }
                }
            }
        }
    }
}
