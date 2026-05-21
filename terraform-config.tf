terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      SBO_Billing = "ecr"
    }
  }
}

provider "aws" {
  alias  = "codeartifact"
  region = "us-east-1"
  default_tags {
    tags = {
      SBO_Billing = "codeartifact"
    }
  }
}
