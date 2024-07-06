terraform {
  backend "s3" {
    encrypt = true
    region  = "ap-southeast-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.56"
    }

  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"
}