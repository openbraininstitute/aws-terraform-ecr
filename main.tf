
# For info, a repo has the following fields:
# * repository_name can be of type 'repo-name' or 'namespace/repo-name'
# * logo must be a png of max 500kb, with width&height between 60 and 2048 pixels: currently fixed to 
# * short_description is limited to 255 characters. It's only visible once the OBI registry would become verified.
# * about_text can be a quite long markdown formatted text: fixed template at the moment
# * usage_text can be a quite long markdown formatted text: fixed template at the moment
# * operating_systems has to be a list, allowed values are 'Linux' and 'Windows'
# * architectures has to be a list, allowed values are 'ARM', 'ARM 64', 'x86', 'x86-64'
# For markdown syntax, see https://docs.aws.amazon.com/AmazonECR/latest/public/public-repository-catalog-data.html

# Likely most important containers which we've been using from the BlueBrain docker hub organisation:
# * bbp-workflow
# * blue-naas-single-cell
# * hpc-resource-provisioner
# * kg-inference-api
# * me-model-analysis
# * obp-accounting-service
# * obp-sonata-cell-position
# * obp-virtual-lab-api
# * sbo-core-web-app
# * thumbnail-generation-api

module "workflow" {
    source = "./public-ecr-repo"

    repository_name   = "workflow"
    short_name        = "Workflow"
    short_description = "Workflow engine used by the Open Brain Institute"
    github_repo       = "https://github.com/openbraininstitute/bbp-workflow"
    long_description  = "The workflow engine is used to run automated pipelines of batch jobs using python and the luigi framework."
    architectures     = ["x86-64"]
    operating_systems = ["Linux"]
}

module "core_web_app" {
    source = "./public-ecr-repo"
    count  = 0 # Disabled

    repository_name   = "core-web-app"
    short_name        = "Core web application"
    short_description = "Core web application used by the Open Brain Institute"
    github_repo       = "https://github.com/openbraininstitute/core-web-app/"
    long_description  = "The core web application is the central piece of the Open Brain Institute web platform which gives access to the other components such as the virtual labs."
    architectures     = ["x86-64"]
    operating_systems = ["Linux"]
}



