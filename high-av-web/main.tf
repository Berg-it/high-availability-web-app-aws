terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0" #will allow installation of 3.0
    }
  }
}

provider "aws" {
  region     = "eu-west-3"
  access_key = var.access_key
  secret_key = var.secret_key
}