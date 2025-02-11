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
        Resource = [for repo in var.repository_names : "arn:aws:ecr-public::${data.aws_caller_identity.current.account_id}:repository/${repo}"]
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
