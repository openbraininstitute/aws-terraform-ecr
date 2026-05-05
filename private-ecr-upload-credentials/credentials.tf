# Transition: both the 'old style' user with access key, and 'new style' github actions role with github idp

resource "aws_iam_role" "github_actions_role" {
  name = replace("gh_ecr_push_${coalesce(var.role_name, var.ecr_repository_name)}", "*", "")

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub" = [for repo in var.github_repository_name : "repo:${var.github_organisation}/${repo}:*"]
          },
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}

resource "aws_iam_user" "ecr_user" {
  name = var.iam_user_name
}

# Attach a policy to allow logging in to ECR and pushing images
resource "aws_iam_policy" "ecr_push_policy" {
  name        = "${var.iam_user_name}-ECRPushPolicy"
  description = "Allows pushing images to ${var.ecr_repository_name} private ECR repository"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "sts:GetServiceBearerToken"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories"
        ]
        Resource = ["arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${var.ecr_repository_name}"]
      }
    ]
  })
}

# Attach policy to the user
resource "aws_iam_user_policy_attachment" "ecr_user_policy_attachment" {
  user       = aws_iam_user.ecr_user.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}

# Data source to get the current AWS account ID
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
