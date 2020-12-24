resource "aws_security_group" "instance" {
  name        = "${var.instance_name}-ec2"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["82.69.24.37/32"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.instance_name
    Terraform = true
  }

}
