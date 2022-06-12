################################################################################
# variables
################################################################################

variable "region" {
  type    = string
  default = "us-east-2"
}
variable "name" {
  type    = string
  default = "EPAM"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "asg_desired_size" {
  type    = number
  default = 2
}
variable "asg_max_size" {
  type    = number
  default = 10
}
variable "asg_min_size" {
  type    = number
  default = 1
}  