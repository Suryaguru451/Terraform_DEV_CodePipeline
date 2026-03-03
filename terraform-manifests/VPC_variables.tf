variable "aws_region" {
    description = "Region where resources are provisioned"
    type = string
    default = "us-east-1"
  
}

variable "Environment" {
    description = "Environment where resources are provisioned"
    type = string
    default = "Testing"
  
}

variable "business_division" {
    description = "Business division branch of the Organization"
    type = string
    default = "SAP"
  
}


variable "name"{
    description = "Name of the VPC"
    type = string
    default = "Test_VPC"
}

variable "vpc_cidr_block"{
    description = "VPC CIDR block configuration"
    type = string
    default = "10.0.0.0/16"
}

variable "availability_zones"{
    description = "Availability Zone config"
    type = list(string)
    default = ["us-east-1a", "us-east-1b"]
}

variable "private_subnets"{
    description = "Private subnet config"
    type = list(string)
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets"{
    description = "Public subnet config"
    type = list(string)
    default = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "database_subnets"{
    description = "database subnet config"
    type = list(string)
    default = ["10.0.151.0/24", "10.0.152.0/24"]
}


variable "vpc_create_database_subnet_group"{
    description = "database subnet config"
    type = bool
    default = true
}

variable "vpc_create_database_subnet_route_table"{
    description = "database route table"
    type = bool
    default = false
}

variable "vpc_enable_nat_gateway"{
    description = "VPC NAT Gateway Config"
    type = bool
    default = true
}

variable "vpc_single_nat_gateway"{
    description = "VPC NAT Gateway Config"
    type = bool
    default = true
}