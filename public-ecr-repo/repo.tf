

locals {
  template_input = {
    short_name        = var.short_name
    short_description = var.short_description
    long_description  = var.long_description
    github_repo       = var.github_repo
  }
}

resource "aws_ecrpublic_repository" "public_repo" {
  repository_name = var.repository_name

  catalog_data {
    architectures     = var.architectures
    description       = var.short_description
    logo_image_blob   = filebase64("${path.module}/openbraininstitute-logo.png")
    operating_systems = var.operating_systems
    usage_text        = templatefile("${path.module}/usage_text.tfpl.md", local.template_input)
    about_text        = templatefile("${path.module}/about_text.tfpl.md", local.template_input)
  }
}

#resource "aws_ecrpublic_repository_policy" "attach_policy" {
#  repository_name = aws_ecrpublic_repository.public_repo.repository_name
#  policy          = data.aws_iam_policy_document.example.json
#}