provider "aws" {
  region = "us-east-1"
}

# Create an IAM User
resource "aws_iam_user" "terraform_ecr_github_actions" {
  name = "terraform-ecr-github-actions"
}

# Attach an inline policy to allow ECR management
resource "aws_iam_user_policy" "terraform_ecr_github_actions_policy" {
  name = "ObiTerraformEcrGithubActions"
  user = aws_iam_user.terraform_ecr_github_actions.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:CreateRepository",
          "ecr:PutLifecyclePolicy",
          "ecr:PutImageScanningConfiguration",
          "ecr:TagResource",
          "ecr:DeleteRepository",
          "ecr:SetRepositoryPolicy",
          "ecr:GetRepositoryPolicy"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:PutImage",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "ecr-public:CreateRegistryAlias",
          "ecr-public:DescribeRegistryAliases",
          "ecr-public:DeleteRegistryAlias"
        ]
        Resource = "*"
      }
    ]
  })
}

# Create IAM Access Key
resource "aws_iam_access_key" "terraform_ecr_github_actions_key" {
  user = aws_iam_user.terraform_ecr_github_actions.name
}

# Outputs (Sensitive outputs should be retrieved with `terraform output -raw <name>`)
output "access_key_id" {
  value     = aws_iam_access_key.terraform_ecr_github_actions_key.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.terraform_ecr_github_actions_key.secret
  sensitive = true
}
