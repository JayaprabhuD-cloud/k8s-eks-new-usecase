output "eks_security_group_id" {
  description = "eks sg output"
  value       = aws_security_group.eks.id
}

output "rds_security_group_id" {
  description = "rds sg output"
  value       = aws_security_group.rds.id
}
