env    = "prod"
region = "eu-west-1"
product = "kardia"

vpc_cidr = "10.10.0.0/16"
vpc_azs  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
vpc_private_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
vpc_public_subnets  = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]