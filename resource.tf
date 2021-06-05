resource "aws_instance" "myec2vm" {
  ami                   = data.aws_ami.amzlinux2.id
  instance_type         = var.instance_type
  key_name              = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vps_ssh.id, aws_security_group.vps_web.id]
  tags = {
    name = "My Linux EC2"
  }
}