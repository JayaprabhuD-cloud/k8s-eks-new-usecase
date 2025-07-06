terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
      helm = {
      source = "hashicorp/helm"
      #version = "2.5.1"
      #version = "~> 2.5"
      version = "~> 2.9"
    }
      http = {
      source = "hashicorp/http"
      #version = "2.1.0"
      #version = "~> 2.1"
      version = "~> 3.3"
    }
      kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }
  backend "s3" {
    bucket = "terraform-remote-state-bucket-s3-hcl"
    key    = "usecase-eks-new/terraform.tfstate"
    region = "us-east-1" 
#    dynamodb_table = "bayer-new-terraform-remote-lock"    
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
