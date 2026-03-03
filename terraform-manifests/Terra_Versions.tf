terraform {
    required_version = "~> 1.14.4"
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "6.28.0"
      }
    random = {
      source = "hashicorp/random"
      version = "~> 3.8"
    }
  }
}

provider "aws" {
  region = var.aws_region
  profile = "default"
}

#Create Random Pet resource
resource "random_pet" "this" {
 length = 2
}