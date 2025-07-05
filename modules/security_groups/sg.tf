
# Creating security group for eks cluster

resource "aws_security_group" "eks" {
  name        = "${var.client}-eks-cluster-sg"
  description = "eks cluster security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.client}-eks-cluster-sg"
  }
}

# Creating security group for RDS DB

resource "aws_security_group" "rds" {
  name        = "${var.client}-rds-db-sg"
  description = "RDS database SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.client}-rds-aurora-mysql-sg"
  }
}
