resource "aws_ecr_lifecycle_policy" "policy" {
  count      = var.lifecycle_policy_max_image_count != null ? 1 : 0
  repository = aws_ecr_repository.private_repo.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire untagged images after 1 day",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Keep last ${var.lifecycle_policy_max_image_count} images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": ${var.lifecycle_policy_max_image_count}
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}
