resource "aws_codeartifact_domain" "main" {
  domain = var.domain_name
}

# Allow staging and production accounts to obtain an auth token for this domain
resource "aws_codeartifact_domain_permissions_policy" "cross_account" {
  domain = aws_codeartifact_domain.main.domain

  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCrossAccountGetToken"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::992382665735:root", # staging
            "arn:aws:iam::671250183987:root", # production
          ]
        }
        Action   = ["codeartifact:GetAuthorizationToken"]
        Resource = "*"
      }
    ]
  })
}

# Allow staging and production accounts to read packages from each repository
resource "aws_codeartifact_repository_permissions_policy" "cross_account" {
  for_each   = var.repositories
  domain     = aws_codeartifact_domain.main.domain
  repository = each.key

  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCrossAccountRead"
        Effect = "Allow"
        Principal = {
          AWS = [
            "arn:aws:iam::992382665735:root", # staging
            "arn:aws:iam::671250183987:root", # production
          ]
        }
        Action = [
          "codeartifact:GetRepositoryEndpoint",
          "codeartifact:ReadFromRepository",
        ]
        Resource = "*"
      }
    ]
  })

  depends_on = [aws_codeartifact_repository.repos]
}

resource "aws_codeartifact_repository" "repos" {
  for_each   = var.repositories
  repository = each.key
  domain     = aws_codeartifact_domain.main.domain

  dynamic "external_connections" {
    for_each = each.value.external_connection != null ? [1] : []
    content {
      external_connection_name = each.value.external_connection
    }
  }
}
