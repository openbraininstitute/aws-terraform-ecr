locals {
  sanitized_repo_name = replace(var.ecr_repository_name, "*", "")
  iam_user_name       = "azure_download_${local.sanitized_repo_name}"
}

resource "aws_iam_user" "download_user" {
  name = local.iam_user_name
}

resource "aws_iam_access_key" "ecr_user_access_key" {
  user = aws_iam_user.download_user.name
}

resource "aws_iam_policy" "download_policy" {
  name        = "ecr-download-policy"
  description = "Policy to allow downloading images from a private ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetAuthorizationToken"
        ]
        Resource = ["arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${var.ecr_repository_name}"]
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "azure_download_policy_attachment" {
  user       = aws_iam_user.download_user.name
  policy_arn = aws_iam_policy.download_policy.arn
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
