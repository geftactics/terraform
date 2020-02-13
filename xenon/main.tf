provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "tfstate-geftactics"
    key    = "xenon"
    region = "eu-west-1"
  }
}

resource "aws_default_vpc" "default" {
}

