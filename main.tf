terraform {

  backend "s3" {
    bucket = "alok-bucket12"
    key    = "assignment/terraform.tfstate"
    region = "us-east-1"
  }


  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.7.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "test"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-201" = "shared"
    "kubernetes.io/role/internal-elb" = "1"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-201" = "shared"
    "kubernetes.io/role/elb" = "1"
  }

}
                                                                       