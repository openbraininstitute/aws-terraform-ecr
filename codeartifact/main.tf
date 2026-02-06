resource "aws_codeartifact_domain" "main" {
  domain = var.domain_name
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
