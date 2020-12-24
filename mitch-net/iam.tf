data "aws_iam_policy_document" "instance" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  assume_role_policy = data.aws_iam_policy_document.instance.json
  name = "${var.env}-${var.product}-ec2"

  tags = {
    Name = var.product
    Terraform = true
  }
}

resource "aws_iam_instance_profile" "instance" {
  name = "${var.env}-${var.product}-ec2"
  role = aws_iam_role.instance.name
}

resource "aws_iam_role_policy" "instance" {
  name = "${var.env}-${var.product}-ec2"
  role = aws_iam_role.instance.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:AttachVolume",
        "ec2:DetachVolume",
        "ec2:AssociateAddress",
        "ec2:CreateImage"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}