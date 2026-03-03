module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.0"
  name    = "${local.name}-ALB"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  load_balancer_type = "application"
  enable_deletion_protection = false
  security_groups = [module.security_group_applicationLB.security_group_id]
  tags = local.common_tags

  #target group
   target_groups = {
    my_TG1 = {
      create_attachment = false
      name_prefix                       = "my-TG1"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      #port             = 80
      tags = local.common_tags 
    }#end of mytg1

  my_TG2 = {
      create_attachment = false
      name_prefix                       = "my-TG1"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_algorithm_type     = "weighted_random"
      load_balancing_anomaly_mitigation = "on"
      load_balancing_cross_zone_enabled = "use_load_balancer_configuration"

      target_group_health = {
        dns_failover = {
          minimum_healthy_targets_count = 2
        }
        unhealthy_state_routing = {
          minimum_healthy_targets_percentage = 50
        }
      }

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

      protocol_version = "HTTP1"
      #port             = 80
      tags = local.common_tags 
    }  #End of myTG2 Block

}#End of Target group block

#listener block start
  listeners = {
   my-https = {
      port                        = 443
      protocol                    = "HTTPS"
      ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn             = module.acm.acm_certificate_arn
      #additional_certificate_arns = [module.wildcard_cert.acm_certificate_arn]

      fixed_response = {
              content_type = "text/plain"
              status_code  = 200
              message_body = "This is a fixed response for root context"
            }
      rules = {
  myapp1_rule = {
    actions = [{
    type = "weighted_forward"
    weighted_forward ={  
      target_groups  = [
        {
          target_group_key = "my_TG1"
          weight = 100
        }
      ]
      stickiness = {
        enabled = true
        duration = 3600
      }
    }
    }]
    conditions = [{
      path_pattern = {
       #host_header = {
        values = ["/app1*"]
       }
    }]
  
  }#End of my app1 rule
}      
 }     

    my-http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  }#End of HTTPS listener

}




resource "aws_lb_target_group_attachment" "my_TG1_attachemnt" {
  depends_on = [ module.alb ]
  for_each = {for k, v in module.ec2_private_instance_app1: k => v}
  target_group_arn = module.alb.target_groups["my_TG1"].arn
  target_id        = each.value.id
  port             = 80
}


#resource "aws_lb_target_group_attachment" "my_TG2_attachemnt" {
#  depends_on = [ module.alb ]
#  for_each = {for k, v in module.ec2_private_instance_app2: k => v}
#  target_group_arn = module.alb.target_groups["my_TG2"].arn
#  target_id        = each.value.id
#  port             = 80
#}

#k = ec2_instance
#v = ec2_instance_details

#Temp outputs

output "zz_ec2_private_app1" {
  value = {for ec2_instance, ec2_instance_details in module.ec2_private_instance_app1: ec2_instance => ec2_instance_details}
}

#output "zz_ec2_private_app2" {
 # value = {for ec2_instance, ec2_instance_details in module.ec2_private_instance_app2: ec2_instance => ec2_instance_details}
#}
