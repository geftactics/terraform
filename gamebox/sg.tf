resource "aws_security_group" "instance" {
  name        = "${var.instance_name}-ec2"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    protocol    = "tcp"
    from_port   = 3389
    to_port     = 3389
    cidr_blocks = ["0.0.0.0/0"]
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
