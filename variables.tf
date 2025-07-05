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