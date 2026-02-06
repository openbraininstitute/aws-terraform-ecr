variable "domain_name" {
  description = "CodeArtifact domain name"
  type        = string
  default     = "obi"
}

variable "repositories" {
  description = "Map of repositories to create with their external connections and credentials"
  type = map(object({
    external_connection     = optional(string)
    github_repository_names = optional(list(string), [])
  }))
  default = {
    pypi = {
      external_connection = "public:pypi"
    }
  }
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "github_organisation" {
  description = "GitHub organisation name"
  type        = string
  default     = ""
}
