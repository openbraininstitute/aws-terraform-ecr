variable "iam_user_name" {
  type        = string
  description = "User name of the IAM user, has to be unique"
  sensitive   = false
}

variable "repository_names" {
  type        = list(string)
  description = "Names of the public ECR repositories to which the user needs upload access"
  sensitive   = false
}
