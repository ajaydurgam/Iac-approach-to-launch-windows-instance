resource "aws_security_group" "windows" {
  name        = "windows_security_group"
  vpc_id      = lookup(var.windowsconfig, "vpc")
  description = "Allow HTTPS (443) and RDP (3389) traffic, Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from anywhere (for demonstration purposes)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP access from anywhere (for demonstration purposes)
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTPS from anywhere (for demonstration purposes)
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow RDP from anywhere (for demonstration purposes)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "project-iac-approach-to-launch-windows" {
  ami                         = lookup(var.windowsconfig, "ami")
  instance_type               = lookup(var.windowsconfig, "itype")
  subnet_id                   = lookup(var.windowsconfig, "subnet")
  associate_public_ip_address = lookup(var.windowsconfig, "publicip")
  key_name                    = lookup(var.windowsconfig, "keyname")
  vpc_security_group_ids      = [aws_security_group.windows.id]

  tags = {
    Name = "windows-iac-approach" #tags used to give a instance name
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

