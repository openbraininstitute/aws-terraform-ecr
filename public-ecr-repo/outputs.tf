output "repo_url" {
  value     = aws_ecrpublic_repository.public_repo.repository_uri
  sensitive = false
}
