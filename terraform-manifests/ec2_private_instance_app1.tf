#EC2 private instance config

module "ec2_private_instance_app1" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  name = "${var.Environment}-Private_instance-app1"
  depends_on = [ module.vpc ]
  ami                    = data.aws_ami.amznlinux2.id
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  for_each = toset(["0", "1"])
  subnet_id              = element(module.vpc.private_subnets, tonumber(each.key))
  #count = var.private_instance_count
  user_data = file("${path.module}/app1_install.sh")
  vpc_security_group_ids = [module.security_group_private.security_group_id]
  tags = local.common_tags
}