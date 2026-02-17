resource "aws_ecr_lifecycle_policy" "policy" {
  count      = var.lifecycle_policy_max_image_count != null || var.lifecycle_policy_max_image_age_days != null ? 1 : 0
  repository = aws_ecr_repository.private_repo.name

  policy = jsonencode({
    rules = concat(
      var.lifecycle_policy_max_image_count != null ? [{
        rulePriority = 1
        description  = "Keep last ${var.lifecycle_policy_max_image_count} images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = var.lifecycle_policy_max_image_count
        }
        action = {
          type = "expire"
        }
      }] : [],
      var.lifecycle_policy_max_image_age_days != null ? [{
        rulePriority = 2
        description  = "Delete images older than ${var.lifecycle_policy_max_image_age_days} days"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.lifecycle_policy_max_image_age_days
        }
        action = {
          type = "expire"
        }
      }] : []
    )
  })
}
