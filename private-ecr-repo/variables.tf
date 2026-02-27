variable "repository_name" {
  type        = string
  description = "Name of the repository"
  sensitive   = false
}

variable "allowed_to_pull_principals" {
  type        = map(list(any))
  description = "Mapping of AWS principals (e.g. services or identities) that are allowed to pull from the private repository"

  validation {
    condition = anytrue([
      for k, v in var.allowed_to_pull_principals :
      contains(["AWS", "Service"], k)
    ])
    error_message = "Must specify at least one of: AWS, Service"
  }
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
