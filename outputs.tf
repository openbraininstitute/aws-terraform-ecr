# CodeArtifact outputs
output "codeartifact_domain_name" {
  description = "CodeArtifact domain name"
  value       = module.codeartifact.domain_name
}

output "codeartifact_domain_arn" {
  description = "CodeArtifact domain ARN"
  value       = module.codeartifact.domain_arn
}

output "codeartifact_repositories" {
  description = "Map of CodeArtifact repositories with their details"
  value       = module.codeartifact.repositories
}

output "codeartifact_read_policy_arn" {
  description = "IAM policy ARN for CodeArtifact read access"
  value       = module.codeartifact.read_policy_arn
}

output "codeartifact_github_roles" {
  description = "Map of GitHub repos to their OIDC role ARNs"
  value       = module.codeartifact.github_roles
}

output "codeartifact_github_read_role_arn" {
  description = "Read-only OIDC role ARN for all GitHub repos"
  value       = module.codeartifact.github_read_role_arn
}
