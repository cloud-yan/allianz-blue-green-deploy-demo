variable "aws_region" {
  description = "The AWS region to deploy the ECR repository."
  type        = string
}

variable "ecr_repo_name" {
  description = "The name of the ECR repository."
  type        = string
}

variable "image_tag_mutability" {
  description = "The image tag mutability setting for the ECR repository."
  type        = string
}
