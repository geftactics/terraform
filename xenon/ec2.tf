resource "aws_spot_fleet_request" "instance" {
  iam_fleet_role                      = aws_iam_role.spotfleet.arn
  replace_unhealthy_instances         = true
  target_capacity                     = 1
  valid_until                         = "2050-01-01T00:00:00Z"
  terminate_instances_with_expiration = true

  dynamic "launch_specification" {
    for_each = var.instance_types

      content {
        instance_type               = launch_specification.value
        ami                         = data.aws_ami.instance.id
        vpc_security_group_ids      = ["${aws_security_group.instance.id}"]
        iam_instance_profile        = aws_iam_instance_profile.instance.name
        associate_public_ip_address = true

        tags = {
          Name = var.instance_name
          Terraform = true
        }

    }

  }

}
