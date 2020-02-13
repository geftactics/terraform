resource "aws_spot_fleet_request" "instance" {
  iam_fleet_role                      = "arn:aws:iam::603042156394:role/aws-ec2-spot-fleet-tagging-role"
  replace_unhealthy_instances         = true
  target_capacity                     = 1
  valid_until                         = "2050-01-01T00:00:00Z"
  terminate_instances_with_expiration = true

  launch_specification {
    instance_type               = "t3.micro"
    ami                         = data.aws_ami.instance.id
    vpc_security_group_ids      = ["${aws_security_group.instance.id}"]
    iam_instance_profile        = aws_iam_instance_profile.instance.name
    associate_public_ip_address = true
  }

  launch_specification {
    instance_type               = "t3a.micro"
    ami                         = data.aws_ami.instance.id
    vpc_security_group_ids      = ["${aws_security_group.instance.id}"]
    iam_instance_profile        = aws_iam_instance_profile.instance.name
    associate_public_ip_address = true
  }

  launch_specification {
    instance_type               = "t3.small"
    ami                         = data.aws_ami.instance.id
    vpc_security_group_ids      = ["${aws_security_group.instance.id}"]
    iam_instance_profile        = aws_iam_instance_profile.instance.name
    associate_public_ip_address = true
  }

  launch_specification {
    instance_type               = "t2.small"
    ami                         = data.aws_ami.instance.id
    vpc_security_group_ids      = ["${aws_security_group.instance.id}"]
    iam_instance_profile        = aws_iam_instance_profile.instance.name
    associate_public_ip_address = true
  }

  launch_specification {
    instance_type               = "t2.micro"
    ami                         = data.aws_ami.instance.id
    vpc_security_group_ids      = ["${aws_security_group.instance.id}"]
    iam_instance_profile        = aws_iam_instance_profile.instance.name
    associate_public_ip_address = true
  }

}
