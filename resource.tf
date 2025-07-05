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


module "eks" {
  source = "./modules/eks"
  name                = var.client
  public_subnets      = module.vpc.public_subnets
  private_subnets     = module.vpc.private_subnets
  cluster_role_arn    = module.iam.eks_cluster_role_arn
  node_role_arn       = module.iam.eks_node_role_arn
  fargate_profile_role_arn = module.iam.fargate_profile_role_arn
  eks_oidc_root_ca_thumbprint = var.eks_oidc_root_ca_thumbprint
  cluster_role_dependency = module.iam.eks_role_depends_on
  namespace_depends_on   = module.helm.namespace_depends_on
  namespace           = module.helm.namespace
  security_group_ids  = [module.security_groups.eks_security_group_id]

  depends_on = [
    module.vpc,
    module.security_groups
  ]
}
