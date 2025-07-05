module "vpc" {
  source = "./modules/vpc"
  client           = var.client
  vpc_cidr_block = var.vpc_cidr_block  
}

module "security_group" {
  source = "./modules/security_groups"
  client   = var.client
  vpc_id = module.vpc.vpc_id
}

module "ecr" {
  source = "./modules/ecr"
  client           = var.client
}