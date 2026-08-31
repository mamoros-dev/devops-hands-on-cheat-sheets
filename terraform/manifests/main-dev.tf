terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Configuration recommended for Backend remoto S3 + DynamoDB (optional)
  # backend "s3" {
  #   bucket         = "my-tf-state-bucket"
  #   key            = "dev/terraform.tfstate"
  #   region         = "eu-west-1"
  #   dynamodb_table = "terraform-locks"
  # }
}

provider "aws" {
  region = var.aws_region
}

module "app_stack" {
  source = "../../modules/aws_app_stack"

  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  instance_type      = var.instance_type
  ami_id             = var.ami_id
}