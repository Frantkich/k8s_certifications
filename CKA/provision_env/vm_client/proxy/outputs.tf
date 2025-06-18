output "ssh_connection" {
  value = "ssh -i ./assets/ssh_keys/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${azurerm_linux_virtual_machine.vm.admin_username}@${azurerm_linux_virtual_machine.vm.public_ip_address}"
}
