variable "repository_name" {
  type        = string
  description = "Name of the repository"
  sensitive   = false
}

variable "allowed_to_pull_identities" {
  type        = list(any)
  description = "List of AWS identities that are allow to pull from the private repository"
}
