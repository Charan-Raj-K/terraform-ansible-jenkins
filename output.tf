output "public_ip" {
  value = aws_instance.myec2vm.public_ip
}
output "public_dns" {
  value = aws_instance.myec2vm.public_dns
}