output "latest_instance_ami" {
  value = data.aws_ami.instance.name
}
