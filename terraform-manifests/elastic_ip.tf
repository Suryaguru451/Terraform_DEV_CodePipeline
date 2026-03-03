resource "aws_eip" "bastion_eip" {
    depends_on = [ 
        module.ec2_public_bastion,
        module.vpc
     ]
  for_each = toset(["0", "1"])
  instance = module.ec2_public_bastion[each.key].id
  domain = "vpc"
  tags = local.common_tags
}