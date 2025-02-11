# Outputs (Sensitive outputs should be retrieved with `terraform output -raw <name>`)
output "publicecr_upload_access_key_id" {
  value     = aws_iam_access_key.ecr_user_access_key.id
  sensitive = true
}

output "publicecr_upload_secret_access_key" {
  value     = aws_iam_access_key.ecr_user_access_key.secret
  sensitive = true
}
