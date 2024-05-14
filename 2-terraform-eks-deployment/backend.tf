terraform {
  backend "s3" {
    bucket = "jensins-kubernetes-app-2024-v2-test"
    region = "us-east-1"
    key = "eks/terraform.tfstate"
  }
}

