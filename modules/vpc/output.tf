output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets" {
  value = aws_subnet.pub-subs[*].id
}

output "private_subnets" {
  value = aws_subnet.pri-subs[*].id
}