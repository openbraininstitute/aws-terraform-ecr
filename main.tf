
# For info, a repo has the following fields:
# * repository_name can be of type 'repo-name' or 'namespace/repo-name'
# * logo must be a png of max 500kb, with width&height between 60 and 2048 pixels: currently fixed to
# * short_description is limited to 255 characters. It's only visible once the OBI registry would become verified.
# * about_text can be a quite long markdown formatted text: fixed template at the moment
# * usage_text can be a quite long markdown formatted text: fixed template at the moment
# * operating_systems has to be a list, allowed values are 'Linux' and 'Windows'
# * architectures has to be a list, allowed values are 'ARM', 'ARM 64', 'x86', 'x86-64'
# For markdown syntax, see https://docs.aws.amazon.com/AmazonECR/latest/public/public-repository-catalog-data.html

locals {
  github_organisation = "openbraininstitute"
}

module "iam_github_oidc_provider" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
  version = "v5.60.0"
}

module "codeartifact" {
  source = "./codeartifact"

  domain_name         = local.github_organisation
  aws_region          = "us-east-1"
  github_organisation = local.github_organisation

  repositories = {
    pypi-prod = {
      external_connection     = "public:pypi"
      github_repository_names = ["Ultraliser", "NeuroMorphoMesh"]
    }
    pypi-dev = {
      external_connection     = "public:pypi"
      github_repository_names = ["Ultraliser", "NeuroMorphoMesh"]
    }
  }

  providers = {
    aws = aws.codeartifact
  }
}

module "obi-one" {
  source = "./public-ecr-repo"

  repository_name   = "obi-one"
  short_name        = "obi-one"
  short_description = "obi-one is a standardized library of functions"
  github_repo       = "https://github.com/openbraininstitute/obi-one"
  long_description  = "obi-one is a standardized library of functions + workflows for biophysically-detailed brain modeling"
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "obi-one-private" {
  source = "./private-ecr-repo"

  repository_name = "obi-one"
  allowed_to_pull_principals = { AWS = [
    "arn:aws:iam::992382665735:role/obi-one-v2-ecs-svc20251020123812886900000005", # staging
    "arn:aws:iam::671250183987:role/obi-one-v2-ecs-svc20251028124622137300000004", # production
  ] }
  lifecycle_policy_max_image_count    = 20
  lifecycle_policy_max_image_age_days = 30
}

module "private_ecr_github_actions_upload_credentials_obi_one" {
  source = "./private-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_obi_one_private"
  role_name              = "obi-one-private"
  ecr_repository_name    = module.obi-one-private.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "obi-one"
}

module "public_ecr_github_actions_upload_credentials_obi_one" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_obi_one"
  ecr_repository_name    = module.obi-one.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "obi-one"
}

module "core_web_app" {
  source = "./public-ecr-repo"

  repository_name   = "core-web-app"
  short_name        = "Core web application"
  short_description = "Core web application used by the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/core-web-app/"
  long_description  = "The core web application is the central piece of the Open Brain Institute web platform which gives access to the other components such as the virtual labs."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_core_web_app" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_core_web_app"
  ecr_repository_name    = module.core_web_app.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "core-web-app"
  cdn_s3_bucket_access   = true
}

# original name: blue-naas-single-cell
module "single_cell_simulator" {
  source = "./public-ecr-repo"

  repository_name   = "single-cell-simulator"
  short_name        = "Single Cell Simulator"
  short_description = "Single Cell Simulator used by the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/Bluenaas"
  long_description  = "This application is used within the Open Brain Institute web platform for small scale model builds, simulations and data processing"
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_single_cell_simulator" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_single_cell_simulator"
  ecr_repository_name    = module.single_cell_simulator.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "Bluenaas"
}

module "hpc_resource_provisioner" {
  source = "./private-ecr-repo"

  repository_name                     = "hpc-resource-provisioner"
  allowed_to_pull_principals          = { Service = ["lambda.amazonaws.com"], AWS = ["arn:aws:iam::130659266700:root", "arn:aws:iam::992382665735:root", "arn:aws:iam::671250183987:root", "arn:aws:iam::058264116529:root"] }
  lifecycle_policy_max_image_count    = 10
  lifecycle_policy_max_image_age_days = 30
}

