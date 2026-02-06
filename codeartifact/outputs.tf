output "domain_name" {
  description = "CodeArtifact domain name"
  value       = aws_codeartifact_domain.main.domain
}

output "domain_arn" {
  description = "CodeArtifact domain ARN"
  value       = aws_codeartifact_domain.main.arn
}

output "repositories" {
  description = "Map of repository names to their details"
  value = {
    for name, repo in aws_codeartifact_repository.repos : name => {
      arn      = repo.arn
      endpoint = "https://${aws_codeartifact_domain.main.domain}-${data.aws_caller_identity.current.account_id}.d.codeartifact.${var.aws_region}.amazonaws.com/pypi/${name}/simple/"
    }
  }
}

output "read_policy_arn" {
  description = "IAM policy ARN for read access"
  value       = aws_iam_policy.codeartifact_read.arn
}

output "github_roles" {
  description = "Map of GitHub repo to OIDC role ARN"
  value = {
    for key, role in aws_iam_role.github_actions_publish : key => {
      role_arn          = role.arn
      codeartifact_repo = local.github_repo_roles_map[key].ca_repo
      github_repo       = local.github_repo_roles_map[key].gh_repo
    }
  }
}

output "github_read_role_arn" {
  description = "Read-only OIDC role ARN for all GitHub repos in the organization"
  value       = aws_iam_role.github_actions_read.arn
}
