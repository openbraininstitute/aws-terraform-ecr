resource "aws_ecr_repository" "private_repo" {
  name = var.repository_name

  # mutable, because otherwise we can't update `latest`
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }
}
