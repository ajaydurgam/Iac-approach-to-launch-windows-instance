resource "aws_instance" "project-iac-approach-to-launch-windows" {
  ami                         = lookup(var.windowsconfig, "ami")
  instance_type               = lookup(var.windowsconfig, "itype")
  subnet_id                   = lookup(var.windowsconfig, "subnet")
  associate_public_ip_address = lookup(var.windowsconfig, "publicip")
  key_name                    = lookup(var.windowsconfig, "keyname")
  vpc_security_group_ids      = [var.windowsconfig.secgroupid]

  tags = {
    Name = "windows-iac-approach"
  }
}
resource "aws_ebs_volume" "voulme-to-attach-it-to-windows" {
  availability_zone = aws_instance.project-iac-approach-to-launch-windows.availability_zone
  size              = lookup(var.windowsconfig, "size")
  type              = lookup(var.windowsconfig, "type")

  tags = {
    Name = "volume-for-.NetCore-app-deployment"
  }


}
resource "aws_volume_attachment" "ebs_att" {
  device_name = lookup(var.windowsconfig, "devicename")
  volume_id   = aws_ebs_volume.voulme-to-attach-it-to-windows.id
  instance_id = aws_instance.project-iac-approach-to-launch-windows.id
}
output "need-public-ip" {
  value = aws_instance.project-iac-approach-to-launch-windows.public_ip
}
 triggers = {
    password = "${rsadecrypt(aws_instance.example.password_data, file("mykey.pem"))}"
  }

output "Administrator_Password" {
    value = "${null_resource.example.triggers.password}"
}
