output "repo_url" {
  value     = aws_ecr_repository.private_repo.repository_url
  sensitive = false
}

output "repository_name" {
  value     = var.repository_name
  sensitive = false
}
