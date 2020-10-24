provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "tfstate-geftactics"
    key    = "gamebox"
    region = "eu-west-1"
  }
}

resource "aws_default_vpc" "default" {
}