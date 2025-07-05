# Elatic Container Registry

resource "aws_ecr_repository" "react" {
  name = "${var.client}-react-app-repository"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.client}-react-app-repository"
  }
}

resource "aws_ecr_repository" "flask" {
  name = "${var.client}-flask-app-repository"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.client}-flask-app-repository"
  }
}