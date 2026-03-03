#EC2 instance variables

variable "instance_type"{
    description = "Type of instance"
    type = string
    default = "t3.micro"
}

variable "instance_keypair"{
    description = "Keypair that needs to be associated"
    type = string
    default = "Terraform_key_pair"
}


variable "private_instance_count"{
    description = "Number of private instances"
    type = number
    default = 2
}

