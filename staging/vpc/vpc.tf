module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.5"

  name = var.project_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnet_cidr
  public_subnets  = var.public_subnet_cidr

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    project = var.project_name
  }
}
