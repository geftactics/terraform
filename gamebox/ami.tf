data "aws_ami" "instance" {
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = var.ami_name_pattern
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
