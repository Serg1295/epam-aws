################################################################################
# Locals
################################################################################

locals {
  name               = var.name
  region             = var.region
  instance_type      = var.instance_type
  asg_desired_size   = var.asg_desired_size
  asg_max_size       = var.asg_max_size
  asg_min_size       = var.asg_min_size

  tags = {
    Name = local.name
  }
}     