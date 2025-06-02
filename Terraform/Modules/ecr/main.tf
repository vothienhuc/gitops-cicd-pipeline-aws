# creating an ECR repository 
resource "aws_ecr_repository" "my_ecr_repo" {
  name                 = "my-ecr"
  image_tag_mutability = "MUTABLE"

  encryption_configuration {
    encryption_type = "AES256"
  }
  image_scanning_configuration {
    scan_on_push = true
  }
}

# the lifecycle policy to expire untagged images older than 15 days
resource "aws_ecr_lifecycle_policy" "ecr_lifecycle" {
  repository = aws_ecr_repository.my_ecr_repo.name
  policy = jsonencode({
    "rules" : [
      {
        "rulePriority" : 1,
        "description" : "Expire images older than 15 days",
        "selection" : {
          "tagStatus" : "untagged",
          "countType" : "sinceImagePushed",
          "countUnit" : "days",
          "countNumber" : 15
        },
        "action" : {
          "type" : "expire"
        }
      }
    ]
  })

}

# Allows the EKS cluster to pull/push images in ECR repo
resource "aws_iam_role_policy" "eks_node_ecr_policy" {
  name = "eks-ecr-access"
  role = var.eks_node_role_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          # pull action 
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:ListImages",
          # push actions
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          # additional action for managing the repo
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
        ],
        Resource = "*"
      }
    ]
  })
}
