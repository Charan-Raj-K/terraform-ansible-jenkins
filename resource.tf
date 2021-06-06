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
#The following code will save the auto-generated EC2 private key as a .pem file in our local machine.
resource "tls_private_key" "ec2_private_key" {
algorithm = "RSA"
rsa_bits  = 4096
provisioner "local-exec" {
command = "echo '${tls_private_key.ec2_private_key.private_key_pem}' > /opt/${var.instance_keypair}.pem"
      }
}
/*module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"
  key_name   = "May"
  public_key = tls_private_key.ec2_private_key.public_key_openssh
}*/
#we will be required to make the key private as by default this file gets saved with public access on the local machine
resource "null_resource" "key-perm" {
depends_on = [
tls_private_key.ec2_private_key,
]
provisioner "local-exec" {
command = "chmod 400 /opt/${var.instance_keypair}.pem"

   }
}

resource "null_resource" "Ansible-execution"  {
provisioner "local-exec" {
command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ec2-user --private-key /opt/${var.instance_keypair}.pem -i '${aws_instance.myec2vm.private_ip},' playbook.yml"
   }
}
