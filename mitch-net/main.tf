provider "aws" {
  region  = var.region
  version = "~> 3.0"
  profile = "mitch-net"
}

terraform {
  backend "s3" {}
}