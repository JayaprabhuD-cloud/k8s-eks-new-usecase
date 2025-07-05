module "vpc" {
  source = "./modules/vpc"
  name           = var.client
  vpc_cidr_block = var.vpc_cidr_block
  
}