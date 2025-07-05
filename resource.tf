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

module "iam" {
  source = "./modules/Iam"
  name = var.name
  aws_iam_openid_connect_provider_arn = module.eks.aws_iam_openid_connect_provider_arn
  aws_iam_openid_connect_provider_extract_from_arn = module.eks.aws_iam_openid_connect_provider_extract_from_arn

  depends_on = [
    module.vpc
  ]

}