terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  backend "s3" {
    bucket = "scaling-fastapi-backend"
    key    = "terraform.tfstate"
    region = "us-west-2"
  }
}

# Configure AWS Provider
provider "aws" {
  region = "us-west-2"
}