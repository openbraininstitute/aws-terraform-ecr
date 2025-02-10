# Create an IAM user for admin access on the AWS web console
resource "aws_iam_user" "public_ecr_admin_user" {
  name = "public-ecr-admin"
}

# Attach an inline policy with only public ECR admin permissions
resource "aws_iam_user_policy" "ecr_public_admin_policy" {
  name = "ECRPublicAdminPolicy"
  user = aws_iam_user.public_ecr_admin_user.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr-public:*"
        ]
        Resource = "*"
      }
    ]
  })
}

# Create a login profile for AWS Console access
resource "aws_iam_user_login_profile" "public_ecr_admin_login_profile" {
  user                    = aws_iam_user.public_ecr_admin_user.name
  password_length         = 20
  password_reset_required = false
}

output "admin_amazon_webinterface_username" {
  value = aws_iam_user.public_ecr_admin_user.name
}

output "admin_amazon_webinterface_password" {
  value     = aws_iam_user_login_profile.public_ecr_admin_login_profile.password
  sensitive = true
}
