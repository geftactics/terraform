resource "aws_spot_fleet_request" "xenon" {
  iam_fleet_role              = "arn:aws:iam::603042156394:role/aws-ec2-spot-fleet-tagging-role"
  replace_unhealthy_instances = true
  target_capacity             = 1
  valid_until                 = "2050-01-01T00:00:00Z"

  launch_specification {
    instance_type            = "t3.micro"
    ami                      = "ami-0713f98de93617bb4"
  }

  launch_specification {
    instance_type            = "t3a.micro"
    ami                      = "ami-0713f98de93617bb4"
  }

  launch_specification {
    instance_type            = "t3.small"
    ami                      = "ami-0713f98de93617bb4"
  }

  launch_specification {
    instance_type            = "t2.small"
    ami                      = "ami-0713f98de93617bb4"
  }

  launch_specification {
    instance_type            = "t2.micro"
    ami                      = "ami-0713f98de93617bb4"
  }

}
