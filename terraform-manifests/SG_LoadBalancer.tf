module "security_group_applicationLB" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"
  name = "ALB_SG"
  description = "Security group for Application Load balancer"
  vpc_id = module.vpc.vpc_id
  #Ingress rules
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  #Egress rules
  tags = local.common_tags
  egress_rules = ["all-all"]

}