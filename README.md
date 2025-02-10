# aws-terraform-ecr
Deploy ECR in AWS with Terraform

# Setup of IAM users

An IAM user was created which has the necessary rights to run the terraform scripts from GitHub
actions: mainly creating ECR registries and access rights, and configuring
an alias for the registry. The access key is stored as a secret in an
environment in the gitHub repo and in pass.

Another IAM user was created which has admin rights and can login into the
Amazon web console. That user is needed to set the alias for the public
registry.

In case you need to run the terraform script to create those users again:

* Log in with the email address of the 'root user' of your AWS account
* At IAM -> Manage access keys: create an access key with a secret
* Export those variables and run the script to create the IAM users:

```
cd setup-iam-users
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
terraform init

# optionally import existing values if you want to update existing resources
# or delete existing resources and recreate them (import statements not yet tested)
terraform import aws_iam_user.public_ecr_admin_user public-ecr-admin
terraform import aws_iam_user.terraform_ecr_github_actions terraform-ecr-github-actions
terraform import aws_iam_user_policy.ecr_public_admin_policy public-ecr-admin:ECRPublicAdminPolicy
terraform import aws_iam_user_login_profile.public_ecr_admin_login_profile public-ecr-admin
terraform import aws_iam_user_policy.terraform_ecr_github_actions_policy terraform-ecr-github-actions:ObiTerraformEcrGithubActions
pass github/aws-terraform-ecr/production/AWS_ACCESS_KEY_ID
terraform import aws_iam_access_key.terraform_ecr_github_actions_key aws_access_key_ID_here

terraform plan
terraform apply

terraform output -raw terraform_ecr_github_actions_access_key_id
terraform output -raw terraform_ecr_github_actions_secret_access_key
terraform output -raw admin_amazon_webinterface_username
terraform output -raw admin_amazon_webinterface_password
```

Afterwards, remove the access key which was created in the root account.

⚠️ Watch out: when using zsh, for some reason a '%' is printed after each output.

Those values are in pass:

```
pass github/aws-terraform-ecr/production/AWS_ACCESS_KEY_ID
pass github/aws-terraform-ecr/production/AWS_SECRET_ACCESS_KEY
pass services/aws/infrateam/ecr/985539765147/public-ecr-admin
```

# Public ECR alias

Each AWS account can have an Amazon ECR Public registry alias. At the
moment, this alias cannot be configured yet with Terraform.

At the moment, a request was created for the alias openbraininstitute. It's pending review at AWS.

To configure: login with the public-ecr-admin admin user and open https://us-east-1.console.aws.amazon.com/ecr/public-registry?region=us-east-1

For more info see https://docs.aws.amazon.com/AmazonECR/latest/public/public-registry-settings.html

# Copyright
Copyright (c) 2025 Open Brain Institute
