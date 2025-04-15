
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
  source = "terraform-aws-modules/iam/aws//modules/iam-github-oidc-provider"
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

module "public_ecr_github_actions_upload_credentials_obi_one" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_obi_one"
  ecr_repository_name    = module.obi-one.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "obi-one"
}

module "obi-generative-gui" {
  source = "./public-ecr-repo"

  repository_name   = "obi-generative-gui"
  short_name        = "obi-generative-gui"
  short_description = "obi-generative-gui"
  github_repo       = "https://github.com/openbraininstitute/obi-generative-gui"
  long_description  = "obi-generative-gui"
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_obi_generative_gui" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_obi_one"
  ecr_repository_name    = module.obi-generative-gui.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "obi-generative-gui"
}

module "workflow" {
  source = "./public-ecr-repo"

  repository_name   = "workflow"
  short_name        = "Workflow"
  short_description = "Workflow engine used by the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/bbp-workflow/"
  long_description  = "The workflow engine is used to run automated pipelines of batch jobs using python and the luigi framework."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_workflow" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_workflow"
  ecr_repository_name    = module.workflow.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "bbp-workflow"
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
}

# original name: blue-naas-single-cell
module "single_cell_simulator" {
  source = "./public-ecr-repo"

  repository_name   = "single-cell-simulator"
  short_name        = "Single Cell Simulator"
  short_description = "Single Cell Simulator used by the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/BlueNaaS-SingleCell/"
  long_description  = "This application is used within the Open Brain Institute web platform to simulate single cells. It's based on BlueNaaS."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_single_cell_simulator" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_single_cell_simulator"
  ecr_repository_name    = module.single_cell_simulator.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "BlueNaaS-SingleCell"
}

module "hpc_resource_provisioner" {
  source = "./public-ecr-repo"

  repository_name   = "hpc-resource-provisioner"
  short_name        = "HPC Resource Provisioner"
  short_description = "Manages the creation and deletion of parallel custers in AWS"
  github_repo       = "https://github.com/openbraininstitute/hpc-resource-provisioner/"
  long_description  = "The HPC Resource Provisioner is a small application used by the Open Brain Institute that offers an API to manage the creation and deletion of parallel-clusters in AWS."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_hpc_resource_provisioner" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_hpc_resource_provisioner"
  ecr_repository_name    = module.hpc_resource_provisioner.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "BlueNaaS-SingleCell"
}

module "kg_inference_api" {
  source = "./public-ecr-repo"

  repository_name   = "kg-inference-api"
  short_name        = "KG Inference API"
  short_description = "Knowledge Graph Inference API, used by the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/kg-inference-api/"
  long_description  = "The KG Inference API is designed to infer morphologies based on various input characteristics. This API leverages knowledge graphs and inference techniques to provide insights into the structure and form of entities within a defined context."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_kg_inference_api" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_kg_inference_api"
  ecr_repository_name    = module.kg_inference_api.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "BlueNaaS-SingleCell"
}

module "me_model_analysis" {
  source = "./public-ecr-repo"

  repository_name   = "me-model-analysis"
  short_name        = "Morpho-Electrical Model Analysis"
  short_description = "Morpho-Electrical model analysis or single-cell model analysis, used by the Open Brain Institute"
  github_repo       = "https://github.com/openbraininstitute/kg-inference-api/"
  long_description  = "This container provides Morpho-Electrical model analysis or single-cell model analysis for the Open Brain Institute platform. The services executes a series of simulation experiments to compute different features of the model which can be used to determine how good a model is."
  architectures     = ["x86-64"]
  operating_systems = ["Linux"]
}

module "public_ecr_github_actions_upload_credentials_me_model_analysis" {
  source = "./public-ecr-upload-credentials"

  iam_user_name          = "github_actions_upload_user_me_model_analysis"
  ecr_repository_name    = module.me_model_analysis.repository_name
  github_organisation    = local.github_organisation
  github_repository_name = "me-model-analysis"
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
