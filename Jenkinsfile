pipeline {
    agent any
    
    environment {
        AWS_PROFILE = 'tu_perfil_aws'
        AWS_DEFAULT_REGION = 'us-east-1'
    }
    
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    // Ejecutar los comandos de Terraform para crear el clúster EKS
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
                    // Actualizar la configuración de kubeconfig para el clúster EKS
                    sh "aws eks update-kubeconfig --name eks-cluster"
                    
                    // Desplegar una aplicación en el clúster EKS
                    sh "kubectl apply -f nginx-deployment.yaml"
                    
                    // Desplegar un servicio en el clúster EKS
                    sh "kubectl apply -f nginx-service.yaml"
                }
            }
        }
        
        // Imprimir variables de entorno
        stage("Print Environment Variables") {
            steps {
                script {
                    echo "AWS_PROFILE: ${env.AWS_PROFILE}"
                    echo "AWS_DEFAULT_REGION: ${env.AWS_DEFAULT_REGION}"
                }
            }
        }
    }
}
