variable "fargate_profile_role_arn" {}
variable "namespace" {}
variable "eks_oidc_root_ca_thumbprint" {}


variable "client" {
  description = "Name of the Client"
  type        = string
}

variable "eks_cluster_role_arn" {
    description = "eks_cluster_role_arn"
    type = string
}

variable "public_subnets" {
  description = "Name of the public_subnets"
  type        = list(string)
}

variable "security_group_id" {
    description = "security_group_ids"
    type        = list(string)
}

variable "eks_cluster_role" {
    description = "eks_cluster_role_dependency"
    type        = any
}

variable "eks_node_role_arn" {
    description = "eks_node_role_arn"
    type = string
}

variable "private_subnets" {
  description = "Name of the private_subnets"
  type        = list(string)
}

variable "namespace_depends_on" {
    description = "namespace_depends_on"
    type        = any
}

