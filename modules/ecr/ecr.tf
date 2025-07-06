# Elatic Container Registry

resource "aws_ecr_repository" "react" {
  name = "bayer-react-app-repository"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "bayer-react-app-repository"
  }
}

resource "aws_ecr_repository" "flask" {
  name = "bayer-flask-app-repository"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "bayer-flask-app-repository"
  }
}