data "aws_iam_policy_document" "allow_eks_pull_from_ecr" {
  statement {
    sid    = "AllowEKSCrossAccountPullfromECR-${var.repository_name}"
    effect = "Allow"

    dynamic "principals" {
      for_each = var.allowed_to_pull_principals
      content {
        type        = principals.key
        identifiers = principals.value
      }
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
  }
}

resource "aws_ecr_repository_policy" "allow_eks_pull_from_ecr" {
  count = length(var.allowed_to_pull_principals) > 0 ? 1 : 0

  repository = aws_ecr_repository.private_repo.name
  policy     = data.aws_iam_policy_document.allow_eks_pull_from_ecr.json
}

moved {
  from = aws_ecr_repository_policy.allow_eks_pull_from_ecr
  to   = aws_ecr_repository_policy.allow_eks_pull_from_ecr[0]
}
