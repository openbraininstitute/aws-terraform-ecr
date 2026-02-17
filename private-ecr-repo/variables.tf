variable "repository_name" {
  type        = string
  description = "Name of the repository"
  sensitive   = false
}

variable "allowed_to_pull_identities" {
  type        = list(any)
  description = "List of AWS identities that are allow to pull from the private repository"
}

variable "lifecycle_policy_max_image_count" {
  type        = number
  description = "Maximum number of images to keep. Older images will be deleted."
  default     = null
}

variable "lifecycle_policy_max_image_age_days" {
  type        = number
  description = "Maximum age in days for images. Images older than this will be deleted."
  default     = null
}
