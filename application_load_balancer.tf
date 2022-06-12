######################################################################
# Application load balancer
######################################################################
resource "aws_lb" "EPAM_ALB" {
  name               = "epam-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ALB_SG.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false


  tags = local.tags
}
#######################################################################
resource "aws_lb_listener" "EPAM_ALB_Listener" {
  load_balancer_arn = aws_lb.EPAM_ALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.EPAM_ALB_Target.arn
  }
}
#######################################################################
resource "aws_lb_target_group" "EPAM_ALB_Target" {
  name     = "epam-alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}