resource "aws_launch_template" "my_launch_template" {
    name = "my_launch_template"
    description = "Launch template used for instance Autoscaling group"
    image_id = data.aws_ami.amznlinux2.id
    instance_type = var.instance_type
    vpc_security_group_ids = [module.security_group_private.security_group_id]
    key_name = var.instance_keypair
    user_data = filebase64("${path.module}/app1_install.sh")
    ebs_optimized = true
    #default_version = 1
    update_default_version = true
    block_device_mappings {
      device_name = "/dev/sda1"
      ebs {
        volume_size = 10
        delete_on_termination = true
        volume_type = "gp2"
        }
    }
    monitoring {
      enabled = true
    }
    tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "MY_ASG_template"
    }
  }

}