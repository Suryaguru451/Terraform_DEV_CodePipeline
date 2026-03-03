#Autoscaling notification

resource "aws_autoscaling_notification" "my_asg_notification" {
  group_names = [aws_autoscaling_group.my_autoscaling_config.id]

  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]

  topic_arn = aws_sns_topic.my_asg_SNS.arn
}



##SNS Topic

resource "aws_sns_topic" "my_asg_SNS" {
  name = "my_asg_SNS_topic${random_pet.this.id}"
}


##SNS subscription
resource "aws_sns_topic_subscription" "myasg_SNS_topic_subscription" {
  topic_arn = aws_sns_topic.my_asg_SNS.arn
  protocol  = "email"
  endpoint  = "suryaguru451@gmail.com"
}