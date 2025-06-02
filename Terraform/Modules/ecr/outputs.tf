output "ecr_url" {
  description = "the URL of the ECR repository"
  value = aws_ecr_repository.my_ecr_repo.repository_url
}

