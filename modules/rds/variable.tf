variable "client" {
  description = "Name of the Client"
  type        = string
}

variable "private_subnets" {
  type = list(string)
}

variable "rds_security_group_ids" {
  type = list(string)
}

variable "db_username" {
  type = string
}

variable "database_name" {
}