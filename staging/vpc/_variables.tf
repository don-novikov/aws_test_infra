variable "aws_region" {}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "nginx-web-server"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR"
  type        = list(string)
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = list(string)
}

