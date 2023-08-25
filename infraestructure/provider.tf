provider "aws" {
    region = var.aws_region
}

# Centralizar controle de versão da arquitetura em um bucket S3
terraform {
    backend "s3" {
        bucket = "vi-terraform-state-bucket"
        key = "state/terraform_state.tfstate"
        region = "us-east-1"
    }
}