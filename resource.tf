resource "aws_instance" "myec2vm" {
  ami                   = data.aws_ami.amzlinux2.id
  instance_type         = var.instance_type
  key_name              = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vps_ssh.id, aws_security_group.vps_web.id]
  tags = {
    Name = "EC2 Via JenkinsJob"
    name = "My Linux EC2"
  }
}
resource "tls_private_key" "ec2_private_key" {
algorithm = "RSA"
rsa_bits  = 4096
provisioner "local-exec" {
command = "sudo echo '${tls_private_key.ec2_private_key.private_key_pem}' > /home/ec2-user/.ssh/${var.instance_keypair}.pem"
      }
}

resource "null_resource" "key-perm" {
depends_on = [
tls_private_key.ec2_private_key,
]
provisioner "local-exec" {
command = "sudo chmod 400 /home/ec2-user/.ssh/${var.instance_keypair}.pem"

   }
}

resource "null_resource" "key-auth" {
provisioner "local-exec" {
command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key /home/ec2-user/.ssh/${var.instance_keypair}.pem -i '${aws_instance.myec2vm.private_ip},' playbook.yml"

   }
}

