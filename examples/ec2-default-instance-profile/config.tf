#=============================#
# AWS Provider Settings       #
#=============================#
provider "aws" {
  version                 = "~> 2.70"
  region                  = var.region
  profile                 = var.profile
  shared_credentials_file = "~/.aws/bb/config"
}

variable "region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "profile" {
  description = "AWS Profile"
  default     = "bb-dev-deploymaster" # ci aws-iam-profile
  #default    = "bb-shared-devops"    # localhost aws-iam-profile
}

#=============================#
# Backend Config (partial)    #
#=============================#
terraform {
  required_version = ">= 0.12.20"
}

#=============================#
# Data sources                #
#=============================#
variable "region_backend_data" {
  description = "AWS Region"
  default     = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    region  = var.region_backend_data
    profile = var.profile
    bucket  = "bb-shared-terraform-backend"
    key     = "shared/network/terraform.tfstate"
  }
}

data "terraform_remote_state" "dns" {
  backend = "s3"

  config = {
    region  = var.region_backend_data
    profile = var.profile
    bucket  = "bb-shared-terraform-backend"
    key     = "shared/dns/binbash.com.ar/terraform.tfstate"
  }
}

data "terraform_remote_state" "security" {
  backend = "s3"

  config = {
    region  = var.region_backend_data
    profile = var.profile
    bucket  = "bb-shared-terraform-backend"
    key     = "shared/security-keys/terraform.tfstate"
  }
}
