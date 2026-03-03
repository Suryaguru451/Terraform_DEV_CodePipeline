# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# VPC AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

#public bastion SG
output "public_security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group_bastion.security_group_id
}


output "public_security_group_name" {
  description = "The name of the security group"
  value       = module.security_group_bastion.security_group_name
}

output "public_security_group_description" {
  description = "The description of the security group"
  value       = module.security_group_bastion.security_group_description
}


#private SG
output "private_security_group_id" {
  description = "The ID of the security group"
  value       = module.security_group_private.security_group_id
}


output "private_security_group_name" {
  description = "The name of the security group"
  value       = module.security_group_private.security_group_name
}

output "private_security_group_description" {
  description = "The description of the security group"
  value       = module.security_group_private.security_group_description
}

#public Bastion instance id

output "ec2_bastion_instance_id" {
  description = "Public instance id"
  value = [for ec2public in module.ec2_public_bastion: ec2public.id]
}

#public Bastion instance IP

output "ec2_bastion_instance_ip" {
  description = "Public instance ip"
  value = [for ec2public in module.ec2_public_bastion: ec2public.public_ip]
}


#private app1 instance id

output "ec2_private_instance_app1_id" {
  description = "Private instance id"
  value = [for ec2private in module.ec2_private_instance_app1: ec2private.id]
}

#private app2 instance IP

output "ec2_private_instance_app1_ip" {
  description = "Public instance ip"
  value = [for ec2private in module.ec2_private_instance_app1: ec2private.private_ip]
}