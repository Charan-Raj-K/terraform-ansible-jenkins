### The Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("inventory.tmpl",
    {
      private-dns = aws_instance.myec2vm.private_dns,
      private-ip  = aws_instance.myec2vm.private_ip,
      private-id  = aws_instance.myec2vm.id
    }
  )
  filename = "inventory.yaml"
}