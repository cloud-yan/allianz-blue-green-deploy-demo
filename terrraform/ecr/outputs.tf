output "ecr_repository_url" {
  value       = aws_ecr_repository.demo_repo.repository_url
  description = "The URL of your ECR repository"
}
