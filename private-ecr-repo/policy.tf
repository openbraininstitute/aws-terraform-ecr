data "aws_iam_policy_document" "allow_eks_pull_from_ecr" {
  statement {
    sid    = "AllowEKSCrossAccountPullfromECR-${var.repository_name}"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.allowed_to_pull_identities
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer"
    ]
  }
}

resource "aws_ecr_repository_policy" "allow_eks_pull_from_ecr" {
  repository = aws_ecr_repository.private_repo.name
  policy     = data.aws_iam_policy_document.allow_eks_pull_from_ecr.json
}
