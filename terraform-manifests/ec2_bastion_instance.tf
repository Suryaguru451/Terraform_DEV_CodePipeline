#EC2 Bastion instance config

module "ec2_public_bastion" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  name = "${var.Environment}-Bastion_Host"

  ami                    = data.aws_ami.amznlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.security_group_bastion.security_group_id]
  for_each = toset(["0", "1"])

  tags = local.common_tags
}