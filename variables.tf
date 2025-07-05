variable "client" {
  description = "Name of the client"
  type        = string
  default     = "Bayer" 
}

variable "vpc_cidr_block" {
  description = "Cidr range for vpc"
  type        = string
  default     = "10.0.0.0/16"
}

# EKS OIDC ROOT CA Thumbprint - valid until 2037
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "Thumbprint of Root CA for EKS OIDC, Valid until 2037"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}

variable "region" {
  description = "Name of the region"
  type        = string
  default     = "us-east-1"
}

variable "db_username" {
  description = "Name of the db_username"
  type        = string
  default     = "admin"
}

variable "database_name" {
  description = "Name of the db_name"
  type        = string
  default     = "test"
}