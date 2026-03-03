resource "aws_autoscaling_group" "my_autoscaling_config" {
  name                      = "my_autoscaling_group"
  max_size                  = 10
  min_size                  = 2
  desired_capacity          = 4
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  target_group_arns = [module.alb.target_groups["my_TG1"].arn]
  vpc_zone_identifier       = module.vpc.private_subnets
   launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = "$Latest"
  }
  instance_refresh {
    strategy = "Rolling"
  
  preferences {
    min_healthy_percentage = 50
  }
  triggers = ["desired_capacity"]
  }
  tag {
    key                 = "Test"
    value               = "Autoscaling group"
    propagate_at_launch = false
  }
}

