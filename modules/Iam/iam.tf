# Creating eks cluster iam role and attaching cluster policy

resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.client}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}



# Creating fargate pod role for eks and attaching fargate pod execution policy

resource "aws_iam_role" "fargate_profile_role" {
  name = "${var.client}-eks-fargate-profile-role-react"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_fargate_pod_execution_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_profile_role.name
}



# Creating ec2 iam role for eks worker node and attaching (node,cni,ecr) policies.

resource "aws_iam_role" "eks_node_role" {
  name = "${var.client}-eks-node-group-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ecr_read_only_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


# Creating web-identity role for load balancer controller and backend flask pod

resource "aws_iam_role" "lb_pod_iam_role" {
  name = "${var.client}-lbc-flaskpod-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${var.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {
            "${var.aws_iam_openid_connect_provider_extract_from_arn}:aud": "sts.amazonaws.com",            
            "${var.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller",
            "${var.aws_iam_openid_connect_provider_extract_from_arn}:sub": "system:serviceaccount:backend:flask-sa"
          }
        }        
      },
    ]
  })

  tags = {
    Name = "${var.client}-lbc-flask-app-role"
  }
}

# attaching aws loadbalanacer controller Policy to role

resource "aws_iam_role_policy_attachment" "lbc_policy_attach" {
  role       = aws_iam_role.lb_pod_iam_role.name
  policy_arn = "arn:aws:iam::058264249757:policy/AwsLoadBalancerControllerPolicy"
}

resource "aws_iam_role_policy_attachment" "lbc_policy_attach" {
  role       = aws_iam_role.lb_pod_iam_role.name
  policy_arn = "arn:aws:iam::058264249757:policy/FlaskSecretsManagerPolicy" 
}


