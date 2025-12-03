variable "aws_region" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "public_subnets" {}
variable "private_subnets" {}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "nginx-web-server"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t4g.micro"
}