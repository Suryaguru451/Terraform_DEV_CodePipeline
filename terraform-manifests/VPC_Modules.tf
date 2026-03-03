#VPC Terraform module

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  #Basic details
  name = "${local.name}-${var.name}"
  cidr = var.vpc_cidr_block

  azs                 = var.availability_zones
  private_subnets     = var.private_subnets
  public_subnets      = var.public_subnets
  #Database subnets
  create_database_subnet_group  = var.vpc_create_database_subnet_group
  create_database_subnet_route_table  = var.vpc_create_database_subnet_route_table
  database_subnets    = var.database_subnets
  #Enable NAT GW for Private subnet
  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_single_nat_gateway
  
  #VPC DNS parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Name = "Public Subnet tags"
  }

  private_subnet_tags = {
    Name = "Private Subnet tags"
  }

  database_subnet_tags = {
    Name = "Database Subnet tags"
  }

  tags = {
    Owner = "Surya"
    Environment = "Test"
  }

  vpc_tags = {
    Name = "vpc-test"
  }
}