# Transition: both the 'old style' user with access key, and 'new style' github actions role with github idp

resource "aws_iam_role" "github_actions_role" {
  name = "gh_ecr_push_${var.ecr_repository_name}"

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
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_organisation}/${var.github_repository_name}:*"
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

# Create IAM Access Key
resource "aws_iam_access_key" "ecr_user_access_key" {
  user = aws_iam_user.ecr_user.name
}

# Attach a policy to allow logging in to ECR and pushing images
resource "aws_iam_policy" "ecr_push_policy" {
  name        = "${var.iam_user_name}-ECRPushPolicy"
  description = "Allows pushing images to ECR public repository"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr-public:GetAuthorizationToken"
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
          "ecr-public:BatchCheckLayerAvailability",
          "ecr-public:PutImage",
          "ecr-public:InitiateLayerUpload",
          "ecr-public:UploadLayerPart",
          "ecr-public:CompleteLayerUpload",
          "ecr-public:DescribeRepositories"
        ]
        Resource = ["arn:aws:ecr-public::${data.aws_caller_identity.current.account_id}:repository/${var.ecr_repository_name}"]
      }
    ]
  })
}

# Attach policy to the user
resource "aws_iam_user_policy_attachment" "ecr_user_policy_attachment" {
  user       = aws_iam_user.ecr_user.name
  policy_arn = aws_iam_policy.ecr_push_policy.arn
}

# policy to allow changes on CDN S3 buckets (core-webapp-static-assets-*)
resource "aws_iam_policy" "cdn_s3_edit_policy" {
  count       = var.cdn_s3_bucket_access ? 1 : 0
  name        = "${var.iam_user_name}-CDNEditPolicy"
  description = "Allows changes on CDN S3 Bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:AbortMultipartUpload"
        ]
        Resource = "arn:aws:s3:::core-webapp-static-assets-*/*"
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "cdn_s3_edit_policy_attachment" {
  count      = var.cdn_s3_bucket_access ? 1 : 0
  user       = aws_iam_user.ecr_user.name
  policy_arn = aws_iam_policy.cdn_s3_edit_policy[0].arn
}

# Data source to get the current AWS account ID
data "aws_caller_identity" "current" {}
