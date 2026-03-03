locals {
    owner = var.business_division
    Environment = var.Environment
    name = "${var.business_division}-${var.Environment}"
    common_tags = {
        owners = local.owner
        environment = local.Environment
    }

}