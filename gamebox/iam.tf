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
  name = "${var.instance_name}-ec2"

  tags = {
    Name = var.instance_name
    Terraform = true
  }
}

resource "aws_iam_instance_profile" "instance" {
  name = "${var.instance_name}-ec2"
  role = aws_iam_role.instance.name
}

# resource "aws_iam_role_policy" "instance" {
#   name = "${var.instance_name}-ec2"
#   role = aws_iam_role.instance.id

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "ec2:AttachVolume",
#         "ec2:DetachVolume",
#         "ec2:AssociateAddress",
#         "ec2:CreateImage"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

data "aws_iam_policy_document" "spotfleet" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["spotfleet.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "spotfleet" {
  assume_role_policy = data.aws_iam_policy_document.spotfleet.json
  name = "SpotFleet-Tagging-Role-For-${var.instance_name}"
}

resource "aws_iam_role_policy_attachment" "spotfleet" {
  role = aws_iam_role.spotfleet.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetTaggingRole"
}

