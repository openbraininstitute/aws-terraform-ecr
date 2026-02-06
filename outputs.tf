output "public_ecr_github_actions_upload_credentials_workflow_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_workflow.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_workflow_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_workflow.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_core_web_app_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_core_web_app.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_core_web_app_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_core_web_app.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_single_cell_simulator_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_single_cell_simulator.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_single_cell_simulator_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_single_cell_simulator.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_hpc_resource_provisioner_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_hpc_resource_provisioner.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_hpc_resource_provisioner_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_hpc_resource_provisioner.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_kg_inference_api_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_kg_inference_api.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_kg_inference_api_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_kg_inference_api.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_me_model_analysis_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_me_model_analysis.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_me_model_analysis_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_me_model_analysis.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_accounting_service_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_accounting_service.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_accounting_service_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_accounting_service.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_sonata_cell_position_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_sonata_cell_position.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_sonata_cell_position_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_sonata_cell_position.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_virtual_lab_api_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_virtual_lab_api.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_virtual_lab_api_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_virtual_lab_api.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_thumbnail_generation_api_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_thumbnail_generation_api.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_thumbnail_generation_api_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_thumbnail_generation_api.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_entitycore_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_entitycore.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_entitycore_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_entitycore.publicecr_upload_secret_access_key
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_notebook_service_access_key_id" {
  value     = module.public_ecr_github_actions_upload_credentials_notebook_service.publicecr_upload_access_key_id
  sensitive = true
}

output "public_ecr_github_actions_upload_credentials_notebook_service_secret_access_key" {
  value     = module.public_ecr_github_actions_upload_credentials_notebook_service.publicecr_upload_secret_access_key
  sensitive = true
}

output "private_ecr_github_actions_upload_credentials_obi_notebook_image_access_key_id" {
  value     = module.private_ecr_github_actions_upload_credentials_obi-notebook_image.privateecr_upload_access_key_id
  sensitive = true
}

output "private_ecr_github_actions_upload_credentials_obi_notebook_image_secret_access_key" {
  value     = module.private_ecr_github_actions_upload_credentials_obi-notebook_image.privateecr_upload_secret_access_key
  sensitive = true
}

output "private_ecr_github_actions_upload_credentials_obi_launch_system_access_key_id" {
  value     = module.private_ecr_github_actions_upload_credentials_launch_system_family.privateecr_upload_access_key_id
  sensitive = true
}

output "private_ecr_github_actions_upload_credentials_obi_launch_system_secret_access_key" {
  value = module.private_ecr_github_actions_upload_credentials_launch_system_family.privateecr_upload_secret_access_key
  # value     = module.private_ecr_github_actions_upload_credentials_launch_system.privateecr_upload_secret_access_key
  sensitive = true
}

output "private_ecr_github_actions_upload_credentials_obi_auth_manager_access_key_id" {
  value     = module.private_ecr_github_actions_upload_credentials_auth_manager.privateecr_upload_access_key_id
  sensitive = true
}

output "private_ecr_github_actions_upload_credentials_obi_auth_manager_secret_access_key" {
  value     = module.private_ecr_github_actions_upload_credentials_auth_manager.privateecr_upload_secret_access_key
  sensitive = true
}

output "private_ecr_download_credentials_launch_family_access_key_id" {
  value     = module.private_ecr_download_credentials_launch_system_family.access_key_id
  sensitive = true
}

output "private_ecr_download_credentials_launch_family_secret_access_key" {
  value     = module.private_ecr_download_credentials_launch_system_family.secret_access_key
  sensitive = true
}

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
