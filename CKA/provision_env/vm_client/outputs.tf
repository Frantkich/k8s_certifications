output "ssh_connection" {
  value = {
    "client" = "ssh -i ~/Documents/0_Projets/0_Interne/certifications_resources/K8s/CKA/provision_env/assets/ssh_keys/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${azurerm_linux_virtual_machine.vm.admin_username}@${azurerm_linux_virtual_machine.vm.public_ip_address}"
    # "proxy" = module.vm_proxy.ssh_connection
  }
}
