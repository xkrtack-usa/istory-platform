provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key

  profile = var.terraform_aws_profile
  region = var.aws_region
  default_tags {
    tags = {
      managed_by = "terraform"
    }
  }
}