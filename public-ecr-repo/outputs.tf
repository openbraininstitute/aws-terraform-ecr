output "repo_url" {
  value     = aws_ecrpublic_repository.public_repo.repository_uri
  sensitive = false
}

output "repository_name" {
  value     = var.repository_name
  sensitive = false
}

output "repository_id" {
  value     = aws_ecrpublic_repository.public_repo.id
  sensitive = false
}

