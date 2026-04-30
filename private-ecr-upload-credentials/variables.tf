variable "role_name" {
  type        = string
  description = "Optional override for the IAM role name suffix. Defaults to ecr_repository_name."
  default     = null
}

variable "iam_user_name" {
  type        = string
  description = "User name of the IAM user, has to be unique"
  sensitive   = false
}

variable "ecr_repository_name" {
  type        = string
  description = "Name of the public ECR repository to which the github action needs upload access"
  sensitive   = false
}

variable "github_organisation" {
  type        = string
  description = "GitHub organisation name"
  sensitive   = false
}

variable "github_repository_name" {
  type        = string
  description = "GitHub repository name"
  sensitive   = false
}