module "private_ecr_github_actions_upload_credentials_hpc_resource_provisioner" {
  source = "./private-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_hpc_resource_provisioner"
  ecr_repository_name    = module.hpc_resource_provisioner.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "hpc-resource-provisioner"
}

module "accounting_service" {
  source = "./public-ecr-repo"

  repository_name   = "accounting-service"
  short_name        = "Accounting Service"
  short_description = "The accounting service of the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/accounting-service/"
  long_description  = "Handles accounting within the Open Brain Institute platform"
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_accounting_service" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_accounting_service"
  ecr_repository_name    = module.accounting_service.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "accounting-service"
}

module "sonata_cell_position" {
  source = "./public-ecr-repo"

  repository_name   = "sonata-cell-position"
  short_name        = "Sonata Cell Position"
  short_description = "The accounting service of the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/sonata-cell-position/"
  long_description  = "Sonata Cell Position application, part of the Open Brain Institute platform"
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_sonata_cell_position" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_sonata_cell_position"
  ecr_repository_name    = module.sonata_cell_position.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "sonata-cell-position"
}

module "virtual_lab_api" {
  source = "./public-ecr-repo"

  repository_name   = "virtual-lab-api"
  short_name        = "Virtual Lab API"
  short_description = "REST api that is used to manage virtual labs and their projects, primarily by the core-web-app"
  github_repo       = "https://github.com/openbraininstitute/virtual-lab-api/"
  long_description  = "This container provides the REST api that is used to manage virtual labs and their projects, primarily by the core-web-app."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_virtual_lab_api" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_virtual_lab_api"
  ecr_repository_name    = module.virtual_lab_api.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "virtual-lab-api"
}

module "thumbnail_generation_api" {
  source = "./public-ecr-repo"

  repository_name   = "thumbnail-generation-api"
  short_name        = "Thumbnail Generation API"
  short_description = "Service for generating thumbnails of morphologies/electrophysiologies and the soma of morphologies"
  github_repo       = "https://github.com/openbraininstitute/thumbnail-generation-api/"
  long_description  = "The Thumbnail Generation API provides the service for generating thumbnails of morphologies/electrophysiologies and the soma of morphologies. The API is designed to receive a content_url from a Nexus resource (morphology or electrophysiology) and produce a corresponding thumbnail image."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_thumbnail_generation_api" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_thumbnail_generation_api"
  ecr_repository_name    = module.thumbnail_generation_api.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "thumbnail-generation-api"
}

module "entitycore" {
  source = "./public-ecr-repo"

  repository_name   = "entitycore"
  short_name        = "Entity Core"
  short_description = "Entity and File manager for OBI"
  github_repo       = "https://github.com/openbraininstitute/entitycore/"
  long_description  = "Entity and File manager for OBI"
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_entitycore" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_entitycore"
  ecr_repository_name    = module.entitycore.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "entitycore"
}

module "neurodamus" {
  source = "./public-ecr-repo"

  repository_name   = "neurodamus"
  short_name        = "Neurodamus"
  short_description = "Neurodamus is a BBP Simulation Control application for Neuron."
  github_repo       = "https://github.com/openbraininstitute/neurodamus/"
  long_description  = "Neurodamus is a BBP Simulation Control application for Neuron."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_neurodamus" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_neurodamus"
  ecr_repository_name    = module.neurodamus.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "neurodamus"
}

module "notebook_service" {
  source = "./public-ecr-repo"

  repository_name   = "notebook-service"
  short_name        = "Notebook Service"
  short_description = "The Notebook Service allows launching notebooks within the platform."
  github_repo       = "https://github.com/openbraininstitute/notebook-service/"
  long_description  = "The Notebook Service allows launching notebooks within the platform."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_notebook_service" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_notebook_service"
  ecr_repository_name    = module.notebook_service.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "notebook-service"
}

module "obi_notebook_image" {
  source          = "./private-ecr-repo"
  repository_name = "obi-notebook-image"
  allowed_to_pull_principals = { AWS = [
    "arn:aws:iam::992382665735:role/eksctl-jupyterhub-nodegroup-ng-xla-NodeInstanceRole-TqeVopvkuh0l", # EKS within main VPC in staging
    "arn:aws:iam::671250183987:role/eksctl-jupyterhub-nodegroup-ng-xla-NodeInstanceRole-ZlwgewinoBDn"  # EKS within main VPC for production
  ] }
  lifecycle_policy_max_image_count    = 30
  lifecycle_policy_max_image_age_days = 30
}

