provider "aws" {
  region = var.aws_region
}

resource "aws_ecr_repository" "demo_repo" {
  name                 = var.ecr_repo_name
  image_tag_mutability = var.image_tag_mutability
}
