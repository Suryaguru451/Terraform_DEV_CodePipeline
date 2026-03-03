resource "aws_autoscaling_policy" "target_policy" {
  name                   = "avg_cpu_policy"
  policy_type = "TargetTrackingScaling"
  depends_on = [ module.alb ]
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label =  "${module.alb.arn_suffix}/${module.alb.target_groups["my_TG1"].arn_suffix}"
    }
    
    target_value = 40.0
  }
  
  estimated_instance_warmup = 180
  autoscaling_group_name = aws_autoscaling_group.my_autoscaling_config.name
}


resource "aws_autoscaling_policy" "high_cpu" {
  name                   = "high_cpu"
  scaling_adjustment     = 4
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_autoscaling_config.name
}

#CloudWatch alarm to trigger scaling policy when above 80%
resource "aws_cloudwatch_metric_alarm" "app1_asg_cwa_cpu" {
  alarm_name          = "App1-ASG-CWA-CPUtilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  treat_missing_data = "missing"
  threshold           = 80

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_autoscaling_config.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  ok_actions = [aws_sns_topic.my_asg_SNS.arn]
  alarm_actions     = [aws_autoscaling_policy.high_cpu.arn, aws_sns_topic.my_asg_SNS.arn]
}