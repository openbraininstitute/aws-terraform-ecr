data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "codeartifact_read" {
  name        = "CodeArtifactReadAccess"
  description = "Allow read access to CodeArtifact repositories"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codeartifact:GetAuthorizationToken",
          "codeartifact:GetRepositoryEndpoint",
          "codeartifact:ReadFromRepository"
        ]
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "sts:GetServiceBearerToken"
        Resource = "*"
        Condition = {
          StringEquals = {
            "sts:AWSServiceName" = "codeartifact.amazonaws.com"
          }
        }
      }
    ]
  })
}

locals {
  # Flatten github repos to create one role per repo per codeartifact repo
  github_repo_roles = flatten([
    for ca_repo, config in var.repositories : [
      for gh_repo in config.github_repository_names : {
        ca_repo = ca_repo
        gh_repo = gh_repo
      }
    ]
  ])
  github_repo_roles_map = {
    for item in local.github_repo_roles : "${item.ca_repo}_${item.gh_repo}" => item
  }
}

# Per-repository publish policies
resource "aws_iam_policy" "repo_publish" {
  for_each    = { for name, config in var.repositories : name => config if length(config.github_repository_names) > 0 }
  name        = "CodeArtifactPublish_${each.key}"
  description = "Allow publish access to ${each.key} repository"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codeartifact:GetAuthorizationToken",
          "codeartifact:GetRepositoryEndpoint",
          "codeartifact:ReadFromRepository"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "codeartifact:PublishPackageVersion",
          "codeartifact:PutPackageMetadata"
        ]
        Resource = aws_codeartifact_repository.repos[each.key].arn
      },
      {
        Effect   = "Allow"
        Action   = "sts:GetServiceBearerToken"
        Resource = "*"
        Condition = {
          StringEquals = {
            "sts:AWSServiceName" = "codeartifact.amazonaws.com"
          }
        }
      }
    ]
  })
}

# GitHub Actions roles - one per GitHub repo
resource "aws_iam_role" "github_actions_publish" {
  for_each = local.github_repo_roles_map
  name     = "gh_codeartifact_${each.value.ca_repo}_${each.value.gh_repo}"

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
            "token.actions.githubusercontent.com:sub" = "repo:${var.github_organisation}/${each.value.gh_repo}:*"
          },
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_publish" {
  for_each   = local.github_repo_roles_map
  role       = aws_iam_role.github_actions_publish[each.key].name
  policy_arn = aws_iam_policy.repo_publish[each.value.ca_repo].arn
}
