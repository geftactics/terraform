variable "ami_name_pattern" {
  type    = list(string)
  default = ["xenon-*"]
}

variable "instance_name" {
  type    = string
  default = "xenon"
}

variable "instance_types" {
  type    = list(string)
  default = ["t3.micro", "t3a.micro", "t3.small", "t2.small", "t2.micro"]
}


