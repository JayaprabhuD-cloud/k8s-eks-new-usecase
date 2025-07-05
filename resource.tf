module "vpc" {
  source = "./modules/vpc"
  name           = var.client
  vpc_cidr_block = var.vpc_cidr_block  
}

module "security_group" {
  source = "./modules/security_groups"
  name   = var.client
  vpc_id = module.vpc.vpc_id
}