module "private_ecr_github_actions_upload_credentials_obi-notebook_image" {
  source = "./private-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_obi_notebook_image"
  ecr_repository_name    = module.obi_notebook_image.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "obi-notebook-image"
}

module "neuroagent" {
  source          = "./private-ecr-repo"
  repository_name = "neuroagent"
  allowed_to_pull_principals = { AWS = [
    "arn:aws:iam::992382665735:role/ecs-service-agent-2024102309133921180000000e",
    "arn:aws:iam::671250183987:role/ecs-service-agent-20240524155002883400000004",
    "arn:aws:iam::992382665735:role/ml-ts-ecs-svc-agent-20260429112127454700000002"
  ] }
  lifecycle_policy_max_image_count    = 10
  lifecycle_policy_max_image_age_days = 30
}

module "private_ecr_github_actions_upload_credentials_neuroagent" {
  source = "./private-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_neuroagent"
  ecr_repository_name    = module.neuroagent.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "neuroagent"
}

module "launch_api" {
  source = "./private-ecr-repo"

  repository_name = "launch-system/api"
  allowed_to_pull_principals = { AWS = [
    "arn:aws:iam::992382665735:role/launch_system_api20251120132453126500000006", # staging
    "arn:aws:iam::671250183987:role/launch_system_api20260402094333665800000001", # production
  ] }
  lifecycle_policy_max_image_count    = 10
  lifecycle_policy_max_image_age_days = 30
}

module "launch_orchestrator" {
  source = "./private-ecr-repo"

  repository_name = "launch-system/orchestrator"
  allowed_to_pull_principals = { AWS = [
    "arn:aws:iam::992382665735:role/launch_system_orchestrator20251120132453283700000008", # staging
    "arn:aws:iam::671250183987:role/launch_system_orchestrator20260402094333744900000005", # production
  ] }
  lifecycle_policy_max_image_count    = 10
  lifecycle_policy_max_image_age_days = 30
}

module "launch_executor" {
  source = "./private-ecr-repo"

  repository_name = "launch-system/default-executor"
  allowed_to_pull_principals = { AWS = [
    "arn:aws:iam::992382665735:role/launch_system_executor20260408081519816200000001", # staging default executor
    "arn:aws:iam::992382665735:role/launch_system_executor20251120132453317700000009", # staging inait executor
    "arn:aws:iam::671250183987:role/launch_system_executor20260416122511009900000003", # production default executor
    "arn:aws:iam::671250183987:role/launch_system_executor20260402094333906500000006", # production inait executor
  ] }
  lifecycle_policy_max_image_count    = 10
  lifecycle_policy_max_image_age_days = 30
}

module "private_ecr_github_actions_upload_credentials_launch_system_family" {
  source = "./private-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_launch_containers"
  ecr_repository_name    = "launch-system*"
  github_organisation    = local.github_organisation
  github_repository_name = "launch-system" # it is in the same repo as launch-system, this is not a typo
}

module "auth_manager" {
  source = "./private-ecr-repo"

  repository_name                     = "auth-manager"
  allowed_to_pull_principals          = { AWS = ["arn:aws:iam::992382665735:role/auth_manager20251030104403745100000003", "arn:aws:iam::671250183987:role/auth_manager20251112133557154300000002"] }
  lifecycle_policy_max_image_count    = 10
  lifecycle_policy_max_image_age_days = 30
}

module "private_ecr_github_actions_upload_credentials_auth_manager" {
  source = "./private-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_auth_manager"
  ecr_repository_name    = module.auth_manager.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "auth-manager"
}

module "grading_service" {
  source = "./private-ecr-repo"

  repository_name                     = "grading-service"
  allowed_to_pull_principals          = { AWS = ["arn:aws:iam::992382665735:role/grading_service", "arn:aws:iam::671250183987:role/grading_service"] }
  lifecycle_policy_max_image_count    = 10
  lifecycle_policy_max_image_age_days = 30
}

module "private_ecr_github_actions_upload_credentials_grading_service" {
  source = "./private-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_grading_service"
  ecr_repository_name    = module.grading_service.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "grading-service"
}
