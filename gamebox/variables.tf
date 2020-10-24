variable "ami_name_pattern" {
  type    = list(string)
  default = ["gamebox*"]
}

variable "instance_name" {
  type    = string
  default = "gamebox"
}

variable "instance_types" {
  type    = list(string)
  default = ["g4dn.xlarge"]
}

variable "availability_zone" {
  type    = string
  default = "eu-west-2a"
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "mobile" {
  type        = string
  description = "Mobile number for SMS alerts that the stack is running (+447_________)"
}