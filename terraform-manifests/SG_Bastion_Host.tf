# Bastion Security group

module "security_group_bastion" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"
  name = "Public_bastion_SG"
  description = "Security group for Bastion instance with SSH"
  vpc_id = module.vpc.vpc_id
  #Ingress rules
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]
  #Egress rules
  tags = local.common_tags
  egress_rules = ["all-all"]

}