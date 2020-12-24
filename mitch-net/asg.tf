resource "aws_launch_configuration" "lc" {
  name_prefix                 = "${var.env}-${var.product}-"
  image_id                    = data.aws_ami.amazonlinux2.id
  instance_type               = "m5.large"
  key_name                    = "mitch-net"
  user_data                   = file("data/user-data.sh")
  security_groups             = ["sg-0e1611466d32e92b2"]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.instance.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "${var.env}-${var.product}-asg"
  launch_configuration = aws_launch_configuration.lc.name
  availability_zones   = ["eu-west-1a"]
  min_size             = 1
  max_size             = 1

  lifecycle {
    create_before_destroy = true
  }
}