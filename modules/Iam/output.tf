output "eks_cluster_role_arn" {
  description = "eks cluster role arn"
  value = aws_iam_role.eks_cluster_role.arn
}


output "fargate_profile_role_arn" {
    description = "eks fargate profile role arn"
    value = aws_iam_role.fargate_profile_role.arn
}

output "eks_node_role_arn" {
    description = "eks node group role arn"
    value = aws_iam_role.eks_node_role.arn
}


output "lbc_flack_pod_iam_role_arn" {
    value = aws_iam_role.lb_pod_iam_role.arn
}

output "eks_role_depends_on" {
  value = aws_iam_role.eks_cluster_role
}

output "lbc_iam_depends_on" {
  value = aws_iam_role.lb_pod_iam_role
}