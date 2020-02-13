resource "aws_iam_role" "instance" {
  name = "${var.instance_name}-ec2"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


resource "aws_iam_instance_profile" "instance" {
  name = "${var.instance_name}-ec2"
  role = aws_iam_role.instance.name
}


resource "aws_iam_role_policy" "instance" {
  name = "${var.instance_name}-ec2"
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
