terraform {
  required_version = "~>0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.21"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}