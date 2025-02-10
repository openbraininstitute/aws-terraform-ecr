
variable "repository_name" {
  type        = string
  description = "Name of the repository"
  sensitive   = false
}

variable "short_name" {
  type        = string
  description = "Short name, used as title"
  sensitive   = false
}

variable "short_description" {
  type        = string
  description = "Short description, limited to 255 characters"
  sensitive   = false
}

variable "long_description" {
  type        = string
  description = "Short description, limited to 255 characters"
  sensitive   = false
}

variable "github_repo" {
  type        = string
  description = "GitHub repo URL"
  sensitive   = false
}

variable "architectures" {
  type        = list(string)
  description = "List of architectures: shown in the public AWS registry, allowed values: ARM, ARM 64, x86, x86-64"
  sensitive   = false
}

variable "operating_systems" {
  type        = list(string)
  description = "List of operating systems: shown in the public AWS registry, allowed values: Linux, Windows"
  sensitive   = false
}
