# aws-terraform-ecr
Deploy ECR in AWS with Terraform

# Setup of IAM user

An IAM user was created which has the necessary rights to run the terraform scripts from GitHub
actions: mainly creating ECR registries and access rights, and configuring
an alias for the registry. The access key is stored as a secret in an
environment in the gitHub repo and in pass.

In case you need to run the terraform script to create that user again:

* Log in with the email address of the 'root user' of your AWS account
* At IAM -> Manage access keys: create an access key, to create the IAM
  user which will have the rights to deploy ECR with terraform from GitHub
  actions.
* Export those variables and run the script to create the IAM user
  and show the access key ID and secret of that IAM user

```
cd setup-iam-users
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
terraform init
terraform apply

terraform output -raw access_key_id
terraform output -raw secret_access_key
```

# Copyright
Copyright (c) 2025 Open Brain Institute

