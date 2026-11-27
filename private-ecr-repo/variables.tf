variable "repository_name" {
  type        = string
  description = "Name of the repository"
  sensitive   = false
}

variable "allowed_to_pull_principals" {
  type        = map(list(any))
  description = "Mapping of AWS principals (e.g. services or identities) that are allowed to pull from the private repository. When empty, no repository policy is created."
  default     = {}

  validation {
    condition     = alltrue([for k in keys(var.allowed_to_pull_principals) : contains(["AWS", "Service"], k)])
    error_message = "Only the keys AWS and Service are allowed"
  }
}

variable "lifecycle_policy_max_image_count" {
  type        = number
  description = "Maximum number of tagged images to keep. Older tagged images will be deleted."
}
