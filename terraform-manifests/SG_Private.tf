# Private Security group

module "security_group_private" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"
  name = "Private_bastion_SG"
  description = "Security group for Bastion instance with SSH"
  vpc_id = module.vpc.vpc_id
  #Ingress rules
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_rules = ["ssh-tcp", "http-80-tcp"]

  #Egress rules
  tags = local.common_tags
  egress_rules = ["all-all"]

}