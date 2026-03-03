#Defining outputs for ASG 

output "launch_template_id" {
    description = "Launch template ID"
    value = aws_launch_template.my_launch_template.id
  
}

output "launch_template_version" {
    description = "Launch template version"
    value = aws_launch_template.my_launch_template.latest_version
  
}

output "autoscaling_group_id" {
    description = "autoscaling group ID"
    value = aws_autoscaling_group.my_autoscaling_config.id
  
}

output "autoscaling_group_name" {
    description = "autoscaling group Name"
    value = aws_autoscaling_group.my_autoscaling_config.name
  
}

output "autoscaling_group_arn" {
    description = "autoscaling group ARN"
    value = aws_autoscaling_group.my_autoscaling_config.arn
  
}