#Terraform ALB variables

variable "dev_DNS_name" {
    description = "App1 DNS name"
    type = string
    default = "dev.suryatestdomain.com"
  
}

variable "app2_DNS_name" {
    description = "App2 DNS name"
    type = string
    default = "app2.suryatestdomain.com"
  
}