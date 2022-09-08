terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.11"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ca-central-1"
}

provider "aws" {
  alias = "use1"
  region = "us-east-1"
}