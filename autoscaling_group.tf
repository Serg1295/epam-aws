###############################################################
# Autoscaling group
###############################################################
resource "aws_launch_configuration" "EPAM_ASG_conf" {
  name_prefix   = "EPAM_ASG_conf"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = local.instance_type
  security_groups = [aws_security_group.ALB_SG.id]
  user_data     = "${file("UserData.sh")}"
  associate_public_ip_address = true
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_attachment" "epam_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.EPAM_ASG.id
  lb_target_group_arn    = aws_lb_target_group.EPAM_ALB_Target.arn
}
###############################################################

resource "aws_autoscaling_group" "EPAM_ASG" {
  name                      = "EPAM_ASG"
  max_size                  = local.asg_max_size
  min_size                  = local.asg_min_size
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = local.asg_desired_size
  force_delete              = true
  launch_configuration      = aws_launch_configuration.EPAM_ASG_conf.name
  vpc_zone_identifier       = module.vpc.public_subnets

  tag {
    key                 = "Name"
    value               = local.name
    propagate_at_launch = "true"
  }
}
