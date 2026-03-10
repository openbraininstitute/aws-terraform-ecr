# aws-terraform-ecr
Deploy ECR in AWS with Terraform

# Setup of IAM / OIDC

GitHub Actions authenticates to AWS using OIDC (no long-lived access keys). The role
`arn:aws:iam::985539765147:role/GithubTerraformEcr` is assumed via `aws-actions/configure-aws-credentials`.

The `setup-iam-users` directory still contains a Terraform script to manage any remaining IAM users
(e.g. for local/manual runs). To apply it:

```
cd setup-iam-users
terraform init -backend-config=production.config
terraform plan -var-file=production.tfvars
terraform apply -var-file=production.tfvars
```

# Public ECR alias

Each AWS account can have an Amazon ECR Public registry alias. At the
moment, this alias cannot be configured yet with Terraform.

At the moment, a request was created for the alias openbraininstitute. It's pending review at AWS.

To configure: open https://us-east-1.console.aws.amazon.com/ecr/public-registry?region=us-east-1

For more info see https://docs.aws.amazon.com/AmazonECR/latest/public/public-registry-settings.html

# Public repos and access credentials for uploading images

In main.tf, 10 public ECR repositories are created.

At the moment also a single user is created which gets upload access to all those repositories.

# Copyright
Copyright (c) 2025 Open Brain Institute
